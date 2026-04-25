package com.tcms.clazz.service;

import com.tcms.clazz.dto.request.CreateClassRequest;
import com.tcms.clazz.entity.ClassEntity;
import com.tcms.clazz.entity.Enrollment;
import com.tcms.student.entity.Student;
import com.tcms.tutor.entity.Tutor;

import java.util.List;

public interface ClassService {

    List<ClassEntity> getAllClasses();

    ClassEntity getClassById(Integer classId);

    List<Tutor> getAllTutors();

    List<Student> getAllStudents();

    List<Enrollment> getEnrollmentsByClassId(Integer classId);

    void createClass(CreateClassRequest request);
}