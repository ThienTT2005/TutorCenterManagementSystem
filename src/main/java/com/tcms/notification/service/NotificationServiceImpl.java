package com.tcms.notification.service;

import com.tcms.notification.entity.Notification;
import com.tcms.notification.entity.NotificationType;
import com.tcms.notification.repository.NotificationRepository;
import com.tcms.user.entity.User;
import com.tcms.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class NotificationServiceImpl implements NotificationService {

    private final NotificationRepository notificationRepository;
    private final UserRepository userRepository;

    @Override
    public List<Notification> getMyNotifications(Integer userId) {
        return notificationRepository.findByUserUserIdOrderByCreatedAtDesc(userId);
    }

    @Override
    public List<Notification> getLatestNotifications(Integer userId) {
        return notificationRepository.findTop5ByUserUserIdOrderByCreatedAtDesc(userId);
    }

    @Override
    public long countUnread(Integer userId) {
        return notificationRepository.countByUserUserIdAndIsReadFalse(userId);
    }

    @Override
    public void markAsRead(Integer userId, Integer notificationId) {
        Notification notification = notificationRepository.findById(notificationId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy thông báo"));
        if (notification.getUser() == null ||
                !notification.getUser().getUserId().equals(userId)) {
            throw new RuntimeException("Bạn không có quyền đọc thông báo này");
        }
        notification.setIsRead(true);
        notification.setReadAt(LocalDateTime.now());
        notificationRepository.save(notification);
    }

    @Override
    public void markAllAsRead(Integer userId) {
        List<Notification> notifications =
                notificationRepository.findByUserUserIdAndIsReadFalseOrderByCreatedAtDesc(userId);
        for (Notification n : notifications) {
            n.setIsRead(true);
            n.setReadAt(LocalDateTime.now());
            notificationRepository.save(n);
        }
    }

    @Override
    public void createNotification(
            Integer userId,
            String title,
            String content,
            NotificationType type,
            Integer referenceId,
            String referenceTable
    ) {
        if (userId == null) return;
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy user nhận thông báo"));
        Notification notification = Notification.builder()
                .user(user)
                .title(title)
                .content(content)
                .type(type)
                .referenceId(referenceId)
                .referenceTable(referenceTable)
                .isRead(false)
                .createdAt(LocalDateTime.now())
                .build();
        notificationRepository.save(notification);
    }
}