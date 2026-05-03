package com.tcms.homework.service;

import com.tcms.homework.dto.request.CreateHomeworkRequest;
import com.tcms.homework.entity.Homework;
import com.tcms.homework.entity.HomeworkQuestion;

import java.util.List;

public interface HomeworkService {

    void createHomework(Integer tutorUserId, CreateHomeworkRequest request);

    List<Homework> getHomeworkBySession(Integer sessionId);

    Homework getHomeworkById(Integer homeworkId);
    List<HomeworkQuestion> getQuestionsByHomeworkId(Integer homeworkId);
    List<Homework> getMyHomework(Integer studentUserId);
}