package com.tcms.profile.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
public class ProfileUpdateRequest {

    private String fullName;
    private String phone;
    private String email;
    private LocalDate dob;
    private String gender;
    private String address;

    // Tutor
    private String school;
    private String major;
    private String description;

    // Student
    private String grade;
}