package com.tcms.tutor.dto.request;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CreateTutorProfileRequest {
    private Integer userId;
    private String fullName;
    private String phone;
    private String email;
    private String dob;
    private String gender;
    private String address;
    private String school;
    private String major;
    private String description;
    private org.springframework.web.multipart.MultipartFile avatarFile;
}