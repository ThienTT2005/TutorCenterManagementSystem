package com.tcms.tutor.entity;

import com.tcms.user.entity.User;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Entity
@Table(name = "tutors")
@Getter
@Setter
public class Tutor {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "tutor_id")
    private Integer tutorId;

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id", unique = true)
    private User user;

    @Column(name = "full_name")
    private String fullName;

    private String phone;
    private String email;

    private LocalDate dob;

    private String gender;
    private String address;
    private String avatar;
    private String school;
    private String major;

    @Column(columnDefinition = "TEXT")
    private String description;
}