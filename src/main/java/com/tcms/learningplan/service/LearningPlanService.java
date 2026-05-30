package com.tcms.learningplan.service;

import com.tcms.learningplan.dto.request.CreateLearningPlanRequest;
import com.tcms.learningplan.entity.LearningPlan;

public interface LearningPlanService {

    LearningPlan getPlanBySessionId(Integer sessionId);

    void createOrUpdatePlan(Integer userId, CreateLearningPlanRequest request);
}