package com.tcms.session.service;

import com.tcms.clazz.entity.ClassEntity;
import com.tcms.clazz.entity.Enrollment;
import com.tcms.clazz.repository.ClassRepository;
import com.tcms.clazz.repository.EnrollmentRepository;
import com.tcms.exception.BadRequestException;
import com.tcms.notification.entity.NotificationType;
import com.tcms.notification.service.NotificationService;
import com.tcms.session.dto.request.GenerateSessionsRequest;
import com.tcms.session.entity.TeachingSession;
import com.tcms.session.repository.TeachingSessionRepository;
import com.tcms.student.entity.Student;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.YearMonth;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class SessionServiceImpl implements SessionService {

    private final TeachingSessionRepository teachingSessionRepository;
    private final ClassRepository classRepository;
    private final EnrollmentRepository enrollmentRepository;
    private final NotificationService notificationService;

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<TeachingSession> getSessionsByClassId(Integer classId) {
        return teachingSessionRepository.findByClassEntityClassIdOrderBySessionDateAscStartTimeAsc(classId);
    }

    @Override
    @Transactional
    public void generateSessions(GenerateSessionsRequest request) {
        validateRequest(request);

        ClassEntity classEntity = classRepository.findById(request.getClassId())
                .orElseThrow(() -> new BadRequestException("Lớp học không tồn tại"));

        LocalDate startDate = LocalDate.parse(request.getStartDate());
        LocalDate endDate = LocalDate.parse(request.getEndDate());

        if (startDate.isAfter(endDate)) {
            throw new BadRequestException("Ngày bắt đầu không được sau ngày kết thúc");
        }

        entityManager
                .createNativeQuery("CALL sp_generate_sessions_from_schedule(:classId, :startDate, :endDate)")
                .setParameter("classId", request.getClassId())
                .setParameter("startDate", startDate)
                .setParameter("endDate", endDate)
                .executeUpdate();

        limitSessionsByRequiredSessionsPerMonth(request.getClassId(), startDate, endDate);

        List<TeachingSession> generatedSessions =
                teachingSessionRepository.findByClassEntityClassIdAndSessionDateBetweenOrderBySessionDateAscStartTimeAsc(
                        request.getClassId(),
                        startDate,
                        endDate
                );

        notifyGeneratedSessions(classEntity, generatedSessions);
    }

    private void limitSessionsByRequiredSessionsPerMonth(Integer classId, LocalDate startDate, LocalDate endDate) {
        ClassEntity classEntity = classRepository.findById(classId)
                .orElseThrow(() -> new BadRequestException("Lớp học không tồn tại"));

        Integer requiredSessions = classEntity.getRequiredSessions();

        if (requiredSessions == null || requiredSessions <= 0) return;

        List<TeachingSession> sessions =
                teachingSessionRepository
                        .findByClassEntityClassIdAndSessionDateBetweenOrderBySessionDateAscStartTimeAsc(
                                classId,
                                startDate,
                                endDate
                        );

        Map<YearMonth, List<TeachingSession>> sessionsByMonth = sessions.stream()
                .collect(Collectors.groupingBy(
                        s -> YearMonth.from(s.getSessionDate()),
                        LinkedHashMap::new,
                        Collectors.toList()
                ));

        for (List<TeachingSession> monthlySessions : sessionsByMonth.values()) {
            if (monthlySessions.size() > requiredSessions) {
                List<TeachingSession> redundantSessions =
                        monthlySessions.subList(requiredSessions, monthlySessions.size());

                teachingSessionRepository.deleteAll(redundantSessions);
            }
        }
    }

    private void notifyGeneratedSessions(ClassEntity classEntity, List<TeachingSession> sessions) {
        if (sessions == null || sessions.isEmpty()) return;

        String content = "Lớp " + classEntity.getClassName()
                + " đã được sinh " + sessions.size()
                + " buổi học mới.";

        if (classEntity.getTutor() != null && classEntity.getTutor().getUser() != null) {
            notificationService.createNotification(
                    classEntity.getTutor().getUser().getUserId(),
                    "Buổi học mới được sinh",
                    content,
                    NotificationType.SCHEDULE,
                    classEntity.getClassId(),
                    "teaching_sessions"
            );
        }

        List<Enrollment> enrollments =
                enrollmentRepository.findByClassEntityClassIdAndStatusTrue(classEntity.getClassId());

        for (Enrollment enrollment : enrollments) {
            Student student = enrollment.getStudent();
            if (student == null) continue;

            if (student.getUser() != null) {
                notificationService.createNotification(
                        student.getUser().getUserId(),
                        "Buổi học mới được sinh",
                        content,
                        NotificationType.SCHEDULE,
                        classEntity.getClassId(),
                        "teaching_sessions"
                );
            }

            if (student.getParent() != null && student.getParent().getUser() != null) {
                notificationService.createNotification(
                        student.getParent().getUser().getUserId(),
                        "Lịch học mới của con",
                        content,
                        NotificationType.SCHEDULE,
                        classEntity.getClassId(),
                        "teaching_sessions"
                );
            }
        }
    }

    private void validateRequest(GenerateSessionsRequest request) {
        if (request.getClassId() == null) {
            throw new BadRequestException("Thiếu lớp học");
        }

        if (request.getStartDate() == null || request.getStartDate().isBlank()) {
            throw new BadRequestException("Vui lòng nhập ngày bắt đầu");
        }

        if (request.getEndDate() == null || request.getEndDate().isBlank()) {
            throw new BadRequestException("Vui lòng nhập ngày kết thúc");
        }
    }
}