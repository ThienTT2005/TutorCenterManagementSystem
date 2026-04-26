package com.tcms.homework.controller;

import com.tcms.homework.dto.request.CreateHomeworkRequest;
import com.tcms.homework.service.HomeworkService;
import com.tcms.user.entity.User;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/tutor/homework")
public class TutorHomeworkController {

    private final HomeworkService homeworkService;

    private boolean isTutor(HttpSession session) {
        Object role = session.getAttribute("role");
        return role != null && "TUTOR".equalsIgnoreCase(role.toString());
    }

    private Integer getCurrentUserId(HttpSession session) {
        Object userIdObj = session.getAttribute("userId");

        if (userIdObj != null) {
            return (Integer) userIdObj;
        }

        Object currentUserObj = session.getAttribute("currentUser");

        if (currentUserObj instanceof User currentUser) {
            return currentUser.getUserId();
        }

        return null;
    }

    @GetMapping("/create")
    public String showCreateHomeworkForm(@RequestParam Integer sessionId,
                                         HttpSession session,
                                         Model model) {

        if (!isTutor(session)) {
            return "redirect:/login";
        }

        CreateHomeworkRequest request = new CreateHomeworkRequest();
        request.setSessionId(sessionId);

        model.addAttribute("request", request);

        return "tutor/homework/create";
    }

    @PostMapping("/create")
    public String createHomework(@ModelAttribute("request") CreateHomeworkRequest request,
                                 HttpSession session,
                                 Model model) {

        if (!isTutor(session)) {
            return "redirect:/login";
        }

        try {
            Integer tutorUserId = getCurrentUserId(session);

            if (tutorUserId == null) {
                throw new RuntimeException("Session không có userId. Hãy đăng nhập lại.");
            }

            homeworkService.createHomework(tutorUserId, request);

            return "redirect:/tutor/classes";

        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("request", request);
            return "tutor/homework/create";
        }
    }

    @GetMapping("/session/{sessionId}")
    public String listHomeworkBySession(@PathVariable Integer sessionId, Model model) {
        model.addAttribute("homeworks", homeworkService.getHomeworkBySession(sessionId));
        model.addAttribute("sessionId", sessionId);
        return "tutor/homework/list";
    }
}