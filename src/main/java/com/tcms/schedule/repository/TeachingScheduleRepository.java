package com.tcms.schedule.repository;

import com.tcms.schedule.entity.TeachingSchedule;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TeachingScheduleRepository extends JpaRepository<TeachingSchedule, Integer> {

    List<TeachingSchedule> findByClassEntityClassId(Integer classId);

    List<TeachingSchedule> findByClassEntityTutorTutorId(Integer tutorId);

    List<TeachingSchedule> findByWeekday(Integer weekday);
}