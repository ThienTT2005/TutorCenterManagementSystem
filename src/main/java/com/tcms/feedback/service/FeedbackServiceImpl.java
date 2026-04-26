package com.tcms.feedback.service;

import com.tcms.clazz.entity.Enrollment;
import com.tcms.clazz.repository.EnrollmentRepository;
import com.tcms.exception.BadRequestException;
import com.tcms.feedback.dto.request.CreateFeedbackRequest;
import com.tcms.feedback.entity.Feedback;
import com.tcms.feedback.entity.FeedbackStatus;
import com.tcms.feedback.repository.FeedbackRepository;
import com.tcms.session.entity.SessionStatus;
import com.tcms.session.entity.TeachingSession;
import com.tcms.session.repository.TeachingSessionRepository;
import com.tcms.student.entity.Student;
import com.tcms.tutor.entity.Tutor;
import com.tcms.tutor.repository.TutorRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class FeedbackServiceImpl implements FeedbackService{
    private final FeedbackRepository feedbackRepository;
    private final TeachingSessionRepository teachingSessionRepository;
    private final TutorRepository tutorRepository;
    private final EnrollmentRepository enrollmentRepository;

    @Override
    public List<Feedback> getFeedbackBySession(Integer sessionId){
        return feedbackRepository.findBySessionSessionId(sessionId);
    }

    @Override
    public List<Feedback> getPendingFeedbacks(){
        return feedbackRepository.findByStatus(FeedbackStatus.PENDING);
    }

    @Override
    public void createFeedback(Integer tutorUserId, CreateFeedbackRequest request){
        if(request.getSessionId() == null){
            throw new BadRequestException("Thiếu buổi học");
        }
        Tutor tutor = tutorRepository.findByUserUserId(tutorUserId)
                .orElseThrow(() -> new BadRequestException("Không tìm thấy hồ sơ gia sư"));
        TeachingSession session = teachingSessionRepository.findById(request.getSessionId())
                .orElseThrow(() -> new BadRequestException("Không tìm thấy buổi học"));
        if(!session.getClassEntity().getTutor().getTutorId().equals(tutor.getTutorId())){
            throw new BadRequestException("Bạn không có quyền feedback buổi học này");
        }
        if(!SessionStatus.COMPLETED.equals(session.getStatus())){
            throw new BadRequestException("Chỉ được feedback sau khi buổi học đã hoàn thành");
        }
        List<Enrollment> enrollments =
                enrollmentRepository.findByClassEntityClassIdAndStatusTrue(
                        session.getClassEntity().getClassId()
                );
        for(Enrollment enrollment : enrollments){
            Student student = enrollment.getStudent();
            String comment = request.getComments() == null ? null : request.getComments().get(student.getStudentId());
            String rating = request.getRatings() == null ? null : request.getRatings().get(student.getStudentId());
            if(comment == null || comment.isBlank()) continue;
            if(rating == null || rating.isBlank()){
                throw new BadRequestException("Vui lòng chọn đánh giá cho học sinh" + student.getFullName());
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
            feedback.setSubmittedAt(LocalDateTime.now());
            feedback.setIsLate(false);
            feedback.setPenaltyRate(BigDecimal.ZERO);
            feedback.setStatus(FeedbackStatus.PENDING);
            feedback.setRejectedReason(null);
            feedbackRepository.save(feedback);
        }
    }

    @Override
    public void approveFeedback(Integer feedbackId){
        Feedback feedback = feedbackRepository.findById(feedbackId)
                .orElseThrow(() -> new BadRequestException("Feedback không tồn tại"));
        feedback.setStatus(FeedbackStatus.APPROVED);
        feedback.setRejectedReason(null);
        feedbackRepository.save(feedback);
    }

    @Override
    public void rejectFeedback(Integer feedbackId){
        Feedback feedback = feedbackRepository.findById(feedbackId)
                .orElseThrow(() -> new BadRequestException("Feedback không tồn tại"));
        feedback.setStatus(FeedbackStatus.REJECTED);
        feedbackRepository.save(feedback);
    }
}
