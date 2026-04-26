package com.tcms.feedback.controller;

import com.tcms.feedback.service.FeedbackService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/feedback")
public class AdminFeedbackController {

    private final FeedbackService feedbackService;

    private boolean isAdmin(HttpSession session) {
        if (session.getAttribute("currentUser") == null) return false;
        String role = (String) session.getAttribute("role");
        return "ADMIN".equalsIgnoreCase(role);
    }

    @GetMapping("/pending")
    public String pendingFeedbacks(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login";

        model.addAttribute("feedbacks", feedbackService.getPendingFeedbacks());
        return "admin/feedback/pending";
    }

    @PostMapping("/{feedbackId}/approve")
    public String approve(@PathVariable Integer feedbackId, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/login";

        feedbackService.approveFeedback(feedbackId);
        return "redirect:/admin/feedback/pending";
    }

    @PostMapping("/{feedbackId}/reject")
    public String reject(@PathVariable Integer feedbackId, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/login";

        feedbackService.rejectFeedback(feedbackId);
        return "redirect:/admin/feedback/pending";
    }
}