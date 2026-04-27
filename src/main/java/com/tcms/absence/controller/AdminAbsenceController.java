package com.tcms.absence.controller;

import com.tcms.absence.service.AbsenceRequestService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/absence")
public class AdminAbsenceController {

    private final AbsenceRequestService absenceRequestService;

    @GetMapping("/pending")
    public String pending(Model model) {
        model.addAttribute("requests", absenceRequestService.getPending());
        return "admin/absence/pending";
    }

    @PostMapping("/approve")
    public String approve(@RequestParam Integer requestId,
                          HttpSession session) {

        Integer adminUserId = (Integer) session.getAttribute("userId");
        absenceRequestService.approve(requestId, adminUserId);

        return "redirect:/admin/absence/pending";
    }

    @PostMapping("/reject")
    public String reject(@RequestParam Integer requestId,
                         @RequestParam String reason,
                         HttpSession session) {

        Integer adminUserId = (Integer) session.getAttribute("userId");
        absenceRequestService.reject(requestId, adminUserId, reason);

        return "redirect:/admin/absence/pending";
    }
}