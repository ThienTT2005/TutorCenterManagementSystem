package com.tcms.session.entity;

import com.tcms.clazz.entity.ClassEntity;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

@Entity
@Table(name = "teaching_sessions")
@Getter
@Setter
public class TeachingSession {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "session_id")
    private Integer sessionId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "class_id")
    private ClassEntity classEntity;

    @Column(name = "session_date")
    private LocalDate sessionDate;

    @Column(name = "start_time")
    private LocalTime startTime;

    @Column(name = "end_time")
    private LocalTime endTime;

    private String topic;

    @Enumerated(EnumType.STRING)
    private SessionStatus status;

    @Column(name = "attendance_code")
    private String attendanceCode;

    @Column(name = "created_at")
    private LocalDateTime createdAt;
}