package com.tcms.payment.entity;

public enum PaymentStatus {
    PENDING,
    PROOF_UPLOADED,
    TUTOR_CONFIRMED,
    ADMIN_APPROVED,
    COMPLETED,
    REJECTED
}
/*
Chờ thanh toán
Đã gửi minh chứng
gia sư xác nhận
admin đã duyệt
hoàn thành
từ chối
Luồng hoạt động:
gia sư gửi yêu cầu thanh toán (pending) --> admin xác nhận duyệt ( admin-approved) --> gửi thông báo truyền đến parent
parent gửi minh chứng (proof-uploaded) --> thông báo đến gia sư --> xem minh chứng
gia sư bấm xác nhận đã nhận tiền ( tutor-confirmed)
- nếu admin
 */