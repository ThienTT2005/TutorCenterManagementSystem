package com.tcms.report.controller;

import com.tcms.report.service.ReportService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;

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

        long classes = reportService.countClasses();
        long students = reportService.countStudents();
        long tutors = reportService.countTutors();
        
        model.addAttribute("totalClasses", classes);
        model.addAttribute("totalStudents", students);
        model.addAttribute("totalTutors", tutors);
        model.addAttribute("totalParents", reportService.countParents());
        model.addAttribute("totalRevenue", reportService.calculateRevenue());
        model.addAttribute("topClasses", reportService.getTopClasses());

        // Safe variables for JSP calculations
        model.addAttribute("safeTotalStudents", students);
        model.addAttribute("safeTotalTutors", tutors);
        
        long totalUsers = students + tutors;
        if (totalUsers > 0) {
            model.addAttribute("studentPercent", (students * 100) / totalUsers);
            model.addAttribute("tutorPercent", (tutors * 100) / totalUsers);
        } else {
            model.addAttribute("studentPercent", 50);
            model.addAttribute("tutorPercent", 50);
        }


        
        return "admin/reports/dashboard";
    }
}