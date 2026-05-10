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
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
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
        public List<Feedback> getPendingFeedbacks(String keyword, String className, String status) {
                List<Feedback> all = feedbackRepository.findAll();

                return all.stream()
                                .filter(f -> {
                                        // Filter by status if provided, otherwise default to PENDING if status is empty
                                        if (status != null && !status.isEmpty()) {
                                                return f.getStatus().name().equalsIgnoreCase(status);
                                        }
                                        return f.getStatus() == FeedbackStatus.PENDING;
                                })
                                .filter(f -> {
                                        if (className == null || className.isEmpty())
                                                return true;
                                        return f.getSession() != null && f.getSession().getClassEntity() != null
                                                        && className.equalsIgnoreCase(
                                                                        f.getSession().getClassEntity().getClassName());
                                })
                                .filter(f -> {
                                        if (keyword == null || keyword.isEmpty())
                                                return true;
                                        String k = keyword.toLowerCase();
                                        boolean matchTutor = f.getSession() != null
                                                        && f.getSession().getClassEntity() != null
                                                        && f.getSession().getClassEntity().getTutor() != null
                                                        && f.getSession().getClassEntity().getTutor().getFullName()
                                                                        .toLowerCase().contains(k);
                                        boolean matchStudent = f.getStudent() != null
                                                        && f.getStudent().getFullName().toLowerCase().contains(k);
                                        boolean matchClass = f.getSession() != null
                                                        && f.getSession().getClassEntity() != null
                                                        && f.getSession().getClassEntity().getClassName().toLowerCase()
                                                                        .contains(k);
                                        boolean matchComment = f.getComment() != null
                                                        && f.getComment().toLowerCase().contains(k);
                                        return matchTutor || matchStudent || matchClass || matchComment;
                                })
                                .sorted((f1, f2) -> f2.getSubmittedAt().compareTo(f1.getSubmittedAt()))
                                .toList();
        }

        @Override
        public List<Feedback> getFeedbacks(String keyword, String className, String status) {
                List<Feedback> allFeedbacks = feedbackRepository.findAll();

                return allFeedbacks.stream()
                                .filter(feedback -> {
                                        if (status == null || status.isBlank()) {
                                                return true;
                                        }

                                        return feedback.getStatus() != null
                                                        && feedback.getStatus().name().equalsIgnoreCase(status);
                                })
                                .filter(feedback -> {
                                        if (className == null || className.isBlank()) {
                                                return true;
                                        }

                                        return feedback.getSession() != null
                                                        && feedback.getSession().getClassEntity() != null
                                                        && feedback.getSession().getClassEntity().getClassName() != null
                                                        && feedback.getSession().getClassEntity().getClassName()
                                                                        .equalsIgnoreCase(className);
                                })
                                .filter(feedback -> {
                                        if (keyword == null || keyword.isBlank()) {
                                                return true;
                                        }

                                        String kw = keyword.toLowerCase().trim();

                                        String tutorName = "";
                                        String classNameValue = "";
                                        String studentName = "";
                                        String comment = "";
                                        String rating = "";
                                        String statusValue = "";

                                        if (feedback.getSession() != null
                                                        && feedback.getSession().getClassEntity() != null) {

                                                if (feedback.getSession().getClassEntity().getClassName() != null) {
                                                        classNameValue = feedback.getSession().getClassEntity()
                                                                        .getClassName();
                                                }

                                                if (feedback.getSession().getClassEntity().getTutor() != null
                                                                && feedback.getSession().getClassEntity().getTutor()
                                                                                .getFullName() != null) {
                                                        tutorName = feedback.getSession().getClassEntity().getTutor()
                                                                        .getFullName();
                                                }
                                        }

                                        if (feedback.getStudent() != null
                                                        && feedback.getStudent().getFullName() != null) {
                                                studentName = feedback.getStudent().getFullName();
                                        }

                                        if (feedback.getComment() != null) {
                                                comment = feedback.getComment();
                                        }

                                        if (feedback.getRating() != null) {
                                                rating = feedback.getRating();
                                        }

                                        if (feedback.getStatus() != null) {
                                                statusValue = feedback.getStatus().name();
                                        }

                                        return tutorName.toLowerCase().contains(kw)
                                                        || classNameValue.toLowerCase().contains(kw)
                                                        || studentName.toLowerCase().contains(kw)
                                                        || comment.toLowerCase().contains(kw)
                                                        || rating.toLowerCase().contains(kw)
                                                        || statusValue.toLowerCase().contains(kw);
                                })
                                .sorted((f1, f2) -> {
                                        if (f1.getSubmittedAt() == null && f2.getSubmittedAt() == null) {
                                                return 0;
                                        }

                                        if (f1.getSubmittedAt() == null) {
                                                return 1;
                                        }

                                        if (f2.getSubmittedAt() == null) {
                                                return -1;
                                        }

                                        return f2.getSubmittedAt().compareTo(f1.getSubmittedAt());
                                })
                                .toList();
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
                                session.getEndTime());

                LocalDateTime deadline = sessionEnd.plusHours(4);

                LocalDateTime now = LocalDateTime.now();

                boolean isLate = now.isAfter(deadline);

                BigDecimal penaltyRate = isLate
                                ? new BigDecimal("0.25")
                                : BigDecimal.ZERO;

                List<Enrollment> enrollments = enrollmentRepository.findByClassEntityClassIdAndStatusTrue(
                                session.getClassEntity().getClassId());

                int savedCount = 0;

                for (Enrollment enrollment : enrollments) {

                        Student student = enrollment.getStudent();

                        String comment = request.getComments() == null
                                        ? null
                                        : request.getComments().get(student.getStudentId());

                        String rating = request.getRatings() == null
                                        ? null
                                        : request.getRatings().get(student.getStudentId());

                        if (comment == null || comment.isBlank())
                                continue;

                        if (rating == null || rating.isBlank()) {
                                throw new BadRequestException(
                                                "Vui lòng chọn đánh giá cho học sinh " + student.getFullName());
                        }

                        List<Feedback> existingFeedbacks = feedbackRepository.findBySessionSessionIdAndStudentStudentId(
                                        session.getSessionId(),
                                        student.getStudentId());

                        Feedback feedback = existingFeedbacks.isEmpty()
                                        ? new Feedback()
                                        : existingFeedbacks.get(0);

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

                // DB trigger trg_calculate_session_validity tự động xử lý việc ghi session_validity_log
                Feedback saved = feedbackRepository.save(feedback);
                notifyStudentAndParentFeedbackApproved(saved);
        }

        @Override
        public void rejectFeedback(Integer feedbackId) {
                Feedback feedback = feedbackRepository.findById(feedbackId)
                                .orElseThrow(() -> new BadRequestException("Feedback không tồn tại"));

                feedback.setStatus(FeedbackStatus.REJECTED);

            try {
                feedbackRepository.save(feedback);
            } catch (Exception e) {
                log.error("Approve feedback failed", e);
                throw e;
            }
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
                                        "feedback");
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
                                        "feedback");
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
                                        "feedback");
                }
        }

}