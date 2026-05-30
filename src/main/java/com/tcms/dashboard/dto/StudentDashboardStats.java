package com.tcms.dashboard.dto;

import com.tcms.feedback.entity.Feedback;
import com.tcms.homework.entity.Homework;
import com.tcms.session.entity.TeachingSession;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import java.util.List;

@Getter
@Setter
@Builder
public class StudentDashboardStats {
    private long totalClasses;
    private long todaySessions;
    private long pendingHomework;
    private long latestFeedback;
    private long absenceRequests;
    private List<TeachingSession> upcomingSessions;
    private List<Homework> pendingHomeworkList;
    private List<Feedback> latestFeedbackList;
}