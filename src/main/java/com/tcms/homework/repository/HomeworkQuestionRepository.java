package com.tcms.homework.repository;

import com.tcms.homework.entity.HomeworkQuestion;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface HomeworkQuestionRepository extends JpaRepository<HomeworkQuestion, Integer> {

    List<HomeworkQuestion> findByHomeworkHomeworkId(Integer homeworkId);
}