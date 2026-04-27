package com.tcms.absence.repository;

import com.tcms.absence.entity.AbsenceRequest;
import com.tcms.absence.entity.AbsenceRequestStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface AbsenceRequestRepository extends JpaRepository<AbsenceRequest, Integer> {

    List<AbsenceRequest> findByParentParentIdOrderByRequestedAtDesc(Integer parentId);

    List<AbsenceRequest> findByStatusOrderByRequestedAtDesc(AbsenceRequestStatus status);

    boolean existsBySessionSessionIdAndStudentStudentIdAndStatus(
            Integer sessionId,
            Integer studentId,
            AbsenceRequestStatus status
    );

    Optional<AbsenceRequest> findBySessionSessionIdAndStudentStudentId(
            Integer sessionId,
            Integer studentId
    );

    boolean existsBySessionSessionIdAndStudentStudentId(Integer sessionId, Integer studentId);
}