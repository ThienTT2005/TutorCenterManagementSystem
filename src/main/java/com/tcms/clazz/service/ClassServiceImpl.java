package com.tcms.clazz.service;

import com.tcms.clazz.dto.request.CreateClassRequest;
import com.tcms.clazz.entity.ClassEntity;
import com.tcms.clazz.entity.Enrollment;
import com.tcms.clazz.repository.ClassRepository;
import com.tcms.clazz.repository.EnrollmentRepository;
import com.tcms.exception.BadRequestException;
import com.tcms.notification.entity.NotificationType;
import com.tcms.notification.service.NotificationService;
import com.tcms.student.entity.Student;
import com.tcms.student.repository.StudentRepository;
import com.tcms.tutor.entity.Tutor;
import com.tcms.tutor.repository.TutorRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ClassServiceImpl implements ClassService {

    private final ClassRepository classRepository;
    private final EnrollmentRepository enrollmentRepository;
    private final TutorRepository tutorRepository;
    private final StudentRepository studentRepository;
    private final NotificationService notificationService;

    @Override
    public List<ClassEntity> getAllClasses() {
        return classRepository.findAll();
    }

    @Override
    public List<ClassEntity> searchClasses(String keyword, String subject, String grade, Boolean status) {
        return classRepository.searchClasses(keyword, subject, grade, status);
    }

    @Override
    public ClassEntity getClassById(Integer classId) {
        return classRepository.findById(classId)
                .orElseThrow(() -> new BadRequestException("Không tìm thấy lớp học"));
    }

    @Override
    public List<Tutor> getAllTutors() {
        return tutorRepository.findAll();
    }

    @Override
    public List<Student> getAllStudents() {
        return studentRepository.findAll();
    }

    @Override
    public List<Enrollment> getEnrollmentsByClassId(Integer classId) {
        return enrollmentRepository.findByClassEntityClassIdAndStatusTrue(classId);
    }

    @Override
    public void createClass(CreateClassRequest request) {
        validateCreateClass(request);

        Tutor tutor = tutorRepository.findById(request.getTutorId())
                .orElseThrow(() -> new BadRequestException("Gia sư không tồn tại"));

        ClassEntity classEntity = new ClassEntity();
        classEntity.setClassName(request.getClassName());
        classEntity.setSubject(request.getSubject());
        classEntity.setGrade(request.getGrade());
        classEntity.setTutor(tutor);
        classEntity.setTuitionFeePerSession(request.getTuitionFeePerSession());
        classEntity.setRequiredSessions(request.getRequiredSessionsPerMonth());
        classEntity.setDescription(request.getDescription());
        classEntity.setStatus(true);

        ClassEntity savedClass = classRepository.save(classEntity);

        notifyTutorAddedToClass(savedClass, tutor);

        if (request.getStudentIds() != null) {
            for (Integer studentId : request.getStudentIds()) {
                Student student = studentRepository.findById(studentId)
                        .orElseThrow(() -> new BadRequestException("Học sinh không tồn tại: " + studentId));

                if (!enrollmentRepository.existsByClassEntityClassIdAndStudentStudentId(savedClass.getClassId(), studentId)) {
                    Enrollment enrollment = new Enrollment();
                    enrollment.setClassEntity(savedClass);
                    enrollment.setStudent(student);
                    enrollment.setStatus(true);

                    enrollmentRepository.save(enrollment);

                    notifyStudentAndParentAddedToClass(savedClass, student);
                    notifyTutorStudentJoinedClass(savedClass, tutor, student);
                }
            }
        }
    }

    @Override
    public void updateClass(Integer classId, CreateClassRequest request) {
        validateCreateClass(request);

        ClassEntity classEntity = getClassById(classId);

        Tutor oldTutor = classEntity.getTutor();

        Tutor tutor = tutorRepository.findById(request.getTutorId())
                .orElseThrow(() -> new BadRequestException("Gia sư không tồn tại"));

        classEntity.setClassName(request.getClassName());
        classEntity.setSubject(request.getSubject());
        classEntity.setGrade(request.getGrade());
        classEntity.setTuitionFeePerSession(request.getTuitionFeePerSession());

        classEntity.setRequiredSessions(request.getRequiredSessionsPerMonth());

        classEntity.setDescription(request.getDescription());
        classEntity.setTutor(tutor);

        if (request.getStatus() != null) {
            classEntity.setStatus(request.getStatus());
        }

        ClassEntity savedClass = classRepository.save(classEntity);

        if (oldTutor == null || !oldTutor.getTutorId().equals(tutor.getTutorId())) {
            notifyTutorAddedToClass(savedClass, tutor);
        }

        List<Enrollment> oldEnrollments = enrollmentRepository.findByClassEntityClassId(classId);
        enrollmentRepository.deleteAll(oldEnrollments);

        if (request.getStudentIds() != null) {
            for (Integer studentId : request.getStudentIds()) {
                Student student = studentRepository.findById(studentId)
                        .orElseThrow(() -> new BadRequestException("Học sinh không tồn tại: " + studentId));

                Enrollment enrollment = new Enrollment();
                enrollment.setClassEntity(savedClass);
                enrollment.setStudent(student);
                enrollment.setStatus(true);

                enrollmentRepository.save(enrollment);

                notifyStudentAndParentAddedToClass(savedClass, student);
                notifyTutorStudentJoinedClass(savedClass, tutor, student);
            }
        }
    }

    @Override
    public void deleteClass(Integer classId) {
        ClassEntity classEntity = getClassById(classId);
        classRepository.delete(classEntity);
    }

    private void notifyTutorAddedToClass(ClassEntity classEntity, Tutor tutor) {
        if (tutor.getUser() == null) return;

        notificationService.createNotification(
                tutor.getUser().getUserId(),
                "Bạn được phân công lớp mới",
                "Bạn đã được phân công dạy lớp: " + classEntity.getClassName(),
                NotificationType.SYSTEM,
                classEntity.getClassId(),
                "classes"
        );
    }

    private void notifyTutorStudentJoinedClass(ClassEntity classEntity, Tutor tutor, Student student) {
        if (tutor.getUser() == null) return;

        notificationService.createNotification(
                tutor.getUser().getUserId(),
                "Có học sinh tham gia lớp",
                "Học sinh " + student.getFullName() + " đã được thêm vào lớp " + classEntity.getClassName(),
                NotificationType.SYSTEM,
                classEntity.getClassId(),
                "classes"
        );
    }

    private void notifyStudentAndParentAddedToClass(ClassEntity classEntity, Student student) {
        if (student.getUser() != null) {
            notificationService.createNotification(
                    student.getUser().getUserId(),
                    "Bạn được thêm vào lớp mới",
                    "Bạn đã được thêm vào lớp: " + classEntity.getClassName(),
                    NotificationType.SYSTEM,
                    classEntity.getClassId(),
                    "classes"
            );
        }

        if (student.getParent() != null && student.getParent().getUser() != null) {
            notificationService.createNotification(
                    student.getParent().getUser().getUserId(),
                    "Con được thêm vào lớp mới",
                    "Học sinh " + student.getFullName() + " đã được thêm vào lớp: " + classEntity.getClassName(),
                    NotificationType.SYSTEM,
                    classEntity.getClassId(),
                    "classes"
            );
        }
    }

    private void validateCreateClass(CreateClassRequest request) {
        if (request.getClassName() == null || request.getClassName().isBlank()) {
            throw new BadRequestException("Tên lớp không được để trống");
        }

        if (request.getSubject() == null || request.getSubject().isBlank()) {
            throw new BadRequestException("Môn học không được để trống");
        }

        if (request.getGrade() == null || request.getGrade().isBlank()) {
            throw new BadRequestException("Khối lớp không được để trống");
        }

        if (request.getTutorId() == null) {
            throw new BadRequestException("Vui lòng chọn gia sư");
        }

        if (request.getTuitionFeePerSession() == null
                || request.getTuitionFeePerSession().compareTo(BigDecimal.ZERO) <= 0) {
            throw new BadRequestException("Học phí phải lớn hơn 0");
        }

        if (request.getRequiredSessionsPerMonth() == null || request.getRequiredSessionsPerMonth() <= 0) {
            throw new BadRequestException("Số buổi yêu cầu trong 1 tháng phải lớn hơn 0");
        }

        if (request.getStudentIds() == null || request.getStudentIds().isEmpty()) {
            throw new BadRequestException("Vui lòng chọn ít nhất 1 học sinh");
        }
    }
}