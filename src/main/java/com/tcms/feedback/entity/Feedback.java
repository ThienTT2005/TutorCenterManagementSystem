package com.tcms.feedback.entity;

import com.tcms.session.entity.TeachingSession;
import com.tcms.student.entity.Student;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "feedback")
@Getter
@Setter
public class Feedback {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "feedback_id")
    private Integer feedbackId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "session_id")
    private TeachingSession session;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "student_id")
    private Student student;

    private String rating;

    @Column(columnDefinition = "TEXT")
    private String comment;

    @Column(name = "submitted_at")
    private LocalDateTime submittedAt;

    @Column(name = "is_late")
    private Boolean isLate;

    @Column(name = "penalty_rate")
    private BigDecimal penaltyRate;

    @Enumerated(EnumType.STRING)
    private FeedbackStatus status;

    @Column(name = "rejected_reason")
    private String rejectedReason;
}