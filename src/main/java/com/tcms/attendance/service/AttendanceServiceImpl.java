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
import com.tcms.tutor.entity.Tutor;
import com.tcms.tutor.repository.TutorRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class AttendanceServiceImpl implements AttendanceService{
    private final AttendanceRepository attendanceRepository;
    private final TeachingSessionRepository teachingSessionRepository;
    private final EnrollmentRepository enrollmentRepository;
    private final TutorRepository tutorRepository;

    @Override
    public List<Attendance> getAttendanceBySession(Integer sessionId){
        return attendanceRepository.findBySessionSessionId(sessionId);
    }

    @Override
    public void checkIn(Integer tutorUserId, AttendanceCodeRequest request){
        TeachingSession teachingSession = validateTutorAndCode(tutorUserId, request);
        if(SessionStatus.COMPLETED.equals(teachingSession.getStatus())){
            throw new BadRequestException("Buổi học đã hoàn thành, không thể check-in");
        }
        if(SessionStatus.CANCELLED.equals(teachingSession.getStatus())){
            throw new BadRequestException("Buổi học đã bị hủy, không thể check-in");
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
        if (now.isBefore(sessionStart) || now.isAfter(sessionEnd)) {
            throw new BadRequestException("Chỉ được check-in trong thời gian diễn ra buổi học");
        }
        if(SessionStatus.PLANNED.equals(teachingSession.getStatus())){
            teachingSession.setStatus(SessionStatus.ONGOING);
            teachingSessionRepository.save(teachingSession);
        }
        List<Enrollment> enrollments = enrollmentRepository.findByClassEntityClassIdAndStatusTrue(teachingSession.getClassEntity().getClassId());
        if(enrollments.isEmpty()){
            throw new BadRequestException("Lớp chưa có học sinh");
        }
        for(Enrollment enrollment : enrollments){
            Attendance attendance = attendanceRepository
                    .findBySessionSessionIdAndStudentStudentId(
                            teachingSession.getSessionId(),
                            enrollment.getStudent().getStudentId()
                    )
                    .orElseGet(() -> {
                        Attendance newAttendance = new Attendance();
                        newAttendance.setSession(teachingSession);
                        newAttendance.setStudent(enrollment.getStudent());
                        newAttendance.setStatus(AttendanceStatus.ABSENT_UNEXCUSED);
                        newAttendance.setIsValid(false);
                        return newAttendance;
                    });
            if (attendance.getCheckinTime() == null) {
                attendance.setCheckinTime(now);
            }
            if (!AttendanceStatus.ABSENT_EXCUSED.equals(attendance.getStatus())) {
                attendance.setStatus(AttendanceStatus.ATTENDED);
            }
            attendance.setIsValid(true);
            attendanceRepository.save(attendance);
        }
    }

    @Override
    public void checkOut(Integer tutorUserId, AttendanceCodeRequest request){
        TeachingSession teachingSession = validateTutorAndCode(tutorUserId, request);
        if(!SessionStatus.ONGOING.equals(teachingSession.getStatus())){
            throw new BadRequestException("Buổi học chưa check-in hoặc đã kết thúc");
        }
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime sessionEnd = LocalDateTime.of(
                teachingSession.getSessionDate(),
                teachingSession.getEndTime()
        );
        if (now.isBefore(sessionEnd)) {
            throw new BadRequestException("Chỉ được check-out sau khi buổi học kết thúc");
        }
        List<Attendance> attendanceList = attendanceRepository.findBySessionSessionId(teachingSession.getSessionId());
        if(attendanceList.isEmpty()){
            throw new BadRequestException("Chưa có dữ liệu check-in");
        }
        for(Attendance attendance : attendanceList){
            if(attendance.getCheckoutTime() == null) attendance.setCheckoutTime(now);
            attendanceRepository.save(attendance);
        }
        teachingSession.setStatus(SessionStatus.COMPLETED);
        teachingSessionRepository.save(teachingSession);
    }

    private TeachingSession validateTutorAndCode(Integer tutorUserId, AttendanceCodeRequest request){
        if(request.getSessionId() == null){
            throw new BadRequestException("Thiếu buổi học");
        }
        if(request.getAttendanceCode() == null || request.getAttendanceCode().isBlank()){
            throw new BadRequestException("Vui lòng nhập mã điểm danh");
        }
        Tutor tutor = tutorRepository.findByUserUserId(tutorUserId)
                .orElseThrow(() -> new BadRequestException("Không tìm thấy hồ sơ gia sư"));
        TeachingSession teachingSession = teachingSessionRepository.findById(request.getSessionId())
                .orElseThrow(() -> new BadRequestException("Không tìm thấy buổi học"));
        if(!teachingSession.getClassEntity().getTutor().getTutorId().equals(tutor.getTutorId())){
            throw new BadRequestException("Bạn không có quyền điểm danh buổi học này");
        }
        if(!request.getAttendanceCode().equals(teachingSession.getAttendanceCode())){
            throw new BadRequestException("Sai mã điểm danh, vui lòng nhập lại mã điểm danh");
        }
        return teachingSession;
    }
}