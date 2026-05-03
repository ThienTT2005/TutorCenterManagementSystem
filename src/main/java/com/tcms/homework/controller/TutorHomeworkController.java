package com.tcms.homework.controller;

import com.tcms.homework.dto.request.CreateHomeworkRequest;
import com.tcms.homework.service.HomeworkService;
import com.tcms.session.entity.TeachingSession;
import com.tcms.session.repository.TeachingSessionRepository;
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
    private final TeachingSessionRepository teachingSessionRepository;

    private boolean isTutor(HttpSession session) {
        Object role = session.getAttribute("role");
        return role != null && "TUTOR".equalsIgnoreCase(role.toString());
    }

    private Integer getCurrentUserId(HttpSession session) {
        Object userIdObj = session.getAttribute("userId");

        if (userIdObj instanceof Integer userId) {
            return userId;
        }

        Object currentUserObj = session.getAttribute("currentUser");

        if (currentUserObj instanceof User currentUser) {
            return currentUser.getUserId();
        }

        return null;
    }
    // đã sửa GetMapping("/session/{sessionId}") và create

    @GetMapping("/session/{sessionId}")
    public String listHomeworkBySession(@PathVariable Integer sessionId,
                                        HttpSession session,
                                        Model model) {

        if (!isTutor(session)) {
            return "redirect:/login";
        }

        TeachingSession sessionItem = teachingSessionRepository.findById(sessionId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy buổi học"));
    // sửa ở đây
        model.addAttribute("sessionItem", sessionItem);
        model.addAttribute("homeworks", homeworkService.getHomeworkBySession(sessionId));

        return "tutor/homework/list";
    }

    @GetMapping("/create")
    public String showCreateHomeworkForm(@RequestParam("sessionId") Integer sessionId,
                                         HttpSession session,
                                         Model model) {

        if (!isTutor(session)) {
            return "redirect:/login";
        }

        TeachingSession sessionItem = teachingSessionRepository.findById(sessionId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy buổi học"));

        CreateHomeworkRequest request = new CreateHomeworkRequest();
        request.setSessionId(sessionId);

        model.addAttribute("sessionItem", sessionItem);
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

            return "redirect:/tutor/homework/session/" + request.getSessionId();

        } catch (Exception e) {
            TeachingSession sessionItem = null;

            if (request.getSessionId() != null) {
                sessionItem = teachingSessionRepository.findById(request.getSessionId())
                        .orElse(null);
            }

            model.addAttribute("error", e.getMessage());
            model.addAttribute("request", request);
            model.addAttribute("sessionItem", sessionItem);

            return "tutor/homework/create";
        }
    }
}