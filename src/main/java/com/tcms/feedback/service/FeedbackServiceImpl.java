package com.tcms.feedback.service;

import com.tcms.clazz.entity.Enrollment;
import com.tcms.clazz.repository.EnrollmentRepository;
import com.tcms.exception.BadRequestException;
import com.tcms.feedback.dto.request.CreateFeedbackRequest;
import com.tcms.feedback.entity.Feedback;
import com.tcms.feedback.entity.FeedbackStatus;
import com.tcms.feedback.repository.FeedbackRepository;
import com.tcms.notification.entity.NotificationType;
import com.tcms.notification.service.NotificationService;
import com.tcms.session.entity.SessionStatus;
import com.tcms.session.entity.TeachingSession;
import com.tcms.session.repository.TeachingSessionRepository;
import com.tcms.session_validity.service.SessionValidityService;
import com.tcms.student.entity.Student;
import com.tcms.tutor.entity.Tutor;
import com.tcms.tutor.repository.TutorRepository;
import com.tcms.user.entity.User;
import com.tcms.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class FeedbackServiceImpl implements FeedbackService {

    private final FeedbackRepository feedbackRepository;
    private final TeachingSessionRepository teachingSessionRepository;
    private final TutorRepository tutorRepository;
    private final EnrollmentRepository enrollmentRepository;
    private final NotificationService notificationService;
    private final UserRepository userRepository;
    private final SessionValidityService sessionValidityService;

    @Override
    public List<Feedback> getFeedbackBySession(Integer sessionId) {
        return feedbackRepository.findBySessionSessionId(sessionId);
    }

    @Override
    public List<Feedback> getPendingFeedbacks() {
        return feedbackRepository.findByStatus(FeedbackStatus.PENDING);
    }

    @Override
    public void createFeedback(Integer tutorUserId, CreateFeedbackRequest request) {

        if (request.getSessionId() == null) {
            throw new BadRequestException("Thiếu buổi học");
        }

        Tutor tutor = tutorRepository.findByUserUserId(tutorUserId)
                .orElseThrow(() -> new BadRequestException("Không tìm thấy hồ sơ gia sư"));

        TeachingSession session = teachingSessionRepository.findById(request.getSessionId())
                .orElseThrow(() -> new BadRequestException("Không tìm thấy buổi học"));

        if (!session.getClassEntity().getTutor().getTutorId().equals(tutor.getTutorId())) {
            throw new BadRequestException("Bạn không có quyền feedback buổi học này");
        }

        if (!SessionStatus.COMPLETED.equals(session.getStatus())) {
            throw new BadRequestException("Chỉ được feedback sau khi buổi học đã hoàn thành");
        }

        LocalDateTime sessionEnd = LocalDateTime.of(
                session.getSessionDate(),
                session.getEndTime()
        );

        LocalDateTime deadline = sessionEnd.plusHours(4);

        LocalDateTime now = LocalDateTime.now();

        boolean isLate = now.isAfter(deadline);

        BigDecimal penaltyRate = isLate
                ? new BigDecimal("0.25")
                : BigDecimal.ZERO;

        List<Enrollment> enrollments =
                enrollmentRepository.findByClassEntityClassIdAndStatusTrue(
                        session.getClassEntity().getClassId()
                );

        int savedCount = 0;

        for (Enrollment enrollment : enrollments) {

            Student student = enrollment.getStudent();

            String comment = request.getComments() == null
                    ? null
                    : request.getComments().get(student.getStudentId());

            String rating = request.getRatings() == null
                    ? null
                    : request.getRatings().get(student.getStudentId());

            if (comment == null || comment.isBlank()) continue;

            if (rating == null || rating.isBlank()) {
                throw new BadRequestException("Vui lòng chọn đánh giá cho học sinh " + student.getFullName());
            }

            Feedback feedback = feedbackRepository
                    .findBySessionSessionIdAndStudentStudentId(
                            session.getSessionId(),
                            student.getStudentId()
                    )
                    .orElse(new Feedback());

            feedback.setSession(session);
            feedback.setStudent(student);
            feedback.setRating(rating);
            feedback.setComment(comment);
            feedback.setSubmittedAt(now);

            feedback.setIsLate(isLate);
            feedback.setPenaltyRate(penaltyRate);

            feedback.setStatus(FeedbackStatus.PENDING);
            feedback.setRejectedReason(null);

            Feedback saved = feedbackRepository.save(feedback);
            savedCount++;

            notifyAdminsFeedbackPending(saved, tutor);
        }

        if (savedCount == 0) {
            throw new BadRequestException("Chưa nhập feedback cho học sinh nào");
        }
    }

    @Override
    public void approveFeedback(Integer feedbackId) {
        Feedback feedback = feedbackRepository.findById(feedbackId)
                .orElseThrow(() -> new BadRequestException("Feedback không tồn tại"));

        feedback.setStatus(FeedbackStatus.APPROVED);
        feedback.setRejectedReason(null);

        Feedback saved = feedbackRepository.save(feedback);
        sessionValidityService.calculateForStudentInSession(
                saved.getSession().getSessionId(),
                saved.getStudent().getStudentId()
        );
        notifyStudentAndParentFeedbackApproved(saved);
    }

    @Override
    public void rejectFeedback(Integer feedbackId) {
        Feedback feedback = feedbackRepository.findById(feedbackId)
                .orElseThrow(() -> new BadRequestException("Feedback không tồn tại"));

        feedback.setStatus(FeedbackStatus.REJECTED);

        feedbackRepository.save(feedback);
    }

    private void notifyAdminsFeedbackPending(Feedback feedback, Tutor tutor) {
        List<User> admins = userRepository.findByRoleRoleName("ADMIN");

        for (User admin : admins) {
            notificationService.createNotification(
                    admin.getUserId(),
                    "Feedback mới chờ duyệt",
                    "Gia sư " + tutor.getFullName() + " vừa tạo feedback mới, cần admin duyệt.",
                    NotificationType.FEEDBACK,
                    feedback.getFeedbackId(),
                    "feedback"
            );
        }
    }

    private void notifyStudentAndParentFeedbackApproved(Feedback feedback) {
        Student student = feedback.getStudent();

        if (student != null && student.getUser() != null) {
            notificationService.createNotification(
                    student.getUser().getUserId(),
                    "Feedback mới từ gia sư",
                    "Bạn có feedback mới sau buổi học.",
                    NotificationType.FEEDBACK,
                    feedback.getFeedbackId(),
                    "feedback"
            );
        }

        if (student != null &&
                student.getParent() != null &&
                student.getParent().getUser() != null) {

            notificationService.createNotification(
                    student.getParent().getUser().getUserId(),
                    "Feedback mới của con",
                    "Con bạn có feedback mới từ gia sư.",
                    NotificationType.FEEDBACK,
                    feedback.getFeedbackId(),
                    "feedback"
            );
        }
    }
}