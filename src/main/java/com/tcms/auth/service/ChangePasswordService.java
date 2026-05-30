package com.tcms.auth.service;

import com.tcms.auth.dto.ChangePasswordRequest;

public interface ChangePasswordService {
    void changePassword(Integer userId, ChangePasswordRequest request);
}