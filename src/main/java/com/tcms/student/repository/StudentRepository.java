package com.tcms.student.repository;

import com.tcms.student.entity.Student;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface StudentRepository extends JpaRepository<Student, Integer> {
    Optional<Student> findByUserUserId(Integer userId);
    List<Student> findByParentParentId(Integer parentId);
}