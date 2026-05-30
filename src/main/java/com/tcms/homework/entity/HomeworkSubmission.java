package com.tcms.homework.entity;

import com.tcms.student.entity.Student;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Table(name = "homework_submissions")
@Getter
@Setter
public class HomeworkSubmission {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "submission_id")
    private Integer submissionId;

    @ManyToOne
    @JoinColumn(name = "homework_id")
    private Homework homework;

    @ManyToOne
    @JoinColumn(name = "student_id")
    private Student student;

    @Column(name = "answers")
    private String answers;

    @Column(name = "attachment_url")
    private String attachmentUrl;

    @Column(name = "score")
    private Double score;

    @Column(name = "teacher_feedback")
    private String teacherFeedback;

    @Column(name = "submitted_at")
    private LocalDateTime submittedAt;

    @Column(name = "graded_at")
    private LocalDateTime gradedAt;

    @Enumerated(EnumType.STRING)
    @Column(name = "status")
    private SubmissionStatus status;
}