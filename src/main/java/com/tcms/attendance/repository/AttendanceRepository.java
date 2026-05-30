package com.tcms.attendance.repository;

import com.tcms.attendance.entity.Attendance;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface AttendanceRepository extends JpaRepository<Attendance, Integer> {

    List<Attendance> findBySessionSessionId(Integer sessionId);

    Optional<Attendance> findBySessionSessionIdAndStudentStudentId(Integer sessionId, Integer studentId);
}