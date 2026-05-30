package com.tcms.learningplan.repository;

import com.tcms.learningplan.entity.LearningPlan;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface LearningPlanRepository extends JpaRepository<LearningPlan, Integer> {

    Optional<LearningPlan> findBySessionSessionId(Integer sessionId);

    boolean existsBySessionSessionId(Integer sessionId);
}