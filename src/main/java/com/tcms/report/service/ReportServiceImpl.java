package com.tcms.report.service;

import com.tcms.clazz.entity.ClassEntity;
import com.tcms.clazz.repository.ClassRepository;
import com.tcms.payment.repository.PaymentRepository;
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
    public BigDecimal calculateRevenue() {
        return paymentRepository.sumAllPayments();
    }

    @Override
    public List<ClassEntity> getTopClasses() {
        return classRepository.findTop5ByOrderByClassIdDesc();
    }
}