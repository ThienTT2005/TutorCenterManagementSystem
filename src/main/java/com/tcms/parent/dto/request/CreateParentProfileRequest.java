package com.tcms.parent.dto.request;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CreateParentProfileRequest {
    private Integer userId;
    private String fullName;
    private String phone;
    private String email;
    private String dob;
    private String gender;
    private String address;
}