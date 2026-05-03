package com.tcms.user.service;

import com.tcms.parent.entity.Parent;
import com.tcms.student.dto.request.CreateStudentProfileRequest;
import com.tcms.tutor.dto.request.CreateTutorProfileRequest;
import com.tcms.parent.dto.request.CreateParentProfileRequest;
import com.tcms.user.dto.request.CreateAccountRequest;
import com.tcms.user.entity.User;

import java.util.List;

public interface AdminUserService {
    List<User> getAllUsers();

    User createAccount(CreateAccountRequest request);

    void createTutorProfile(CreateTutorProfileRequest request);

    void createParentProfile(CreateParentProfileRequest request);

    void createStudentProfile(CreateStudentProfileRequest request);

    List<Parent> getAllParents();

    List<User> searchUsers(String username, String role, Boolean status);
}