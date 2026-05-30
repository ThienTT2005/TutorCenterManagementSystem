package com.tcms.learningplan.controller;

import com.tcms.learningplan.dto.request.CreateLearningPlanRequest;
import com.tcms.learningplan.service.LearningPlanService;
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
public class LearningPlanController {
    private final LearningPlanService learningPlanService;
    private final TeachingSessionRepository teachingSessionRepository;
    private boolean isTutor(HttpSession session){
        if(session.getAttribute("currentUser") == null) return false;
        String role = (String) session.getAttribute("role");
        return "TUTOR".equalsIgnoreCase(role);
    }

    @GetMapping("/{sessionId}/learning-plan")
    public String showLearningPlanForm(@PathVariable Integer sessionId,
                                       HttpSession session,
                                       Model model){
        if(!isTutor(session)) return "redirect:/login";
        TeachingSession teachingSession = teachingSessionRepository.findById(sessionId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy buổi học"));
        var oldPlan = learningPlanService.getPlanBySessionId(sessionId);
        CreateLearningPlanRequest request = new CreateLearningPlanRequest();
        request.setSessionId(sessionId);
        if(oldPlan != null){
            request.setTitle(oldPlan.getTitle());
            request.setContent(oldPlan.getContent());
            request.setObjectives(oldPlan.getObjectives());
        }
        model.addAttribute("sessionItem", teachingSession);
        model.addAttribute("request", request);

        return "tutor/learningplans/form";
    }

    @PostMapping("/{sessionId}/learning-plan")
    public String saveLearningPlan(@PathVariable Integer sessionId,
                                   @ModelAttribute("request") CreateLearningPlanRequest request,
                                   HttpSession session,
                                   Model model){
        if(!isTutor(session)) return "redirect:/login";
        try{
            User user =  (User) session.getAttribute("currentUser");
            request.setSessionId(sessionId);
            learningPlanService.createOrUpdatePlan(user.getUserId(), request);
            TeachingSession teachingSession = teachingSessionRepository.findById(sessionId)
                    .orElseThrow(() -> new RuntimeException("Không tìm thấy buổi học"));
            return "redirect:/tutor/classes/" + teachingSession.getClassEntity().getClassId();
        } catch(Exception e){
            TeachingSession teachingSession = teachingSessionRepository.findById(sessionId)
                    .orElseThrow(() -> new RuntimeException("Không tìm thấy buổi học"));
            model.addAttribute("error", e.getMessage());
            model.addAttribute("sessionItem", teachingSession);
            return "tutor/learningplans/form";
        }
    }
}
