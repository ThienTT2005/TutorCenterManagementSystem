package com.tcms.payment.entity;

import com.tcms.clazz.entity.ClassEntity;
import com.tcms.student.entity.Student;
import com.tcms.tutor.entity.Tutor;
import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "payments")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Payment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer paymentId;

    @ManyToOne
    @JoinColumn(name = "tutor_id")
    private Tutor tutor;

    @ManyToOne
    @JoinColumn(name = "class_id")
    private ClassEntity classEntity;

    @ManyToOne
    @JoinColumn(name = "student_id")
    private Student student;

    @Column(name = "session_ids")
    private String sessionIds;

    @Column(name = "total_sessions")
    private Integer totalSessions;

    private BigDecimal amount;

    @Column(name = "request_date")
    private LocalDateTime requestDate;

    @Column(name = "proof_url")
    private String proofUrl;

    @Column(name = "tutor_confirmed_at")
    private LocalDateTime tutorConfirmedAt;

    @Column(name = "admin_approved_at")
    private LocalDateTime adminApprovedAt;

    @Enumerated(EnumType.STRING)
    private PaymentStatus status;

    private String note;

    @Column(name = "rejection_reason")
    private String rejectionReason;
}