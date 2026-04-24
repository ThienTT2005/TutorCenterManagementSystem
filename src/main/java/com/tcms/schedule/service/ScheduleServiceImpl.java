package com.tcms.schedule.service;

import com.tcms.clazz.entity.ClassEntity;
import com.tcms.clazz.entity.Enrollment;
import com.tcms.clazz.repository.ClassRepository;
import com.tcms.clazz.repository.EnrollmentRepository;
import com.tcms.exception.BadRequestException;
import com.tcms.schedule.dto.request.CreateScheduleRequest;
import com.tcms.schedule.entity.TeachingSchedule;
import com.tcms.schedule.repository.TeachingScheduleRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ScheduleServiceImpl implements ScheduleService {

    private final TeachingScheduleRepository teachingScheduleRepository;
    private final ClassRepository classRepository;
    private final EnrollmentRepository enrollmentRepository;

    @Override
    public List<TeachingSchedule> getSchedulesByClassId(Integer classId) {
        return teachingScheduleRepository.findByClassEntityClassId(classId);
    }

    @Override
    public void createSchedule(CreateScheduleRequest request) {
        validateRequest(request);

        ClassEntity classEntity = classRepository.findById(request.getClassId())
                .orElseThrow(() -> new BadRequestException("Lớp học không tồn tại"));

        LocalTime startTime = LocalTime.parse(request.getStartTime());
        LocalTime endTime = LocalTime.parse(request.getEndTime());

        if (!startTime.isBefore(endTime)) {
            throw new BadRequestException("Giờ bắt đầu phải nhỏ hơn giờ kết thúc");
        }

        checkClassScheduleConflict(classEntity.getClassId(), request.getWeekday(), startTime, endTime);

        if (classEntity.getTutor() != null) {
            checkTutorScheduleConflict(classEntity.getTutor().getTutorId(), request.getWeekday(), startTime, endTime);
        }

        checkStudentScheduleConflict(classEntity.getClassId(), request.getWeekday(), startTime, endTime);

        TeachingSchedule schedule = new TeachingSchedule();
        schedule.setClassEntity(classEntity);
        schedule.setWeekday(request.getWeekday());
        schedule.setStartTime(startTime);
        schedule.setEndTime(endTime);

        teachingScheduleRepository.save(schedule);
    }

    private void validateRequest(CreateScheduleRequest request) {
        if (request.getClassId() == null) {
            throw new BadRequestException("Thiếu lớp học");
        }

        if (request.getWeekday() == null) {
            throw new BadRequestException("Vui lòng chọn thứ trong tuần");
        }

        if (request.getWeekday() < 2 || request.getWeekday() > 8) {
            throw new BadRequestException("Thứ trong tuần không hợp lệ");
        }

        if (request.getStartTime() == null || request.getStartTime().isBlank()) {
            throw new BadRequestException("Vui lòng nhập giờ bắt đầu");
        }

        if (request.getEndTime() == null || request.getEndTime().isBlank()) {
            throw new BadRequestException("Vui lòng nhập giờ kết thúc");
        }
    }

    private void checkClassScheduleConflict(Integer classId, Integer weekday, LocalTime startTime, LocalTime endTime) {
        List<TeachingSchedule> schedules = teachingScheduleRepository.findByClassEntityClassId(classId);

        for (TeachingSchedule s : schedules) {
            if (s.getWeekday().equals(weekday)
                    && isOverlap(startTime, endTime, s.getStartTime(), s.getEndTime())) {
                throw new BadRequestException("Lịch học bị trùng trong cùng lớp");
            }
        }
    }

    private void checkTutorScheduleConflict(Integer tutorId, Integer weekday, LocalTime startTime, LocalTime endTime) {
        List<TeachingSchedule> schedules = teachingScheduleRepository.findByClassEntityTutorTutorId(tutorId);

        for (TeachingSchedule s : schedules) {
            if (s.getWeekday().equals(weekday)
                    && isOverlap(startTime, endTime, s.getStartTime(), s.getEndTime())) {
                throw new BadRequestException("Gia sư đã có lịch dạy trùng thời gian");
            }
        }
    }

    private void checkStudentScheduleConflict(Integer classId, Integer weekday, LocalTime startTime, LocalTime endTime) {
        List<Enrollment> currentClassEnrollments =
                enrollmentRepository.findByClassEntityClassIdAndStatusTrue(classId);

        for (Enrollment currentEnrollment : currentClassEnrollments) {
            Integer studentId = currentEnrollment.getStudent().getStudentId();

            List<TeachingSchedule> allSchedulesInSameWeekday =
                    teachingScheduleRepository.findByWeekday(weekday);

            for (TeachingSchedule schedule : allSchedulesInSameWeekday) {
                List<Enrollment> enrollmentsOfOtherClass =
                        enrollmentRepository.findByClassEntityClassIdAndStatusTrue(
                                schedule.getClassEntity().getClassId()
                        );

                boolean sameStudent = enrollmentsOfOtherClass.stream()
                        .anyMatch(e -> e.getStudent().getStudentId().equals(studentId));

                if (sameStudent
                        && !schedule.getClassEntity().getClassId().equals(classId)
                        && isOverlap(startTime, endTime, schedule.getStartTime(), schedule.getEndTime())) {
                    throw new BadRequestException(
                            "Học sinh " + currentEnrollment.getStudent().getFullName()
                                    + " bị trùng lịch học"
                    );
                }
            }
        }
    }

    private boolean isOverlap(LocalTime start1, LocalTime end1, LocalTime start2, LocalTime end2) {
        return start1.isBefore(end2) && end1.isAfter(start2);
    }
}