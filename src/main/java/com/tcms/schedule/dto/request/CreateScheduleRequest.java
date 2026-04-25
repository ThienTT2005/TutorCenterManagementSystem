package com.tcms.schedule.dto.request;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CreateScheduleRequest {

    private Integer classId;

    private Integer weekday;

    private String startTime;

    private String endTime;
}