package com.tcms.auth.controller;

import com.tcms.auth.dto.LoginRequest;
import com.tcms.auth.service.AuthService;
import com.tcms.user.entity.User;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
public class AuthController {

    private final AuthService authService;

    @GetMapping("/login")
    public String showLoginPage() {
        return "auth/login";
    }

    @PostMapping("/login")
    public String login(@ModelAttribute LoginRequest request,
                        HttpSession session,
                        Model model) {
        try {
            User user = authService.login(request);

            session.setAttribute("currentUser", user);
            session.setAttribute("role", user.getRole().getRoleName());

            String role = user.getRole().getRoleName();

            if ("ADMIN".equalsIgnoreCase(role)) {
                return "redirect:/admin/dashboard";
            } else if ("TUTOR".equalsIgnoreCase(role)) {
                return "redirect:/tutor/dashboard";
            } else if ("PARENT".equalsIgnoreCase(role)) {
                return "redirect:/parent/dashboard";
            } else if ("STUDENT".equalsIgnoreCase(role)) {
                return "redirect:/student/dashboard";
            }

            return "redirect:/login";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "auth/login";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}