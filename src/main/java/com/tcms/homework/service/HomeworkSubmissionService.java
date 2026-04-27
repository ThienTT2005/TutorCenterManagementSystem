package com.tcms.homework.service;

import com.tcms.homework.dto.request.SubmitHomeworkRequest;
import com.tcms.homework.entity.HomeworkSubmission;

import java.util.List;

public interface HomeworkSubmissionService {

    void submit(Integer studentUserId, SubmitHomeworkRequest request);
    List<HomeworkSubmission> getSubmissionsByHomework(Integer homeworkId);

    HomeworkSubmission getById(Integer submissionId);

    void grade(Integer submissionId, Double score, String feedback);
    HomeworkSubmission getMySubmission(Integer studentUserId, Integer homeworkId);
}