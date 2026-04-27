package com.tcms.absence.controller;

import com.tcms.absence.dto.request.CreateAbsenceRequest;
import com.tcms.absence.service.AbsenceRequestService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/parent/absence")
public class ParentAbsenceController {

    private final AbsenceRequestService service;

    @GetMapping("/create")
    public String form(@RequestParam Integer sessionId,
                       @RequestParam Integer studentId,
                       Model model) {

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