package com.tcms.clazz.repository;

import com.tcms.clazz.entity.ClassEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ClassRepository extends JpaRepository<ClassEntity, Integer> {
    List<ClassEntity> findByTutorTutorIdAndStatusTrue(Integer tutorId);

    @Query("SELECT c FROM ClassEntity c WHERE " +
            "(:keyword IS NULL OR LOWER(c.className) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
            "OR LOWER(c.subject) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
            "OR (c.tutor IS NOT NULL AND LOWER(c.tutor.fullName) LIKE LOWER(CONCAT('%', :keyword, '%')))) AND " +
            "(:subject IS NULL OR :subject = '' OR c.subject = :subject) AND " +
            "(:grade IS NULL OR :grade = '' OR c.grade = :grade) AND " +
            "(:status IS NULL OR c.status = :status)")
    List<ClassEntity> searchClasses(
            @Param("keyword") String keyword,
            @Param("subject") String subject,
            @Param("grade") String grade,
            @Param("status") Boolean status);

    List<ClassEntity> findTop5ByOrderByClassIdDesc();
}
