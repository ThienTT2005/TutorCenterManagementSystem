package com.tcms.dashboard.service;

import com.tcms.dashboard.dto.AdminDashboardStats;
import com.tcms.dashboard.dto.ParentDashboardStats;
import com.tcms.dashboard.dto.StudentDashboardStats;
import com.tcms.dashboard.dto.TutorDashboardStats;

public interface DashboardService {

    AdminDashboardStats getAdminStats();

    TutorDashboardStats getTutorStats(Integer tutorUserId);

    java.util.List<com.tcms.session.entity.TeachingSession> getTodaySessions(Integer tutorUserId);

    java.util.List<com.tcms.feedback.entity.Feedback> getPendingFeedbacks(Integer tutorUserId);

    java.util.List<com.tcms.session.entity.TeachingSession> getPendingProgress(Integer tutorUserId);

    java.util.List<com.tcms.payment.entity.Payment> getDashboardPayments(Integer tutorUserId);

    java.util.List<com.tcms.homework.entity.HomeworkSubmission> getPendingHomeworkSubmissions(Integer tutorUserId);

    ParentDashboardStats getParentStats(Integer parentUserId);

    StudentDashboardStats getStudentStats(Integer studentUserId);

}