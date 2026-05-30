package com.tcms.session_validity.entity;

import com.tcms.payment.entity.Payment;
import com.tcms.session.entity.TeachingSession;
import com.tcms.student.entity.Student;
import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "session_validity_log")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SessionValidityLog {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "log_id")
    private Integer logId;

    @ManyToOne
    @JoinColumn(name = "session_id")
    private TeachingSession session;

    @ManyToOne
    @JoinColumn(name = "student_id")
    private Student student;

    @Column(name = "attendance_valid")
    private Boolean attendanceValid;

    @Column(name = "feedback_status")
    private String feedbackStatus;

    @Column(name = "feedback_penalty")
    private BigDecimal feedbackPenalty;

    @Column(name = "feedback_submitted_at")
    private LocalDateTime feedbackSubmittedAt;

    @Column(name = "is_paid")
    private Boolean isPaid;

    @Column(name = "calculated_amount")
    private BigDecimal calculatedAmount;

    @ManyToOne
    @JoinColumn(name = "payment_id")
    private Payment payment;

    @Column(name = "calculated_at")
    private LocalDateTime calculatedAt;
}