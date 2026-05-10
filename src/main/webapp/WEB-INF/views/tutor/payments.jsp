<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="activePage" value="payment" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý thanh toán | TCMS Tutor</title>

    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0"/>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/tutor-dashboard.css">

    <style>

        .payment-page {
            padding: 28px;
            background: var(--bg-page);
            min-height: 100vh;
        }

        .page-head {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 24px;
        }

        .page-head h1 {
            font-size: 28px;
            font-weight: 900;
            color: var(--text-dark);
            margin: 0 0 6px;
        }

        .page-head p {
            margin: 0;
            color: var(--text-muted);
            font-size: 13px;
            font-weight: 600;
        }

        .btn-primary {
            min-height: 42px;
            border: none;
            border-radius: 12px;
            background: var(--primary);
            color: #fff;
            padding: 0 18px;
            font-size: 13px;
            font-weight: 900;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
        }

        .stats-row {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 18px;
            margin-bottom: 24px;
        }

        .stat-card {
            background: #fff;
            border: 1px solid var(--border-color);
            border-radius: 18px;
            padding: 22px;
            box-shadow: var(--shadow-sm);
        }

        .stat-card span {
            display: block;
            color: var(--text-muted);
            font-size: 12px;
            font-weight: 800;
            margin-bottom: 8px;
        }

        .stat-card strong {
            font-size: 28px;
            font-weight: 900;
            color: var(--text-dark);
        }

        .payment-card {
            background: #fff;
            border: 1px solid var(--border-color);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: var(--shadow-sm);
        }

        .payment-toolbar {
            padding: 18px;
            display: flex;
            gap: 12px;
            border-bottom: 1px solid var(--border-color);
        }

        .search-input,
        .filter-select {
            height: 42px;
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 0 14px;
            font-size: 13px;
            font-weight: 700;
            outline: none;
        }

        .search-input {
            flex: 1;
        }

        .filter-select {
            width: 220px;
        }

        .payment-table-wrapper {
            width: 100%;
            overflow-x: auto;
        }

        .payment-table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
        }

        .payment-table thead {
            background: #f8fafc;
        }
        .payment-table tr {
            display: table-row;
        }
        .payment-table th,
        .payment-table td {
            display: table-cell;
            padding: 16px;
            text-align: left;
            vertical-align: middle;
            border-bottom: 1px solid #f1f5f9;
        }
        .payment-table th {
            font-size: 11px;
            font-weight: 900;
            color: #94a3b8;
            text-transform: uppercase;
            letter-spacing: .5px;
            white-space: nowrap;
        }

        .payment-table td {
            font-size: 13px;
            font-weight: 700;
            color: #0f172a;
        }


        .payment-table tbody tr:hover {
            background: #fafcff;
        }

        .payment-id {
            color: var(--primary);
            font-weight: 900;
            font-size: 13px;
        }

        .student-info {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        .student-info strong {
            font-size: 14px;
            color: #0f172a;
        }

        .subject-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 7px 12px;
            border-radius: 999px;
            background: #eff6ff;
            color: #2563eb;
            font-size: 11px;
            font-weight: 900;
        }

        .lesson-count {
            font-weight: 800;
            color: #334155;
        }

        .payment-amount {
            font-size: 15px;
            font-weight: 900;
            color: #16a34a;
        }

        .payment-time {
            color: #475569;
            font-size: 13px;
            font-weight: 700;
            white-space: nowrap;
        }

        .status-pill {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 6px 12px;
            border-radius: 999px;
            font-size: 10px;
            font-weight: 900;
            text-transform: uppercase;
            white-space: nowrap;
        }

        .st-pending {
            background: #fef3c7;
            color: #d97706;
        }

        .st-proof {
            background: #dbeafe;
            color: #2563eb;
        }

        .st-admin {
            background: #ede9fe;
            color: #7c3aed;
        }

        .st-approved {
            background: #cffafe;
            color: #0891b2;
        }

        .st-completed {
            background: #dcfce7;
            color: #16a34a;
        }

        .st-rejected {
            background: #fee2e2;
            color: #dc2626;
        }

        .payment-actions {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .action-btn {
            min-height: 34px;
            border: none;
            border-radius: 10px;
            padding: 0 12px;
            background: #eef2ff;
            color: var(--primary);
            font-size: 12px;
            font-weight: 800;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: .2s ease;
        }

        .action-btn:hover {
            background: #dbeafe;
        }

        .action-danger {
            background: #fef2f2;
            color: #dc2626;
        }

        .action-danger:hover {
            background: #fee2e2;
        }

        .empty-row {
            text-align: center;
            padding: 50px !important;
            color: #94a3b8 !important;
            font-size: 14px;
            font-weight: 700;
        }

        .empty-row i {
            display: block;
            font-size: 28px;
            margin-bottom: 12px;
        }

        .alert {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 14px 16px;
            border-radius: 14px;
            margin-bottom: 18px;
            font-size: 14px;
            font-weight: 700;
        }

        .alert-danger {
            background: #fef2f2;
            color: #dc2626;
            border: 1px solid #fecaca;
        }

        .alert-success {
            background: #ecfdf5;
            color: #16a34a;
            border: 1px solid #bbf7d0;
        }

        .modal-backdrop {
            position: fixed;
            inset: 0;
            background: rgba(15, 23, 42, .45);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 9999;
        }

        .modal-backdrop.active {
            display: flex;
        }

        .modal-box {
            width: 460px;
            max-width: calc(100% - 32px);
            background: #fff;
            border-radius: 22px;
            box-shadow: 0 24px 60px rgba(15, 23, 42, .25);
            padding: 26px;
        }

        .modal-box h2 {
            margin: 0 0 6px;
            font-size: 22px;
            font-weight: 900;
            color: #173b73;
        }

        .modal-box p {
            margin: 0 0 22px;
            color: var(--text-muted);
            font-size: 13px;
            line-height: 1.5;
        }

        .form-group {
            margin-bottom: 16px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-size: 12px;
            font-weight: 900;
            color: #4b6385;
            text-transform: uppercase;
        }

        .form-control {
            width: 100%;
            min-height: 44px;
            border: 1px solid #dbe3ef;
            border-radius: 12px;
            padding: 0 14px;
            outline: none;
            font-size: 14px;
            font-weight: 600;
            color: #0f172a;
        }

        textarea.form-control {
            min-height: 110px;
            padding: 12px 14px;
            resize: vertical;
        }

        .modal-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 20px;
        }

        .btn-cancel {
            min-height: 40px;
            border-radius: 12px;
            border: 1px solid var(--border-color);
            background: #fff;
            padding: 0 16px;
            font-weight: 800;
            cursor: pointer;
        }

        .proof-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: var(--primary);
            font-weight: 900;
            text-decoration: none;
        }

    </style>
