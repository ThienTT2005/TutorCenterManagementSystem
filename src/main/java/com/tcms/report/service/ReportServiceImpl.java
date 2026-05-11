package com.tcms.report.service;

import com.tcms.clazz.entity.ClassEntity;
import com.tcms.clazz.repository.ClassRepository;
import com.tcms.payment.repository.PaymentRepository;
import com.tcms.parent.repository.ParentRepository;
import com.tcms.schedule.repository.TeachingScheduleRepository;
import com.tcms.student.repository.StudentRepository;
import com.tcms.tutor.repository.TutorRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class ReportServiceImpl implements ReportService {

    private final ClassRepository classRepository;
    private final StudentRepository studentRepository;
    private final TutorRepository tutorRepository;
    private final PaymentRepository paymentRepository;
    private final ParentRepository parentRepository;
    private final TeachingScheduleRepository teachingScheduleRepository;

    @Override
    public long countClasses() {
        return classRepository.count();
    }

    @Override
    public long countStudents() {
        return studentRepository.count();
    }

    @Override
    public long countTutors() {
        return tutorRepository.count();
    }

    @Override
    public long countParents() {
        return parentRepository.count();
    }

    @Override
    public BigDecimal calculateRevenue() {
        return paymentRepository.sumAllPayments();
    }

    @Override
    public List<ClassEntity> getTopClasses() {
        return classRepository.findTop5ByOrderByClassIdDesc();
    }

    @Override
    public Map<String, Long> getWeeklyClasses() {
        Map<String, Long> result = new LinkedHashMap<>();

        result.put("T2", teachingScheduleRepository.countByWeekday(2));
        result.put("T3", teachingScheduleRepository.countByWeekday(3));
        result.put("T4", teachingScheduleRepository.countByWeekday(4));
        result.put("T5", teachingScheduleRepository.countByWeekday(5));
        result.put("T6", teachingScheduleRepository.countByWeekday(6));
        result.put("T7", teachingScheduleRepository.countByWeekday(7));
        result.put("CN", teachingScheduleRepository.countByWeekday(8));

        return result;
    }

    @Override
    public List<String> getRevenueLabels() {
        return List.of(
                "T1","T2","T3","T4","T5","T6",
                "T7","T8","T9","T10","T11","T12"
        );
    }

    @Override
    public List<BigDecimal> getRevenueData() {

        List<BigDecimal> data = new ArrayList<>();

        for (int month = 1; month <= 12; month++) {

            BigDecimal revenue =
                    paymentRepository.sumRevenueByMonth(month);

            data.add(revenue != null ? revenue : BigDecimal.ZERO);
        }

        return data;
    }
}