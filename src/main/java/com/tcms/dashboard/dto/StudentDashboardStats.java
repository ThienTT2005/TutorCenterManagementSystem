package com.tcms.dashboard.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class StudentDashboardStats {
    private long totalClasses;
    private long todaySessions;
    private long pendingHomework;
    private long latestFeedback;
    private long absenceRequests;
}