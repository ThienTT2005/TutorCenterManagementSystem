package com.tcms.user.service;

import com.tcms.student.dto.request.CreateStudentProfileRequest;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

@SpringBootTest
@Transactional
public class AdminUserServiceTest {

    @Autowired
    private AdminUserService adminUserService;

    @Test
    public void testCreateStudentProfile() {
        CreateStudentProfileRequest request = new CreateStudentProfileRequest();
        request.setUserId(6); // Use existing student user
        request.setParentId(1); // Use existing parent
        request.setFullName("Test Student");
        request.setGender("Nam");
        request.setSchool("Test School");
        request.setGrade("10A1");

        System.out.println("Testing student creation...");
        try {
            adminUserService.createStudentProfile(request);
            System.out.println("Test student created successfully");
        } catch (Exception e) {
            System.out.println("Test failed: " + e.getMessage());
            e.printStackTrace();
        }
    }
}