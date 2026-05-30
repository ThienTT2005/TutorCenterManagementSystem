package com.tcms.payment.dto.request;

import lombok.Getter;
import lombok.Setter;
import org.springframework.web.multipart.MultipartFile;
@Getter
@Setter
public class UploadPaymentProofRequest {
    private Integer paymentId;
    private String proofUrl;
    private MultipartFile proofFile;
}