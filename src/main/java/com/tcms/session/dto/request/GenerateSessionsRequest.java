package com.tcms.session.dto.request;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class GenerateSessionsRequest {

    private Integer classId;

    private String startDate;

    private String endDate;
}