package com.tcms.schedule.dto.request;

import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
public class CreateScheduleBatchRequest {
    private Integer classId;
    private List<CreateScheduleRequest> schedules = new ArrayList<>();
}