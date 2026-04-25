package com.tcms.clazz.repository;

import com.tcms.clazz.entity.ClassEntity;
import org.springframework.data.jpa.repository.JpaRepository;
public interface ClassRepository extends JpaRepository<ClassEntity, Integer> {
}
