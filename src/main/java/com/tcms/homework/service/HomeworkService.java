package com.tcms.homework.service;

import com.tcms.homework.dto.request.CreateHomeworkRequest;
import com.tcms.homework.entity.Homework;

import java.util.List;

public interface HomeworkService {

    void createHomework(Integer tutorUserId, CreateHomeworkRequest request);

    List<Homework> getHomeworkBySession(Integer sessionId);

    Homework getHomeworkById(Integer homeworkId);
}