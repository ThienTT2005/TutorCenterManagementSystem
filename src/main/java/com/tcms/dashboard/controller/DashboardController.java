package com.tcms.dashboard.controller;

import com.tcms.dashboard.service.DashboardService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@RequiredArgsConstructor
public class DashboardController {

    private final DashboardService dashboardService;

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
        if (session.getAttribute("currentUser") == null) {
            return "redirect:/login";
        }

        Integer userId = (Integer) session.getAttribute("userId");
        model.addAttribute("stats", dashboardService.getTutorStats(userId));
        return "tutor/dashboard";
    }

    @GetMapping("/parent/dashboard")
    public String parentDashboard(HttpSession session, Model model) {
        if (session.getAttribute("currentUser") == null) {
            return "redirect:/login";
        }

        Integer userId = (Integer) session.getAttribute("userId");
        model.addAttribute("stats", dashboardService.getParentStats(userId));
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