</head>

<body>

<jsp:include page="common/sidebar.jsp"/>

<main class="main-content">

    <jsp:include page="common/header.jsp"/>

    <section class="payment-page">

        <div class="page-head">

            <div>
                <h1>Quản lý thanh toán</h1>
                <p>Theo dõi yêu cầu thanh toán và trạng thái xử lý trong hệ thống.</p>
            </div>

            <button type="button"
                    class="btn-primary"
                    onclick="openCreateModal()">

                <i class="fa-solid fa-circle-plus"></i>
                Tạo yêu cầu thanh toán
            </button>

        </div>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">
                <i class="fa-solid fa-circle-exclamation"></i>
                <span>${errorMessage}</span>
            </div>
        </c:if>

        <c:if test="${not empty successMessage}">
            <div class="alert alert-success">
                <i class="fa-solid fa-circle-check"></i>
                <span>${successMessage}</span>
            </div>
        </c:if>

        <c:set var="total" value="0"/>
        <c:set var="pending" value="0"/>
        <c:set var="proof" value="0"/>
        <c:set var="rejected" value="0"/>

        <c:forEach var="p" items="${payments}">

            <c:set var="total" value="${total + 1}"/>

            <c:if test="${p.status == 'PENDING'}">
                <c:set var="pending" value="${pending + 1}"/>
            </c:if>

            <c:if test="${p.status == 'PROOF_UPLOADED'}">
                <c:set var="proof" value="${proof + 1}"/>
            </c:if>

            <c:if test="${p.status == 'REJECTED'}">
                <c:set var="rejected" value="${rejected + 1}"/>
            </c:if>

        </c:forEach>

        <div class="stats-row">

            <div class="stat-card">
                <span>Tổng yêu cầu</span>
                <strong>${total}</strong>
            </div>

            <div class="stat-card">
                <span>Chờ thanh toán</span>
                <strong>${pending}</strong>
            </div>

            <div class="stat-card">
                <span>Đã gửi minh chứng</span>
                <strong>${proof}</strong>
            </div>

            <div class="stat-card">
                <span>Bị từ chối</span>
                <strong>${rejected}</strong>
            </div>

        </div>

        <div class="payment-card">

            <div class="payment-toolbar">

                <input class="search-input"
                       id="paymentSearch"
                       type="text"
                       placeholder="Tìm kiếm..."
                       onkeyup="filterPayments()">

                <select class="filter-select"
                        id="statusFilter"
                        onchange="filterPayments()">

                    <option value="">Tất cả trạng thái</option>
                    <option value="PENDING">Chờ Admin duyệt</option>
                    <option value="ADMIN_APPROVED">Chờ Phụ huynh TT</option>
                    <option value="PROOF_UPLOADED">Đã gửi minh chứng</option>
                    <option value="TUTOR_CONFIRMED">Chờ Admin xác nhận</option>
                    <option value="COMPLETED">Hoàn tất</option>
                    <option value="REJECTED">Từ chối</option>

                </select>

            </div>

            <div class="payment-table-wrapper">

                <table class="payment-table">

                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Học sinh</th>
                        <th>Môn học</th>
                        <th>Số buổi</th>
                        <th>Số tiền</th>
                        <th>Thời gian thanh toán</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                    </thead>

                    <tbody>

                    <c:choose>

                        <c:when test="${not empty payments}">

                            <c:forEach var="p" items="${payments}">

                                <tr class="payment-row"
                                    data-status="${p.status}"
                                    data-search="${p.paymentId} ${p.student.fullName} ${p.classEntity.subject} ${p.classEntity.className}">

                                    <td>
                                        <span class="payment-id">
                                            #PAY-${p.paymentId}
                                        </span>
                                    </td>

                                    <td>
                                        <div class="student-info">
                                            <strong>
                                                <c:out value="${p.student.fullName}"/>
                                            </strong>
                                        </div>
                                    </td>

                                    <td>
                                        <span class="subject-badge">
                                            <c:out value="${p.classEntity.subject}"/>
                                        </span>
                                    </td>

                                    <td>
                                        <span class="lesson-count">
                                            ${p.totalSessions} buổi
                                        </span>
                                    </td>

                                    <td>
                                        <span class="payment-amount">
                                            <fmt:formatNumber value="${p.amount}"
                                                              type="number"/>
                                            đ
                                        </span>
                                    </td>

                                    <td>
                                        <div class="payment-time">
                                                ${p.requestDate}
                                        </div>
                                    </td>

                                    <td>

                                        <c:choose>

                                            <c:when test="${p.status == 'PENDING'}">
                                                <span class="status-pill st-pending">
                                                    Chờ Admin duyệt
                                                </span>
                                            </c:when>

                                            <c:when test="${p.status == 'ADMIN_APPROVED'}">
                                                <span class="status-pill st-approved">
                                                    Chờ Phụ huynh TT
                                                </span>
                                            </c:when>

                                            <c:when test="${p.status == 'PROOF_UPLOADED'}">
                                                <span class="status-pill st-proof">
                                                    Đã gửi minh chứng
                                                </span>
                                            </c:when>

                                            <c:when test="${p.status == 'TUTOR_CONFIRMED'}">
                                                <span class="status-pill st-admin">
                                                    Chờ Admin xác nhận
                                                </span>
                                            </c:when>

                                            <c:when test="${p.status == 'COMPLETED'}">
                                                <span class="status-pill st-completed">
                                                    Hoàn tất
                                                </span>
                                            </c:when>

                                            <c:otherwise>
                                                <span class="status-pill st-rejected">
                                                    Từ chối
                                                </span>
                                            </c:otherwise>

                                        </c:choose>

                                    </td>

                                    <td>

                                        <div class="payment-actions">

                                            <c:if test="${not empty p.proofUrl}">

                                                <button type="button"
                                                        class="action-btn"
                                                        onclick="openProofModal(
                                                                '${p.proofUrl}',
                                                                '${p.paymentId}',
                                                                '${p.status}'
                                                                )">

                                                    <i class="fa-solid fa-image"></i>
                                                    <c:choose>
                                                        <c:when test="${p.status == 'PROOF_UPLOADED'}">Xem & Xác nhận</c:when>
                                                        <c:otherwise>Minh chứng</c:otherwise>
                                                    </c:choose>
                                                </button>

                                            </c:if>

                                            <c:if test="${p.status == 'REJECTED'}">

                                                <button type="button"
                                                        class="action-btn action-danger"
                                                        onclick="openRejectModal(
                                                                '${p.rejectionReason}'
                                                                )">

                                                    <i class="fa-solid fa-circle-info"></i>
                                                    Lý do

                                                </button>

                                            </c:if>

                                        </div>

                                    </td>

                                </tr>

                            </c:forEach>

                        </c:when>

                        <c:otherwise>

                            <tr>
                                <td colspan="8" class="empty-row">

                                    <i class="fa-regular fa-folder-open"></i>

                                    Chưa có yêu cầu thanh toán nào.

                                </td>
                            </tr>

                        </c:otherwise>

                    </c:choose>

                    </tbody>

                </table>

            </div>

        </div>

    </section>

