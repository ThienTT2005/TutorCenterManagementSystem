package com.tcms.payment.dto.request;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RejectPaymentRequest {
    private Integer paymentId;
    private String reason;
}