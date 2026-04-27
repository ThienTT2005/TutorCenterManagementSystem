package com.tcms.tutor.service;
import com.tcms.clazz.entity.ClassEntity;
import com.tcms.clazz.entity.Enrollment;
import com.tcms.clazz.repository.ClassRepository;
import com.tcms.clazz.repository.EnrollmentRepository;
import com.tcms.exception.BadRequestException;
import com.tcms.session.entity.TeachingSession;
import com.tcms.session.repository.TeachingSessionRepository;
import com.tcms.tutor.entity.Tutor;
import com.tcms.tutor.repository.TutorRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
@RequiredArgsConstructor
public class TutorClassServiceImpl implements TutorClassService{
    private final TutorRepository tutorRepository;
    private final ClassRepository classRepository;
    private final EnrollmentRepository enrollmentRepository;
    private final TeachingSessionRepository teachingSessionRepository;

    @Override
    public List<ClassEntity> getMyClasses(Integer userId){
        Tutor tutor = getTutorByUserId(userId);
        return classRepository.findByTutorTutorIdAndStatusTrue(tutor.getTutorId());
    }

    @Override
    public ClassEntity getMyClassDetail(Integer userId, Integer classId){
        Tutor tutor = getTutorByUserId(userId);
        ClassEntity classEntity = classRepository.findById(classId)
                .orElseThrow(() -> new BadRequestException("Không tìm thấy lớp học"));
        if(!classEntity.getTutor().getTutorId().equals(tutor.getTutorId())){
            throw new BadRequestException("Bạn không có quyền xem lớp này");
        }
        return classEntity;
    }

    @Override
    public List<Enrollment> getStudentsOfClass(Integer userId, Integer classId){
        getMyClassDetail(userId, classId);
        return enrollmentRepository.findByClassEntityClassIdAndStatusTrue(classId);
    }

    @Override
    public List<TeachingSession> getSessionsOfClass(Integer userId, Integer classId){
        getMyClassDetail(userId, classId);
        return teachingSessionRepository
                .findByClassEntityClassIdOrderBySessionDateAscStartTimeAsc(classId);
    }

    private Tutor getTutorByUserId(Integer userId){
        return tutorRepository.findByUserUserId(userId)
                .orElseThrow(() -> new BadRequestException("Không tìm thấy hồ sơ gia sư"));
    }
}