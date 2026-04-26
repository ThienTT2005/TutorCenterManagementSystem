package com.tcms.feedback.service;

import com.tcms.feedback.dto.request.CreateFeedbackRequest;
import com.tcms.feedback.entity.Feedback;

import java.util.List;

public interface FeedbackService {

    List<Feedback> getFeedbackBySession(Integer sessionId);

    List<Feedback> getPendingFeedbacks();

    void createFeedback(Integer tutorUserId, CreateFeedbackRequest request);

    void approveFeedback(Integer feedbackId);

    void rejectFeedback(Integer feedbackId);
}