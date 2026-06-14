package com.tcms.profile.controller;

import com.tcms.parent.entity.Parent;
import com.tcms.profile.dto.ProfileUpdateRequest;
import com.tcms.profile.service.ProfileService;
import com.tcms.student.entity.Student;
import com.tcms.student.repository.StudentRepository;
import com.tcms.tutor.entity.Tutor;
import com.tcms.user.entity.User;
import com.tcms.user.repository.UserRepository;
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
    private final StudentRepository studentRepository;
    private final UserRepository userRepository;

    @GetMapping
    public String viewProfile(HttpSession session, Model model) {

        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            return "redirect:/login";
        }

        Object profile = profileService.getProfile(userId);
        model.addAttribute("profile", profile);
        model.addAttribute("activePage", "profile");
        model.addAttribute("request", profileService.buildProfileUpdateRequest(userId));

        // Thêm danh sách con cho PARENT
        if (profile instanceof Parent parent) {
            model.addAttribute("children",
                    studentRepository.findByParentParentId(parent.getParentId()));
        }

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

            // Cập nhật session fullName sau khi update thành công
            refreshSessionUserInfo(session, userId);

            return "redirect:/profile";
        } catch (Exception e) {
            String errorMsg = java.net.URLEncoder.encode(
                    e.getMessage() != null ? e.getMessage() : "Cập nhật thất bại",
                    java.nio.charset.StandardCharsets.UTF_8);
            return "redirect:/profile?edit=true&error=" + errorMsg;
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
            String avatarUrl = profileService.uploadAvatar(userId, file);

            // ✅ Cập nhật session để header/sidebar hiển thị ảnh mới ngay lập tức
            session.setAttribute("avatar", avatarUrl);
            refreshSessionUserInfo(session, userId);

            return "redirect:/profile?edit=true";
        } catch (Exception e) {
            String errorMsg = java.net.URLEncoder.encode(
                    e.getMessage() != null ? e.getMessage() : "Upload thất bại",
                    java.nio.charset.StandardCharsets.UTF_8);
            return "redirect:/profile?edit=true&error=" + errorMsg;
        }
    }

    /**
     * Reload User từ DB và cập nhật lại currentUser + avatar trong session.
     * Đảm bảo header/sidebar phản ánh thông tin mới nhất.
     */
    private void refreshSessionUserInfo(HttpSession session, Integer userId) {
        try {
            User freshUser = userRepository.findById(userId).orElse(null);
            if (freshUser == null) return;

            // Cập nhật currentUser trong session
            session.setAttribute("currentUser", freshUser);

            String role = String.valueOf(session.getAttribute("role"));

            if ("TUTOR".equalsIgnoreCase(role) && freshUser.getTutor() != null) {
                Tutor tutor = freshUser.getTutor();
                session.setAttribute("avatar", tutor.getAvatar());
                session.setAttribute("fullName", tutor.getFullName());
            } else if ("PARENT".equalsIgnoreCase(role) && freshUser.getParent() != null) {
                Parent parent = freshUser.getParent();
                session.setAttribute("avatar", parent.getAvatar());
                session.setAttribute("fullName", parent.getFullName());
            } else if ("STUDENT".equalsIgnoreCase(role) && freshUser.getStudent() != null) {
                Student student = freshUser.getStudent();
                session.setAttribute("avatar", student.getAvatar());
                session.setAttribute("fullName", student.getFullName());
            }
        } catch (Exception ignored) {
            // Không để lỗi session làm hỏng luồng chính
        }
    }
}