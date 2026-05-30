package com.tcms.schedule.service;

import com.tcms.schedule.dto.request.CreateScheduleRequest;
import com.tcms.schedule.dto.request.UpdateScheduleRequest;
import com.tcms.schedule.entity.TeachingSchedule;

import java.util.List;

public interface ScheduleService {

    List<TeachingSchedule> getSchedulesByClassId(Integer classId);

    void createSchedule(CreateScheduleRequest request);
    void deleteSchedule(Integer scheduleId);

    void updateSchedule(Integer scheduleId, UpdateScheduleRequest request);

}