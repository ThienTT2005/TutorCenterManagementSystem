package com.tcms.payment.service;

import com.tcms.clazz.entity.ClassEntity;
import com.tcms.clazz.repository.ClassRepository;
import com.tcms.notification.entity.NotificationType;
import com.tcms.notification.service.NotificationService;
import com.tcms.parent.entity.Parent;
import com.tcms.parent.repository.ParentRepository;
import com.tcms.payment.dto.request.CreatePaymentRequest;
import com.tcms.payment.dto.request.RejectPaymentRequest;
import com.tcms.payment.dto.request.UploadPaymentProofRequest;
import com.tcms.payment.entity.Payment;
import com.tcms.payment.entity.PaymentStatus;
import com.tcms.payment.repository.PaymentRepository;
import com.tcms.session.entity.SessionStatus;
import com.tcms.session_validity.entity.SessionValidityLog;
import com.tcms.session_validity.repository.SessionValidityLogRepository;
import com.tcms.student.entity.Student;
import com.tcms.student.repository.StudentRepository;
import com.tcms.tutor.entity.Tutor;
import com.tcms.tutor.repository.TutorRepository;
import com.tcms.user.entity.User;
import com.tcms.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class PaymentServiceImpl implements PaymentService {

    private final PaymentRepository paymentRepository;
    private final SessionValidityLogRepository validityLogRepository;
    private final TutorRepository tutorRepository;
    private final ClassRepository classRepository;
    private final StudentRepository studentRepository;
    private final ParentRepository parentRepository;
    private final NotificationService notificationService;
    private final UserRepository userRepository;

    @Override
    public void createPayment(Integer tutorUserId, CreatePaymentRequest request) {

        if (request.getClassId() == null || request.getStudentId() == null) {
            throw new RuntimeException("Thiếu thông tin tạo payment");
        }

        Tutor tutor = tutorRepository.findByUserUserId(tutorUserId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy gia sư"));

        ClassEntity classEntity = classRepository.findById(request.getClassId())
                .orElseThrow(() -> new RuntimeException("Không tìm thấy lớp học"));

        Student student = studentRepository.findById(request.getStudentId())
                .orElseThrow(() -> new RuntimeException("Không tìm thấy học sinh"));

        if (classEntity.getTutor() == null ||
                !classEntity.getTutor().getTutorId().equals(tutor.getTutorId())) {
            throw new RuntimeException("Gia sư không phụ trách lớp này");
        }

        List<SessionValidityLog> validLogs =
                validityLogRepository.findByStudentStudentIdAndIsPaidFalse(student.getStudentId())
                        .stream()
                        .filter(log -> log.getSession() != null)
                        .filter(log -> log.getSession().getClassEntity() != null)
                        .filter(log -> log.getSession().getClassEntity().getClassId().equals(classEntity.getClassId()))
                        .filter(log -> log.getSession().getStatus() == SessionStatus.COMPLETED)
                        .filter(log -> !log.getSession().getSessionDate().isAfter(LocalDate.now()))
                        .filter(log -> Boolean.TRUE.equals(log.getAttendanceValid()))
                        .filter(log -> "APPROVED".equals(log.getFeedbackStatus()))
                        .filter(log -> log.getCalculatedAmount() != null)
                        .filter(log -> log.getCalculatedAmount().compareTo(BigDecimal.ZERO) > 0)
                        .collect(Collectors.toList());

        if (validLogs.isEmpty()) {
            throw new RuntimeException("Không có buổi học hợp lệ để yêu cầu thanh toán");
        }

        String sessionIds = validLogs.stream()
                .sorted((a, b) -> a.getSession().getSessionDate()
                        .compareTo(b.getSession().getSessionDate()))
                .map(log -> log.getSession().getSessionId().toString())
                .collect(Collectors.joining(","));

        BigDecimal totalAmount = validLogs.stream()
                .map(SessionValidityLog::getCalculatedAmount)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        Payment payment = Payment.builder()
                .tutor(tutor)
                .classEntity(classEntity)
                .student(student)
                .sessionIds(sessionIds)
                .totalSessions(validLogs.size())
                .amount(totalAmount)
                .note(request.getNote())
                .status(PaymentStatus.PENDING)
                .requestDate(LocalDateTime.now())
                .build();
        Payment saved = paymentRepository.save(payment);
        if (student.getParent() != null && student.getParent().getUser() != null) {
            notificationService.createNotification(
                    student.getParent().getUser().getUserId(),
                    "Yêu cầu thanh toán mới",
                    "Gia sư đã tạo yêu cầu thanh toán cho học sinh " + student.getFullName(),
                    NotificationType.PAYMENT,
                    saved.getPaymentId(),
                    "payments"
            );
        }
    }

    @Override
    public void uploadProof(Integer parentUserId, UploadPaymentProofRequest request) {

        if (request.getPaymentId() == null || request.getProofUrl() == null || request.getProofUrl().isBlank()) {
            throw new RuntimeException("Thiếu thông tin minh chứng thanh toán");
        }

        Parent parent = parentRepository.findByUserUserId(parentUserId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy phụ huynh"));

        Payment payment = paymentRepository.findById(request.getPaymentId())
                .orElseThrow(() -> new RuntimeException("Không tìm thấy yêu cầu thanh toán"));

        if (payment.getStudent() == null ||
                payment.getStudent().getParent() == null ||
                !payment.getStudent().getParent().getParentId().equals(parent.getParentId())) {
            throw new RuntimeException("Bạn không có quyền upload minh chứng cho thanh toán này");
        }

        if (payment.getStatus() != PaymentStatus.PENDING) {
            throw new RuntimeException("Payment không ở trạng thái chờ upload minh chứng");
        }

        payment.setProofUrl(request.getProofUrl());
        payment.setStatus(PaymentStatus.PROOF_UPLOADED);
        Payment saved = paymentRepository.save(payment);
        if (saved.getTutor() != null && saved.getTutor().getUser() != null) {
            notificationService.createNotification(
                    saved.getTutor().getUser().getUserId(),
                    "Phụ huynh đã upload minh chứng",
                    "Phụ huynh đã gửi minh chứng thanh toán, cần gia sư xác nhận.",
                    NotificationType.PAYMENT,
                    saved.getPaymentId(),
                    "payments"
            );
        }
    }

    @Override
    public void tutorConfirm(Integer tutorUserId, Integer paymentId) {

        if (paymentId == null) {
            throw new RuntimeException("Thiếu mã payment");
        }

        Tutor tutor = tutorRepository.findByUserUserId(tutorUserId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy gia sư"));

        Payment payment = paymentRepository.findById(paymentId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy yêu cầu thanh toán"));

        if (payment.getTutor() == null ||
                !payment.getTutor().getTutorId().equals(tutor.getTutorId())) {
            throw new RuntimeException("Bạn không có quyền xác nhận thanh toán này");
        }

        if (payment.getStatus() != PaymentStatus.PROOF_UPLOADED) {
            throw new RuntimeException("Phụ huynh chưa upload minh chứng");
        }

        payment.setStatus(PaymentStatus.TUTOR_CONFIRMED);
        payment.setTutorConfirmedAt(LocalDateTime.now());

        Payment saved = paymentRepository.save(payment);

        List<User> admins = userRepository.findByRoleRoleName("ADMIN");

        for (User admin : admins) {
            notificationService.createNotification(
                    admin.getUserId(),
                    "Thanh toán chờ admin duyệt",
                    "Gia sư đã xác nhận nhận tiền, cần admin duyệt thanh toán.",
                    NotificationType.PAYMENT,
                    saved.getPaymentId(),
                    "payments"
            );
        }
    }

    @Override
    public void adminApprove(Integer paymentId) {

        if (paymentId == null) {
            throw new RuntimeException("Thiếu mã payment");
        }

        Payment payment = paymentRepository.findById(paymentId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy yêu cầu thanh toán"));

        if (payment.getStatus() != PaymentStatus.TUTOR_CONFIRMED) {
            throw new RuntimeException("Gia sư chưa xác nhận đã nhận tiền");
        }

        List<Integer> sessionIds = parseSessionIds(payment.getSessionIds());

        List<SessionValidityLog> logs =
                validityLogRepository.findByStudentStudentIdAndSessionSessionIdIn(
                        payment.getStudent().getStudentId(),
                        sessionIds
                );

        for (SessionValidityLog log : logs) {
            if (!Boolean.TRUE.equals(log.getIsPaid())) {
                log.setIsPaid(true);
                log.setPayment(payment);
                validityLogRepository.save(log);
            }
        }

        payment.setStatus(PaymentStatus.COMPLETED);
        payment.setAdminApprovedAt(LocalDateTime.now());

        paymentRepository.save(payment);
    }

    @Override
    public void adminReject(RejectPaymentRequest request) {

        if (request.getPaymentId() == null || request.getReason() == null || request.getReason().isBlank()) {
            throw new RuntimeException("Thiếu thông tin từ chối thanh toán");
        }

        Payment payment = paymentRepository.findById(request.getPaymentId())
                .orElseThrow(() -> new RuntimeException("Không tìm thấy yêu cầu thanh toán"));

        if (payment.getStatus() != PaymentStatus.PENDING
                && payment.getStatus() != PaymentStatus.PROOF_UPLOADED
                && payment.getStatus() != PaymentStatus.TUTOR_CONFIRMED) {
            throw new RuntimeException("Không thể từ chối payment ở trạng thái này");
        }

        payment.setStatus(PaymentStatus.REJECTED);
        payment.setRejectionReason(request.getReason());

        Payment saved = paymentRepository.save(payment);

        if (saved.getTutor() != null && saved.getTutor().getUser() != null) {
            notificationService.createNotification(
                    saved.getTutor().getUser().getUserId(),
                    "Thanh toán bị từ chối",
                    "Admin đã từ chối thanh toán. Lý do: " + request.getReason(),
                    NotificationType.PAYMENT,
                    saved.getPaymentId(),
                    "payments"
            );
        }

        if (saved.getStudent() != null &&
                saved.getStudent().getParent() != null &&
                saved.getStudent().getParent().getUser() != null) {
            notificationService.createNotification(
                    saved.getStudent().getParent().getUser().getUserId(),
                    "Thanh toán bị từ chối",
                    "Admin đã từ chối thanh toán. Lý do: " + request.getReason(),
                    NotificationType.PAYMENT,
                    saved.getPaymentId(),
                    "payments"
            );
        }
    }

    @Override
    public List<Payment> getTutorPayments(Integer tutorUserId) {
        Tutor tutor = tutorRepository.findByUserUserId(tutorUserId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy gia sư"));

        return paymentRepository.findByTutorTutorIdOrderByRequestDateDesc(tutor.getTutorId());
    }

    @Override
    public List<Payment> getParentPayments(Integer parentUserId) {
        Parent parent = parentRepository.findByUserUserId(parentUserId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy phụ huynh"));

        return paymentRepository.findByStudentParentParentIdOrderByRequestDateDesc(parent.getParentId());
    }

    @Override
    public List<Payment> getAllPayments() {
        return paymentRepository.findAllByOrderByRequestDateDesc();
    }

    private List<Integer> parseSessionIds(String sessionIds) {
        if (sessionIds == null || sessionIds.isBlank()) {
            throw new RuntimeException("Payment không có danh sách buổi học");
        }

        return Arrays.stream(sessionIds.split(","))
                .map(String::trim)
                .filter(s -> !s.isBlank())
                .map(Integer::parseInt)
                .toList();
    }
}