</main>

<!-- CREATE MODAL -->

<div class="modal-backdrop" id="createPaymentModal">

    <div class="modal-box">

        <h2>Tạo yêu cầu thanh toán</h2>

        <p>
            Vui lòng cung cấp thông tin để tạo yêu cầu thanh toán.
        </p>

        <form action="${pageContext.request.contextPath}/payment/create"
              method="post">

            <div class="form-group">

                <label>Chọn lớp học</label>

                <select name="classId"
                        class="form-control"
                        required>

                    <option value="">
                        Vui lòng chọn lớp học...
                    </option>

                    <c:forEach var="classEntity" items="${classes}">
                        <option value="${classEntity.classId}">
                            <c:out value="${classEntity.className}"/>
                        </option>
                    </c:forEach>

                </select>

            </div>

            <div class="form-group">

                <label>Chọn học sinh</label>

                <select name="studentId"
                        class="form-control"
                        required>

                    <option value="">
                        Chọn học sinh...
                    </option>

                    <c:forEach var="enrollment" items="${students}">

                        <c:if test="${not empty enrollment.student}">

                            <option value="${enrollment.student.studentId}">
                                <c:out value="${enrollment.student.fullName}"/>
                            </option>

                        </c:if>

                    </c:forEach>

                </select>

            </div>

            <div class="form-group">

                <label>Ghi chú</label>

                <textarea name="note"
                          class="form-control"
                          placeholder="Nhập ghi chú..."></textarea>

            </div>

            <div class="modal-actions">

                <button type="button"
                        class="btn-cancel"
                        onclick="closeCreateModal()">

                    Hủy

                </button>

                <button type="submit"
                        class="btn-primary">

                    Gửi yêu cầu

                </button>

            </div>

        </form>

    </div>

