package com.tcms.schedule.service;

import com.tcms.schedule.dto.request.CreateScheduleRequest;
import com.tcms.schedule.entity.TeachingSchedule;

import java.util.List;

public interface ScheduleService {

    List<TeachingSchedule> getSchedulesByClassId(Integer classId);

    void createSchedule(CreateScheduleRequest request);
}