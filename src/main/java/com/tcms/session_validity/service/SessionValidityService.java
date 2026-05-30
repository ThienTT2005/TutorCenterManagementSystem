package com.tcms.session_validity.service;

public interface SessionValidityService {

    void calculateForSession(Integer sessionId);

    void calculateForStudentInSession(Integer sessionId, Integer studentId);
}