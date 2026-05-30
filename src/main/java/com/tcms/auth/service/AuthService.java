package com.tcms.auth.service;

import com.tcms.auth.dto.LoginRequest;
import com.tcms.user.entity.User;

public interface AuthService {
    User login(LoginRequest request);
}