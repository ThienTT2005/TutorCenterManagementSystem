package com.tcms.student.controller;

import com.tcms.clazz.repository.EnrollmentRepository;
import com.tcms.session.repository.TeachingSessionRepository;
import com.tcms.student.entity.Student;
import com.tcms.student.repository.StudentRepository;
import com.tcms.user.entity.User;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/student/classes")
public class StudentClassController {

    private final StudentRepository studentRepository;
    private final EnrollmentRepository enrollmentRepository;
    private final TeachingSessionRepository teachingSessionRepository;

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

        boolean joined = enrollmentRepository
                .existsByClassEntityClassIdAndStudentStudentId(classId, student.getStudentId());

        if (!joined) {
            throw new RuntimeException("Bạn không thuộc lớp này");
        }

        model.addAttribute("sessions",
                teachingSessionRepository.findByClassEntityClassIdOrderBySessionDateAscStartTimeAsc(classId));

        return "student/classes/detail";
    }
}