package com.tcms.student.controller;

import com.tcms.clazz.repository.EnrollmentRepository;
import com.tcms.session.repository.TeachingSessionRepository;
import com.tcms.student.entity.Student;
import com.tcms.student.repository.StudentRepository;
import com.tcms.user.entity.User;
import com.tcms.feedback.repository.FeedbackRepository;
import com.tcms.homework.repository.HomeworkRepository;
import com.tcms.feedback.entity.FeedbackStatus;
import com.tcms.learningplan.repository.LearningPlanRepository;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/student/classes")
public class StudentClassController {

    private final StudentRepository studentRepository;
    private final EnrollmentRepository enrollmentRepository;
    private final TeachingSessionRepository teachingSessionRepository;
    private final HomeworkRepository homeworkRepository;
    private final FeedbackRepository feedbackRepository;
    private final LearningPlanRepository learningPlanRepository;

    private Student getCurrentStudent(HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null && session.getAttribute("currentUser") != null) {
            User currentUser = (User) session.getAttribute("currentUser");
            userId = currentUser.getUserId();
        }

        if (userId == null) {
            throw new RuntimeException("Bạn chưa đăng nhập");
        }

        return studentRepository.findByUserUserId(userId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy học sinh"));
    }

    @GetMapping
    public String listClasses(HttpSession session, Model model) {
        Student student = getCurrentStudent(session);

        model.addAttribute("student", student);
        model.addAttribute("enrollments",
                enrollmentRepository.findByStudentStudentIdAndStatusTrue(student.getStudentId()));

        return "student/classes/list";
    }

    @GetMapping("/{classId}")
    public String classDetail(@PathVariable Integer classId,
                               HttpSession session,
                               Model model) {

        Student student = getCurrentStudent(session);

        var enrollment = enrollmentRepository
                .findByStudentStudentIdAndStatusTrue(student.getStudentId())
                .stream()
                .filter(e -> e.getClassEntity() != null
                        && e.getClassEntity().getClassId().equals(classId))
                .findFirst()
                .orElseThrow(() -> new RuntimeException("Bạn không thuộc lớp này"));

        var sessions =
                teachingSessionRepository
                        .findByClassEntityClassIdOrderBySessionDateAscStartTimeAsc(classId);

        Map<Integer, Object> homeworkMap = new HashMap<>();
        Map<Integer, Object> feedbackMap = new HashMap<>();
        Map<Integer, Object> learningPlanMap = new HashMap<>();

        for (var sessionItem : sessions) {

            Integer sessionId = sessionItem.getSessionId();

            var homeworks =
                    homeworkRepository.findBySessionSessionId(sessionId);

            if (homeworks != null && !homeworks.isEmpty()) {
                homeworkMap.put(sessionId, homeworks);
            }

            var feedback =
                    feedbackRepository.findBySessionSessionIdAndStatus(sessionId, FeedbackStatus.APPROVED);

            if (feedback != null && !feedback.isEmpty()) {
                feedbackMap.put(sessionId, feedback);
            }

            var learningPlan =
                    learningPlanRepository.findBySessionSessionId(sessionId)
                            .orElse(null);

            if (learningPlan != null) {
                learningPlanMap.put(sessionId, learningPlan);
            }
        }

        model.addAttribute("student", student);

        model.addAttribute("classItem", enrollment.getClassEntity());

        model.addAttribute("sessions", sessions);

        model.addAttribute("homeworkMap", homeworkMap);

        model.addAttribute("feedbackMap", feedbackMap);

        model.addAttribute("learningPlanMap", learningPlanMap);

        return "student/classes/detail";
    }
}