<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
            <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta charset="UTF-8">
                    <title>Phê duyệt Thanh toán | TCMS Admin</title>
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">

                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
                    <link rel="stylesheet"
                        href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap">
                    <link rel="stylesheet"
                          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0"/>

                    <link rel="stylesheet" href="<c:url value='/css/core-dashboard.css' />">
                    <style>
                        .page-body {
                            padding: 2rem 2.5rem;
                        }

                        .page-title {
                            font-size: 1.75rem;
                            font-weight: 800;
                            color: #0f172a;
                            margin-bottom: 2rem;
                            letter-spacing: -0.025em;
                        }

                        /* Summary Cards */
                        .summary-grid {
                            display: grid;
                            grid-template-columns: repeat(4, 1fr);
                            gap: 1.5rem;
                            margin-bottom: 2.5rem;
                        }

                        .summary-card {
                            background: #fff;
                            padding: 1.5rem;
                            border-radius: 1.25rem;
                            border: 1px solid var(--border-color);
                            box-shadow: var(--card-shadow);
                            display: flex;
                            flex-direction: column;
                            position: relative;
                            overflow: hidden;
                        }

                        .card-header {
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                            margin-bottom: 1.25rem;
                        }

                        .card-icon {
                            width: 42px;
                            height: 42px;
                            border-radius: 10px;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            font-size: 1.25rem;
                        }

                        .icon-total {
                            background: #eff6ff;
                            color: #2563eb;
                        }

                        .icon-pending {
                            background: #fefce8;
                            color: #ca8a04;
                        }

                        .icon-overdue {
                            background: #fef2f2;
                            color: #dc2626;
                        }

                        .icon-done {
                            background: #f0fdf4;
                            color: #16a34a;
                        }

                        .card-label {
                            font-size: 0.875rem;
                            color: #64748b;
                            font-weight: 500;
                        }

                        .card-value {
                            font-size: 1.625rem;
                            font-weight: 800;
                            color: #0f172a;
                            margin: 0.25rem 0;
                        }

                        .card-subtext {
                            font-size: 0.75rem;
                            font-weight: 600;
                            display: flex;
                            align-items: center;
                            gap: 4px;
                        }

                        .badge-priority {
                            background: #2563eb;
                            color: #fff;
                            padding: 2px 8px;
                            border-radius: 6px;
                            font-size: 10px;
                            text-transform: uppercase;
                        }

                        /* Filter Section */
                        .filter-section {
                            background: #fff;
                            padding: 1rem;
                            border-radius: 1rem;
                            border: 1px solid var(--border-color);
                            display: flex;
                            gap: 1rem;
                            align-items: center;
                            margin-bottom: 2rem;
                            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
                        }

                        .search-box {
                            flex: 1;
                            position: relative;
                        }

                        .search-box input {
                            width: 100%;
                            padding: 0.75rem 1rem 0.75rem 2.75rem;
                            border-radius: 0.75rem;
                            border: 1px solid var(--border-color);
                            background: #f8fafc;
                            font-family: inherit;
                            font-size: 0.875rem;
                        }

                        .search-box i {
                            position: absolute;
                            left: 1rem;
                            top: 50%;
                            transform: translateY(-50%);
                            color: #94a3b8;
                        }

                        .filter-select {
                            padding: 0.75rem 1rem;
                            border-radius: 0.75rem;
                            border: 1px solid var(--border-color);
                            background: #fff;
                            font-family: inherit;
                            font-size: 0.875rem;
                            color: #334155;
                            min-width: 160px;
                        }

                        .btn-filter {
                            background: #1e293b;
                            color: #fff;
                            padding: 0.75rem 1.5rem;
                            border-radius: 0.75rem;
                            font-weight: 700;
                            font-size: 0.875rem;
                            border: none;
                            cursor: pointer;
                            transition: all 0.2s;
                        }

                        .btn-clear-filter {
                            background: transparent;
                            color: #2563eb;
                            padding: 0;
                            border: none;
                            font-weight: 700;
                            font-size: 0.875rem;
                            cursor: pointer;
                            display: inline-flex;
                            align-items: center;
                            gap: 0.75rem;
                            white-space: nowrap;
                        }

                        .btn-clear-filter .clear-icon {
                            width: 42px;
                            height: 42px;
                            border: 1px solid #dbe4f0;
                            background: #f8fafc;
                            color: #0f172a;
                            border-radius: 0;
                            display: inline-flex;
                            align-items: center;
                            justify-content: center;
                        }

                        .btn-clear-filter:hover {
                            color: #1d4ed8;
                        }

                        .filter-select[type="month"] {
                            min-width: 170px;
                        }

                        .no-result-row td {
                            text-align: center;
                            padding: 2rem;
                            color: #64748b;
                            font-weight: 600;
                        }

                        /* Table Container */
                        .table-card {
                            background: #fff;
                            border-radius: 1.5rem;
                            border: 1px solid var(--border-color);
                            box-shadow: var(--card-shadow);
                            overflow: hidden;
                        }

                        table {
                            width: 100%;
                            border-collapse: collapse;
                        }

                        th {
                            background: #fafafa;
                            padding: 1.25rem 1.5rem;
                            text-align: left;
                            font-size: 0.75rem;
                            font-weight: 700;
                            text-transform: uppercase;
                            letter-spacing: 0.05em;
                            color: #64748b;
                            border-bottom: 1px solid #f1f5f9;
                        }

                        td {
                            padding: 1.25rem 1.5rem;
                            border-bottom: 1px solid #f1f5f9;
                            vertical-align: middle;
                        }

                        /* Data Styling */
                        .payment-id {
                            color: #2563eb;
                            font-weight: 800;
                            font-size: 0.875rem;
                            display: flex;
                            align-items: center;
                            gap: 6px;
                        }

                        .partner-box {
                            display: flex;
                            flex-direction: column;
                            gap: 0.75rem;
                        }

                        .actor-info {
                            display: flex;
                            align-items: center;
                            gap: 0.75rem;
                        }

                        .actor-avatar {
                            width: 32px;
                            height: 32px;
                            border-radius: 50%;
                            background: #e2e8f0;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            font-size: 0.625rem;
                            font-weight: 800;
                            color: #fff;
                        }

                        .avatar-tutor {
                            background: #3b82f6;
                        }

                        .avatar-parent {
                            background: #94a3b8;
                        }

                        .actor-details h4 {
                            font-size: 0.8125rem;
                            font-weight: 700;
                            margin: 0;
                            color: #1e293b;
                        }

                        .actor-details p {
                            font-size: 0.75rem;
                            color: #64748b;
                            margin-top: 0.125rem;
                        }

                        .class-details h4 {
                            font-size: 0.875rem;
                            font-weight: 700;
                            margin: 0;
                            color: #1e293b;
                        }

                        .class-details p {
                            font-size: 0.75rem;
                            color: #64748b;
                            margin-top: 0.25rem;
                            line-height: 1.4;
                        }

                        .amount-text {
                            font-size: 1rem;
                            font-weight: 800;
                            color: #0f172a;
                        }

                        /* Status Badges */
                        .badge {
                            display: inline-flex;
                            align-items: center;
                            padding: 0.375rem 0.75rem;
                            border-radius: 999px;
                            font-size: 0.75rem;
                            font-weight: 700;
                            text-transform: uppercase;
                        }

                        .status-pending {
                            background: #fff7ed;
                            color: #ea580c;
                            border: 1px solid #fed7aa;
                        }

                        .status-tutor_confirmed {
                            background: #eff6ff;
                            color: #2563eb;
                            border: 1px solid #bfdbfe;
                        }

                        .status-completed {
                            background: #f0fdf4;
                            color: #16a34a;
                            border: 1px solid #bbf7d0;
                        }

                        .status-rejected {
                            background: #fef2f2;
                            color: #dc2626;
                            border: 1px solid #fecaca;
                        }

                        .btn-proof {
                            display: inline-flex;
                            align-items: center;
                            gap: 6px;
                            padding: 0.5rem 1rem;
                            background: #eff6ff;
                            color: #2563eb;
                            border-radius: 999px;
                            font-size: 0.75rem;
                            font-weight: 700;
                            text-decoration: none;
                        }

                        .action-btns {
                            display: flex;
                            gap: 0.5rem;
                        }

                        .btn-action {
                            width: 34px;
                            height: 34px;
                            border-radius: 50%;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            border: none;
                            cursor: pointer;
                            transition: all 0.2s;
                        }

                        .btn-approve {
                            background: #10b981;
                            color: #fff;
                        }

                        .btn-reject {
                            background: #ef4444;
                            color: #fff;
                        }

                        .btn-approve:hover {
                            background: #059669;
                        }

                        .btn-reject:hover {
                            background: #dc2626;
                        }

                        /* Modal */
                        .modal {
                            display: none;
                            position: fixed;
                            top: 0;
                            left: 0;
                            width: 100%;
                            height: 100%;
                            background: rgba(0, 0, 0, 0.4);
                            backdrop-filter: blur(4px);
                            z-index: 1000;
                            align-items: center;
                            justify-content: center;
                        }

                        .modal.active {
                            display: flex;
                        }

                        .modal-content {
                            background: #fff;
                            width: 100%;
                            max-width: 450px;
                            border-radius: 1.5rem;
                            padding: 2rem;
                            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
                        }

                        .modal-header h3 {
                            font-size: 1.25rem;
                            font-weight: 800;
                            margin: 0;
                        }

                        .modal-body {
                            margin: 1.5rem 0;
                        }

                        .form-control {
                            width: 100%;
                            padding: 0.75rem 1rem;
                            border-radius: 0.75rem;
                            border: 1px solid var(--border-color);
                            font-family: inherit;
                            resize: none;
                        }

                        .modal-footer {
                            display: flex;
                            justify-content: flex-end;
                            gap: 1rem;
                        }

                        .btn-cancel {
                            background: #f1f5f9;
                            color: #64748b;
                            padding: 0.75rem 1.5rem;
                            border-radius: 0.75rem;
                            border: none;
                            cursor: pointer;
                            font-weight: 700;
                        }

                        .btn-confirm-reject {
                            background: var(--danger);
                            color: #fff;
                            padding: 0.75rem 1.5rem;
                            border-radius: 0.75rem;
                            border: none;
                            cursor: pointer;
                            font-weight: 700;
                        }

                        .pagination {
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                            padding: 1.5rem;
                            background: #fff;
                            border-top: 1px solid #f1f5f9;
                        }

                        .page-info {
                            font-size: 0.75rem;
                            font-weight: 700;
                            color: #64748b;
                            text-transform: uppercase;
                        }

                        .page-nav {
                            display: flex;
                            gap: 0.5rem;
                        }

                        .page-btn {
                            width: 36px;
                            height: 36px;
                            border-radius: 10px;
                            border: 1px solid var(--border-color);
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            font-size: 0.875rem;
                            font-weight: 700;
                            color: #64748b;
                            text-decoration: none;
                            transition: all 0.2s;
                        }

                        .page-btn.active {
                            background: #2563eb;
                            color: #fff;
                            border-color: #2563eb;
                        }
                    </style>
                </head>

                <body>

                    <jsp:include page="common/sidebar.jsp" />

                    <div class="main-content">
                        <jsp:include page="common/header.jsp" />

                        <div class="page-body">
                            <h1 class="page-title">Phê duyệt Thanh toán</h1>

                            <!-- Summary Cards -->
                            <c:set var="totalAmount" value="0" />
                            <c:set var="pendingCount" value="0" />
                            <c:set var="completedCount" value="0" />
                            <c:set var="collectedTuition" value="0" />

                            <c:forEach var="p" items="${payments}">
                                <c:set var="totalAmount" value="${totalAmount + p.amount}" />

                                <c:if test="${p.status == 'TUTOR_CONFIRMED'}">
                                    <c:set var="pendingCount" value="${pendingCount + 1}" />
                                </c:if>

                                <c:if test="${p.status == 'COMPLETED' || p.status == 'ADMIN_APPROVED'}">
                                    <c:set var="completedCount" value="${completedCount + 1}" />
                                    <c:set var="collectedTuition" value="${collectedTuition + p.amount}" />
                                </c:if>
                            </c:forEach>

                            <div class="summary-grid">
                                <div class="summary-card">
                                    <div class="card-header">
                                        <div class="card-icon icon-total">
                                            <span class="material-symbols-rounded">payments</span>
                                        </div>
                                        <span class="card-label">THÁNG NÀY</span>
                                    </div>
                                    <div class="card-label">Tổng giá trị giao dịch</div>
                                    <div class="card-value">
                                        <fmt:formatNumber value="${totalAmount}" type="number" pattern="#,###" /> VND
                                    </div>
                                </div>

                                <div class="summary-card">
                                    <div class="card-header">
                                        <div class="card-icon icon-pending">
                                            <span class="material-symbols-rounded">approval_delegation</span>
                                        </div>
                                        <span class="badge-priority">PRIORITY</span>
                                    </div>
                                    <div class="card-label">Cần Admin duyệt</div>
                                    <div class="card-value">${pendingCount}</div>
                                    <div class="card-subtext" style="color: #2563eb;">Yêu cầu mới</div>
                                </div>

                                <div class="summary-card">
                                    <div class="card-header">
                                        <div class="card-icon icon-overdue">
                                            <span class="material-symbols-rounded">verified</span>
                                        </div>
                                    </div>

                                    <div class="card-label">Thanh toán đã duyệt</div>

                                    <div class="card-value">
                                        ${approvedPaymentsCount}
                                    </div>

                                    <div class="card-subtext" style="color: #16a34a;">
                                        THÀNH CÔNG
                                    </div>
                                </div>

                                <div class="summary-card">
                                    <div class="card-header">
                                        <div class="card-icon icon-overdue">
                                            <span class="material-symbols-rounded">account_balance_wallet</span>
                                        </div>
                                    </div>

                                    <div class="card-label">Tổng học phí đã thu</div>

                                    <div class="card-value">
                                        <fmt:formatNumber value="${collectedTuition}" type="number" pattern="#,###" /> VND
                                    </div>

                                    <div class="card-subtext" style="color: #16a34a;">
                                        Từ các giao dịch đã duyệt / hoàn tất
                                    </div>
                                </div>
                            </div>

                            <!-- Filter Section -->
                            <form action="${pageContext.request.contextPath}/admin/payments/approve"
                                  method="GET"
                                  class="filters-toolbar"
                                  id="paymentFilterForm">

                                <div class="filter-group" style="flex: 2;">
                                    <div class="filter-input">
            <span class="material-symbols-rounded" style="color: var(--text-muted);">
                search
            </span>

                                        <input type="text"
                                               id="paymentKeyword"
                                               name="keyword"
                                               value="${param.keyword}"
                                               placeholder="Tìm mã GD, gia sư, phụ huynh, học sinh, lớp học...">
                                    </div>
                                </div>

                                <div class="filter-group">
                                    <div class="filter-input">
                                        <select id="paymentStatus" name="status">
                                            <option value="">Trạng thái</option>
                                            <option value="PENDING" ${param.status == 'PENDING' ? 'selected' : ''}>
                                                Chờ thanh toán
                                            </option>
                                            <option value="PROOF_UPLOADED" ${param.status == 'PROOF_UPLOADED' ? 'selected' : ''}>
                                                Đã gửi minh chứng
                                            </option>
                                            <option value="TUTOR_CONFIRMED" ${param.status == 'TUTOR_CONFIRMED' ? 'selected' : ''}>
                                                Chờ Admin duyệt
                                            </option>
                                            <option value="ADMIN_APPROVED" ${param.status == 'ADMIN_APPROVED' ? 'selected' : ''}>
                                                Đã duyệt
                                            </option>
                                            <option value="COMPLETED" ${param.status == 'COMPLETED' ? 'selected' : ''}>
                                                Hoàn tất
                                            </option>
                                            <option value="REJECTED" ${param.status == 'REJECTED' ? 'selected' : ''}>
                                                Từ chối
                                            </option>
                                        </select>
                                    </div>
                                </div>

                                <div class="filter-group">
                                    <div class="filter-input">
                                        <input type="month"
                                               id="paymentMonth"
                                               name="month"
                                               value="${param.month}">
                                    </div>
                                </div>

                                <button type="submit"
                                        id="applyPaymentFilter"
                                        class="icon-btn"
                                        style="background: var(--bg-page); border: 1px solid var(--border-color); width: 44px; height: 44px;">
                                    <span class="material-symbols-rounded">filter_list</span>
                                </button>

                                <a href="${pageContext.request.contextPath}/admin/payments/approve"
                                   id="clearPaymentFilter"
                                   style="color: var(--primary); font-size: 13px; font-weight: 700; text-decoration: none;">
                                    Xóa lọc
                                </a>
                            </form>

                            <!-- Table Container -->
                            <div class="table-card">
                                <div style="overflow-x: auto;">
                                    <table>
                                        <thead>
                                            <tr>
                                                <th>MÃ GD</th>
                                                <th>ĐỐI TÁC (GIA SƯ & PHỤ HUYNH)</th>
                                                <th>CHI TIẾT LỚP HỌC</th>
                                                <th>GIÁ TRỊ</th>
                                                <th>MINH CHỨNG</th>
                                                <th>TRẠNG THÁI</th>
                                                <th>THAO TÁC</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="payment" items="${payments}">
                                                <c:set var="paymentMonth" value="" />
                                                <c:if test="${not empty payment.requestDate}">
                                                    <c:set var="paymentMonth" value="${fn:substring(payment.requestDate, 0, 7)}" />
                                                </c:if>

                                                <tr class="payment-row"
                                                    data-status="${payment.status}"
                                                    data-month="${paymentMonth}">
                                                    <td>
                                                        <div class="payment-id">
                                                            #PAY-${payment.paymentId}
                                                            <span class="material-symbols-rounded"
                                                                style="font-size: 14px; color: #94a3b8;">history</span>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="partner-box">
                                                            <div class="actor-info">
                                                                <div class="actor-avatar avatar-tutor">
                                                                    ${fn:substring(payment.tutor.fullName, 0, 1)}
                                                                </div>
                                                                <div class="actor-details">
                                                                    <h4>
                                                                        <c:out value="${payment.tutor.fullName}" />
                                                                    </h4>
                                                                </div>
                                                            </div>
                                                            <div class="actor-info">
                                                                <div class="actor-avatar avatar-parent">
                                                                    ${fn:substring(payment.student.parent.fullName, 0,
                                                                    1)}
                                                                </div>
                                                                <div class="actor-details">
                                                                    <p>
                                                                        <c:out
                                                                            value="${payment.student.parent.fullName}" />
                                                                        (Phụ huynh em
                                                                        <c:out value="${payment.student.fullName}" />)
                                                                    </p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="class-details">
                                                            <h4>
                                                                <c:out value="${payment.classEntity.className}" />
                                                            </h4>
                                                            <p>
                                                                ${payment.totalSessions} buổi học<br>
                                                                <span style="font-size: 11px; color: #94a3b8;">(Mã:
                                                                    <c:out value="${payment.classEntity.classCode}" />)
                                                                </span>
                                                            </p>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="amount-text">
                                                            <fmt:formatNumber value="${payment.amount}" type="number"
                                                                pattern="#,###" />đ
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty payment.proofUrl}">
                                                                <a href="${payment.proofUrl}" target="_blank"
                                                                    class="btn-proof">
                                                                    <span class="material-symbols-rounded"
                                                                        style="font-size: 16px;">image</span>
                                                                    Xem minh chứng
                                                                </a>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span
                                                                    style="font-size: 0.75rem; color: #94a3b8; font-style: italic;">Chưa
                                                                    có minh chứng</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <span class="badge status-${fn:toLowerCase(payment.status)}">
                                                            <c:choose>
                                                                <c:when test="${payment.status == 'PENDING'}">Chờ thanh
                                                                    toán</c:when>
                                                                <c:when test="${payment.status == 'TUTOR_CONFIRMED'}">
                                                                    Chờ Admin duyệt</c:when>
                                                                <c:when test="${payment.status == 'ADMIN_APPROVED'}">Đã
                                                                    duyệt</c:when>
                                                                <c:when test="${payment.status == 'COMPLETED'}">Hoàn tất
                                                                </c:when>
                                                                <c:when test="${payment.status == 'REJECTED'}">Từ chối
                                                                </c:when>
                                                                <c:otherwise>${payment.status}</c:otherwise>
                                                            </c:choose>
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <div class="action-btns">
                                                            <c:if test="${payment.status == 'TUTOR_CONFIRMED'}">
                                                                <form
                                                                    action="${pageContext.request.contextPath}/payment/admin-approve"
                                                                    method="post" style="margin:0">
                                                                    <input type="hidden" name="paymentId"
                                                                        value="${payment.paymentId}">
                                                                    <button type="submit" class="btn-action btn-approve"
                                                                        title="Duyệt thanh toán">
                                                                        <i class="fa-solid fa-check"></i>
                                                                    </button>
                                                                </form>
                                                                <button type="button" class="btn-action btn-reject"
                                                                    onclick="openRejectModal('${payment.paymentId}', '${payment.tutor.fullName}')"
                                                                    title="Từ chối">
                                                                    <i class="fa-solid fa-xmark"></i>
                                                                </button>
                                                            </c:if>
                                                            <c:if test="${payment.status == 'PENDING'}">
                                                                <button class="btn-proof"
                                                                    style="background: #fff7ed; color: #ea580c; border: 1px solid #fed7aa; cursor: default;">
                                                                    <span class="material-symbols-rounded"
                                                                        style="font-size: 16px;">notifications_active</span>
                                                                    Nhắc nhở
                                                                </button>
                                                            </c:if>
                                                            <c:if
                                                                test="${payment.status == 'ADMIN_APPROVED' || payment.status == 'COMPLETED'}">
                                                                <div
                                                                    style="font-size: 0.7rem; color: #94a3b8; line-height: 1.2;">
                                                                    Đã xử lý lúc<br>
                                                                    <fmt:parseDate value="${payment.adminApprovedAt}"
                                                                        pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate"
                                                                        type="both" />
                                                                    <fmt:formatDate value="${parsedDate}"
                                                                        pattern="HH:mm dd/MM" />
                                                                </div>
                                                            </c:if>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            <tr id="noPaymentResultRow" class="no-result-row" style="display: none;">
                                                <td colspan="7">
                                                    Không tìm thấy giao dịch phù hợp với điều kiện lọc.
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>

                                <!-- Pagination -->
                                <div class="pagination">
                                    <div class="page-info" id="paymentPageInfo">
                                        Trang 1 / 1 (Tổng ${fn:length(payments)} giao dịch)
                                    </div>
                                    <div class="page-nav">
                                        <a href="#" class="page-btn"><i class="fa-solid fa-chevron-left"></i></a>
                                        <a href="#" class="page-btn active">1</a>
                                        <a href="#" class="page-btn"><i class="fa-solid fa-chevron-right"></i></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Reject Modal -->
                    <div id="rejectModal" class="modal">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h3>Từ chối Thanh toán</h3>
                            </div>
                            <form action="${pageContext.request.contextPath}/payment/admin-reject" method="post">
                                <input type="hidden" name="paymentId" id="rejectPaymentId">
                                <div class="modal-body">
                                    <p style="font-size: 0.875rem; color: #64748b; margin-bottom: 1rem;">
                                        Gia sư: <span id="rejectTutorName"
                                            style="color: #0f172a; font-weight: 700;"></span>
                                    </p>
                                    <div style="margin-bottom: 1rem;">
                                        <label
                                            style="font-size: 0.8125rem; font-weight: 700; color: #1e293b; display: block; margin-bottom: 0.5rem;">Lý
                                            do từ chối</label>
                                        <textarea name="reason" class="form-control" rows="4"
                                            placeholder="Nhập lý do chi tiết..." required></textarea>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn-cancel" onclick="closeRejectModal()">Hủy
                                        bỏ</button>
                                    <button type="submit" class="btn-confirm-reject">Xác nhận từ chối</button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <script>
                        function openRejectModal(id, tutorName) {
                            const rejectPaymentId = document.getElementById('rejectPaymentId');
                            const rejectTutorName = document.getElementById('rejectTutorName');
                            const rejectModal = document.getElementById('rejectModal');

                            if (rejectPaymentId) {
                                rejectPaymentId.value = id;
                            }

                            if (rejectTutorName) {
                                rejectTutorName.innerText = tutorName || '';
                            }

                            if (rejectModal) {
                                rejectModal.classList.add('active');
                            }
                        }

                        function closeRejectModal() {
                            const rejectModal = document.getElementById('rejectModal');

                            if (rejectModal) {
                                rejectModal.classList.remove('active');
                            }
                        }

                        document.addEventListener('DOMContentLoaded', function () {
                            const keywordInput = document.getElementById('paymentKeyword');
                            const statusSelect = document.getElementById('paymentStatus');
                            const monthInput = document.getElementById('paymentMonth');
                            const applyButton = document.getElementById('applyPaymentFilter');
                            const clearButton = document.getElementById('clearPaymentFilter');
                            const filterForm = document.getElementById('paymentFilterForm');

                            const rows = Array.from(document.querySelectorAll('.payment-row'));
                            const noResultRow = document.getElementById('noPaymentResultRow');
                            const pageInfo = document.getElementById('paymentPageInfo');

                            const totalRows = rows.length;

                            function normalizeText(value) {
                                return (value || '')
                                    .toString()
                                    .toLowerCase()
                                    .normalize('NFD')
                                    .replace(/[\u0300-\u036f]/g, '')
                                    .trim();
                            }

                            function getInputValue(element) {
                                return element ? element.value : '';
                            }

                            function updatePageInfo(visibleCount) {
                                if (!pageInfo) {
                                    return;
                                }

                                if (visibleCount === totalRows) {
                                    pageInfo.innerText = 'Trang 1 / 1 (Tổng ' + totalRows + ' giao dịch)';
                                } else {
                                    pageInfo.innerText = 'Hiển thị ' + visibleCount + ' / ' + totalRows + ' giao dịch';
                                }
                            }

                            function applyPaymentFilter() {
                                const keyword = normalizeText(getInputValue(keywordInput));
                                const selectedStatus = getInputValue(statusSelect);
                                const selectedMonth = getInputValue(monthInput);

                                let visibleCount = 0;

                                rows.forEach(function (row) {
                                    const rowText = normalizeText(row.innerText);
                                    const rowStatus = row.getAttribute('data-status') || '';
                                    const rowMonth = row.getAttribute('data-month') || '';

                                    const matchKeyword = keyword === '' || rowText.includes(keyword);
                                    const matchStatus = selectedStatus === '' || rowStatus === selectedStatus;
                                    const matchMonth = selectedMonth === '' || rowMonth === selectedMonth;

                                    if (matchKeyword && matchStatus && matchMonth) {
                                        row.style.display = '';
                                        visibleCount++;
                                    } else {
                                        row.style.display = 'none';
                                    }
                                });

                                if (noResultRow) {
                                    noResultRow.style.display = visibleCount === 0 ? '' : 'none';
                                }

                                updatePageInfo(visibleCount);
                            }

                            function clearPaymentFilter(event) {
                                if (event) {
                                    event.preventDefault();
                                }

                                if (keywordInput) {
                                    keywordInput.value = '';
                                }

                                if (statusSelect) {
                                    statusSelect.value = '';
                                }

                                if (monthInput) {
                                    monthInput.value = '';
                                }

                                rows.forEach(function (row) {
                                    row.style.display = '';
                                });

                                if (noResultRow) {
                                    noResultRow.style.display = 'none';
                                }

                                updatePageInfo(totalRows);

                                if (keywordInput) {
                                    keywordInput.focus();
                                }

                                if (window.history && window.history.replaceState) {
                                    const cleanUrl = window.location.origin + window.location.pathname;
                                    window.history.replaceState({}, document.title, cleanUrl);
                                }
                            }

                            if (filterForm) {
                                filterForm.addEventListener('submit', function (event) {
                                    event.preventDefault();
                                    applyPaymentFilter();
                                });
                            }

                            if (applyButton) {
                                applyButton.addEventListener('click', function (event) {
                                    event.preventDefault();
                                    applyPaymentFilter();
                                });
                            }

                            if (clearButton) {
                                clearButton.addEventListener('click', clearPaymentFilter);
                            }

                            if (keywordInput) {
                                keywordInput.addEventListener('keyup', function (event) {
                                    if (event.key === 'Enter') {
                                        applyPaymentFilter();
                                    }
                                });
                            }

                            if (statusSelect) {
                                statusSelect.addEventListener('change', applyPaymentFilter);
                            }

                            if (monthInput) {
                                monthInput.addEventListener('change', applyPaymentFilter);
                            }

                            document.addEventListener('click', function (event) {
                                const modal = document.getElementById('rejectModal');

                                if (modal && event.target === modal) {
                                    closeRejectModal();
                                }
                            });
                        });
                    </script>
                </body>

                </html>