</div>

<!-- PROOF MODAL -->
<div class="modal-backdrop" id="proofModal">
    <div class="modal-box" style="width: 600px; max-width: 100%; padding: 0; overflow: hidden;">
        <div style="padding: 1.5rem; border-bottom: 1px solid #e2e8f0;">
            <h3 style="margin: 0; font-size: 1.25rem; font-weight: 700; color: #0f172a;">Minh chứng thanh toán</h3>
        </div>
        <div style="padding: 1.5rem; text-align: center;">
            <img id="proofImage" src="" alt="Minh chứng" style="max-width: 100%; border-radius: 8px; max-height: 400px; object-fit: contain;">
        </div>
        <div style="padding: 1.25rem 1.5rem; background-color: #f8fafc; border-top: 1px solid #e2e8f0; display: flex; justify-content: space-between; align-items: center;">
            <a id="proofLink" href="#" target="_blank" style="display: inline-flex; align-items: center; gap: 8px; color: #2563eb; font-weight: 600; text-decoration: none; font-size: 0.875rem;">
                <i class="fa-solid fa-arrow-up-right-from-square"></i>
                Mở trong thẻ mới
            </a>
            <div style="display: flex; gap: 10px;">
                <button type="button" class="btn-cancel" onclick="closeProofModal()" style="margin: 0;">Đóng</button>
                <form id="confirmPaymentForm" action="${pageContext.request.contextPath}/payment/tutor-confirm" method="post" style="margin: 0; display: none;">
                    <input type="hidden" name="paymentId" id="confirmPaymentId" value="">
                    <button type="submit" class="btn-primary" style="margin: 0;">Đã nhận được tiền</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- REJECT MODAL -->
