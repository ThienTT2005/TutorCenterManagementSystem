package com.tcms.notification.service;

import com.tcms.notification.entity.Notification;
import com.tcms.notification.entity.NotificationType;

import java.util.List;

public interface NotificationService {

    List<Notification> getMyNotifications(Integer userId);

    List<Notification> getLatestNotifications(Integer userId);

    long countUnread(Integer userId);

    void markAsRead(Integer userId, Integer notificationId);

    void markAllAsRead(Integer userId);

    void createNotification(
            Integer userId,
            String title,
            String content,
            NotificationType type,
            Integer referenceId,
            String referenceTable
    );
}