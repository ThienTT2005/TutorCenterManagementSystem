package com.tcms.homework.controller;

import com.tcms.homework.dto.request.SubmitHomeworkRequest;
import com.tcms.homework.service.HomeworkService;
import com.tcms.homework.service.HomeworkSubmissionService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/student/homework")
public class StudentHomeworkController {

    private final HomeworkService homeworkService;
    private final HomeworkSubmissionService submissionService;

    @GetMapping
    public String listMyHomework(HttpSession session, Model model) {
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            return "redirect:/login";
        }

        model.addAttribute("homeworks", homeworkService.getMyHomework(userId));

        return "student/homework/list";
    }

    @GetMapping("/session/{sessionId}")
    public String listHomeworkBySession(@PathVariable Integer sessionId, Model model) {
        model.addAttribute("homeworks", homeworkService.getHomeworkBySession(sessionId));
        model.addAttribute("sessionId", sessionId);
        return "student/homework/list";
    }

    @GetMapping("/detail/{id}")
    public String viewHomework(@PathVariable Integer id,
                               HttpSession session,
                               Model model) {

        model.addAttribute("homework", homeworkService.getHomeworkById(id));

        Integer userId = (Integer) session.getAttribute("userId");

        if (userId != null) {
            model.addAttribute("submission",
                    submissionService.getMySubmission(userId, id));
        }

        model.addAttribute("request", new SubmitHomeworkRequest());

        return "student/homework/detail";
    }

    @PostMapping("/submit")
    public String submit(@ModelAttribute SubmitHomeworkRequest request,
                         HttpSession session,
                         Model model) {
        try {
            Integer userId = (Integer) session.getAttribute("userId");

            if (userId == null) {
                return "redirect:/login";
            }

            submissionService.submit(userId, request);

            return "redirect:/student/classes";

        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("homework", homeworkService.getHomeworkById(request.getHomeworkId()));
            return "student/homework/detail";
        }
    }
}