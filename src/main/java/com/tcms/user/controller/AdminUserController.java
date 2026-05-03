package com.tcms.user.controller;

import com.tcms.parent.dto.request.CreateParentProfileRequest;
import com.tcms.student.dto.request.CreateStudentProfileRequest;
import com.tcms.tutor.dto.request.CreateTutorProfileRequest;
import com.tcms.user.dto.request.CreateAccountRequest;
import com.tcms.user.entity.User;
import com.tcms.user.service.AdminUserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/users")
public class AdminUserController {

    private final AdminUserService adminUserService;

    private boolean isAdmin(HttpSession session) {
        if (session.getAttribute("currentUser") == null)
            return false;
        String role = (String) session.getAttribute("role");
        return "ADMIN".equalsIgnoreCase(role);
    }

    @GetMapping
    public String listUsers(@RequestParam(required = false) String username,
                            @RequestParam(required = false) String role,
                            @RequestParam(required = false) Boolean status,
                            HttpSession session,
                            Model model) {
        if (!isAdmin(session)) {
            return "redirect:/login";
        }

        model.addAttribute("users", adminUserService.searchUsers(username, role, status));

        model.addAttribute("username", username);
        model.addAttribute("selectedRole", role);
        model.addAttribute("selectedStatus", status);

        return "admin/users/list";
    }

    @GetMapping("/create")
    public String showCreateAccountForm(HttpSession session, Model model) {
        if (!isAdmin(session))
            return "redirect:/login";

        model.addAttribute("request", new CreateAccountRequest());
        return "admin/users/create-account";
    }

    @PostMapping("/create")
    public String createAccount(@ModelAttribute("request") CreateAccountRequest request,
            HttpSession session,
            Model model) {
        if (!isAdmin(session))
            return "redirect:/login";

        try {
            User user = adminUserService.createAccount(request);
            String role = user.getRole().getRoleName();

            if ("TUTOR".equalsIgnoreCase(role)) {
                return "redirect:/admin/users/" + user.getUserId() + "/profile/tutor";
            } else if ("PARENT".equalsIgnoreCase(role)) {
                return "redirect:/admin/users/" + user.getUserId() + "/profile/parent";
            } else if ("STUDENT".equalsIgnoreCase(role)) {
                return "redirect:/admin/users/" + user.getUserId() + "/profile/student";
            }

            return "redirect:/admin/users";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "admin/users/create-account";
        }
    }

    @GetMapping("/{userId}/profile/tutor")
    public String showTutorProfileForm(@PathVariable Integer userId, HttpSession session, Model model) {
        if (!isAdmin(session))
            return "redirect:/login";

        CreateTutorProfileRequest request = new CreateTutorProfileRequest();
        request.setUserId(userId);
        model.addAttribute("request", request);
        return "admin/users/create-tutor-profile";
    }

    @PostMapping("/{userId}/profile/tutor")
    public String createTutorProfile(@PathVariable Integer userId,
            @ModelAttribute("request") CreateTutorProfileRequest request,
            HttpSession session,
            Model model) {
        if (!isAdmin(session))
            return "redirect:/login";

        try {
            request.setUserId(userId);
            adminUserService.createTutorProfile(request);
            return "redirect:/admin/users";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "admin/users/create-tutor-profile";
        }
    }

    @GetMapping("/{userId}/profile/parent")
    public String showParentProfileForm(@PathVariable Integer userId, HttpSession session, Model model) {
        if (!isAdmin(session))
            return "redirect:/login";

        CreateParentProfileRequest request = new CreateParentProfileRequest();
        request.setUserId(userId);
        model.addAttribute("request", request);
        return "admin/users/create-parent-profile";
    }

    @PostMapping("/{userId}/profile/parent")
    public String createParentProfile(@PathVariable Integer userId,
            @ModelAttribute("request") CreateParentProfileRequest request,
            HttpSession session,
            Model model) {
        if (!isAdmin(session))
            return "redirect:/login";

        try {
            request.setUserId(userId);
            adminUserService.createParentProfile(request);
            return "redirect:/admin/users";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "admin/users/create-parent-profile";
        }
    }

    // @GetMapping("/{userId}/profile/student")
    // public String showStudentProfileForm(@PathVariable Integer userId,
    // HttpSession session, Model model) {
    // if (!isAdmin(session)) return "redirect:/login";
    //
    // CreateStudentProfileRequest request = new CreateStudentProfileRequest();
    // request.setUserId(userId);
    // model.addAttribute("request", request);
    // model.addAttribute("parents", adminUserService.getAllParents());
    // return "admin/users/create-student-profile";
    // }
    @GetMapping("/{userId}/profile/student")
    public String showCreateStudentProfile(
            @PathVariable Integer userId,
            Model model,
            HttpSession session) {

        if (!isAdmin(session))
            return "redirect:/login";

        model.addAttribute("request", new CreateStudentProfileRequest());
        model.addAttribute("parents", adminUserService.getAllParents());
        model.addAttribute("userId", userId);

        return "admin/users/create-student-profile";
    }

    @PostMapping("/{userId}/profile/student")
    public String createStudentProfile(@PathVariable Integer userId,
            @ModelAttribute("request") CreateStudentProfileRequest request,
            HttpSession session,
            Model model) {
        if (!isAdmin(session))
            return "redirect:/login";

        try {
            request.setUserId(userId);
            adminUserService.createStudentProfile(request);
            return "redirect:/admin/users";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("parents", adminUserService.getAllParents());
            return "admin/users/create-student-profile";
        }
    }
}