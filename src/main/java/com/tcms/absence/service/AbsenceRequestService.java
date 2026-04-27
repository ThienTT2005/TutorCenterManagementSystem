package com.tcms.absence.service;

import com.tcms.absence.dto.request.CreateAbsenceRequest;
import com.tcms.absence.entity.AbsenceRequest;

import java.util.List;

public interface AbsenceRequestService {

    void create(Integer parentUserId, CreateAbsenceRequest request);

    List<AbsenceRequest> getMyRequests(Integer parentUserId);

    List<AbsenceRequest> getPending();

    void approve(Integer requestId, Integer adminUserId);

    void reject(Integer requestId, Integer adminUserId, String reason);
}
