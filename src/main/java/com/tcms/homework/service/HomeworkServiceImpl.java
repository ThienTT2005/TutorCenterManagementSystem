package com.tcms.homework.service;

import com.tcms.clazz.entity.Enrollment;
import com.tcms.clazz.repository.EnrollmentRepository;
import com.tcms.exception.BadRequestException;
import com.tcms.homework.dto.request.CreateHomeworkQuestionRequest;
import com.tcms.homework.dto.request.CreateHomeworkRequest;
import com.tcms.homework.entity.Homework;
import com.tcms.homework.entity.HomeworkQuestion;
import com.tcms.homework.entity.HomeworkType;
import com.tcms.homework.repository.HomeworkQuestionRepository;
import com.tcms.homework.repository.HomeworkRepository;
import com.tcms.notification.entity.NotificationType;
import com.tcms.notification.service.NotificationService;
import com.tcms.session.entity.TeachingSession;
import com.tcms.session.repository.TeachingSessionRepository;
import com.tcms.student.entity.Student;
import com.tcms.tutor.entity.Tutor;
import com.tcms.tutor.repository.TutorRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class HomeworkServiceImpl implements HomeworkService {

    private final HomeworkRepository homeworkRepository;
    private final HomeworkQuestionRepository homeworkQuestionRepository;
    private final TeachingSessionRepository teachingSessionRepository;
    private final TutorRepository tutorRepository;
    private final EnrollmentRepository enrollmentRepository;
    private final NotificationService notificationService;

    @Override
    public void createHomework(Integer tutorUserId, CreateHomeworkRequest request) {
        if (request.getSessionId() == null) {
            throw new BadRequestException("Thiếu buổi học");
        }

        if (request.getTitle() == null || request.getTitle().trim().isEmpty()) {
            throw new BadRequestException("Tên bài tập không được để trống");
        }

        TeachingSession session = teachingSessionRepository.findById(request.getSessionId())
                .orElseThrow(() -> new RuntimeException("Buổi học không tồn tại"));

        Tutor tutor = tutorRepository.findByUserUserId(tutorUserId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy gia sư"));

        if (!session.getClassEntity().getTutor().getTutorId().equals(tutor.getTutorId())) {
            throw new BadRequestException("Bạn không có quyền tạo bài tập cho buổi học này");
        }

        HomeworkType type;
        try {
            type = HomeworkType.valueOf(request.getType());
        } catch (Exception e) {
            throw new BadRequestException("Loại bài tập không hợp lệ");
        }

        Homework homework = new Homework();
        homework.setSession(session);
        homework.setTutor(tutor);
        homework.setTitle(request.getTitle());
        homework.setType(type);
        homework.setContent(request.getContent());
        homework.setAttachmentUrl(request.getAttachmentUrl());
        homework.setDeadline(request.getDeadline());
        homework.setCreatedAt(LocalDateTime.now());

        Homework savedHomework = homeworkRepository.save(homework);

        if (type == HomeworkType.MULTIPLE_CHOICE) {
            if (request.getQuestions() == null || request.getQuestions().isEmpty()) {
                throw new BadRequestException("Bài trắc nghiệm phải có ít nhất 1 câu hỏi");
            }

            for (CreateHomeworkQuestionRequest q : request.getQuestions()) {
                if (q.getQuestionText() == null || q.getQuestionText().trim().isEmpty()) {
                    continue;
                }

                HomeworkQuestion question = new HomeworkQuestion();
                question.setHomework(savedHomework);
                question.setQuestionText(q.getQuestionText());
                question.setOptionA(q.getOptionA());
                question.setOptionB(q.getOptionB());
                question.setOptionC(q.getOptionC());
                question.setOptionD(q.getOptionD());
                question.setCorrectAnswer(q.getCorrectAnswer());

                homeworkQuestionRepository.save(question);
            }
        }

        notifyStudentsAndParentsNewHomework(savedHomework, session);
    }

    @Override
    public List<Homework> getHomeworkBySession(Integer sessionId) {
        return homeworkRepository.findBySessionSessionId(sessionId);
    }

    @Override
    public Homework getHomeworkById(Integer homeworkId) {
        return homeworkRepository.findById(homeworkId)
                .orElseThrow(() -> new BadRequestException("Bài tập không tồn tại"));
    }

    private void notifyStudentsAndParentsNewHomework(Homework homework, TeachingSession session) {
        List<Enrollment> enrollments =
                enrollmentRepository.findByClassEntityClassIdAndStatusTrue(
                        session.getClassEntity().getClassId()
                );

        for (Enrollment enrollment : enrollments) {
            Student student = enrollment.getStudent();

            if (student == null) continue;

            if (student.getUser() != null) {
                notificationService.createNotification(
                        student.getUser().getUserId(),
                        "Bài tập mới",
                        "Bạn có bài tập mới: " + homework.getTitle(),
                        NotificationType.HOMEWORK,
                        homework.getHomeworkId(),
                        "homework"
                );
            }

            if (student.getParent() != null && student.getParent().getUser() != null) {
                notificationService.createNotification(
                        student.getParent().getUser().getUserId(),
                        "Bài tập mới của con",
                        "Con bạn có bài tập mới: " + homework.getTitle(),
                        NotificationType.HOMEWORK,
                        homework.getHomeworkId(),
                        "homework"
                );
            }
        }
    }
}