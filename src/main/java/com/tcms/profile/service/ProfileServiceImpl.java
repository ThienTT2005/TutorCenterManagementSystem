package com.tcms.profile.service;

import com.tcms.exception.BadRequestException;
import com.tcms.parent.entity.Parent;
import com.tcms.parent.repository.ParentRepository;
import com.tcms.profile.dto.ProfileUpdateRequest;
import com.tcms.student.entity.Student;
import com.tcms.student.repository.StudentRepository;
import com.tcms.tutor.entity.Tutor;
import com.tcms.tutor.repository.TutorRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ProfileServiceImpl implements ProfileService {

    private final TutorRepository tutorRepository;
    private final ParentRepository parentRepository;
    private final StudentRepository studentRepository;

    private static final String UPLOAD_DIR =
            System.getProperty("user.dir") + "/src/main/resources/static/uploads/";

    @Override
    public Object getProfile(Integer userId) {
        Tutor tutor = tutorRepository.findByUserUserId(userId).orElse(null);
        if (tutor != null) return tutor;

        Parent parent = parentRepository.findByUserUserId(userId).orElse(null);
        if (parent != null) return parent;

        Student student = studentRepository.findByUserUserId(userId).orElse(null);
        if (student != null) return student;

        throw new BadRequestException("Không tìm thấy hồ sơ người dùng");
    }

    @Override
    public void updateProfile(Integer userId, ProfileUpdateRequest request) {
        Tutor tutor = tutorRepository.findByUserUserId(userId).orElse(null);
        if (tutor != null) {
            updateTutor(tutor, request);
            tutorRepository.save(tutor);
            return;
        }

        Parent parent = parentRepository.findByUserUserId(userId).orElse(null);
        if (parent != null) {
            updateParent(parent, request);
            parentRepository.save(parent);
            return;
        }

        Student student = studentRepository.findByUserUserId(userId).orElse(null);
        if (student != null) {
            updateStudent(student, request);
            studentRepository.save(student);
            return;
        }

        throw new BadRequestException("Không tìm thấy hồ sơ người dùng");
    }

    @Override
    public String uploadAvatar(Integer userId, MultipartFile file) {
        if (file == null || file.isEmpty()) {
            throw new BadRequestException("Vui lòng chọn ảnh");
        }

        String originalName = file.getOriginalFilename();
        if (originalName == null || originalName.isBlank()) {
            throw new BadRequestException("Tên file không hợp lệ");
        }

        String lowerName = originalName.toLowerCase();
        if (!lowerName.endsWith(".jpg")
                && !lowerName.endsWith(".jpeg")
                && !lowerName.endsWith(".png")
                && !lowerName.endsWith(".webp")) {
            throw new BadRequestException("Chỉ cho phép upload ảnh jpg, jpeg, png, webp");
        }

        try {
            File dir = new File(UPLOAD_DIR);
            if (!dir.exists()) dir.mkdirs();

            String fileName = UUID.randomUUID() + "_" + originalName.replaceAll("\\s+", "_");
            File dest = new File(UPLOAD_DIR + fileName);
            file.transferTo(dest);

            String avatarUrl = "/uploads/" + fileName;

            Tutor tutor = tutorRepository.findByUserUserId(userId).orElse(null);
            if (tutor != null) {
                tutor.setAvatar(avatarUrl);
                tutorRepository.save(tutor);
                return avatarUrl;
            }

            Parent parent = parentRepository.findByUserUserId(userId).orElse(null);
            if (parent != null) {
                parent.setAvatar(avatarUrl);
                parentRepository.save(parent);
                return avatarUrl;
            }

            Student student = studentRepository.findByUserUserId(userId).orElse(null);
            if (student != null) {
                student.setAvatar(avatarUrl);
                studentRepository.save(student);
                return avatarUrl;
            }

            throw new BadRequestException("Không tìm thấy hồ sơ để lưu avatar");

        } catch (BadRequestException e) {
            throw e;
        } catch (Exception e) {
            throw new RuntimeException("Upload avatar thất bại");
        }
    }

    private void updateTutor(Tutor tutor, ProfileUpdateRequest request) {
        tutor.setFullName(request.getFullName());
        tutor.setPhone(request.getPhone());
        tutor.setEmail(request.getEmail());
        tutor.setDob(request.getDob());
        tutor.setGender(request.getGender());
        tutor.setAddress(request.getAddress());
        tutor.setSchool(request.getSchool());
        tutor.setMajor(request.getMajor());
        tutor.setDescription(request.getDescription());
    }

    private void updateParent(Parent parent, ProfileUpdateRequest request) {
        parent.setFullName(request.getFullName());
        parent.setPhone(request.getPhone());
        parent.setEmail(request.getEmail());
        parent.setDob(request.getDob());
        parent.setGender(request.getGender());
        parent.setAddress(request.getAddress());
    }

    private void updateStudent(Student student, ProfileUpdateRequest request) {
        student.setFullName(request.getFullName());
        student.setDob(request.getDob());
        student.setGender(request.getGender());
        student.setAddress(request.getAddress());
        student.setSchool(request.getSchool());
        student.setGrade(request.getGrade());
    }
}