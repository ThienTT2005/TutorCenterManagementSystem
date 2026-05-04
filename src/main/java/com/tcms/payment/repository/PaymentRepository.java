package com.tcms.payment.repository;

import com.tcms.payment.entity.Payment;
import com.tcms.payment.entity.PaymentStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.math.BigDecimal;
import java.util.List;

public interface PaymentRepository extends JpaRepository<Payment, Integer> {

    List<Payment> findByTutorTutorIdOrderByRequestDateDesc(Integer tutorId);

    List<Payment> findByStudentStudentIdOrderByRequestDateDesc(Integer studentId);

    List<Payment> findByStudentParentParentIdOrderByRequestDateDesc(Integer parentId);

    List<Payment> findByStatusOrderByRequestDateDesc(PaymentStatus status);

    List<Payment> findAllByOrderByRequestDateDesc();

    @Query("SELECT COALESCE(SUM(p.amount), 0) FROM Payment p WHERE p.status = 'COMPLETED'")
    BigDecimal sumAllPayments();
}