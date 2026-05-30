package com.tcms.student.dto.request;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CreateStudentProfileRequest {
    private Integer userId;
    private Integer parentId;
    private String fullName;
    private String dob;
    private String gender;
    private String address;
    private String school;
    private String grade;
    private org.springframework.web.multipart.MultipartFile avatarFile;
}