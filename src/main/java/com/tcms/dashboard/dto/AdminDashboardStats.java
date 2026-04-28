package com.tcms.dashboard.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.Map;

@Getter
@Setter
@Builder
public class AdminDashboardStats {
    private long totalStudents;
    private long totalTutors;
    private BigDecimal monthlyRevenue;
    private long pendingPayments;
    private long activeClasses;
    private long pendingFeedbacks;
    private long pendingAbsenceRequests;
    private Map<String, Long> monthlyGrowth;
}