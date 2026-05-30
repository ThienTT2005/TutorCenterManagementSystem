package com.tcms.session.repository;

import com.tcms.session.entity.SessionStatus;
import com.tcms.session.entity.TeachingSession;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

public interface TeachingSessionRepository extends JpaRepository<TeachingSession, Integer> {

    List<TeachingSession> findByClassEntityClassIdOrderBySessionDateAscStartTimeAsc(Integer classId);

    List<TeachingSession> findByClassEntityClassIdAndSessionDateBetweenOrderBySessionDateAscStartTimeAsc(
            Integer classId,
            LocalDate startDate,
            LocalDate endDate
    );

    List<TeachingSession> findByClassEntityClassIdInAndSessionDateBetweenOrderBySessionDateAscStartTimeAsc(
            List<Integer> classIds,
            LocalDate startDate,
            LocalDate endDate
    );


    @Modifying
    @Query("""
        DELETE FROM TeachingSession s
        WHERE s.classEntity.classId = :classId
          AND FUNCTION('DAYOFWEEK', s.sessionDate) = :weekday
          AND s.startTime = :startTime
          AND s.endTime = :endTime
          AND s.status <> :completedStatus
    """)
    void deleteUncompletedSessionsBySchedule(
            @Param("classId") Integer classId,
            @Param("weekday") Integer weekday,
            @Param("startTime") LocalTime startTime,
            @Param("endTime") LocalTime endTime,
            @Param("completedStatus") SessionStatus completedStatus
    );
}