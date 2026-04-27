package com.tcms.payment.dto.request;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CreatePaymentRequest {
    private Integer classId;
    private Integer studentId;
    private String note;
}