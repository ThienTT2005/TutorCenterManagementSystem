package com.tcms.dashboard.controller;

import com.tcms.dashboard.service.DashboardService;
import com.tcms.notification.service.NotificationService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@RequiredArgsConstructor
public class DashboardController {

    private final DashboardService dashboardService;
    private final com.tcms.tutor.repository.TutorRepository tutorRepository;
    private final com.tcms.parent.repository.ParentRepository parentRepository;
    private final NotificationService notificationService;
    @GetMapping("/admin/dashboard")
    public String adminDashboard(HttpSession session, Model model) {
        if (session.getAttribute("currentUser") == null) {
            return "redirect:/login";
        }

        model.addAttribute("stats", dashboardService.getAdminStats());
        return "admin/dashboard";
    }

    @GetMapping("/tutor/dashboard")
    public String tutorDashboard(HttpSession session, Model model) {
        com.tcms.user.entity.User user = (com.tcms.user.entity.User) session.getAttribute("currentUser");
        if (user == null) {
            return "redirect:/login";
        }

        Integer userId = user.getUserId();
        model.addAttribute("stats", dashboardService.getTutorStats(userId));
        
        // Fetch tutor profile for name and avatar
        tutorRepository.findByUserUserId(userId).ifPresent(tutor -> {
            model.addAttribute("loggedInUser", tutor);
        });
        
        model.addAttribute("currentUser", user);
        model.addAttribute("now", java.time.LocalDate.now());

        model.addAttribute("notifications", notificationService.getLatestNotifications(userId));
        model.addAttribute("unreadCount", notificationService.countUnread(userId));

        // Real data for dashboard lists
        model.addAttribute("todaySessions", dashboardService.getTodaySessions(userId));
        model.addAttribute("pendingFeedbacks", dashboardService.getPendingFeedbacks(userId));
        model.addAttribute("pendingProgress", dashboardService.getPendingProgress(userId));
        model.addAttribute("dashboardPayments", dashboardService.getDashboardPayments(userId));
        model.addAttribute("pendingHomeworkSubmissions", dashboardService.getPendingHomeworkSubmissions(userId));


        return "tutor/dashboard";
    }

    @GetMapping("/parent/dashboard")
    public String parentDashboard(HttpSession session, Model model) {
        com.tcms.user.entity.User user =
                (com.tcms.user.entity.User) session.getAttribute("currentUser");

        if (user == null || !user.getRole().getRoleName().equals("PARENT")) {
            return "redirect:/login";
        }

        Integer userId = user.getUserId();

        parentRepository.findByUserUserId(userId).ifPresent(p -> {
            model.addAttribute("loggedInUser", p);
        });

        model.addAttribute("currentUser", user);
        model.addAttribute("stats", dashboardService.getParentStats(userId));
        model.addAttribute("todaySessions", dashboardService.getTodaySessions(userId));

        model.addAttribute("notifications", notificationService.getLatestNotifications(userId));
        model.addAttribute("unreadCount", notificationService.countUnread(userId));

        return "parent/dashboard";
    }

    @GetMapping("/student/dashboard")
    public String studentDashboard(HttpSession session, Model model) {
        if (session.getAttribute("currentUser") == null) {
            return "redirect:/login";
        }

        Integer userId = (Integer) session.getAttribute("userId");
        model.addAttribute("stats", dashboardService.getStudentStats(userId));
        return "student/dashboard";
    }
}