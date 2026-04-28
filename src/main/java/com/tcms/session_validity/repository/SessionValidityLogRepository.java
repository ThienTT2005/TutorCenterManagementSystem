package com.tcms.session_validity.repository;

import com.tcms.session_validity.entity.SessionValidityLog;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface SessionValidityLogRepository extends JpaRepository<SessionValidityLog, Integer> {

    List<SessionValidityLog> findByStudentStudentId(Integer studentId);

    List<SessionValidityLog> findByStudentStudentIdAndIsPaidFalse(Integer studentId);

    List<SessionValidityLog> findByStudentStudentIdAndSessionSessionIdIn(
            Integer studentId,
            List<Integer> sessionIds
    );

    Optional<SessionValidityLog> findBySessionSessionIdAndStudentStudentId(
            Integer sessionId,
            Integer studentId
    );
}