package com.tcms.session.repository;

import com.tcms.session.entity.TeachingSession;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;
import java.util.List;

public interface TeachingSessionRepository extends JpaRepository<TeachingSession, Integer> {

    List<TeachingSession> findByClassEntityClassIdOrderBySessionDateAscStartTimeAsc(Integer classId);

    List<TeachingSession> findByClassEntityClassIdAndSessionDateBetweenOrderBySessionDateAscStartTimeASC(
            Integer classId,
            LocalDate startDate,
            LocalDate endDate
    );
}