package com.tcms.absence.controller;

import com.tcms.absence.dto.request.CreateAbsenceRequest;
import com.tcms.absence.service.AbsenceRequestService;
import com.tcms.clazz.repository.EnrollmentRepository;
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

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;


@Controller
@RequiredArgsConstructor
@RequestMapping("/parent/absence")
public class ParentAbsenceController {

    private final AbsenceRequestService service;
    private final ParentRepository parentRepository;
    private final StudentRepository studentRepository;
    private final TeachingSessionRepository sessionRepository;
    private final EnrollmentRepository enrollmentRepository;


    @GetMapping("/create")
    public String form(@RequestParam(required = false) Integer sessionId,
                       @RequestParam(required = false) Integer studentId,
                       HttpSession session,
                       Model model) {

        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) return "redirect:/login";

        Parent parent = parentRepository.findByUserUserId(userId)
                .orElseThrow(() -> new RuntimeException("Parent not found"));

        if (sessionId != null && studentId != null) {
            TeachingSession ts = sessionRepository.findById(sessionId).orElse(null);
            Student s = studentRepository.findById(studentId).orElse(null);
            model.addAttribute("selectedSession", ts);
            model.addAttribute("selectedStudent", s);
        }

        List<Student> children = studentRepository.findByParentParentId(parent.getParentId());
        model.addAttribute("children", children);

        List<Integer> childIds = children.stream().map(Student::getStudentId).collect(Collectors.toList());
        List<com.tcms.clazz.entity.Enrollment> enrollments = enrollmentRepository.findByStudentStudentIdInAndStatusTrue(childIds);
        model.addAttribute("enrollments", enrollments);

        List<Integer> classIds = enrollments.stream().map(e -> e.getClassEntity().getClassId()).distinct().collect(Collectors.toList());
        
        LocalDate today = LocalDate.now();
        LocalDate nextWeek = today.plusDays(7);
        
        List<TeachingSession> upcomingSessions = sessionRepository.findByClassEntityClassIdInAndSessionDateBetweenOrderBySessionDateAscStartTimeAsc(
                classIds, today, nextWeek);
        model.addAttribute("upcomingSessions", upcomingSessions);


        CreateAbsenceRequest req = new CreateAbsenceRequest();
        req.setSessionId(sessionId);
        req.setStudentId(studentId);

        model.addAttribute("request", req);
        return "parent/absence/create";
    }


    @PostMapping("/create")
    public String create(@ModelAttribute CreateAbsenceRequest request,
                         HttpSession session,
                         Model model) {
        try {
            Integer userId = (Integer) session.getAttribute("userId");
            service.create(userId, request);
            return "redirect:/parent/absence/list";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("request", request);
            return "parent/absence/create";
        }
    }

    @GetMapping("/list")
    public String list(HttpSession session, Model model) {
        Integer userId = (Integer) session.getAttribute("userId");

        model.addAttribute("requests", service.getMyRequests(userId));

        return "parent/absence/list";
    }
}