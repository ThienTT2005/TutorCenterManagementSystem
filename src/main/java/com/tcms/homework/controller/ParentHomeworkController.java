package com.tcms.homework.controller;

import com.tcms.homework.entity.Homework;
import com.tcms.homework.entity.HomeworkSubmission;
import com.tcms.homework.service.HomeworkService;
import com.tcms.homework.service.HomeworkSubmissionService;
import com.tcms.parent.entity.Parent;
import com.tcms.parent.repository.ParentRepository;
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
@RequestMapping("/parent/homework")
public class ParentHomeworkController {

    private final HomeworkService homeworkService;
    private final HomeworkSubmissionService submissionService;
    private final ParentRepository parentRepository;

    private Parent getCurrentParent(HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            throw new RuntimeException("Bạn chưa đăng nhập");
        }
        return parentRepository.findByUserUserId(userId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy phụ huynh"));
    }

    @GetMapping("/session/{sessionId}")
    public String listHomeworkBySession(@PathVariable Integer sessionId,
                                        @RequestParam(required = false) Integer studentId,
                                        HttpSession session,
                                        Model model) {
        Parent parent = getCurrentParent(session);
        List<Homework> homeworks = homeworkService.getHomeworkBySession(sessionId);

        model.addAttribute("parent", parent);
        model.addAttribute("homeworks", homeworks);
        model.addAttribute("sessionId", sessionId);
        model.addAttribute("studentId", studentId);

        return "parent/homework/list";
    }

    @GetMapping("/detail/{homeworkId}")
    public String detail(@PathVariable Integer homeworkId,
                         @RequestParam(required = false) Integer studentId,
                         HttpSession session,
                         Model model) {
        Parent parent = getCurrentParent(session);
        Homework homework = homeworkService.getHomeworkById(homeworkId);

        model.addAttribute("parent", parent);
        model.addAttribute("homework", homework);
        model.addAttribute("questions", homeworkService.getQuestionsByHomeworkId(homeworkId));

        if (studentId != null) {
            HomeworkSubmission submission = submissionService.getMySubmissionByStudentId(studentId, homeworkId);
            model.addAttribute("submission", submission);
            model.addAttribute("studentId", studentId);
        }

        return "parent/homework/detail";
    }
}
