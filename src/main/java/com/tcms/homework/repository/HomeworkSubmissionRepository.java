package com.tcms.homework.repository;

import com.tcms.homework.entity.HomeworkSubmission;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface HomeworkSubmissionRepository extends JpaRepository<HomeworkSubmission, Integer> {
    Optional<HomeworkSubmission> findByHomeworkHomeworkIdAndStudentStudentId(
            Integer homeworkId,
            Integer studentId
    );
    List<HomeworkSubmission> findByHomeworkHomeworkId(Integer homeworkId);
}