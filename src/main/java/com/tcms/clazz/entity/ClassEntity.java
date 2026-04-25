package com.tcms.clazz.entity;

import com.tcms.tutor.entity.Tutor;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "classes")
@Getter
@Setter

public class ClassEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "class_id")
    private Integer classId;

    @Column(name = "class_name")
    private String className;

    private String subject;

    private String grade;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "tutor_id")
    private Tutor tutor;

    @Column(name = "tuition_fee_per_session")
    private BigDecimal tuitionFeePerSession;

    @Column(name = "required_sessions")
    private Integer requiredSessions;

    @Column(columnDefinition = "TEXT")
    private String description;

    private Boolean status;

    @Column(name = "created_at")
    private LocalDateTime createdAt;
}
