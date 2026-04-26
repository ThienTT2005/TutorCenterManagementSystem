package com.tcms.feedback.repository;

import com.tcms.feedback.entity.Feedback;
import com.tcms.feedback.entity.FeedbackStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface FeedbackRepository extends JpaRepository<Feedback, Integer> {

    List<Feedback> findBySessionSessionId(Integer sessionId);

    List<Feedback> findByStatus(FeedbackStatus status);

    Optional<Feedback> findBySessionSessionIdAndStudentStudentId(Integer sessionId, Integer studentId);
}