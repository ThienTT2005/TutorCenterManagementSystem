package com.tcms.homework.repository;

import com.tcms.homework.entity.Homework;
import com.tcms.homework.entity.HomeworkQuestion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface HomeworkRepository extends JpaRepository<Homework, Integer> {
    List<Homework> findBySessionSessionId(Integer sessionId);
    @Query("SELECT q FROM HomeworkQuestion q WHERE q.homework.homeworkId = :homeworkId")
    List<HomeworkQuestion> findQuestions(Integer homeworkId);
    List<Homework> findBySessionClassEntityClassIdIn(List<Integer> classIds);
}