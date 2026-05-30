package com.tcms.tutor.controller;

import com.tcms.clazz.entity.ClassEntity;
import com.tcms.learningplan.entity.LearningPlan;

import com.tcms.learningplan.service.LearningPlanService;
import com.tcms.tutor.service.TutorClassService;
import com.tcms.feedback.repository.FeedbackRepository;
import com.tcms.homework.repository.HomeworkRepository;
import com.tcms.learningplan.repository.LearningPlanRepository;
import com.tcms.session.entity.TeachingSession;
import com.tcms.user.entity.User;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequiredArgsConstructor
@RequestMapping("/tutor/classes")
public class TutorClassController {
    private final TutorClassService tutorClassService;
    private final LearningPlanService learningPlanService;
    private final FeedbackRepository feedbackRepository;
    private final HomeworkRepository homeworkRepository;
    private final LearningPlanRepository learningPlanRepository;


    private User getCurrentUser(HttpSession session) {
        return (User) session.getAttribute("currentUser");
    }

    private boolean isTutor(HttpSession session) {
        if (session.getAttribute("currentUser") == null)
            return false;
        String role = (String) session.getAttribute("role");
        return "TUTOR".equalsIgnoreCase(role);
    }

    @GetMapping
    public String myClasses(HttpSession session, Model model) {
        if (!isTutor(session))
            return "redirect:/login";
        User user = getCurrentUser(session);
        model.addAttribute("classes", tutorClassService.getMyClasses(user.getUserId()));
        return "tutor/classes/list";
    }

    @GetMapping("/{classId}")
    public String classDetail(@PathVariable Integer classId,
            HttpSession session,
            Model model) {
        if (!isTutor(session))
            return "redirect:/login";
        User user = getCurrentUser(session);
        ClassEntity classItem = tutorClassService.getMyClassDetail(user.getUserId(), classId);
        List<TeachingSession> sessions = tutorClassService.getSessionsOfClass(user.getUserId(), classId);

        Map<Integer, Boolean> feedbackMap = new HashMap<>();
        Map<Integer, Boolean> homeworkMap = new HashMap<>();
        Map<Integer, Boolean> learningPlanMap = new HashMap<>();

        for (TeachingSession s : sessions) {
            feedbackMap.put(s.getSessionId(), feedbackRepository.existsBySessionSessionId(s.getSessionId()));
            homeworkMap.put(s.getSessionId(), homeworkRepository.existsBySessionSessionId(s.getSessionId()));
            learningPlanMap.put(s.getSessionId(), learningPlanRepository.existsBySessionSessionId(s.getSessionId()));
        }

        model.addAttribute("classItem", classItem);
        model.addAttribute("enrollments", tutorClassService.getStudentsOfClass(user.getUserId(), classId));
        model.addAttribute("sessions", sessions);
        model.addAttribute("feedbackMap", feedbackMap);
        model.addAttribute("homeworkMap", homeworkMap);
        model.addAttribute("learningPlanMap", learningPlanMap);
        model.addAttribute("learningPlanService", learningPlanService);
        return "tutor/classes/detail";

    }
}
