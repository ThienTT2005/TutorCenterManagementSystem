package com.tcms.scheduler;

import com.tcms.clazz.entity.Enrollment;
import com.tcms.clazz.repository.EnrollmentRepository;
import com.tcms.notification.entity.NotificationType;
import com.tcms.notification.service.NotificationService;
import com.tcms.session.entity.TeachingSession;
import com.tcms.session.entity.SessionStatus;
import com.tcms.session.repository.TeachingSessionRepository;
import com.tcms.student.entity.Student;
import lombok.RequiredArgsConstructor;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Component
@RequiredArgsConstructor
public class SessionReminderScheduler {

    private final TeachingSessionRepository sessionRepository;
    private final EnrollmentRepository enrollmentRepository;
    private final NotificationService notificationService;

    private final Set<Integer> remindedSessionIds = new HashSet<>();

    @Scheduled(fixedRate = 300000)
    public void remindUpcomingSessions() {

        LocalDateTime now = LocalDateTime.now();
        LocalDateTime twoHoursLater = now.plusHours(2);

        List<TeachingSession> sessions = sessionRepository.findAll();

        for (TeachingSession session : sessions) {

            if (session.getStatus() != SessionStatus.PLANNED) continue;

            if (remindedSessionIds.contains(session.getSessionId())) continue;

            LocalDateTime sessionStart = LocalDateTime.of(
                    session.getSessionDate(),
                    session.getStartTime()
            );

            if (sessionStart.isAfter(now) && sessionStart.isBefore(twoHoursLater)) {

                sendNotification(session);

                remindedSessionIds.add(session.getSessionId());
            }
        }
    }

    private void sendNotification(TeachingSession session) {

        String content = "Buổi học sẽ bắt đầu lúc "
                + session.getStartTime()
                + " ngày " + session.getSessionDate();

        // Tutor
        if (session.getClassEntity().getTutor() != null &&
                session.getClassEntity().getTutor().getUser() != null) {

            notificationService.createNotification(
                    session.getClassEntity().getTutor().getUser().getUserId(),
                    "Sắp đến giờ học",
                    content,
                    NotificationType.SCHEDULE,
                    session.getSessionId(),
                    "teaching_sessions"
            );
        }

        // Student + Parent
        List<Enrollment> enrollments =
                enrollmentRepository.findByClassEntityClassIdAndStatusTrue(
                        session.getClassEntity().getClassId()
                );

        for (Enrollment e : enrollments) {

            Student student = e.getStudent();

            if (student.getUser() != null) {
                notificationService.createNotification(
                        student.getUser().getUserId(),
                        "Sắp đến giờ học",
                        content,
                        NotificationType.SCHEDULE,
                        session.getSessionId(),
                        "teaching_sessions"
                );
            }

            if (student.getParent() != null &&
                    student.getParent().getUser() != null) {

                notificationService.createNotification(
                        student.getParent().getUser().getUserId(),
                        "Con sắp đến giờ học",
                        content,
                        NotificationType.SCHEDULE,
                        session.getSessionId(),
                        "teaching_sessions"
                );
            }
        }
    }
}