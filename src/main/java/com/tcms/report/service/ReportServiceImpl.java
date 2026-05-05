package com.tcms.report.service;

import com.tcms.clazz.entity.ClassEntity;
import com.tcms.clazz.repository.ClassRepository;
import com.tcms.payment.repository.PaymentRepository;
import com.tcms.parent.repository.ParentRepository;
import com.tcms.student.repository.StudentRepository;
import com.tcms.tutor.repository.TutorRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ReportServiceImpl implements ReportService {

    private final ClassRepository classRepository;
    private final StudentRepository studentRepository;
    private final TutorRepository tutorRepository;
    private final PaymentRepository paymentRepository;
    private final ParentRepository parentRepository;

    @Override
    public Long countClasses() {
        return classRepository.count();
    }

    @Override
    public Long countStudents() {
        return studentRepository.count();
    }

    @Override
    public Long countTutors() {
        return tutorRepository.count();
    }

    @Override
    public Long countParents() {
        return parentRepository.count();
    }

    @Override
    public BigDecimal calculateRevenue() {
        return paymentRepository.sumAllPayments();
    }

    @Override
    public List<Object[]> getMonthlyRevenue() {
        return paymentRepository.getMonthlyRevenue();
    }

    @Override
    public List<ClassEntity> getTopClasses() {
        return classRepository.findTop5ByOrderByClassIdDesc();
    }
}