package com.tcms.attendance.dto.request;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AttendanceCodeRequest {
    private Integer sessionId;
    private String attendanceCode;
}