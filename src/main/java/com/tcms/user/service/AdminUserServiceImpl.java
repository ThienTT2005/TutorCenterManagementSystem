package com.tcms.user.service;

import com.tcms.exception.BadRequestException;
import com.tcms.parent.dto.request.CreateParentProfileRequest;
import com.tcms.parent.entity.Parent;
import com.tcms.parent.repository.ParentRepository;
import com.tcms.student.dto.request.CreateStudentProfileRequest;
import com.tcms.student.entity.Student;
import com.tcms.student.repository.StudentRepository;
import com.tcms.tutor.dto.request.CreateTutorProfileRequest;
import com.tcms.tutor.entity.Tutor;
import com.tcms.tutor.repository.TutorRepository;
import com.tcms.user.dto.request.CreateAccountRequest;
import com.tcms.user.entity.Role;
import com.tcms.user.entity.User;
import com.tcms.user.repository.RoleRepository;
import com.tcms.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
@RequiredArgsConstructor
public class AdminUserServiceImpl implements AdminUserService {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final TutorRepository tutorRepository;
    private final ParentRepository parentRepository;
    private final StudentRepository studentRepository;
    private final PasswordEncoder passwordEncoder;

    @Override
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    @Override
    public User createAccount(CreateAccountRequest request) {
        if (request.getUsername() == null || request.getUsername().isBlank()) {
            throw new BadRequestException("Username không được để trống");
        }
        if (request.getPassword() == null || request.getPassword().isBlank()) {
            throw new BadRequestException("Password không được để trống");
        }
        if (request.getRole() == null || request.getRole().isBlank()) {
            throw new BadRequestException("Role không được để trống");
        }

        if (userRepository.findByUsername(request.getUsername()).isPresent()) {
            throw new BadRequestException("Username đã tồn tại");
        }

        Role role = roleRepository.findByRoleName(request.getRole())
                .orElseThrow(() -> new BadRequestException("Role không hợp lệ"));

        User user = new User();
        user.setUsername(request.getUsername());
        user.setPassword(passwordEncoder.encode(request.getPassword()));
        user.setRole(role);
        user.setStatus(true);

        return userRepository.save(user);
    }

    @Override
    public void createTutorProfile(CreateTutorProfileRequest request) {
        User user = userRepository.findById(request.getUserId())
                .orElseThrow(() -> new BadRequestException("User không tồn tại"));

        validatePhone(request.getPhone());

        if (request.getPhone() != null && !request.getPhone().isBlank() && tutorRepository.existsByPhone(request.getPhone())) {
            throw new BadRequestException("Số điện thoại gia sư đã tồn tại");
        }

        if(request.getEmail() != null && !request.getEmail().isBlank() && tutorRepository.existsByEmail(request.getEmail())){
            throw new BadRequestException("Email gia sư đã tồn tại");
        }

        Tutor tutor = new Tutor();
        tutor.setUser(user);
        tutor.setFullName(request.getFullName());
        tutor.setPhone(request.getPhone());
        tutor.setEmail(request.getEmail());
        tutor.setGender(request.getGender());
        tutor.setAddress(request.getAddress());
        tutor.setSchool(request.getSchool());
        tutor.setMajor(request.getMajor());
        tutor.setDescription(request.getDescription());

        if (request.getDob() != null && !request.getDob().isBlank()) {
            tutor.setDob(LocalDate.parse(request.getDob()));
        }

        tutorRepository.save(tutor);
    }

    @Override
    public void createParentProfile(CreateParentProfileRequest request) {
        User user = userRepository.findById(request.getUserId())
                .orElseThrow(() -> new BadRequestException("User không tồn tại"));

        validatePhone(request.getPhone());
        if (request.getPhone() != null && !request.getPhone().isBlank() && parentRepository.existsByPhone(request.getPhone())) {
            throw new BadRequestException("Số điện thoại phụ huynh đã tồn tại");
        }

        if(request.getEmail() != null && !request.getEmail().isBlank() && parentRepository.existsByEmail(request.getEmail())){
            throw new BadRequestException("Email phụ huynh đã tồn tại");
        }

        Parent parent = new Parent();
        parent.setUser(user);
        parent.setFullName(request.getFullName());
        parent.setPhone(request.getPhone());
        parent.setEmail(request.getEmail());
        parent.setGender(request.getGender());
        parent.setAddress(request.getAddress());

        if (request.getDob() != null && !request.getDob().isBlank()) {
            parent.setDob(LocalDate.parse(request.getDob()));
        }

        parentRepository.save(parent);
    }

    @Override
    public void createStudentProfile(CreateStudentProfileRequest request) {
        User user = userRepository.findById(request.getUserId())
                .orElseThrow(() -> new BadRequestException("User không tồn tại"));

        if (request.getParentId() == null) {
            throw new BadRequestException("Học sinh phải chọn phụ huynh");
        }

        Parent parent = parentRepository.findById(request.getParentId())
                .orElseThrow(() -> new BadRequestException("Phụ huynh không tồn tại"));

        Student student = new Student();
        student.setUser(user);
        student.setParent(parent);
        student.setFullName(request.getFullName());
        student.setGender(request.getGender());
        student.setAddress(request.getAddress());
        student.setSchool(request.getSchool());
        student.setGrade(request.getGrade());

        if (request.getDob() != null && !request.getDob().isBlank()) {
            student.setDob(LocalDate.parse(request.getDob()));
        }

        studentRepository.save(student);
    }

    @Override
    public List<Parent> getAllParents() {
        return parentRepository.findAll();
    }

    private void validatePhone(String phone) {
        if (phone != null && !phone.isBlank()) {
            if (!phone.matches("^0\\d{9}$")) {
                throw new BadRequestException("Số điện thoại phải gồm 10 số và bắt đầu bằng 0");
            }
        }
    }
}