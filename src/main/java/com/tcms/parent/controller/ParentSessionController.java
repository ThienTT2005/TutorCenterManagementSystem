package com.tcms.parent.controller;

import com.tcms.feedback.repository.FeedbackRepository;
import com.tcms.learningplan.entity.LearningPlan;
import com.tcms.learningplan.repository.LearningPlanRepository;
import com.tcms.parent.entity.Parent;
import com.tcms.parent.repository.ParentRepository;
import com.tcms.session.entity.TeachingSession;
import com.tcms.session.repository.TeachingSessionRepository;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/parent/sessions")
public class ParentSessionController {

    private final ParentRepository parentRepository;
    private final TeachingSessionRepository teachingSessionRepository;
    private final LearningPlanRepository learningPlanRepository;
    private final FeedbackRepository feedbackRepository;

    private Parent getCurrentParent(HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            throw new RuntimeException("Bạn chưa đăng nhập");
        }

        return parentRepository.findByUserUserId(userId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy phụ huynh"));
    }

    @GetMapping("/{sessionId}/learning-plan")
    public String viewLearningPlan(@PathVariable Integer sessionId,
                                   HttpSession httpSession,
                                   Model model) {

        Parent parent = getCurrentParent(httpSession);

        TeachingSession sessionItem = teachingSessionRepository.findById(sessionId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy buổi học"));

        LearningPlan plan = learningPlanRepository
                .findBySessionSessionId(sessionId)
                .orElse(null);

        model.addAttribute("parent", parent);
        model.addAttribute("sessionItem", sessionItem);
        model.addAttribute("plan", plan);

        return "parent/learningplans/detail";
    }

    @GetMapping("/{sessionId}/feedback")
    public String viewFeedback(@PathVariable Integer sessionId,
                               @RequestParam Integer studentId,
                               HttpSession httpSession,
                               Model model) {

        Parent parent = getCurrentParent(httpSession);

        TeachingSession sessionItem = teachingSessionRepository.findById(sessionId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy buổi học"));

        model.addAttribute("parent", parent);
        model.addAttribute("sessionItem", sessionItem);

        model.addAttribute(
                "feedback",
                feedbackRepository
                        .findBySessionSessionIdAndStudentStudentId(sessionId, studentId)
                        .orElse(null)
        );

        return "parent/feedback/detail";
    }
}