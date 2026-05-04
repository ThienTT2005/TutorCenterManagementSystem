package com.tcms.profile.controller;

import com.tcms.profile.dto.ProfileUpdateRequest;
import com.tcms.profile.service.ProfileService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequiredArgsConstructor
@RequestMapping("/profile")
public class ProfileController {

    private final ProfileService profileService;

    @GetMapping
    public String viewProfile(HttpSession session, Model model) {

        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            return "redirect:/login";
        }

        model.addAttribute("profile", profileService.getProfile(userId));
        model.addAttribute("request", profileService.buildProfileUpdateRequest(userId));

        return "profile/view";
    }

    @PostMapping("/update")
    public String updateProfile(HttpSession session,
                                @ModelAttribute ProfileUpdateRequest request,
                                Model model) {

        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            return "redirect:/login";
        }

        try {
            profileService.updateProfile(userId, request);
            return "redirect:/profile";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("profile", profileService.getProfile(userId));
            model.addAttribute("request", request);
            return "profile/view";
        }
    }

    @PostMapping("/avatar")
    public String uploadAvatar(HttpSession session,
                               @RequestParam("file") MultipartFile file,
                               Model model) {

        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            return "redirect:/login";
        }

        try {
            profileService.uploadAvatar(userId, file);
            return "redirect:/profile";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("profile", profileService.getProfile(userId));
            model.addAttribute("request", profileService.buildProfileUpdateRequest(userId));
            return "profile/view";
        }
    }
}