package com.tcms.auth.controller;

import com.tcms.auth.dto.ChangePasswordRequest;
import com.tcms.auth.service.ChangePasswordService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/change-password")
public class ChangePasswordController {

    private final ChangePasswordService changePasswordService;

    @GetMapping
    public String form(HttpSession session, Model model) {
        if (session.getAttribute("currentUser") == null) {
            return "redirect:/login";
        }

        model.addAttribute("request", new ChangePasswordRequest());
        return "auth/change-password";
    }

    @PostMapping
    public String changePassword(
            @ModelAttribute("request") ChangePasswordRequest request,
            HttpSession session,
            Model model
    ) {
        if (session.getAttribute("currentUser") == null) {
            return "redirect:/login";
        }

        try {
            Integer userId = (Integer) session.getAttribute("userId");
            changePasswordService.changePassword(userId, request);

            model.addAttribute("success", "Đổi mật khẩu thành công");
            model.addAttribute("request", new ChangePasswordRequest());
            return "auth/change-password";

        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("request", request);
            return "auth/change-password";
        }
    }
}