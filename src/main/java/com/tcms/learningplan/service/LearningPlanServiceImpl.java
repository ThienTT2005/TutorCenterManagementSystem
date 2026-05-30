package com.tcms.learningplan.service;

import com.tcms.exception.BadRequestException;
import com.tcms.learningplan.dto.request.CreateLearningPlanRequest;
import com.tcms.learningplan.entity.LearningPlan;
import com.tcms.learningplan.repository.LearningPlanRepository;
import com.tcms.session.entity.TeachingSession;
import com.tcms.session.repository.TeachingSessionRepository;
import com.tcms.tutor.entity.Tutor;
import com.tcms.tutor.repository.TutorRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
public class LearningPlanServiceImpl implements LearningPlanService {

    private final LearningPlanRepository learningPlanRepository;
    private final TeachingSessionRepository teachingSessionRepository;
    private final TutorRepository tutorRepository;

    @Override
    public LearningPlan getPlanBySessionId(Integer sessionId) {
        return learningPlanRepository.findBySessionSessionId(sessionId).orElse(null);
    }

    @Override
    public void createOrUpdatePlan(Integer userId, CreateLearningPlanRequest request) {
        validateRequest(request);

        Tutor tutor = tutorRepository.findByUserUserId(userId)
                .orElseThrow(() -> new BadRequestException("Không tìm thấy hồ sơ gia sư"));

        TeachingSession session = teachingSessionRepository.findById(request.getSessionId())
                .orElseThrow(() -> new BadRequestException("Không tìm thấy buổi học"));

        if (!session.getClassEntity().getTutor().getTutorId().equals(tutor.getTutorId())) {
            throw new BadRequestException("Bạn không có quyền tạo kế hoạch cho buổi học này");
        }

        LocalDateTime now = LocalDateTime.now();
        LocalDateTime sessionStart = LocalDateTime.of(
                session.getSessionDate(),
                session.getStartTime()
        );

        if (!now.isBefore(sessionStart)) {
            throw new BadRequestException("Chỉ được tạo hoặc cập nhật giáo án trước khi buổi học bắt đầu");
        }

        LearningPlan plan = learningPlanRepository
                .findBySessionSessionId(request.getSessionId())
                .orElse(new LearningPlan());

        plan.setSession(session);
        plan.setTitle(request.getTitle());
        plan.setContent(request.getContent());
        plan.setObjectives(request.getObjectives());

        learningPlanRepository.save(plan);
    }

    private void validateRequest(CreateLearningPlanRequest request) {
        if (request.getSessionId() == null) {
            throw new BadRequestException("Thiếu buổi học");
        }

        if (request.getTitle() == null || request.getTitle().isBlank()) {
            throw new BadRequestException("Tên bài học không được để trống");
        }

        if (request.getContent() == null || request.getContent().isBlank()) {
            throw new BadRequestException("Nội dung bài học không được để trống");
        }

        if (request.getObjectives() == null || request.getObjectives().isBlank()) {
            throw new BadRequestException("Mục tiêu buổi học không được để trống");
        }
    }
}