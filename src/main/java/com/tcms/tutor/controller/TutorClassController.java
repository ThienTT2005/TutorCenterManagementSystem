package com.tcms.tutor.controller;

import com.tcms.learningplan.entity.LearningPlan;
import com.tcms.learningplan.service.LearningPlanService;
import com.tcms.tutor.service.TutorClassService;
import com.tcms.user.entity.User;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequiredArgsConstructor
@RequestMapping("/tutor/classes")
public class TutorClassController {
    private final TutorClassService tutorClassService;
    private final LearningPlanService learningPlanService;
    private User getCurrentUser(HttpSession session){
        return (User) session.getAttribute("currentUser");
    }
    private boolean isTutor(HttpSession session){
        if(session.getAttribute("currentUser") == null) return false;
        String role = (String) session.getAttribute("role");
        return "TUTOR".equalsIgnoreCase(role);
    }

    @GetMapping
    public String myClasses(HttpSession session, Model model){
        if(!isTutor(session)) return "redirect:/login";
        User user = getCurrentUser(session);
        model.addAttribute("classes", tutorClassService.getMyClasses(user.getUserId()));
        return "tutor/classes/list";
    }

    @GetMapping("/{classId}")
    public String classDetail(@PathVariable Integer classId,
                              HttpSession session,
                              Model model){
        if(!isTutor(session)) return "redirect:/login";
        User user = getCurrentUser(session);
        model.addAttribute("classItem", tutorClassService.getMyClassDetail(user.getUserId(), classId));
        model.addAttribute("enrollments", tutorClassService.getStudentsOfClass(user.getUserId(), classId));
        model.addAttribute("sessions", tutorClassService.getSessionsOfClass(user.getUserId(), classId));
        model.addAttribute("learningPlanService", learningPlanService);
        return "tutor/classes/detail";
    }
}
