package com.tcms.absence.dto.request;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CreateAbsenceRequest {

    private Integer sessionId;

    private Integer studentId;

    private String reason;
}
