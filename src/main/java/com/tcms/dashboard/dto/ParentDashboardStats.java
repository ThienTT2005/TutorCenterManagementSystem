package com.tcms.dashboard.dto;

import com.tcms.student.entity.Student;
import com.tcms.clazz.entity.Enrollment;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import java.util.List;

@Getter
@Setter
@Builder
public class ParentDashboardStats {
    private long totalClasses;
    private long todaySessions;
    private long pendingHomework;
    private long latestFeedback;
    private long pendingPayments;
    private long absenceRequests;
    private List<Student> children;
    private List<Enrollment> enrollments;
}
