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

        if (userId != null) {
            model.addAttribute("latestNotifications", notificationService.getLatestNotifications(userId));
            model.addAttribute("unreadNotificationCount", notificationService.countUnread(userId));
        }
    }
}