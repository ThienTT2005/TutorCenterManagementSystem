package com.tcms.profile.service;

import com.tcms.profile.dto.ProfileUpdateRequest;
import org.springframework.web.multipart.MultipartFile;

public interface ProfileService {

    Object getProfile(Integer userId);

    ProfileUpdateRequest buildProfileUpdateRequest(Integer userId);

    void updateProfile(Integer userId, ProfileUpdateRequest request);

    String uploadAvatar(Integer userId, MultipartFile file);
}