<div class="modal-backdrop" id="rejectModal">
    <div class="modal-box">
        <h2>Lý do từ chối</h2>
        <p id="rejectReasonText">Không có lý do.</p>

        <div class="modal-actions">
            <button type="button" class="btn-cancel" onclick="closeRejectModal()">Đóng</button>
        </div>
    </div>
</div>

<script>

    function openCreateModal() {
        document.getElementById('createPaymentModal')
            .classList.add('active');
    }

    function closeCreateModal() {
        document.getElementById('createPaymentModal')
            .classList.remove('active');
    }

    function openProofModal(url, paymentId, status) {
        if (!url || url === 'null' || url.trim() === '') {
            alert('Chưa có minh chứng thanh toán.');
            return;
        }

        document.getElementById('proofLink').href = url;
        document.getElementById('proofImage').src = url;
        
        if (status === 'PROOF_UPLOADED' && paymentId) {
            document.getElementById('confirmPaymentForm').style.display = 'block';
            document.getElementById('confirmPaymentId').value = paymentId;
        } else {
            document.getElementById('confirmPaymentForm').style.display = 'none';
        }

        document.getElementById('proofModal').classList.add('active');
    }

    function closeProofModal() {
        document.getElementById('proofModal').classList.remove('active');
    }

    function openRejectModal(reason) {
        document.getElementById('rejectReasonText').innerText =
            reason && reason !== 'null' && reason.trim() !== ''
                ? reason
                : 'Không có lý do từ chối.';

        document.getElementById('rejectModal').classList.add('active');
    }

    function closeRejectModal() {
        document.getElementById('rejectModal').classList.remove('active');
    }

    function filterPayments() {

        const keyword =
            document.getElementById('paymentSearch')
                .value
                .toLowerCase()
                .trim();

        const status =
            document.getElementById('statusFilter')
                .value
                .trim();

        const rows =
            document.querySelectorAll('.payment-row');

        rows.forEach(row => {

            const rowSearch =
                (row.dataset.search || "")
                    .toLowerCase()
                    .trim();

            const rowStatus =
                (row.dataset.status || "")
                    .trim();

            const matchKeyword =
                keyword === "" ||
                rowSearch.includes(keyword);

            const matchStatus =
                status === "" ||
                rowStatus === status;

            row.style.display =
                (matchKeyword && matchStatus)
                    ? ""
                    : "none";
        });
    }

    document.querySelectorAll('.modal-backdrop')
        .forEach(modal => {

            modal.addEventListener('click', function (e) {

                if (e.target === modal) {
                    modal.classList.remove('active');
                }

            });

        });

</script>

</body>
</html>