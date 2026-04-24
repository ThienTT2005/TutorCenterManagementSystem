package com.tcms.session.service;

import com.tcms.session.dto.request.GenerateSessionsRequest;
import com.tcms.session.entity.TeachingSession;

import java.util.List;

public interface SessionService {

    List<TeachingSession> getSessionsByClassId(Integer classId);

    void generateSessions(GenerateSessionsRequest request);
}