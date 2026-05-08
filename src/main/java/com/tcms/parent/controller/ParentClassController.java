package com.tcms.parent.controller;

import com.tcms.clazz.entity.Enrollment;
import com.tcms.clazz.repository.EnrollmentRepository;
import com.tcms.feedback.repository.FeedbackRepository;
import com.tcms.homework.entity.Homework;
import com.tcms.homework.repository.HomeworkRepository;
import com.tcms.homework.service.HomeworkService;
import com.tcms.homework.service.HomeworkSubmissionService;
import com.tcms.learningplan.repository.LearningPlanRepository;
import com.tcms.parent.entity.Parent;
import com.tcms.parent.repository.ParentRepository;
import com.tcms.session.entity.TeachingSession;
import com.tcms.session.repository.TeachingSessionRepository;
import com.tcms.student.entity.Student;
import com.tcms.student.repository.StudentRepository;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/parent/classes")
public class ParentClassController {

    private final ParentRepository parentRepository;
    private final StudentRepository studentRepository;
    private final EnrollmentRepository enrollmentRepository;
    private final TeachingSessionRepository teachingSessionRepository;

    private final FeedbackRepository feedbackRepository;
    private final HomeworkRepository homeworkRepository;
    private final LearningPlanRepository learningPlanRepository;
    private final HomeworkService homeworkService;
    private final HomeworkSubmissionService submissionService;

    private Parent getCurrentParent(HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            throw new RuntimeException("Bạn chưa đăng nhập");
        }

        return parentRepository.findByUserUserId(userId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy phụ huynh"));
    }

    @GetMapping
    public String listChildrenClasses(HttpSession session, Model model) {
        Parent parent = getCurrentParent(session);

        List<Student> children = studentRepository.findByParentParentId(parent.getParentId());

        List<Enrollment> allEnrollments = new java.util.ArrayList<>();
        for (Student child : children) {
            allEnrollments.addAll(
                    enrollmentRepository.findByStudentStudentIdAndStatusTrue(child.getStudentId())
            );
        }

        model.addAttribute("parent", parent);
        model.addAttribute("loggedInUser", parent);
        model.addAttribute("children", children);
        model.addAttribute("enrollments", allEnrollments);

        return "parent/classes/list";
    }

    @GetMapping("/{studentId}/{classId}")
    public String classDetail(@PathVariable Integer studentId,
                              @PathVariable Integer classId,
                              HttpSession session,
                              Model model) {

        Parent parent = getCurrentParent(session);

        Student student = studentRepository.findById(studentId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy học sinh"));

        if (student.getParent() == null ||
                !student.getParent().getParentId().equals(parent.getParentId())) {
            throw new RuntimeException("Bạn không có quyền xem học sinh này");
        }

        boolean joined = enrollmentRepository
                .existsByClassEntityClassIdAndStudentStudentId(classId, studentId);

        if (!joined) {
            throw new RuntimeException("Học sinh không thuộc lớp này");
        }

        List<TeachingSession> sessions =
                teachingSessionRepository.findByClassEntityClassIdOrderBySessionDateAscStartTimeAsc(classId);

        Map<Integer, Object> feedbackMap = new HashMap<>();
        Map<Integer, Object> homeworkMap = new HashMap<>();
        Map<Integer, Object> learningPlanMap = new HashMap<>();

        for (TeachingSession sessionItem : sessions) {
            Integer sessionId = sessionItem.getSessionId();

            feedbackRepository.findBySessionSessionIdAndStudentStudentId(sessionId, studentId)
                    .ifPresent(feedback -> feedbackMap.put(sessionId, feedback));

            homeworkMap.put(
                    sessionId,
                    homeworkRepository.findBySessionSessionId(sessionId)
            );

            learningPlanRepository.findBySessionSessionId(sessionId)
                    .ifPresent(plan -> learningPlanMap.put(sessionId, plan));
        }

        model.addAttribute("parent", parent);
        model.addAttribute("loggedInUser", parent);
        model.addAttribute("student", student);
        model.addAttribute("classId", classId);
        model.addAttribute("sessions", sessions);

        model.addAttribute("feedbackMap", feedbackMap);
        model.addAttribute("homeworkMap", homeworkMap);
        model.addAttribute("learningPlanMap", learningPlanMap);

        return "parent/classes/detail";
    }
}