package com.tcms.notification.repository;

import com.tcms.notification.entity.Notification;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface NotificationRepository extends JpaRepository<Notification, Integer> {

    List<Notification> findByUserUserIdOrderByCreatedAtDesc(Integer userId);

    List<Notification> findTop5ByUserUserIdOrderByCreatedAtDesc(Integer userId);

    List<Notification> findByUserUserIdAndIsReadFalseOrderByCreatedAtDesc(Integer userId);

    long countByUserUserIdAndIsReadFalse(Integer userId);
}