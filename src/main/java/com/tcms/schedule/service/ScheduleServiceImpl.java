package com.tcms.schedule.service;

import com.tcms.clazz.entity.ClassEntity;
import com.tcms.clazz.entity.Enrollment;
import com.tcms.clazz.repository.ClassRepository;
import com.tcms.clazz.repository.EnrollmentRepository;
import com.tcms.exception.BadRequestException;
import com.tcms.schedule.dto.request.CreateScheduleRequest;
import com.tcms.schedule.dto.request.UpdateScheduleRequest;
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

        checkClassScheduleConflict(classEntity.getClassId(), request.getWeekday(), startTime, endTime, null);

        if (classEntity.getTutor() != null) {
            checkTutorScheduleConflict(classEntity.getTutor().getTutorId(), request.getWeekday(), startTime, endTime, null);
        }

        checkStudentScheduleConflict(classEntity.getClassId(), request.getWeekday(), startTime, endTime, null);

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

    private void checkClassScheduleConflict(Integer classId, Integer weekday, LocalTime startTime, LocalTime endTime, Integer excludeScheduleId) {
        List<TeachingSchedule> schedules = teachingScheduleRepository.findByClassEntityClassId(classId);

        for (TeachingSchedule s : schedules) {
            if (s.getWeekday().equals(weekday)
                    && (excludeScheduleId == null || !s.getScheduleId().equals(excludeScheduleId))
                    && isOverlap(startTime, endTime, s.getStartTime(), s.getEndTime())) {
                throw new BadRequestException("Lịch học bị trùng trong cùng lớp");
            }
        }
    }

    private void checkTutorScheduleConflict(Integer tutorId, Integer weekday, LocalTime startTime, LocalTime endTime, Integer excludeScheduleId) {
        List<TeachingSchedule> schedules = teachingScheduleRepository.findByClassEntityTutorTutorId(tutorId);

        for (TeachingSchedule s : schedules) {
            if (s.getWeekday().equals(weekday)
                    && (excludeScheduleId == null || !s.getScheduleId().equals(excludeScheduleId))
                    && isOverlap(startTime, endTime, s.getStartTime(), s.getEndTime())) {
                throw new BadRequestException("Gia sư đã có lịch dạy trùng thời gian");
            }
        }
    }

    private void checkStudentScheduleConflict(Integer classId, Integer weekday, LocalTime startTime, LocalTime endTime, Integer excludeScheduleId) {
        List<Enrollment> currentClassEnrollments =
                enrollmentRepository.findByClassEntityClassIdAndStatusTrue(classId);

        for (Enrollment currentEnrollment : currentClassEnrollments) {
            Integer studentId = currentEnrollment.getStudent().getStudentId();

            List<TeachingSchedule> allSchedulesInSameWeekday =
                    teachingScheduleRepository.findByWeekday(weekday);

            for (TeachingSchedule schedule : allSchedulesInSameWeekday) {
                if (excludeScheduleId != null && schedule.getScheduleId().equals(excludeScheduleId)) {
                    continue;
                }
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
    @Override
    public void deleteSchedule(Integer scheduleId) {

        TeachingSchedule schedule = teachingScheduleRepository.findById(scheduleId)
                .orElseThrow(() -> new BadRequestException("Lịch học không tồn tại"));

        long count = teachingScheduleRepository.countByClassEntityClassId(schedule.getClassEntity().getClassId());
        if (count <= 1) {
            throw new BadRequestException("Cần có ít nhất 1 buổi/tuần cố định");
        }

        teachingScheduleRepository.delete(schedule);
    }

    @Override
    public void updateSchedule(Integer scheduleId,
                               UpdateScheduleRequest request) {

        TeachingSchedule schedule = teachingScheduleRepository.findById(scheduleId)
                .orElseThrow(() -> new BadRequestException("Lịch học không tồn tại"));

        LocalTime startTime = LocalTime.parse(request.getStartTime());
        LocalTime endTime = LocalTime.parse(request.getEndTime());

        if (!startTime.isBefore(endTime)) {
            throw new BadRequestException("Giờ bắt đầu phải nhỏ hơn giờ kết thúc");
        }

        Integer classId = schedule.getClassEntity().getClassId();
        checkClassScheduleConflict(classId, request.getWeekday(), startTime, endTime, scheduleId);

        if (schedule.getClassEntity().getTutor() != null) {
            checkTutorScheduleConflict(schedule.getClassEntity().getTutor().getTutorId(), request.getWeekday(), startTime, endTime, scheduleId);
        }

        checkStudentScheduleConflict(classId, request.getWeekday(), startTime, endTime, scheduleId);

        schedule.setWeekday(request.getWeekday());
        schedule.setStartTime(startTime);
        schedule.setEndTime(endTime);

        teachingScheduleRepository.save(schedule);
    }
}