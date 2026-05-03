package com.tcms.common;

import com.tcms.notification.service.NotificationService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice
@RequiredArgsConstructor
public class GlobalModelAttribute {

    private final NotificationService notificationService;

    @ModelAttribute
    public void addNotificationData(Model model, HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");

        // Fallback to currentUser if userId is not directly in session
        if (userId == null && session.getAttribute("currentUser") != null) {
            com.tcms.user.entity.User currentUser = (com.tcms.user.entity.User) session.getAttribute("currentUser");
            userId = currentUser.getUserId();
        }

        if (userId != null) {
            var currentUser = session.getAttribute("currentUser");
            model.addAttribute("loggedInUser", currentUser);

            var latest = notificationService.getLatestNotifications(userId);
            var unread = notificationService.countUnread(userId);

            // Standard names used in header.jsp (Student, Tutor, Admin)
            model.addAttribute("notifications", latest);
            model.addAttribute("unreadCount", unread);
        }
    }
}