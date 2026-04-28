package com.tcms.profile.service;

import com.tcms.profile.dto.ProfileUpdateRequest;

public interface ProfileService {

    Object getProfile(Integer userId);

    void updateProfile(Integer userId, ProfileUpdateRequest request);

    String uploadAvatar(Integer userId, org.springframework.web.multipart.MultipartFile file);
}