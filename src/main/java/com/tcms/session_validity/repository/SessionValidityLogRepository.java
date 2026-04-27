package com.tcms.session_validity.repository;

import com.tcms.session_validity.entity.SessionValidityLog;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface SessionValidityLogRepository extends JpaRepository<SessionValidityLog, Integer> {

    List<SessionValidityLog> findByStudentStudentId(Integer studentId);

    List<SessionValidityLog> findByStudentStudentIdAndSessionSessionIdIn(
            Integer studentId,
            List<Integer> sessionIds
    );
}