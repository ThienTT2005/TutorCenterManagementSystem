package com.tcms.payment.repository;

import com.tcms.payment.entity.Payment;
import com.tcms.payment.entity.PaymentStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PaymentRepository extends JpaRepository<Payment, Integer> {

    List<Payment> findByTutorTutorIdOrderByRequestDateDesc(Integer tutorId);

    List<Payment> findByStudentStudentIdOrderByRequestDateDesc(Integer studentId);

    List<Payment> findByStudentParentParentIdOrderByRequestDateDesc(Integer parentId);

    List<Payment> findByStatusOrderByRequestDateDesc(PaymentStatus status);

    List<Payment> findAllByOrderByRequestDateDesc();
}