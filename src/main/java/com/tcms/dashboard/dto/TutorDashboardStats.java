package com.tcms.dashboard.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class TutorDashboardStats {
    private long totalClasses;
    private long todayClasses;
    private long pendingFeedbacks;
    private long homeworkToGrade;
    private long pendingPayments;
}