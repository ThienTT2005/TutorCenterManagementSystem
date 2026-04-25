package com.tcms.tutor.repository;

import com.tcms.tutor.entity.Tutor;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface TutorRepository extends JpaRepository<Tutor, Integer> {
    boolean existsByPhone(String phone);
    boolean existsByEmail(String email);
    Optional<Tutor> findByUserUserId(Integer userId);
}