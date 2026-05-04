package com.tcms.user.service;

import com.tcms.parent.entity.Parent;
import com.tcms.profile.dto.ProfileUpdateRequest;
import com.tcms.student.dto.request.CreateStudentProfileRequest;
import com.tcms.student.entity.Student;
import com.tcms.tutor.dto.request.CreateTutorProfileRequest;
import com.tcms.parent.dto.request.CreateParentProfileRequest;
import com.tcms.tutor.entity.Tutor;
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

    User getUserById(Integer userId);

    Object getProfileByUserId(Integer userId);

    ProfileUpdateRequest buildProfileUpdateRequest(Integer userId);

    void updateProfileByAdmin(Integer userId, ProfileUpdateRequest request);

    List<Student> getAllStudents();
    List<Tutor> getAllTutors();
}