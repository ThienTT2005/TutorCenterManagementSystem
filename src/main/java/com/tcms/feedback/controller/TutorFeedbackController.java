package com.tcms.feedback.controller;

import com.tcms.clazz.repository.EnrollmentRepository;
import com.tcms.feedback.dto.request.CreateFeedbackRequest;
import com.tcms.feedback.service.FeedbackService;
import com.tcms.session.entity.TeachingSession;
import com.tcms.session.repository.TeachingSessionRepository;
import com.tcms.user.entity.User;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/tutor/sessions")
public class TutorFeedbackController {

    private final FeedbackService feedbackService;
    private final TeachingSessionRepository teachingSessionRepository;
    private final EnrollmentRepository enrollmentRepository;

    private boolean isTutor(HttpSession session) {
        if (session.getAttribute("currentUser") == null) return false;
        String role = (String) session.getAttribute("role");
        return "TUTOR".equalsIgnoreCase(role);
    }

    @GetMapping("/{sessionId}/feedback")
    public String showFeedbackForm(@PathVariable Integer sessionId,
                                   HttpSession session,
                                   Model model) {
        if (!isTutor(session)) return "redirect:/login";

        TeachingSession sessionItem = teachingSessionRepository.findById(sessionId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy buổi học"));

        model.addAttribute("sessionItem", sessionItem);
        model.addAttribute("enrollments",
                enrollmentRepository.findByClassEntityClassIdAndStatusTrue(
                        sessionItem.getClassEntity().getClassId()
                ));
        model.addAttribute("feedbacks", feedbackService.getFeedbackBySession(sessionId));
        model.addAttribute("request", new CreateFeedbackRequest());

        return "tutor/feedback/form";
    }

    @PostMapping("/{sessionId}/feedback")
    public String saveFeedback(@PathVariable Integer sessionId,
                               @ModelAttribute CreateFeedbackRequest request,
                               HttpSession session,
                               Model model) {
        if (!isTutor(session)) return "redirect:/login";

        try {
            User user = (User) session.getAttribute("currentUser");
            request.setSessionId(sessionId);
            feedbackService.createFeedback(user.getUserId(), request);

            return "redirect:/tutor/classes";
        } catch (Exception e) {
            TeachingSession sessionItem = teachingSessionRepository.findById(sessionId)
                    .orElseThrow(() -> new RuntimeException("Không tìm thấy buổi học"));

            model.addAttribute("error", e.getMessage());
            model.addAttribute("sessionItem", sessionItem);
            model.addAttribute("enrollments",
                    enrollmentRepository.findByClassEntityClassIdAndStatusTrue(
                            sessionItem.getClassEntity().getClassId()
                    ));
            return "tutor/feedback/form";
        }
    }
}