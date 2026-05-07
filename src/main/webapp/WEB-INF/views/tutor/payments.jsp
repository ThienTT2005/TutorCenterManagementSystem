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
            font-size: 26px;
            font-weight: 900;
            margin: 0 0 6px;
            color: var(--text-dark);
        }

        .page-head p {
            margin: 0;
            color: var(--text-muted);
            font-size: 13px;
            font-weight: 600;
        }

        .btn-primary {
            min-height: 40px;
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
            padding: 16px;
            display: flex;
            gap: 12px;
            border-bottom: 1px solid var(--border-color);
        }

        .search-input,
        .filter-select {
            height: 40px;
            border: 1px solid var(--border-color);
            border-radius: 10px;
            padding: 0 14px;
            font-size: 13px;
            font-weight: 600;
            outline: none;
        }

        .search-input {
            flex: 1;
        }

        .filter-select {
            width: 190px;
        }

        .payment-table {
            width: 100%;
            border-collapse: collapse;
        }

        .payment-table th {
            background: #f8fafc;
            color: #94a3b8;
            font-size: 11px;
            font-weight: 900;
            text-align: left;
            padding: 16px;
            text-transform: uppercase;
            letter-spacing: .4px;
        }

        .payment-table td {
            padding: 18px 16px;
            border-bottom: 1px solid #f1f5f9;
            color: #0f172a;
            font-size: 13px;
            font-weight: 700;
            vertical-align: middle;
        }

        .payment-id {
            color: var(--primary);
            font-weight: 900;
        }

        .status-pill {
            display: inline-flex;
            align-items: center;
            padding: 5px 10px;
            border-radius: 999px;
            font-size: 10px;
            font-weight: 900;
            text-transform: uppercase;
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
            background: #f3e8ff;
            color: #7c3aed;
        }

        .st-approved {
            background: #ecfeff;
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

        .action-btn {
            border: none;
            background: transparent;
            color: var(--primary);
            font-size: 13px;
            font-weight: 900;
            cursor: pointer;
            padding: 6px 8px;
        }

        .action-danger {
            color: var(--danger);
        }

        .empty-row {
            text-align: center;
            padding: 40px !important;
            color: var(--text-muted) !important;
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
    </style>
</head>

<body>

<jsp:include page="common/sidebar.jsp" />

<main class="main-content">
    <jsp:include page="common/header.jsp" />

    <section class="payment-page">

        <div class="page-head">
            <div>
                <h1>Quản lý thanh toán</h1>
                <p>Theo dõi yêu cầu thanh toán và trạng thái xử lý trong hệ thống.</p>
            </div>

            <button type="button" class="btn-primary" onclick="openCreateModal()">
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

        <c:set var="total" value="0" />
        <c:set var="pending" value="0" />
        <c:set var="proof" value="0" />
        <c:set var="rejected" value="0" />

        <c:forEach var="p" items="${payments}">
            <c:set var="total" value="${total + 1}" />
            <c:if test="${p.status == 'PENDING'}">
                <c:set var="pending" value="${pending + 1}" />
            </c:if>
            <c:if test="${p.status == 'PROOF_UPLOADED'}">
                <c:set var="proof" value="${proof + 1}" />
            </c:if>
            <c:if test="${p.status == 'REJECTED'}">
                <c:set var="rejected" value="${rejected + 1}" />
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
                       placeholder="Tìm mã GD, gia sư, phụ huynh, học sinh, lớp học..."
                       onkeyup="filterPayments()">

                <select class="filter-select" id="statusFilter" onchange="filterPayments()">
                    <option value="">Trạng thái</option>
                    <option value="PENDING">Chờ thanh toán</option>
                    <option value="PROOF_UPLOADED">Đã gửi minh chứng</option>
                    <option value="TUTOR_CONFIRMED">Chờ admin duyệt</option>
                    <option value="ADMIN_APPROVED">Đã duyệt</option>
                    <option value="COMPLETED">Hoàn tất</option>
                    <option value="REJECTED">Từ chối</option>
                </select>
            </div>

            <table class="payment-table">
                <thead>
                <tr>
                    <th>Payment ID</th>
                    <th>Học sinh</th>
                    <th>Lớp</th>
                    <th>Tổng buổi</th>
                    <th>Số tiền</th>
                    <th>Ngày tạo</th>
                    <th>Trạng thái</th>
                    <th>Thao tác</th>
                </tr>
                </thead>

                <tbody>
                <c:choose>
                    <c:when test="${not empty payments}">
                        <c:forEach var="payment" items="${payments}">
                            <tr class="payment-row"
                                data-status="${payment.status}"
                                data-search="
                                    ${payment.paymentId}
                                    ${payment.student.fullName}
                                    ${payment.classEntity.className}
                                    ${payment.amount}
                                    ${payment.status}
                                ">

                                <td>
                                    <span class="payment-id">
                                        #PYM-${payment.paymentId}
                                    </span>
                                </td>

                                <td>
                                    <c:out value="${empty payment.student.fullName ? 'Học sinh' : payment.student.fullName}" />
                                </td>

                                <td>
                                    <c:out value="${empty payment.classEntity.className ? 'Lớp học' : payment.classEntity.className}" />
                                </td>

                                <td>
                                    <c:out value="${empty payment.totalSessions ? 0 : payment.totalSessions}" />
                                </td>

                                <td>
                                    <strong>
                                        <fmt:formatNumber value="${payment.amount}" pattern="#,###" />đ
                                    </strong>
                                </td>

                                <td>
                                    <c:out value="${payment.requestDate}" />
                                </td>

                                <td>
                                    <c:choose>
                                        <c:when test="${payment.status == 'PENDING'}">
                                            <span class="status-pill st-pending">Chờ thanh toán</span>
                                        </c:when>

                                        <c:when test="${payment.status == 'PROOF_UPLOADED'}">
                                            <span class="status-pill st-proof">Đã gửi minh chứng</span>
                                        </c:when>

                                        <c:when test="${payment.status == 'TUTOR_CONFIRMED'}">
                                            <span class="status-pill st-admin">Chờ admin duyệt</span>
                                        </c:when>

                                        <c:when test="${payment.status == 'ADMIN_APPROVED'}">
                                            <span class="status-pill st-approved">Đã duyệt</span>
                                        </c:when>

                                        <c:when test="${payment.status == 'COMPLETED'}">
                                            <span class="status-pill st-completed">Hoàn tất</span>
                                        </c:when>

                                        <c:when test="${payment.status == 'REJECTED'}">
                                            <span class="status-pill st-rejected">Từ chối</span>
                                        </c:when>

                                        <c:otherwise>
                                            <span class="status-pill">${payment.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td>
                                    <c:choose>

                                        <c:when test="${payment.status == 'PROOF_UPLOADED'}">
                                            <button type="button"
                                                    class="action-btn"
                                                    onclick="openProofModal('${payment.proofUrl}')">
                                                Xem minh chứng
                                            </button>

                                            <form action="${pageContext.request.contextPath}/payment/tutor-confirm"
                                                  method="post"
                                                  style="display:inline;">
                                                <input type="hidden" name="paymentId" value="${payment.paymentId}">
                                                <button type="submit" class="action-btn">
                                                    Xác nhận nhận tiền
                                                </button>
                                            </form>
                                        </c:when>

                                        <c:when test="${payment.status == 'COMPLETED'}">
                                            <button type="button"
                                                    class="action-btn"
                                                    onclick="openProofModal('${payment.proofUrl}')">
                                                Xem minh chứng
                                            </button>
                                        </c:when>

                                        <c:when test="${payment.status == 'REJECTED'}">
                                            <button type="button"
                                                    class="action-btn action-danger"
                                                    onclick="openRejectModal('${payment.rejectionReason}')">
                                                Lý do từ chối
                                            </button>
                                        </c:when>

                                        <c:when test="${payment.status == 'TUTOR_CONFIRMED'}">
                                            <span style="color:#94a3b8;font-size:12px;font-weight:800;">
                                                Đang chờ admin duyệt
                                            </span>
                                        </c:when>

                                        <c:when test="${payment.status == 'PENDING'}">
                                            <span style="color:#94a3b8;font-size:12px;font-weight:800;">
                                                Chờ phụ huynh thanh toán
                                            </span>
                                        </c:when>

                                        <c:otherwise>
                                            <span style="color:#94a3b8;">---</span>
                                        </c:otherwise>

                                    </c:choose>
                                </td>

                            </tr>
                        </c:forEach>
                    </c:when>

                    <c:otherwise>
                        <tr>
                            <td colspan="8" class="empty-row">
                                Chưa có yêu cầu thanh toán nào.
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>

    </section>
</main>

<div class="modal-backdrop" id="createPaymentModal">
    <div class="modal-box">
        <h2>Tạo yêu cầu thanh toán</h2>
        <p>Vui lòng cung cấp chi tiết buổi học và thông tin học sinh để gửi yêu cầu thanh toán tới phụ huynh.</p>

        <form action="${pageContext.request.contextPath}/payment/create" method="post">

            <div class="form-group">
                <label>Chọn lớp học</label>
                <select name="classId" class="form-control" required>
                    <option value="">Vui lòng chọn lớp học...</option>
                    <c:forEach var="clazz" items="${classes}">
                        <option value="${clazz.classId}">
                            <c:out value="${clazz.className}" />
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-group">
                <label>Chọn học sinh</label>

                <select name="studentId"
                        id="studentSelect"
                        class="form-control"
                        required>

                    <option value="">Chọn học sinh từ danh sách lớp...</option>

                    <c:forEach var="enrollment" items="${students}">
                        <c:if test="${not empty enrollment.student}">
                            <option value="${enrollment.student.studentId}">
                                <c:out value="${enrollment.student.fullName}" />
                            </option>
                        </c:if>
                    </c:forEach>

                </select>
            </div>

            <div class="form-group">
                <label>Ghi chú</label>
                <textarea name="note"
                          class="form-control"
                          placeholder="Nhập chi tiết buổi dạy, bài tập đã giao hoặc các lưu ý đặc biệt về học phí..."></textarea>
            </div>

            <div class="modal-actions">
                <button type="button" class="btn-cancel" onclick="closeCreateModal()">Hủy</button>
                <button type="submit" class="btn-primary">Gửi yêu cầu</button>
            </div>

        </form>
    </div>
</div>

<div class="modal-backdrop" id="proofModal">
    <div class="modal-box">
        <h2>Minh chứng thanh toán</h2>
        <p>Phụ huynh đã gửi minh chứng thanh toán cho yêu cầu này.</p>

        <a id="proofLink"
           class="proof-link"
           href="#"
           target="_blank">
            <i class="fa-solid fa-arrow-up-right-from-square"></i>
            Mở minh chứng
        </a>

        <div class="modal-actions">
            <button type="button" class="btn-cancel" onclick="closeProofModal()">Đóng</button>
        </div>
    </div>
</div>

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
        document.getElementById('createPaymentModal').classList.add('active');
    }

    function closeCreateModal() {
        document.getElementById('createPaymentModal').classList.remove('active');
    }

    function openProofModal(url) {
        if (!url || url === 'null' || url.trim() === '') {
            alert('Chưa có minh chứng thanh toán.');
            return;
        }

        document.getElementById('proofLink').href = url;
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
        const keyword = document.getElementById('paymentSearch').value.toLowerCase();
        const status = document.getElementById('statusFilter').value;
        const rows = document.querySelectorAll('.payment-row');

        rows.forEach(row => {
            const rowSearch = row.dataset.search.toLowerCase();
            const rowStatus = row.dataset.status;

            const matchKeyword = rowSearch.includes(keyword);
            const matchStatus = !status || rowStatus === status;

            row.style.display = matchKeyword && matchStatus ? '' : 'none';
        });
    }

    document.querySelectorAll('.modal-backdrop').forEach(modal => {
        modal.addEventListener('click', function (e) {
            if (e.target === modal) {
                modal.classList.remove('active');
            }
        });
    });
</script>

</body>
</html>