package com.tcms.feedback.service;

import com.tcms.feedback.dto.request.CreateFeedbackRequest;
import com.tcms.feedback.entity.Feedback;

import java.util.List;

public interface FeedbackService {

    List<Feedback> getFeedbackBySession(Integer sessionId);

    List<Feedback> getPendingFeedbacks(String keyword, String className, String status);

    void createFeedback(Integer tutorUserId, CreateFeedbackRequest request);

    void approveFeedback(Integer feedbackId);

    void rejectFeedback(Integer feedbackId);
    List<Feedback> getFeedbacks(String keyword, String className, String status);
}