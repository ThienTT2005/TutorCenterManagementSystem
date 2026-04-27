package com.tcms.absence.service;

import com.tcms.absence.dto.request.CreateAbsenceRequest;
import com.tcms.absence.entity.AbsenceRequest;
import com.tcms.absence.entity.AbsenceRequestStatus;
import com.tcms.absence.repository.AbsenceRequestRepository;
import com.tcms.notification.entity.NotificationType;
import com.tcms.notification.service.NotificationService;
import com.tcms.parent.entity.Parent;
import com.tcms.parent.repository.ParentRepository;
import com.tcms.session.entity.SessionStatus;
import com.tcms.session.entity.TeachingSession;
import com.tcms.session.repository.TeachingSessionRepository;
import com.tcms.student.entity.Student;
import com.tcms.student.repository.StudentRepository;
import com.tcms.user.entity.User;
import com.tcms.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class AbsenceRequestServiceImpl implements AbsenceRequestService {

    private final AbsenceRequestRepository repository;
    private final ParentRepository parentRepository;
    private final StudentRepository studentRepository;
    private final TeachingSessionRepository sessionRepository;
    private final NotificationService notificationService;
    private final UserRepository userRepository;

    @Override
    public void create(Integer parentUserId, CreateAbsenceRequest request) {
        Parent parent = parentRepository.findByUserUserId(parentUserId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy phụ huynh"));

        Student student = studentRepository.findById(request.getStudentId())
                .orElseThrow(() -> new RuntimeException("Không tìm thấy học sinh"));

        if (student.getParent() == null ||
                !student.getParent().getParentId().equals(parent.getParentId())) {
            throw new RuntimeException("Bạn không có quyền xin nghỉ cho học sinh này");
        }

        TeachingSession session = sessionRepository.findById(request.getSessionId())
                .orElseThrow(() -> new RuntimeException("Không tìm thấy buổi học"));

        LocalDateTime sessionStart = LocalDateTime.of(
                session.getSessionDate(),
                session.getStartTime()
        );

        LocalDateTime now = LocalDateTime.now();

        if (!now.isBefore(sessionStart)) {
            throw new RuntimeException("Không thể xin nghỉ vì buổi học đã bắt đầu hoặc đã kết thúc");
        }

        if (now.isAfter(sessionStart.minusHours(12))) {
            throw new RuntimeException("Chỉ được xin nghỉ trước giờ học ít nhất 12 tiếng");
        }

        if (request.getReason() == null || request.getReason().trim().isEmpty()) {
            throw new RuntimeException("Lý do xin nghỉ không được để trống");
        }

        if (repository.existsBySessionSessionIdAndStudentStudentId(
                request.getSessionId(),
                request.getStudentId()
        )) {
            throw new RuntimeException("Bạn đã gửi yêu cầu xin nghỉ cho buổi này rồi");
        }

        AbsenceRequest ar = new AbsenceRequest();
        ar.setParent(parent);
        ar.setStudent(student);
        ar.setSession(session);
        ar.setReason(request.getReason());
        ar.setRequestedAt(LocalDateTime.now());
        ar.setStatus(AbsenceRequestStatus.PENDING);

        AbsenceRequest saved = repository.save(ar);

        notifyAdminsAbsencePending(saved);
    }

    @Override
    public List<AbsenceRequest> getMyRequests(Integer parentUserId) {
        Parent parent = parentRepository.findByUserUserId(parentUserId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy phụ huynh"));

        return repository.findByParentParentIdOrderByRequestedAtDesc(parent.getParentId());
    }

    @Override
    public List<AbsenceRequest> getPending() {
        return repository.findByStatusOrderByRequestedAtDesc(AbsenceRequestStatus.PENDING);
    }

    @Override
    public void approve(Integer requestId, Integer adminUserId) {
        AbsenceRequest ar = repository.findById(requestId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy yêu cầu xin nghỉ"));

        if (ar.getStatus() != AbsenceRequestStatus.PENDING) {
            throw new RuntimeException("Yêu cầu này đã được xử lý");
        }

        ar.setStatus(AbsenceRequestStatus.APPROVED);
        ar.setProcessedAt(LocalDateTime.now());
        ar.setProcessedBy(adminUserId);

        TeachingSession session = ar.getSession();

        session.setStatus(SessionStatus.CANCELLED);
        sessionRepository.save(session);

        AbsenceRequest saved = repository.save(ar);

        notifyParentAbsenceResult(saved);
        notifyTutorSessionCancelled(saved);
    }

    @Override
    public void reject(Integer requestId, Integer adminUserId, String reason) {
        if (reason == null || reason.isBlank()) {
            throw new RuntimeException("Lý do từ chối không được để trống");
        }

        AbsenceRequest ar = repository.findById(requestId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy request"));

        if (ar.getStatus() != AbsenceRequestStatus.PENDING) {
            throw new RuntimeException("Yêu cầu này đã được xử lý");
        }

        ar.setStatus(AbsenceRequestStatus.REJECTED);
        ar.setProcessedAt(LocalDateTime.now());
        ar.setProcessedBy(adminUserId);
        ar.setRejectionReason(reason);

        AbsenceRequest saved = repository.save(ar);

        notifyParentAbsenceResult(saved);
    }

    private void notifyAdminsAbsencePending(AbsenceRequest ar) {
        List<User> admins = userRepository.findByRoleRoleName("ADMIN");

        String studentName = ar.getStudent() != null ? ar.getStudent().getFullName() : "học sinh";

        for (User admin : admins) {
            notificationService.createNotification(
                    admin.getUserId(),
                    "Yêu cầu xin nghỉ chờ duyệt",
                    "Phụ huynh vừa gửi yêu cầu xin nghỉ cho " + studentName + ".",
                    NotificationType.ATTENDANCE,
                    ar.getRequestId(),
                    "absence_requests"
            );
        }
    }

    private void notifyParentAbsenceResult(AbsenceRequest ar) {
        if (ar.getParent() == null || ar.getParent().getUser() == null) {
            return;
        }

        String result = ar.getStatus() == AbsenceRequestStatus.APPROVED
                ? "đã được duyệt"
                : "đã bị từ chối";

        String content = "Yêu cầu xin nghỉ của học sinh "
                + ar.getStudent().getFullName()
                + " "
                + result
                + ".";

        if (ar.getStatus() == AbsenceRequestStatus.REJECTED && ar.getRejectionReason() != null) {
            content += " Lý do: " + ar.getRejectionReason();
        }

        notificationService.createNotification(
                ar.getParent().getUser().getUserId(),
                "Kết quả yêu cầu xin nghỉ",
                content,
                NotificationType.ATTENDANCE,
                ar.getRequestId(),
                "absence_requests"
        );
    }

    private void notifyTutorSessionCancelled(AbsenceRequest ar) {
        if (ar.getSession() == null ||
                ar.getSession().getClassEntity() == null ||
                ar.getSession().getClassEntity().getTutor() == null ||
                ar.getSession().getClassEntity().getTutor().getUser() == null) {
            return;
        }

        notificationService.createNotification(
                ar.getSession().getClassEntity().getTutor().getUser().getUserId(),
                "Buổi học bị hủy",
                "Buổi học ngày " + ar.getSession().getSessionDate()
                        + " đã bị hủy do phụ huynh xin nghỉ.",
                NotificationType.ATTENDANCE,
                ar.getRequestId(),
                "absence_requests"
        );
    }
}