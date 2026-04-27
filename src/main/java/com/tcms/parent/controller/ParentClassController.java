package com.tcms.parent.controller;

import com.tcms.clazz.entity.Enrollment;
import com.tcms.clazz.repository.EnrollmentRepository;
import com.tcms.parent.entity.Parent;
import com.tcms.parent.repository.ParentRepository;
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

        Map<Integer, List<Enrollment>> enrollmentMap = new HashMap<>();

        for (Student child : children) {
            enrollmentMap.put(
                    child.getStudentId(),
                    enrollmentRepository.findByStudentStudentIdAndStatusTrue(child.getStudentId())
            );
        }

        model.addAttribute("parent", parent);
        model.addAttribute("children", children);
        model.addAttribute("enrollmentMap", enrollmentMap);

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

        if (!student.getParent().getParentId().equals(parent.getParentId())) {
            throw new RuntimeException("Bạn không có quyền xem học sinh này");
        }

        boolean joined = enrollmentRepository
                .existsByClassEntityClassIdAndStudentStudentId(classId, studentId);

        if (!joined) {
            throw new RuntimeException("Học sinh không thuộc lớp này");
        }

        model.addAttribute("student", student);
        model.addAttribute("classId", classId);
        model.addAttribute("sessions",
                teachingSessionRepository.findByClassEntityClassIdOrderBySessionDateAscStartTimeAsc(classId));

        return "parent/classes/detail";
    }
}