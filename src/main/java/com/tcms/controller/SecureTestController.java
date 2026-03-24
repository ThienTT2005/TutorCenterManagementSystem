package com.tcms.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class SecureTestController {

    @GetMapping("/api/secure-test")
    public String secureTest() {
        return "You accessed a protected API!";
    }
}