package com.tcms.student.controller;

import com.tcms.feedback.entity.Feedback;
import com.tcms.feedback.repository.FeedbackRepository;
import com.tcms.learningplan.entity.LearningPlan;
import com.tcms.learningplan.repository.LearningPlanRepository;
import com.tcms.student.entity.Student;
import com.tcms.student.repository.StudentRepository;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/student/sessions")
public class StudentSessionController {

    private final StudentRepository studentRepository;
    private final LearningPlanRepository learningPlanRepository;
    private final FeedbackRepository feedbackRepository;

    @GetMapping("/{sessionId}/learning-plan")
    public String viewLearningPlan(
            @PathVariable Integer sessionId,
            HttpSession httpSession,
            Model model
    ) {
        Integer studentUserId = (Integer) httpSession.getAttribute("userId");

        Student student = studentRepository.findByUserUserId(studentUserId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy học sinh"));

        LearningPlan plan = learningPlanRepository
                .findBySessionSessionId(sessionId)
                .orElse(null);

        model.addAttribute("student", student);
        model.addAttribute("plan", plan);

        return "student/learningplans/detail";
    }

    @GetMapping("/{sessionId}/feedback")
    public String viewFeedback(
            @PathVariable Integer sessionId,
            HttpSession httpSession,
            Model model
    ) {
        Integer studentUserId = (Integer) httpSession.getAttribute("userId");

        Student student = studentRepository.findByUserUserId(studentUserId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy học sinh"));

        Feedback feedback = feedbackRepository
                .findBySessionSessionIdAndStudentStudentId(sessionId, student.getStudentId())
                .orElse(null);

        model.addAttribute("student", student);
        model.addAttribute("feedback", feedback);

        return "student/feedback/detail";
    }
}