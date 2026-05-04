package com.tcms.report.controller;

import com.tcms.report.service.ReportService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/reports")
public class ReportController {

    private final ReportService reportService;

    private boolean isAdmin(HttpSession session) {
        Object role = session.getAttribute("role");
        return role != null && "ADMIN".equalsIgnoreCase(role.toString());
    }

    @GetMapping
    public String dashboard(HttpSession session, Model model) {

        if (!isAdmin(session)) {
            return "redirect:/login";
        }

        model.addAttribute("totalClasses", reportService.countClasses());
        model.addAttribute("totalStudents", reportService.countStudents());
        model.addAttribute("totalTutors", reportService.countTutors());
        model.addAttribute("totalRevenue", reportService.calculateRevenue());
        model.addAttribute("topClasses", reportService.getTopClasses());

        return "admin/reports/dashboard";
    }
}