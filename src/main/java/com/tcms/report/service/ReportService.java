package com.tcms.report.service;

import com.tcms.clazz.entity.ClassEntity;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

public interface ReportService {

    long countClasses();

    long countStudents();

    long countTutors();

    long countParents();

    BigDecimal calculateRevenue();

    List<ClassEntity> getTopClasses();

    Map<String, Long> getWeeklyClasses();
}