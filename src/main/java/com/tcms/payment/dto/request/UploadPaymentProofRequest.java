package com.tcms.payment.dto.request;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UploadPaymentProofRequest {
    private Integer paymentId;
    private String proofUrl;
}