package com.tcms.homework.entity;

import com.tcms.session.entity.TeachingSession;
import com.tcms.tutor.entity.Tutor;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "homework")
@Getter
@Setter
public class Homework {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "homework_id")
    private Integer homeworkId;

    @ManyToOne
    @JoinColumn(name = "session_id")
    private TeachingSession session;

    @ManyToOne
    @JoinColumn(name = "tutor_id")
    private Tutor tutor;

    private String title;

    @Enumerated(EnumType.STRING)
    private HomeworkType type;

    private String content;

    @Column(name = "attachment_url")
    private String attachmentUrl;

    private LocalDate deadline;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @OneToMany(mappedBy = "homework", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<HomeworkQuestion> questions = new ArrayList<>();
}