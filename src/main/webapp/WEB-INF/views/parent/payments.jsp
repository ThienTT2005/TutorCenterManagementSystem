<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="activePage" value="payments" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thanh toán của phụ huynh</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0" />

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student-dashboard.css">

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            background: #f4f8ff;
            color: #0f172a;
            font-family: Arial, Helvetica, sans-serif;
        }

        .main-content {
            min-height: 100vh;
            background: #f4f8ff;
        }

        .payment-page {
            padding: 28px 32px 40px;
        }

        .page-header {
            margin-bottom: 26px;
        }

        .page-header h1 {
            margin: 0;
            font-size: 28px;
            font-weight: 800;
            color: #111827;
        }

        .page-header p {
            margin: 8px 0 0;
            color: #64748b;
            font-size: 14px;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, minmax(0, 1fr));
            gap: 22px;
            margin-bottom: 28px;
        }

        .stat-card {
            background: #ffffff;
            border-radius: 16px;
            border: 1px solid #e8eef7;
            min-height: 132px;
            padding: 24px;
            box-shadow: 0 12px 28px rgba(15, 23, 42, 0.05);
        }

        .stat-top {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .stat-icon {
            width: 42px;
            height: 42px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 21px;
        }

        .stat-icon.total {
            background: #eaf2ff;
            color: #2563eb;
        }

        .stat-icon.pending {
            background: #fff0e6;
            color: #f97316;
        }

        .stat-icon.processing {
            background: #eef2ff;
            color: #4f46e5;
        }

        .stat-icon.completed {
            background: #e7f9ef;
            color: #16a34a;
        }

        .stat-chip {
            padding: 5px 10px;
            border-radius: 999px;
            font-size: 11px;
            font-weight: 800;
        }

        .chip-green {
            background: #dcfce7;
            color: #16a34a;
        }

        .chip-orange {
            background: #fff7ed;
            color: #ea580c;
        }

        .chip-blue {
            background: #e0e7ff;
            color: #4f46e5;
        }

        .stat-label {
            margin: 0 0 5px;
            font-size: 13px;
            color: #64748b;
            font-weight: 500;
        }

        .stat-value {
            margin: 0;
            font-size: 30px;
            line-height: 1;
            font-weight: 900;
            color: #0f172a;
            letter-spacing: 1px;
        }

        .table-card {
            background: #ffffff;
            border-radius: 16px;
            border: 1px solid #e8eef7;
            box-shadow: 0 14px 34px rgba(15, 23, 42, 0.08);
            overflow: hidden;
            margin-bottom: 30px;
        }

        .table-header {
            padding: 22px 26px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .table-header h2 {
            margin: 0;
            font-size: 17px;
            font-weight: 800;
            color: #111827;
            display: flex;
            align-items: center;
            gap: 9px;
        }

        .table-header h2 i {
            color: #2563eb;
        }

        .table-tools {
            display: flex;
            align-items: center;
            gap: 14px;
            color: #64748b;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: #f8fafc;
        }

        th {
            padding: 15px 26px;
            text-align: left;
            font-size: 11px;
            font-weight: 900;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 0.6px;
            border-bottom: 1px solid #edf2f7;
        }

        td {
            padding: 22px 26px;
            border-bottom: 1px solid #f1f5f9;
            vertical-align: middle;
            font-size: 14px;
            color: #334155;
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        .student-cell {
            display: flex;
            align-items: center;
            gap: 12px;
            min-width: 190px;
        }

        .student-avatar {
            width: 38px;
            height: 38px;
            border-radius: 50%;
            background: #e5eefb;
            border: 1px solid #dbe3ef;
            color: #2563eb;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            font-weight: 800;
            flex-shrink: 0;
        }

        .student-name {
            margin: 0;
            font-size: 14px;
            font-weight: 800;
            color: #111827;
        }

        .student-sub {
            margin: 4px 0 0;
            color: #94a3b8;
            font-size: 12px;
            font-weight: 500;
        }

        .tutor-cell {
            display: flex;
            align-items: center;
            gap: 8px;
            color: #334155;
            font-weight: 700;
            min-width: 110px;
        }

        .tutor-dot {
            width: 7px;
            height: 7px;
            border-radius: 50%;
            background: #3b82f6;
            flex-shrink: 0;
        }

        .class-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 54px;
            padding: 6px 12px;
            border-radius: 999px;
            background: #eff6ff;
            color: #1e40af;
            font-size: 12px;
            font-weight: 800;
        }

        .session-count {
            color: #111827;
            font-weight: 800;
            text-align: center;
        }

        .amount {
            color: #0066d9;
            font-size: 15px;
            font-weight: 900;
            white-space: nowrap;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 7px 12px;
            border-radius: 999px;
            font-size: 11px;
            font-weight: 900;
            text-transform: uppercase;
            white-space: nowrap;
        }

        .status-PENDING {
            background: #fff7ed;
            color: #c2410c;
            border: 1px solid #fed7aa;
        }

        .status-PROOF_UPLOADED {
            background: #eff6ff;
            color: #1d4ed8;
            border: 1px solid #bfdbfe;
        }

        .status-TUTOR_CONFIRMED {
            background: #f3e8ff;
            color: #7e22ce;
            border: 1px solid #e9d5ff;
        }

        .status-COMPLETED,
        .status-ADMIN_APPROVED {
            background: #dcfce7;
            color: #15803d;
            border: 1px solid #86efac;
        }

        .status-REJECTED {
            background: #fee2e2;
            color: #b91c1c;
            border: 1px solid #fecaca;
        }

        .proof-form {
            display: flex;
            align-items: center;
            gap: 8px;
            min-width: 220px;
        }

        .proof-input {
            width: 150px;
            height: 34px;
            border: 1px solid #dbe3ef;
            border-radius: 9px;
            background: #f8fafc;
            padding: 0 10px;
            outline: none;
            font-size: 12px;
            color: #334155;
        }

        .proof-input:focus {
            border-color: #2563eb;
            background: #ffffff;
        }

        .send-btn {
            height: 34px;
            padding: 0 16px;
            border: none;
            border-radius: 9px;
            background: #2563eb;
            color: #ffffff;
            font-size: 12px;
            font-weight: 800;
            cursor: pointer;
        }

        .send-btn:hover {
            background: #1d4ed8;
        }

        .detail-link {
            color: #334155;
            text-decoration: none;
            font-size: 12px;
            font-weight: 800;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            white-space: nowrap;
        }

        .proof-link {
            color: #2563eb;
            text-decoration: none;
            font-size: 12px;
            font-weight: 800;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .rejection-text {
            margin-top: 8px;
            color: #b91c1c;
            font-size: 12px;
            line-height: 1.5;
        }

        .table-footer {
            padding: 16px 26px;
            border-top: 1px solid #edf2f7;
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: #64748b;
            font-size: 12px;
        }

        .pagination {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .page-btn {
            width: 30px;
            height: 30px;
            border-radius: 9px;
            border: 1px solid #dbe3ef;
            background: #ffffff;
            color: #64748b;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            text-decoration: none;
            font-weight: 700;
        }

        .page-btn.active {
            background: #0b63ce;
            color: #ffffff;
            border-color: #0b63ce;
        }

        .bottom-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 28px;
        }

        .info-card {
            background: #ffffff;
            border: 1px solid #e8eef7;
            border-radius: 16px;
            padding: 26px;
            min-height: 190px;
        }

        .info-card h3 {
            margin: 0 0 20px;
            color: #111827;
            font-size: 17px;
            font-weight: 800;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .info-card h3 i,
        .info-card h3 .material-symbols-rounded {
            color: #2563eb;
        }

        .guide-list {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .guide-item {
            display: flex;
            align-items: flex-start;
            gap: 10px;
            color: #475569;
            font-size: 13px;
            line-height: 1.5;
        }

        .guide-number {
            width: 22px;
            height: 22px;
            border-radius: 50%;
            background: #dbeafe;
            color: #2563eb;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 11px;
            font-weight: 900;
            flex-shrink: 0;
        }

        .bank-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
        }

        .bank-item {
            background: #f8fafc;
            border: 1px solid #edf2f7;
            border-radius: 12px;
            padding: 16px;
        }

        .bank-label {
            margin: 0 0 8px;
            color: #94a3b8;
            font-size: 10px;
            font-weight: 900;
            text-transform: uppercase;
        }

        .bank-value {
            margin: 0;
            color: #0f172a;
            font-size: 14px;
            font-weight: 900;
        }

        .empty-box {
            padding: 44px;
            text-align: center;
            color: #64748b;
            font-size: 14px;
        }

        @media (max-width: 1200px) {
            .stats-grid {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }

            .table-card {
                overflow-x: auto;
            }

            table {
                min-width: 1050px;
            }

            .bottom-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            .payment-page {
                padding: 20px;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }

            .table-footer {
                flex-direction: column;
                align-items: flex-start;
                gap: 12px;
            }
        }
    </style>
</head>

<body>

<jsp:include page="common/sidebar.jsp" />

<c:set var="totalCount" value="0" />
<c:set var="pendingCount" value="0" />
<c:set var="processingCount" value="0" />
<c:set var="completedCount" value="0" />

<c:forEach var="payment" items="${payments}">
    <c:set var="totalCount" value="${totalCount + 1}" />

    <c:if test="${payment.status == 'PENDING'}">
        <c:set var="pendingCount" value="${pendingCount + 1}" />
    </c:if>

    <c:if test="${payment.status == 'PROOF_UPLOADED' or payment.status == 'TUTOR_CONFIRMED'}">
        <c:set var="processingCount" value="${processingCount + 1}" />
    </c:if>

    <c:if test="${payment.status == 'COMPLETED' or payment.status == 'ADMIN_APPROVED'}">
        <c:set var="completedCount" value="${completedCount + 1}" />
    </c:if>
</c:forEach>

<main class="main-content">
    <jsp:include page="common/header.jsp" />

    <div class="payment-page">

        <div class="page-header">
            <h1>Thanh toán của phụ huynh</h1>
            <p>Xem yêu cầu thanh toán, upload minh chứng và theo dõi lịch sử.</p>
        </div>

        <section class="stats-grid">
            <div class="stat-card">
                <div class="stat-top">
                    <div class="stat-icon total">
                        <span class="material-symbols-rounded">receipt_long</span>
                    </div>
                    <span class="stat-chip chip-green">+12%</span>
                </div>
                <p class="stat-label">Tổng yêu cầu</p>
                <p class="stat-value">
                    <c:choose>
                        <c:when test="${totalCount lt 10}">0${totalCount}</c:when>
                        <c:otherwise>${totalCount}</c:otherwise>
                    </c:choose>
                </p>
            </div>

            <div class="stat-card">
                <div class="stat-top">
                    <div class="stat-icon pending">
                        <span class="material-symbols-rounded">pending_actions</span>
                    </div>
                    <span class="stat-chip chip-orange">Cần xử lý</span>
                </div>
                <p class="stat-label">Chờ thanh toán</p>
                <p class="stat-value">
                    <c:choose>
                        <c:when test="${pendingCount lt 10}">0${pendingCount}</c:when>
                        <c:otherwise>${pendingCount}</c:otherwise>
                    </c:choose>
                </p>
            </div>

            <div class="stat-card">
                <div class="stat-top">
                    <div class="stat-icon processing">
                        <span class="material-symbols-rounded">sync</span>
                    </div>
                    <span class="stat-chip chip-blue">Gần đây</span>
                </div>
                <p class="stat-label">Đang xử lý</p>
                <p class="stat-value">
                    <c:choose>
                        <c:when test="${processingCount lt 10}">0${processingCount}</c:when>
                        <c:otherwise>${processingCount}</c:otherwise>
                    </c:choose>
                </p>
            </div>

            <div class="stat-card">
                <div class="stat-top">
                    <div class="stat-icon completed">
                        <span class="material-symbols-rounded">check_circle</span>
                    </div>
                    <span class="stat-chip chip-green">Hoàn thành</span>
                </div>
                <p class="stat-label">Đã hoàn tất</p>
                <p class="stat-value">
                    <c:choose>
                        <c:when test="${completedCount lt 10}">0${completedCount}</c:when>
                        <c:otherwise>${completedCount}</c:otherwise>
                    </c:choose>
                </p>
            </div>
        </section>

        <section class="table-card">
            <div class="table-header">
                <h2>
                    <i class="fa-solid fa-list"></i>
                    Danh sách yêu cầu thanh toán
                </h2>

                <div class="table-tools">
                    <i class="fa-solid fa-filter"></i>
                    <i class="fa-solid fa-ellipsis-vertical"></i>
                </div>
            </div>

            <c:choose>
                <c:when test="${empty payments}">
                    <div class="empty-box">
                        Chưa có yêu cầu thanh toán nào.
                    </div>
                </c:when>

                <c:otherwise>
                    <table>
                        <thead>
                        <tr>
                            <th>Học sinh</th>
                            <th>Gia sư</th>
                            <th>Lớp</th>
                            <th>Số buổi</th>
                            <th>Số tiền</th>
                            <th>Trạng thái</th>
                            <th style="text-align: right;">Hành động</th>
                        </tr>
                        </thead>

                        <tbody>
                        <c:forEach var="payment" items="${payments}" varStatus="loop">
                            <tr>
                                <td>
                                    <div class="student-cell">
                                        <div class="student-avatar">
                                            <c:choose>
                                                <c:when test="${not empty payment.student.fullName}">
                                                    <c:out value="${fn:substring(payment.student.fullName, 0, 1)}"/>
                                                </c:when>
                                                <c:otherwise>HS</c:otherwise>
                                            </c:choose>
                                        </div>

                                        <div>
                                            <p class="student-name">
                                                <c:out value="${payment.student.fullName}"/>
                                            </p>
                                            <p class="student-sub">
                                                ID: HS-${payment.student.studentId}
                                            </p>
                                        </div>
                                    </div>
                                </td>

                                <td>
                                    <div class="tutor-cell">
                                        <span class="tutor-dot"></span>
                                        <span>
                                            <c:out value="${payment.tutor.fullName}"/>
                                        </span>
                                    </div>
                                </td>

                                <td>
                                    <span class="class-badge">
                                        <c:out value="${payment.classEntity.className}"/>
                                    </span>
                                </td>

                                <td class="session-count">
                                    <c:out value="${payment.totalSessions}"/>
                                </td>

                                <td>
                                    <span class="amount">
                                        <c:out value="${payment.amount}"/>đ
                                    </span>
                                </td>

                                <td>
                                    <span class="status-badge status-${payment.status}">
                                        <span>●</span>
                                        <c:out value="${payment.status}"/>
                                    </span>

                                    <c:if test="${payment.status == 'REJECTED' and not empty payment.rejectionReason}">
                                        <div class="rejection-text">
                                            Lý do: <c:out value="${payment.rejectionReason}"/>
                                        </div>
                                    </c:if>
                                </td>

                                <td style="text-align: right;">
                                    <c:choose>
                                        <c:when test="${payment.status == 'PENDING'}">
                                            <form action="${pageContext.request.contextPath}/payment/upload-proof"
                                                  method="post"
                                                  class="proof-form">
                                                <input type="hidden"
                                                       name="paymentId"
                                                       value="${payment.paymentId}">

                                                <input type="text"
                                                       name="proofUrl"
                                                       class="proof-input"
                                                       placeholder="Tải ảnh lên"
                                                       required>

                                                <button type="submit" class="send-btn">
                                                    Gửi
                                                </button>
                                            </form>
                                        </c:when>

                                        <c:when test="${not empty payment.proofUrl}">
                                            <a href="${payment.proofUrl}"
                                               target="_blank"
                                               class="proof-link">
                                                Xem minh chứng
                                                <i class="fa-solid fa-chevron-right"></i>
                                            </a>
                                        </c:when>

                                        <c:otherwise>
                                            <span class="detail-link">
                                                Xem chi tiết
                                                <i class="fa-solid fa-chevron-right"></i>
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>

                    <div class="table-footer">
                        <span>
                            Hiển thị 1 - ${totalCount} trong số ${totalCount} kết quả
                        </span>

                        <div class="pagination">
                            <a href="#" class="page-btn">
                                <i class="fa-solid fa-chevron-left"></i>
                            </a>
                            <a href="#" class="page-btn active">1</a>
                            <a href="#" class="page-btn">2</a>
                            <a href="#" class="page-btn">
                                <i class="fa-solid fa-chevron-right"></i>
                            </a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </section>

        <section class="bottom-grid">
            <div class="info-card">
                <h3>
                    <i class="fa-regular fa-circle-info"></i>
                    Hướng dẫn thanh toán
                </h3>

                <div class="guide-list">
                    <div class="guide-item">
                        <span class="guide-number">1</span>
                        <span>Kiểm tra thông tin yêu cầu thanh toán trong danh sách bên trên bao gồm học sinh, lớp và số tiền.</span>
                    </div>

                    <div class="guide-item">
                        <span class="guide-number">2</span>
                        <span>Chuyển khoản theo thông tin tài khoản được cung cấp .</span>
                    </div>

                    <div class="guide-item">
                        <span class="guide-number">3</span>
                        <span>Chụp ảnh màn hình giao dịch thành công và tải ảnh lên.</span>
                    </div>
                </div>
            </div>


        </section>

    </div>
</main>

</body>
</html>