package com.tcms.dashboard.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DashboardController {

    @GetMapping("/admin/dashboard")
    public String adminDashboard(HttpSession session) {
        if (session.getAttribute("currentUser") == null) {
            return "redirect:/login";
        }
        return "admin/dashboard";
    }

    @GetMapping("/tutor/dashboard")
    public String tutorDashboard(HttpSession session) {
        if (session.getAttribute("currentUser") == null) {
            return "redirect:/login";
        }
        return "tutor/dashboard";
    }

    @GetMapping("/parent/dashboard")
    public String parentDashboard(HttpSession session) {
        if (session.getAttribute("currentUser") == null) {
            return "redirect:/login";
        }
        return "parent/dashboard";
    }

    @GetMapping("/student/dashboard")
    public String studentDashboard(HttpSession session) {
        if (session.getAttribute("currentUser") == null) {
            return "redirect:/login";
        }
        return "student/dashboard";
    }
}