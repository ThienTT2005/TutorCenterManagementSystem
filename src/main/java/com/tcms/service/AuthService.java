package com.tcms.service;

import com.tcms.dto.auth.LoginRequest;
import com.tcms.dto.auth.LoginResponse;

public interface AuthService {
    LoginResponse login(LoginRequest request);
}