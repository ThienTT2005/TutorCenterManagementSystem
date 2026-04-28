package com.tcms.session_validity.service;

import com.tcms.attendance.entity.Attendance;
import com.tcms.attendance.repository.AttendanceRepository;
import com.tcms.clazz.entity.ClassEntity;
import com.tcms.clazz.entity.Enrollment;
import com.tcms.clazz.repository.EnrollmentRepository;
import com.tcms.feedback.entity.Feedback;
import com.tcms.feedback.entity.FeedbackStatus;
import com.tcms.feedback.repository.FeedbackRepository;
import com.tcms.session.entity.TeachingSession;
import com.tcms.session.repository.TeachingSessionRepository;
import com.tcms.session_validity.entity.SessionValidityLog;
import com.tcms.session_validity.repository.SessionValidityLogRepository;
import com.tcms.student.entity.Student;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class SessionValidityServiceImpl implements SessionValidityService {

    private final SessionValidityLogRepository validityLogRepository;
    private final TeachingSessionRepository teachingSessionRepository;
    private final EnrollmentRepository enrollmentRepository;
    private final AttendanceRepository attendanceRepository;
    private final FeedbackRepository feedbackRepository;

    @Override
    public void calculateForSession(Integer sessionId) {
        TeachingSession session = teachingSessionRepository.findById(sessionId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy buổi học"));

        List<Enrollment> enrollments =
                enrollmentRepository.findByClassEntityClassIdAndStatusTrue(
                        session.getClassEntity().getClassId()
                );

        for (Enrollment enrollment : enrollments) {
            calculateForStudentInSession(sessionId, enrollment.getStudent().getStudentId());
        }
    }

    @Override
    public void calculateForStudentInSession(Integer sessionId, Integer studentId) {
        TeachingSession session = teachingSessionRepository.findById(sessionId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy buổi học"));

        Student student = enrollmentRepository.findByClassEntityClassIdAndStatusTrue(
                        session.getClassEntity().getClassId()
                )
                .stream()
                .map(Enrollment::getStudent)
                .filter(s -> s.getStudentId().equals(studentId))
                .findFirst()
                .orElseThrow(() -> new RuntimeException("Học sinh không thuộc lớp này"));

        Attendance attendance = attendanceRepository
                .findBySessionSessionIdAndStudentStudentId(sessionId, studentId)
                .orElse(null);

        Feedback feedback = feedbackRepository
                .findBySessionSessionIdAndStudentStudentId(sessionId, studentId)
                .orElse(null);

        Boolean attendanceValid = attendance != null && Boolean.TRUE.equals(attendance.getIsValid());

        String feedbackStatus = feedback == null ? "MISSING" : feedback.getStatus().name();

        BigDecimal feedbackPenalty = feedback == null || feedback.getPenaltyRate() == null
                ? BigDecimal.ZERO
                : feedback.getPenaltyRate();

        LocalDateTime feedbackSubmittedAt = feedback == null
                ? null
                : feedback.getSubmittedAt();

        BigDecimal calculatedAmount = calculateAmount(
                session.getClassEntity(),
                attendanceValid,
                feedback
        );

        SessionValidityLog log = validityLogRepository
                .findBySessionSessionIdAndStudentStudentId(sessionId, studentId)
                .orElse(new SessionValidityLog());

        log.setSession(session);
        log.setStudent(student);
        log.setAttendanceValid(attendanceValid);
        log.setFeedbackStatus(feedbackStatus);
        log.setFeedbackPenalty(feedbackPenalty);
        log.setFeedbackSubmittedAt(feedbackSubmittedAt);
        log.setCalculatedAmount(calculatedAmount);
        log.setCalculatedAt(LocalDateTime.now());

        if (log.getIsPaid() == null) {
            log.setIsPaid(false);
        }

        validityLogRepository.save(log);
    }

    private BigDecimal calculateAmount(
            ClassEntity classEntity,
            Boolean attendanceValid,
            Feedback feedback
    ) {
        BigDecimal baseAmount = classEntity.getTuitionFeePerSession() == null
                ? BigDecimal.ZERO
                : classEntity.getTuitionFeePerSession();

        if (!Boolean.TRUE.equals(attendanceValid)) {
            return BigDecimal.ZERO;
        }

        if (feedback == null) {
            return BigDecimal.ZERO;
        }

        if (!FeedbackStatus.APPROVED.equals(feedback.getStatus())) {
            return BigDecimal.ZERO;
        }

        BigDecimal penaltyRate = feedback.getPenaltyRate() == null
                ? BigDecimal.ZERO
                : feedback.getPenaltyRate();

        BigDecimal payableRate = BigDecimal.ONE.subtract(penaltyRate);

        return baseAmount.multiply(payableRate);
    }
}