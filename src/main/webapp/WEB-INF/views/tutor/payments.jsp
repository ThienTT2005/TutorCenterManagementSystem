<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="activePage" value="payments" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thanh toán của gia sư | TCMS Tutor</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0"/>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/tutor-dashboard.css">

    <style>
        :root {
            --primary: #0057bf;
            --primary-hover: #004da8;
            --primary-light: #eff6ff;
            --danger: #dc2626;
            --danger-light: #fee2e2;
            --warning: #d97706;
            --warning-light: #fef3c7;
            --success: #16a34a;
            --success-light: #dcfce7;
            --purple: #7c3aed;
            --purple-light: #f3e8ff;
            --bg-page: #f4f8ff;
            --bg-white: #ffffff;
            --text-dark: #0f172a;
            --text-muted: #64748b;
            --border-color: #e2e8f0;
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            background: var(--bg-page);
            color: var(--text-dark);
            font-family: Arial, Helvetica, sans-serif;
        }

        .payment-page {
            min-height: 100vh;
            padding: 28px 32px 42px;
            background: var(--bg-page);
        }

        .page-header {
            margin-bottom: 28px;
        }

        .page-title {
            margin: 0 0 18px;
            font-size: 26px;
            line-height: 1.2;
            font-weight: 900;
            color: #183b73;
        }

        .page-subtitle {
            max-width: 800px;
            margin: 0;
            color: #5b77a0;
            font-size: 15px;
            line-height: 1.7;
            font-weight: 500;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, minmax(0, 1fr));
            gap: 22px;
            margin-bottom: 30px;
        }

        .stat-card {
            min-height: 138px;
            background: var(--bg-white);
            border: 1px solid #e8eef7;
            border-radius: 18px;
            padding: 24px;
            box-shadow: 0 10px 28px rgba(15, 23, 42, 0.04);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .stat-card.active {
            background: #e8f3ff;
            border-color: #93c5fd;
        }

        .stat-top {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
        }

        .stat-icon {
            width: 42px;
            height: 42px;
            border-radius: 13px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .stat-icon .material-symbols-rounded {
            font-size: 22px;
        }

        .icon-blue {
            background: #eaf2ff;
            color: #2563eb;
        }

        .icon-orange {
            background: #fff2e7;
            color: #f97316;
        }

        .icon-cloud {
            background: #0b82ff;
            color: #ffffff;
        }

        .icon-red {
            background: #fee2e2;
            color: #ef4444;
        }

        .stat-chip {
            padding: 5px 9px;
            border-radius: 999px;
            font-size: 11px;
            font-weight: 900;
            text-transform: uppercase;
        }

        .chip-muted {
            color: #94a3b8;
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
            background: #dbeafe;
            color: #1d4ed8;
        }

        .chip-red {
            background: #fee2e2;
            color: #dc2626;
        }

        .stat-label {
            margin: 0 0 6px;
            color: #64748b;
            font-size: 13px;
            font-weight: 700;
        }

        .stat-value-row {
            display: flex;
            align-items: baseline;
            gap: 8px;
        }

        .stat-value {
            margin: 0;
            color: #0b2f60;
            font-size: 30px;
            line-height: 1;
            font-weight: 950;
        }

        .stat-note {
            color: #16a34a;
            font-size: 12px;
            font-weight: 900;
        }

        .section-title-row {
            margin-bottom: 16px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 16px;
        }

        .section-title {
            margin: 0;
            display: flex;
            align-items: center;
            gap: 9px;
            color: #173b73;
            font-size: 19px;
            font-weight: 900;
        }

        .section-title i {
            color: #0b63ce;
        }

        .filter-row {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .filter-select,
        .filter-button {
            height: 38px;
            border-radius: 10px;
            border: 1px solid #dbe3ef;
            background: #ffffff;
            color: #334155;
            font-size: 13px;
            font-weight: 700;
            padding: 0 13px;
            outline: none;
        }

        .filter-button {
            background: #0b63ce;
            color: #ffffff;
            border-color: #0b63ce;
            cursor: pointer;
        }

        .table-card {
            background: #ffffff;
            border: 1px solid #e8eef7;
            border-radius: 18px;
            box-shadow: 0 14px 32px rgba(15, 23, 42, 0.06);
            overflow: hidden;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: #ffffff;
        }

        th {
            padding: 18px 22px;
            color: #94a3b8;
            font-size: 11px;
            font-weight: 900;
            text-transform: uppercase;
            letter-spacing: 0.7px;
            text-align: left;
            border-bottom: 1px solid #edf2f7;
        }

        td {
            padding: 22px;
            border-bottom: 1px solid #f1f5f9;
            color: #334155;
            font-size: 14px;
            vertical-align: middle;
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        tbody tr:hover {
            background: #fbfdff;
        }

        .payment-code {
            color: #64748b;
            font-size: 13px;
            font-weight: 800;
            white-space: nowrap;
        }

        .student-cell {
            display: flex;
            align-items: center;
            gap: 13px;
            min-width: 210px;
        }

        .avatar {
            width: 38px;
            height: 38px;
            border-radius: 12px;
            background: #dbeafe;
            color: #2563eb;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            font-weight: 900;
            flex-shrink: 0;
        }

        .avatar.orange {
            background: #ffedd5;
            color: #f97316;
        }

        .avatar.green {
            background: #dcfce7;
            color: #16a34a;
        }

        .avatar.red {
            background: #fee2e2;
            color: #ef4444;
        }

        .student-name {
            margin: 0 0 4px;
            color: #153c70;
            font-size: 14px;
            line-height: 1.35;
            font-weight: 900;
        }

        .class-sub {
            margin: 0;
            color: #64748b;
            font-size: 12px;
            line-height: 1.4;
            font-weight: 600;
        }

        .sessions-count {
            color: #153c70;
            font-weight: 900;
            white-space: nowrap;
        }

        .amount {
            color: #0b2f60;
            font-size: 15px;
            font-weight: 950;
            white-space: nowrap;
        }

        .request-date {
            color: #5b77a0;
            font-size: 13px;
            font-weight: 700;
            white-space: nowrap;
        }

        .status-badge {
            min-width: 86px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 5px;
            padding: 8px 12px;
            border-radius: 999px;
            font-size: 11px;
            line-height: 1.1;
            font-weight: 950;
            text-transform: uppercase;
            text-align: center;
        }

        .status-PENDING {
            background: #fff7ed;
            color: #c2410c;
            border: 1px solid #fed7aa;
        }

        .status-PROOF_UPLOADED {
            background: #dbeafe;
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

        .action-cell {
            min-width: 130px;
        }

        .action-stack {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            gap: 8px;
        }

        .confirm-form {
            margin: 0;
        }

        .btn-confirm {
            min-height: 32px;
            padding: 0 14px;
            border: none;
            border-radius: 9px;
            background: #0b63ce;
            color: #ffffff;
            font-size: 12px;
            font-weight: 900;
            cursor: pointer;
        }

        .btn-confirm:hover {
            background: #004da8;
        }

        .proof-link {
            min-height: 32px;
            padding: 0 12px;
            border-radius: 9px;
            border: 1px solid #dbeafe;
            color: #0b63ce;
            background: #ffffff;
            text-decoration: none;
            font-size: 12px;
            font-weight: 900;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .history-link {
            min-height: 30px;
            padding: 0 12px;
            border-radius: 999px;
            border: 1px solid #bfdbfe;
            color: #0b63ce;
            background: #ffffff;
            text-decoration: none;
            font-size: 12px;
            font-weight: 850;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .waiting-text {
            color: #94a3b8;
            font-size: 13px;
            line-height: 1.45;
            font-weight: 700;
        }

        .reject-reason {
            color: #dc2626;
            font-size: 12px;
            font-weight: 700;
            line-height: 1.4;
        }

        .empty-box {
            padding: 48px 24px;
            text-align: center;
            color: #64748b;
            font-size: 14px;
            font-weight: 700;
        }

        .table-footer {
            padding: 18px 22px;
            border-top: 1px solid #edf2f7;
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: #64748b;
            font-size: 12px;
            font-weight: 600;
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
            display: inline-flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            font-size: 12px;
            font-weight: 800;
        }

        .page-btn.active {
            background: #0b63ce;
            border-color: #0b63ce;
            color: #ffffff;
        }

        @media (max-width: 1180px) {
            .stats-grid {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }

            .table-card {
                overflow-x: auto;
            }

            table {
                min-width: 1050px;
            }

            .section-title-row {
                flex-direction: column;
                align-items: flex-start;
            }
        }

        @media (max-width: 680px) {
            .payment-page {
                padding: 20px;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }

            .filter-row {
                width: 100%;
                flex-direction: column;
                align-items: stretch;
            }

            .table-footer {
                flex-direction: column;
                align-items: flex-start;
                gap: 14px;
            }
        }
    </style>
</head>

<body>

<jsp:include page="common/sidebar.jsp" />

<c:set var="totalCount" value="0" />
<c:set var="pendingCount" value="0" />
<c:set var="proofUploadedCount" value="0" />
<c:set var="rejectedCount" value="0" />

<c:forEach var="payment" items="${payments}">
    <c:set var="totalCount" value="${totalCount + 1}" />

    <c:if test="${payment.status == 'PENDING'}">
        <c:set var="pendingCount" value="${pendingCount + 1}" />
    </c:if>

    <c:if test="${payment.status == 'PROOF_UPLOADED'}">
        <c:set var="proofUploadedCount" value="${proofUploadedCount + 1}" />
    </c:if>

    <c:if test="${payment.status == 'REJECTED'}">
        <c:set var="rejectedCount" value="${rejectedCount + 1}" />
    </c:if>
</c:forEach>

<div class="main-content">
    <jsp:include page="common/header.jsp" />

    <main class="payment-page">

        <header class="page-header">
            <h1 class="page-title">Thanh toán của gia sư</h1>
            <p class="page-subtitle">
                Quản lý và phê duyệt các yêu cầu thanh toán từ gia sư.
                Theo dõi trạng thái chuyển khoản của phụ huynh và đối soát minh chứng giao dịch
                để gia tăng tính minh bạch.
            </p>
        </header>

        <section class="stats-grid">
            <div class="stat-card">
                <div class="stat-top">
                    <div class="stat-icon icon-blue">
                        <span class="material-symbols-rounded">receipt_long</span>
                    </div>
                    <span class="stat-chip chip-muted">Monthly</span>
                </div>

                <div>
                    <p class="stat-label">Tổng yêu cầu</p>
                    <div class="stat-value-row">
                        <p class="stat-value">${totalCount}</p>
                        <span class="stat-note">+12%</span>
                    </div>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-top">
                    <div class="stat-icon icon-orange">
                        <span class="material-symbols-rounded">pending_actions</span>
                    </div>
                </div>

                <div>
                    <p class="stat-label">Chờ phụ huynh</p>
                    <div class="stat-value-row">
                        <p class="stat-value">${pendingCount}</p>
                        <span class="stat-chip chip-orange">Pending</span>
                    </div>
                </div>
            </div>

            <div class="stat-card active">
                <div class="stat-top">
                    <div class="stat-icon icon-cloud">
                        <span class="material-symbols-rounded">cloud_upload</span>
                    </div>
                </div>

                <div>
                    <p class="stat-label">Đã upload proof</p>
                    <div class="stat-value-row">
                        <p class="stat-value">${proofUploadedCount}</p>
                        <span class="stat-chip chip-blue">Cần xác nhận</span>
                    </div>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-top">
                    <div class="stat-icon icon-red">
                        <span class="material-symbols-rounded">error</span>
                    </div>
                </div>

                <div>
                    <p class="stat-label">Yêu cầu lỗi</p>
                    <div class="stat-value-row">
                        <p class="stat-value">${rejectedCount}</p>
                        <span class="stat-chip chip-red">Cần xem lại</span>
                    </div>
                </div>
            </div>
        </section>

        <section class="section-title-row">
            <h2 class="section-title">
                <i class="fa-solid fa-list"></i>
                Danh sách giao dịch
            </h2>

            <div class="filter-row">
                <select class="filter-select">
                    <option>Tất cả tháng</option>
                </select>

                <select class="filter-select">
                    <option>Mọi học sinh</option>
                </select>

                <button type="button" class="filter-button">
                    Lọc dữ liệu
                </button>
            </div>
        </section>

        <section class="table-card">
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
                            <th>Mã/STT</th>
                            <th>Thông tin lớp học</th>
                            <th>Buổi học</th>
                            <th>Tổng tiền</th>
                            <th>Ngày yêu cầu</th>
                            <th>Trạng thái</th>
                            <th>Hành động</th>
                        </tr>
                        </thead>

                        <tbody>
                        <c:forEach var="payment" items="${payments}" varStatus="loop">
                            <tr>
                                <td>
                                    <span class="payment-code">
                                        #PM<c:out value="${payment.paymentId}" />
                                    </span>
                                </td>

                                <td>
                                    <div class="student-cell">
                                        <div class="avatar ${loop.index % 4 == 1 ? 'orange' : loop.index % 4 == 2 ? 'green' : loop.index % 4 == 3 ? 'red' : ''}">
                                            <c:choose>
                                                <c:when test="${not empty payment.student.fullName}">
                                                    <c:out value="${fn:substring(payment.student.fullName, 0, 1)}" />
                                                </c:when>
                                                <c:otherwise>HS</c:otherwise>
                                            </c:choose>
                                        </div>

                                        <div>
                                            <p class="student-name">
                                                <c:out value="${payment.student.fullName}" />
                                            </p>
                                            <p class="class-sub">
                                                <c:out value="${payment.classEntity.className}" />
                                                <br>
                                                <c:out value="${payment.classEntity.subject}" />
                                                <c:if test="${not empty payment.classEntity.grade}">
                                                    - Khối <c:out value="${payment.classEntity.grade}" />
                                                </c:if>
                                            </p>
                                        </div>
                                    </div>
                                </td>

                                <td>
                                    <span class="sessions-count">
                                        <c:out value="${payment.totalSessions}" /> buổi
                                    </span>
                                </td>

                                <td>
                                    <span class="amount">
                                        <fmt:formatNumber value="${payment.amount}" type="number" groupingUsed="true" />đ
                                    </span>
                                </td>

                                <td>
                                    <span class="request-date">
                                        <c:out value="${payment.requestDate}" />
                                    </span>
                                </td>

                                <td>
                                    <c:choose>
                                        <c:when test="${payment.status == 'PENDING'}">
                                            <span class="status-badge status-PENDING">
                                                ● Chờ phụ huynh
                                            </span>
                                        </c:when>

                                        <c:when test="${payment.status == 'PROOF_UPLOADED'}">
                                            <span class="status-badge status-PROOF_UPLOADED">
                                                Cần xác nhận
                                            </span>
                                        </c:when>

                                        <c:when test="${payment.status == 'TUTOR_CONFIRMED'}">
                                            <span class="status-badge status-TUTOR_CONFIRMED">
                                                Đã xác nhận
                                            </span>
                                        </c:when>

                                        <c:when test="${payment.status == 'COMPLETED' or payment.status == 'ADMIN_APPROVED'}">
                                            <span class="status-badge status-COMPLETED">
                                                ◎ Xong
                                            </span>
                                        </c:when>

                                        <c:when test="${payment.status == 'REJECTED'}">
                                            <span class="status-badge status-REJECTED">
                                                ● Lỗi
                                            </span>
                                        </c:when>

                                        <c:otherwise>
                                            <span class="status-badge">
                                                <c:out value="${payment.status}" />
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td class="action-cell">
                                    <div class="action-stack">
                                        <c:choose>
                                            <c:when test="${payment.status == 'PROOF_UPLOADED'}">
                                                <form action="${pageContext.request.contextPath}/payment/tutor-confirm"
                                                      method="post"
                                                      class="confirm-form">
                                                    <input type="hidden"
                                                           name="paymentId"
                                                           value="${payment.paymentId}">

                                                    <button type="submit" class="btn-confirm">
                                                        Xác nhận
                                                    </button>
                                                </form>

                                                <c:if test="${not empty payment.proofUrl}">
                                                    <a href="${payment.proofUrl}"
                                                       target="_blank"
                                                       class="proof-link">
                                                        <i class="fa-regular fa-image"></i>
                                                        Xem minh chứng
                                                    </a>
                                                </c:if>
                                            </c:when>

                                            <c:when test="${payment.status == 'PENDING'}">
                                                <span class="waiting-text">
                                                    Đang chờ xử lý...
                                                </span>
                                            </c:when>

                                            <c:when test="${payment.status == 'TUTOR_CONFIRMED'}">
                                                <span class="waiting-text">
                                                    Đã xác nhận, chờ admin duyệt
                                                </span>
                                            </c:when>

                                            <c:when test="${payment.status == 'COMPLETED' or payment.status == 'ADMIN_APPROVED'}">
                                                <span class="history-link">
                                                    <i class="fa-solid fa-clock-rotate-left"></i>
                                                    Lịch sử
                                                </span>
                                            </c:when>

                                            <c:when test="${payment.status == 'REJECTED'}">
                                                <c:choose>
                                                    <c:when test="${not empty payment.rejectionReason}">
                                                        <div class="reject-reason">
                                                            <c:out value="${payment.rejectionReason}" />
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="waiting-text">
                                                            Gửi yêu cầu lại
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>

                                            <c:otherwise>
                                                <span class="waiting-text">
                                                    Không có hành động
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>

                    <div class="table-footer">
                        <span>
                            Hiển thị 1 - ${totalCount} trên ${totalCount} yêu cầu
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

    </main>
</div>

</body>
</html>