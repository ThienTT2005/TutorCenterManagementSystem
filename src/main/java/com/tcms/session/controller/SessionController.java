package com.tcms.session.controller;

import com.tcms.clazz.service.ClassService;
import com.tcms.session.dto.request.GenerateSessionsRequest;
import com.tcms.session.service.SessionService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/classes/{classId}/sessions")
public class SessionController {

    private final SessionService sessionService;
    private final ClassService classService;

    private boolean isAdmin(HttpSession session) {
        if (session.getAttribute("currentUser") == null) return false;
        String role = (String) session.getAttribute("role");
        return "ADMIN".equalsIgnoreCase(role);
    }

    @GetMapping("/generate")
    public String showGenerateSessionsForm(@PathVariable Integer classId,
                                           HttpSession session,
                                           Model model) {
        if (!isAdmin(session)) return "redirect:/login";

        GenerateSessionsRequest request = new GenerateSessionsRequest();
        request.setClassId(classId);

        model.addAttribute("request", request);
        model.addAttribute("classItem", classService.getClassById(classId));

        return "admin/sessions/generate";
    }

    @PostMapping("/generate")
    public String generateSessions(@PathVariable Integer classId,
                                   @ModelAttribute("request") GenerateSessionsRequest request,
                                   HttpSession session,
                                   Model model) {
        if (!isAdmin(session)) return "redirect:/login";

        try {
            request.setClassId(classId);
            sessionService.generateSessions(request);
            return "redirect:/admin/classes/" + classId;
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("classItem", classService.getClassById(classId));
            return "admin/sessions/generate";
        }
    }
}