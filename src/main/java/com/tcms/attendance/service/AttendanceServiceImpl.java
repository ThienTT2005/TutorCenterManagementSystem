package com.tcms.attendance.service;

import com.tcms.attendance.dto.request.AttendanceCodeRequest;
import com.tcms.attendance.entity.Attendance;
import com.tcms.attendance.entity.AttendanceStatus;
import com.tcms.attendance.repository.AttendanceRepository;
import com.tcms.clazz.entity.Enrollment;
import com.tcms.clazz.repository.EnrollmentRepository;
import com.tcms.exception.BadRequestException;
import com.tcms.session.entity.SessionStatus;
import com.tcms.session.entity.TeachingSession;
import com.tcms.session.repository.TeachingSessionRepository;
import com.tcms.session_validity.service.SessionValidityService;
import com.tcms.tutor.entity.Tutor;
import com.tcms.tutor.repository.TutorRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class AttendanceServiceImpl implements AttendanceService {

    private final AttendanceRepository attendanceRepository;
    private final TeachingSessionRepository teachingSessionRepository;
    private final EnrollmentRepository enrollmentRepository;
    private final TutorRepository tutorRepository;
    private final SessionValidityService sessionValidityService;
    private static final long ALLOWED_MINUTES = 15;

    @Override
    public List<Attendance> getAttendanceBySession(Integer sessionId) {
        return attendanceRepository.findBySessionSessionId(sessionId);
    }

    @Override
    public void checkIn(Integer tutorUserId, AttendanceCodeRequest request) {
        TeachingSession teachingSession = validateTutorAndCode(tutorUserId, request);

        if (SessionStatus.COMPLETED.equals(teachingSession.getStatus())) {
            throw new BadRequestException("Buổi học đã hoàn thành");
        }

        if (SessionStatus.CANCELLED.equals(teachingSession.getStatus())) {
            throw new BadRequestException("Buổi học đã bị hủy");
        }

        LocalDateTime now = LocalDateTime.now();

        LocalDateTime sessionStart = LocalDateTime.of(
                teachingSession.getSessionDate(),
                teachingSession.getStartTime()
        );

        LocalDateTime sessionEnd = LocalDateTime.of(
                teachingSession.getSessionDate(),
                teachingSession.getEndTime()
        );

        if (now.isBefore(sessionStart.minusMinutes(ALLOWED_MINUTES))) {
            throw new BadRequestException("Chỉ được check-in sớm tối đa 15 phút");
        }

        if (now.isAfter(sessionEnd)) {
            throw new BadRequestException("Buổi học đã kết thúc");
        }

        boolean checkinValid =
                Math.abs(Duration.between(sessionStart, now).toMinutes()) <= ALLOWED_MINUTES;

        if (SessionStatus.PLANNED.equals(teachingSession.getStatus())) {
            teachingSession.setStatus(SessionStatus.ONGOING);
            teachingSessionRepository.save(teachingSession);
        }

        List<Enrollment> enrollments =
                enrollmentRepository.findByClassEntityClassIdAndStatusTrue(
                        teachingSession.getClassEntity().getClassId()
                );

        for (Enrollment enrollment : enrollments) {

            Attendance attendance = attendanceRepository
                    .findBySessionSessionIdAndStudentStudentId(
                            teachingSession.getSessionId(),
                            enrollment.getStudent().getStudentId()
                    )
                    .orElseGet(() -> {
                        Attendance newA = new Attendance();
                        newA.setSession(teachingSession);
                        newA.setStudent(enrollment.getStudent());
                        newA.setStatus(AttendanceStatus.ABSENT_UNEXCUSED);
                        newA.setIsValid(false);
                        return newA;
                    });

            if (attendance.getCheckinTime() == null) {
                attendance.setCheckinTime(now);
            }

            if (!AttendanceStatus.ABSENT_EXCUSED.equals(attendance.getStatus())) {
                attendance.setStatus(AttendanceStatus.ATTENDED);
                attendance.setIsValid(checkinValid);
            }

            attendanceRepository.save(attendance);
        }
    }

    @Override
    public void checkOut(Integer tutorUserId, AttendanceCodeRequest request) {
        TeachingSession teachingSession = validateTutorAndCode(tutorUserId, request);

        if (!SessionStatus.ONGOING.equals(teachingSession.getStatus())) {
            throw new BadRequestException("Buổi học chưa check-in");
        }

        LocalDateTime now = LocalDateTime.now();

        LocalDateTime sessionEnd = LocalDateTime.of(
                teachingSession.getSessionDate(),
                teachingSession.getEndTime()
        );

        if (now.isBefore(sessionEnd.minusMinutes(ALLOWED_MINUTES))) {
            throw new BadRequestException("Chỉ được check-out sớm tối đa 15 phút");
        }

        boolean checkoutValid =
                Math.abs(Duration.between(sessionEnd, now).toMinutes()) <= ALLOWED_MINUTES;

        List<Attendance> attendanceList =
                attendanceRepository.findBySessionSessionId(teachingSession.getSessionId());

        for (Attendance attendance : attendanceList) {

            if (attendance.getCheckoutTime() == null) {
                attendance.setCheckoutTime(now);
            }

            if (!AttendanceStatus.ABSENT_EXCUSED.equals(attendance.getStatus())) {
                boolean currentValid = Boolean.TRUE.equals(attendance.getIsValid());
                attendance.setIsValid(currentValid && checkoutValid);
            }

            attendanceRepository.save(attendance);
        }

        teachingSession.setStatus(SessionStatus.COMPLETED);
        teachingSessionRepository.save(teachingSession);
        sessionValidityService.calculateForSession(teachingSession.getSessionId());
    }

    private TeachingSession validateTutorAndCode(Integer tutorUserId, AttendanceCodeRequest request) {

        if (request.getSessionId() == null) {
            throw new BadRequestException("Thiếu buổi học");
        }

        if (request.getAttendanceCode() == null || request.getAttendanceCode().isBlank()) {
            throw new BadRequestException("Thiếu mã điểm danh");
        }

        Tutor tutor = tutorRepository.findByUserUserId(tutorUserId)
                .orElseThrow(() -> new BadRequestException("Không tìm thấy gia sư"));

        TeachingSession session = teachingSessionRepository.findById(request.getSessionId())
                .orElseThrow(() -> new BadRequestException("Không tìm thấy buổi học"));

        if (!session.getClassEntity().getTutor().getTutorId().equals(tutor.getTutorId())) {
            throw new BadRequestException("Không có quyền");
        }

        if (!request.getAttendanceCode().equals(session.getAttendanceCode())) {
            throw new BadRequestException("Sai mã điểm danh");
        }

        return session;
    }
}