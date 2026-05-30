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
import org.springframework.transaction.annotation.Transactional;

import java.io.File;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;
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

    private static final String UPLOAD_DIR =
            System.getProperty("user.dir") + "/src/main/resources/static/uploads/";

    @Override
    @Transactional
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
                        .filter(log -> Arrays.asList("APPROVED", "ON_TIME", "LATE")
                                .contains(log.getFeedbackStatus()))
                        .filter(log -> log.getCalculatedAmount() != null)
                        .filter(log -> log.getCalculatedAmount().compareTo(BigDecimal.ZERO) > 0)
                        .collect(Collectors.toList());

        if (validLogs.isEmpty()) {
            throw new IllegalArgumentException("Không có buổi học hợp lệ để yêu cầu thanh toán");
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

        List<User> admins = userRepository.findByRoleRoleName("ADMIN");

        for (User admin : admins) {
            notificationService.createNotification(
                    admin.getUserId(),
                    "Yêu cầu thanh toán mới cần duyệt",
                    "Gia sư " + tutor.getFullName()
                            + " đã tạo yêu cầu thanh toán cho lớp "
                            + classEntity.getClassName(),
                    NotificationType.PAYMENT,
                    saved.getPaymentId(),
                    "payments"
            );
        }
    }

    @Override
    public void uploadProof(Integer parentUserId, UploadPaymentProofRequest request) {

        if (request.getPaymentId() == null) {
            throw new RuntimeException("Thiếu thông tin thanh toán");
        }
        
        boolean hasFile = request.getProofFile() != null && !request.getProofFile().isEmpty();
        boolean hasUrl = request.getProofUrl() != null && !request.getProofUrl().isBlank();
        
        if (!hasFile && !hasUrl) {
            throw new RuntimeException("Thiếu thông tin minh chứng thanh toán");
        }

        Parent parent = parentRepository.findByUserUserId(parentUserId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy phụ huynh"));

        Payment payment = paymentRepository.findById(request.getPaymentId())
                .orElseThrow(() -> new RuntimeException("Không tìm thấy yêu cầu thanh toán"));

        if (payment.getStudent() == null
                || payment.getStudent().getParent() == null
                || !payment.getStudent().getParent().getParentId()
                .equals(parent.getParentId())) {
            throw new RuntimeException("Bạn không có quyền upload minh chứng");
        }

        if (payment.getStatus() != PaymentStatus.ADMIN_APPROVED) {
            throw new RuntimeException("Payment chưa được admin duyệt");
        }

        if (request.getProofFile() != null && !request.getProofFile().isEmpty()) {
            try {
                File dir = new File(UPLOAD_DIR);
                if (!dir.exists()) dir.mkdirs();

                String originalName = request.getProofFile().getOriginalFilename();
                String fileName = UUID.randomUUID() + "_" + (originalName != null ? originalName.replaceAll("\\s+", "_") : "proof");
                File dest = new File(UPLOAD_DIR + fileName);
                request.getProofFile().transferTo(dest);

                payment.setProofUrl("/uploads/" + fileName);
            } catch (Exception e) {
                throw new RuntimeException("Lỗi khi tải ảnh lên: " + e.getMessage());
            }
        } else if (request.getProofUrl() != null && !request.getProofUrl().isBlank()) {
            payment.setProofUrl(request.getProofUrl());
        } else {
            throw new RuntimeException("Thiếu thông tin minh chứng thanh toán");
        }

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
                .orElseThrow(() -> new RuntimeException("Không tìm thấy payment"));

        if (payment.getTutor() == null
                || !payment.getTutor().getTutorId().equals(tutor.getTutorId())) {
            throw new RuntimeException("Bạn không có quyền xác nhận");
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
                    "Gia sư đã xác nhận nhận tiền, cần admin duyệt.",
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
                .orElseThrow(() -> new RuntimeException("Không tìm thấy payment"));

        if (payment.getStatus() == PaymentStatus.PENDING) {

            payment.setStatus(PaymentStatus.ADMIN_APPROVED);
            payment.setAdminApprovedAt(LocalDateTime.now());

            if (payment.getStudent().getParent() != null
                    && payment.getStudent().getParent().getUser() != null) {

                notificationService.createNotification(
                        payment.getStudent().getParent().getUser().getUserId(),
                        "Yêu cầu thanh toán mới",
                        "Admin đã duyệt yêu cầu thanh toán cho lớp "
                                + payment.getClassEntity().getClassName(),
                        NotificationType.PAYMENT,
                        payment.getPaymentId(),
                        "payments"
                );
            }

        } else if (payment.getStatus() == PaymentStatus.TUTOR_CONFIRMED) {

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

        } else {
            throw new RuntimeException("Trạng thái không cho phép duyệt");
        }

        paymentRepository.save(payment);
    }

    @Override
    public void adminReject(RejectPaymentRequest request) {

        if (request.getPaymentId() == null
                || request.getReason() == null
                || request.getReason().isBlank()) {
            throw new RuntimeException("Thiếu thông tin từ chối");
        }

        Payment payment = paymentRepository.findById(request.getPaymentId())
                .orElseThrow(() -> new RuntimeException("Không tìm thấy payment"));

        if (payment.getStatus() != PaymentStatus.PENDING
                && payment.getStatus() != PaymentStatus.PROOF_UPLOADED
                && payment.getStatus() != PaymentStatus.TUTOR_CONFIRMED
                && payment.getStatus() != PaymentStatus.ADMIN_APPROVED) {

            throw new RuntimeException("Không thể từ chối payment");
        }

        payment.setStatus(PaymentStatus.REJECTED);
        payment.setRejectionReason(request.getReason());

        Payment saved = paymentRepository.save(payment);

        if (saved.getTutor() != null && saved.getTutor().getUser() != null) {
            notificationService.createNotification(
                    saved.getTutor().getUser().getUserId(),
                    "Thanh toán bị từ chối",
                    "Admin đã từ chối thanh toán. Lý do: "
                            + request.getReason(),
                    NotificationType.PAYMENT,
                    saved.getPaymentId(),
                    "payments"
            );
        }

        if (saved.getStudent() != null
                && saved.getStudent().getParent() != null
                && saved.getStudent().getParent().getUser() != null) {

            notificationService.createNotification(
                    saved.getStudent().getParent().getUser().getUserId(),
                    "Thanh toán bị từ chối",
                    "Admin đã từ chối thanh toán. Lý do: "
                            + request.getReason(),
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

        return paymentRepository.findByTutorTutorIdOrderByRequestDateDesc(
                tutor.getTutorId()
        );
    }

    @Override
    public List<Payment> getParentPayments(Integer parentUserId) {

        Parent parent = parentRepository.findByUserUserId(parentUserId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy phụ huynh"));

        return paymentRepository.findByStudentParentParentIdOrderByRequestDateDesc(
                parent.getParentId()
        );
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

    @Override
    public long countApprovedPayments() {

        return paymentRepository.countByStatus(PaymentStatus.ADMIN_APPROVED)
                + paymentRepository.countByStatus(PaymentStatus.COMPLETED);
    }
}