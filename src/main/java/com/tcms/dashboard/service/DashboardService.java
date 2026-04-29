package com.tcms.dashboard.service;

import com.tcms.dashboard.dto.AdminDashboardStats;
import com.tcms.dashboard.dto.ParentDashboardStats;
import com.tcms.dashboard.dto.StudentDashboardStats;
import com.tcms.dashboard.dto.TutorDashboardStats;

public interface DashboardService {

    AdminDashboardStats getAdminStats();

    TutorDashboardStats getTutorStats(Integer tutorUserId);

    ParentDashboardStats getParentStats(Integer parentUserId);

    StudentDashboardStats getStudentStats(Integer studentUserId);
}