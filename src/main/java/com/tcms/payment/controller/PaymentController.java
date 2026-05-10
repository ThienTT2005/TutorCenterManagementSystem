package com.tcms.payment.controller;

import com.tcms.payment.dto.request.CreatePaymentRequest;
import com.tcms.payment.dto.request.RejectPaymentRequest;
import com.tcms.payment.dto.request.UploadPaymentProofRequest;
import com.tcms.payment.service.PaymentService;
import com.tcms.tutor.service.TutorClassService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/payment")
public class PaymentController {

    private final PaymentService paymentService;
    private final TutorClassService tutorclass;

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
            HttpSession session,
            Model model
    ) {
        Integer parentUserId = (Integer) session.getAttribute("userId");
        model.addAttribute("activePage", "payments");
        model.addAttribute(
                "payments",
                paymentService.getParentPayments(parentUserId)
        );

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