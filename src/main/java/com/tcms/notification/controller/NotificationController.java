package com.tcms.notification.controller;

import com.tcms.notification.service.NotificationService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/notifications")
public class NotificationController {

    private final NotificationService notificationService;

    @GetMapping
    public String list(
            HttpSession session,
            Model model
    ) {
        Integer userId = (Integer) session.getAttribute("userId");

        model.addAttribute("notifications", notificationService.getMyNotifications(userId));
        model.addAttribute("unreadCount", notificationService.countUnread(userId));

        return "notifications/list";
    }

    @PostMapping("/{notificationId}/read")
    public String markAsRead(
            @PathVariable Integer notificationId,
            HttpSession session
    ) {
        Integer userId = (Integer) session.getAttribute("userId");

        notificationService.markAsRead(userId, notificationId);

        return "redirect:/notifications";
    }

    @PostMapping("/read-all")
    public String markAllAsRead(HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");

        notificationService.markAllAsRead(userId);

        return "redirect:/notifications";
    }
}