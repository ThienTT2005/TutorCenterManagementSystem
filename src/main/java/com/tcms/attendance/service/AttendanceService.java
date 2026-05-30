package com.tcms.attendance.service;

import com.tcms.attendance.dto.request.AttendanceCodeRequest;
import com.tcms.attendance.entity.Attendance;

import java.util.List;

public interface AttendanceService {

    List<Attendance> getAttendanceBySession(Integer sessionId);

    void checkIn(Integer tutorUserId, AttendanceCodeRequest request);

    void checkOut(Integer tutorUserId, AttendanceCodeRequest request);
}