package com.tcms.report.service;

import com.tcms.clazz.entity.ClassEntity;

import java.math.BigDecimal;
import java.util.List;

public interface ReportService {

    Long countClasses();

    Long countStudents();

    Long countTutors();
    
    Long countParents();

    BigDecimal calculateRevenue();
    
    List<Object[]> getMonthlyRevenue();

    List<ClassEntity> getTopClasses();
}