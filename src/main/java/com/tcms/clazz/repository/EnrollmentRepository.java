package com.tcms.clazz.repository;

import com.tcms.clazz.entity.Enrollment;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface EnrollmentRepository extends JpaRepository<Enrollment, Integer> {
    boolean existsByClassEntityClassIdAndStudentStudentId(Integer classId, Integer studentId);

    List<Enrollment> findByClassEntityClassIdAndStatusTrue(Integer classId);

    List<Enrollment> findByClassEntityClassId(Integer classId);

    List<Enrollment> findByStudentStudentIdAndStatusTrue(Integer studentId);
}