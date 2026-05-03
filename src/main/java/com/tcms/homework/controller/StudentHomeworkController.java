package com.tcms.homework.controller;

import com.tcms.homework.dto.request.SubmitHomeworkRequest;
import com.tcms.homework.entity.HomeworkSubmission;
import com.tcms.homework.service.HomeworkService;
import com.tcms.homework.service.HomeworkSubmissionService;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpSession;
import java.util.Map;
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
            HomeworkSubmission submission = submissionService.getMySubmission(userId, id);
            model.addAttribute("submission", submission);

            if (submission != null && submission.getAnswers() != null) {
                try {
                    ObjectMapper mapper = new ObjectMapper();
                    Map<String, String> answersMap = mapper.readValue(
                            submission.getAnswers(),
                            new com.fasterxml.jackson.core.type.TypeReference<Map<String, String>>() {}
                    );
                    model.addAttribute("studentAnswers", answersMap);
                } catch (Exception e) {
                    // Ignore parsing errors
                }
            }
        }

        model.addAttribute("questions", homeworkService.getQuestionsByHomeworkId(id));
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
            model.addAttribute("questions", homeworkService.getQuestionsByHomeworkId(request.getHomeworkId()));
            return "student/homework/detail";
        }
    }
}