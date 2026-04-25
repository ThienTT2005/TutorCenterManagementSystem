package com.tcms.parent.repository;

import com.tcms.parent.entity.Parent;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ParentRepository extends JpaRepository<Parent, Integer> {
    boolean existsByPhone(String phone);
    boolean existsByEmail(String email);
}