package com.tcms.homework.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.tcms.exception.BadRequestException;
import com.tcms.homework.dto.request.SubmitHomeworkRequest;
import com.tcms.homework.entity.*;
import com.tcms.homework.repository.HomeworkQuestionRepository;
import com.tcms.homework.repository.HomeworkRepository;
import com.tcms.homework.repository.HomeworkSubmissionRepository;
import com.tcms.notification.entity.NotificationType;
import com.tcms.notification.service.NotificationService;
import com.tcms.student.entity.Student;
import com.tcms.student.repository.StudentRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class HomeworkSubmissionServiceImpl implements HomeworkSubmissionService {

    private final HomeworkRepository homeworkRepository;
    private final HomeworkSubmissionRepository homeworkSubmissionRepository;
    private final HomeworkQuestionRepository homeworkQuestionRepository;
    private final StudentRepository studentRepository;
    private final ObjectMapper objectMapper;
    private final NotificationService notificationService;

    @Override
    public void submit(Integer studentUserId, SubmitHomeworkRequest request) {
        Homework homework = homeworkRepository.findById(request.getHomeworkId())
                .orElseThrow(() -> new BadRequestException("Bài tập không tồn tại"));

        Student student = studentRepository.findByUserUserId(studentUserId)
                .orElseThrow(() -> new BadRequestException("Không tìm thấy học sinh"));

        if (homeworkSubmissionRepository
                .findByHomeworkHomeworkIdAndStudentStudentId(
                        request.getHomeworkId(),
                        student.getStudentId()
                ).isPresent()) {
            throw new BadRequestException("Bạn đã nộp bài rồi");
        }

        HomeworkSubmission submission = new HomeworkSubmission();
        submission.setHomework(homework);
        submission.setStudent(student);
        submission.setSubmittedAt(LocalDateTime.now());
        submission.setAnswers(request.getAnswers());
        submission.setAttachmentUrl(request.getAttachmentUrl());
        submission.setStatus(SubmissionStatus.SUBMITTED);

        if (homework.getType() == HomeworkType.MULTIPLE_CHOICE) {
            gradeMultipleChoice(homework, request, submission);
        }

        HomeworkSubmission saved = homeworkSubmissionRepository.save(submission);

        notifyTutorStudentSubmitted(saved);
    }

    private void gradeMultipleChoice(
            Homework homework,
            SubmitHomeworkRequest request,
            HomeworkSubmission submission
    ) {
        try {
            Map<String, String> answersMap = objectMapper.readValue(
                    request.getAnswers(),
                    new TypeReference<Map<String, String>>() {}
            );

            List<HomeworkQuestion> questions =
                    homeworkQuestionRepository.findByHomeworkHomeworkId(homework.getHomeworkId());

            if (questions.isEmpty()) {
                throw new BadRequestException("Bài trắc nghiệm chưa có câu hỏi");
            }

            int correct = 0;

            for (HomeworkQuestion question : questions) {
                String key = "q_" + question.getQuestionId();
                String studentAnswer = answersMap.get(key);

                if (studentAnswer != null
                        && studentAnswer.equalsIgnoreCase(question.getCorrectAnswer())) {
                    correct++;
                }
            }

            double score = correct * 10.0 / questions.size();

            submission.setScore(score);
            submission.setStatus(SubmissionStatus.GRADED);
            submission.setGradedAt(LocalDateTime.now());

        } catch (BadRequestException e) {
            throw e;
        } catch (Exception e) {
            throw new BadRequestException("Lỗi parse đáp án");
        }
    }

    @Override
    public List<HomeworkSubmission> getSubmissionsByHomework(Integer homeworkId) {
        return homeworkSubmissionRepository.findByHomeworkHomeworkId(homeworkId);
    }

    @Override
    public HomeworkSubmission getById(Integer submissionId) {
        return homeworkSubmissionRepository.findById(submissionId)
                .orElseThrow(() -> new BadRequestException("Không tìm thấy bài nộp"));
    }

    @Override
    public void grade(Integer submissionId, Double score, String feedback) {
        HomeworkSubmission submission = getById(submissionId);

        submission.setScore(score);
        submission.setTeacherFeedback(feedback);
        submission.setStatus(SubmissionStatus.GRADED);
        submission.setGradedAt(LocalDateTime.now());

        homeworkSubmissionRepository.save(submission);
    }

    @Override
    public HomeworkSubmission getMySubmission(Integer studentUserId, Integer homeworkId) {
        Student student = studentRepository.findByUserUserId(studentUserId)
                .orElseThrow(() -> new BadRequestException("Không tìm thấy học sinh"));

        return homeworkSubmissionRepository
                .findByHomeworkHomeworkIdAndStudentStudentId(homeworkId, student.getStudentId())
                .orElse(null);
    }

    private void notifyTutorStudentSubmitted(HomeworkSubmission submission) {
        Homework homework = submission.getHomework();

        if (homework == null ||
                homework.getTutor() == null ||
                homework.getTutor().getUser() == null) {
            return;
        }

        String studentName = submission.getStudent() != null
                ? submission.getStudent().getFullName()
                : "Học sinh";

        notificationService.createNotification(
                homework.getTutor().getUser().getUserId(),
                "Học sinh đã nộp bài",
                studentName + " vừa nộp bài tập: " + homework.getTitle(),
                NotificationType.HOMEWORK,
                submission.getSubmissionId(),
                "homework_submissions"
        );
    }
}