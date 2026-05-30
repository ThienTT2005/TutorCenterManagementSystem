package com.tcms.homework.controller;

import com.tcms.homework.service.HomeworkSubmissionService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/tutor/homework/submissions")
public class TutorHomeworkSubmissionController {

    private final HomeworkSubmissionService submissionService;
    private final com.tcms.homework.service.HomeworkService homeworkService;

    @GetMapping("/homework/{homeworkId}")
    public String list(@PathVariable Integer homeworkId, Model model) {

        model.addAttribute("submissions",
                submissionService.getSubmissionsByHomework(homeworkId));
        
        model.addAttribute("homework", homeworkService.getHomeworkById(homeworkId));
        model.addAttribute("homeworkId", homeworkId);

        return "tutor/homework/submissions";
    }

    @GetMapping("/{submissionId}")
    public String detail(@PathVariable Integer submissionId, Model model) {

        model.addAttribute("submission",
                submissionService.getById(submissionId));

        return "tutor/homework/submission-detail";
    }

    @PostMapping("/grade")
    public String grade(@RequestParam Integer submissionId,
                        @RequestParam Double score,
                        @RequestParam String feedback) {

        submissionService.grade(submissionId, score, feedback);

        return "redirect:/tutor/homework/submissions/" + submissionId;
    }
}