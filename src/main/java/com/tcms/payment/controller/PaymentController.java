package com.tcms.payment.controller;

import com.tcms.clazz.entity.ClassEntity;
import com.tcms.clazz.repository.EnrollmentRepository;
import com.tcms.parent.entity.Parent;
import com.tcms.parent.repository.ParentRepository;
import com.tcms.payment.dto.request.CreatePaymentRequest;
import com.tcms.payment.dto.request.RejectPaymentRequest;
import com.tcms.payment.dto.request.UploadPaymentProofRequest;
import com.tcms.payment.service.PaymentService;
import com.tcms.student.entity.Student;
import com.tcms.student.repository.StudentRepository;
import com.tcms.tutor.service.TutorClassService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/payment")
public class PaymentController {

    private final PaymentService paymentService;
    private final TutorClassService tutorclass;
    private final ParentRepository parentRepository;
    private final StudentRepository studentRepository;
    private final EnrollmentRepository enrollmentRepository;

    @PostMapping("/create")
    public String createPayment(
            @ModelAttribute CreatePaymentRequest request,
            HttpSession session,
            org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttributes
    ) {

        Integer tutorUserId = (Integer) session.getAttribute("userId");

        try {

            paymentService.createPayment(tutorUserId, request);

            redirectAttributes.addFlashAttribute(
                    "successMessage",
                    "Tạo yêu cầu thanh toán thành công!"
            );

        } catch (IllegalArgumentException e) {

            redirectAttributes.addFlashAttribute(
                    "errorMessage",
                    e.getMessage()
            );

        } catch (Exception e) {

            redirectAttributes.addFlashAttribute(
                    "errorMessage",
                    "Có lỗi xảy ra khi tạo yêu cầu thanh toán"
            );
        }

        return "redirect:/payment/tutor";
    }

    @PostMapping("/upload-proof")
    public String uploadProof(
            @ModelAttribute UploadPaymentProofRequest request,
            HttpSession session
    ) {
        Integer parentUserId = (Integer) session.getAttribute("userId");

        paymentService.uploadProof(parentUserId, request);

        return "redirect:/payment/parent";
    }

    @PostMapping("/tutor-confirm")
    public String tutorConfirm(
            @RequestParam Integer paymentId,
            HttpSession session
    ) {
        Integer tutorUserId = (Integer) session.getAttribute("userId");

        paymentService.tutorConfirm(tutorUserId, paymentId);

        return "redirect:/payment/tutor";
    }

    @PostMapping("/admin-approve")
    public String adminApprove(
            @RequestParam Integer paymentId
    ) {
        paymentService.adminApprove(paymentId);

        return "redirect:/payment/admin";
    }

    @PostMapping("/admin-reject")
    public String adminReject(
            @ModelAttribute RejectPaymentRequest request
    ) {
        paymentService.adminReject(request);

        return "redirect:/payment/admin";
    }

    @GetMapping("/tutor")
    public String tutorPayments(HttpSession session, Model model) {
        Integer tutorUserId = (Integer) session.getAttribute("userId");

        model.addAttribute("activePage", "payment");
        model.addAttribute("payments", paymentService.getTutorPayments(tutorUserId));

        model.addAttribute("classes", tutorclass.getMyClasses(tutorUserId));

        // Ban đầu chưa chọn lớp nên chưa load học sinh
        var classes = tutorclass.getMyClasses(tutorUserId);


        if (classes != null && !classes.isEmpty()) {
            Integer firstClassId = classes.get(0).getClassId();

            model.addAttribute(
                    "students",
                    tutorclass.getStudentsOfClass(tutorUserId, firstClassId)
            );
        } else {
            model.addAttribute("students", java.util.Collections.emptyList());
        }

        return "tutor/payments";
    }

    @GetMapping("/parent")
    public String parentPayments(
            @RequestParam(required = false) Integer studentId,
            @RequestParam(required = false) Integer classId,
            HttpSession session,
            Model model
    ) {
        Integer parentUserId = (Integer) session.getAttribute("userId");

        Parent parent = parentRepository.findByUserUserId(parentUserId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy phụ huynh"));

        List<Student> children = studentRepository.findByParentParentId(parent.getParentId());

        Map<Integer, ClassEntity> classMap = new LinkedHashMap<>();

        for (Student child : children) {
            enrollmentRepository.findByStudentStudentIdAndStatusTrue(child.getStudentId())
                    .forEach(enrollment -> {
                        if (enrollment.getClassEntity() != null) {
                            classMap.put(
                                    enrollment.getClassEntity().getClassId(),
                                    enrollment.getClassEntity()
                            );
                        }
                    });
        }

        List<ClassEntity> classes = new ArrayList<>(classMap.values());

        var payments = paymentService.getParentPayments(parentUserId)
                .stream()
                .filter(p -> p.getStatus() != com.tcms.payment.entity.PaymentStatus.PENDING)
                .filter(p -> studentId == null
                        || p.getStudent().getStudentId().equals(studentId))
                .filter(p -> classId == null
                        || p.getClassEntity().getClassId().equals(classId))
                .toList();

        model.addAttribute("activePage", "payments");
        model.addAttribute("payments", payments);
        model.addAttribute("children", children);
        model.addAttribute("classes", classes);
        model.addAttribute("selectedStudentId", studentId);
        model.addAttribute("selectedClassId", classId);

        return "parent/payments";
    }

    @GetMapping("/admin")
    public String adminPayments(Model model) {
        model.addAttribute("activePage", "payments");
        model.addAttribute(
                "payments",
                paymentService.getAllPayments()
        );
        model.addAttribute("approvedPaymentsCount", paymentService.countApprovedPayments());

        return "admin/payments";
    }
}