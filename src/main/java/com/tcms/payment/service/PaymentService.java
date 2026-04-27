package com.tcms.payment.service;

import com.tcms.payment.dto.request.CreatePaymentRequest;
import com.tcms.payment.dto.request.RejectPaymentRequest;
import com.tcms.payment.dto.request.UploadPaymentProofRequest;
import com.tcms.payment.entity.Payment;

import java.util.List;

public interface PaymentService {

    void createPayment(Integer tutorUserId, CreatePaymentRequest request);

    void uploadProof(Integer parentUserId, UploadPaymentProofRequest request);

    void tutorConfirm(Integer tutorUserId, Integer paymentId);

    void adminApprove(Integer paymentId);

    void adminReject(RejectPaymentRequest request);

    List<Payment> getTutorPayments(Integer tutorUserId);

    List<Payment> getParentPayments(Integer parentUserId);

    List<Payment> getAllPayments();
}