<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="activePage" value="absence" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Duyệt đơn xin nghỉ | TCMS Admin</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0"/>

    <link rel="stylesheet" href="<c:url value='/css/core-dashboard.css' />">

    <style>
        :root {
            --primary: #4f46e5;
            --primary-light: #eef2ff;
            --success: #10b981;
            --success-light: #ecfdf5;
            --danger: #ef4444;
            --danger-light: #fef2f2;
            --warning: #f59e0b;
            --warning-light: #fffbeb;
            --bg-page: #f8fafc;
            --card-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.04), 0 8px 10px -6px rgba(0, 0, 0, 0.04);
        }

        body {
            background-color: var(--bg-page);
            font-family: 'Plus Jakarta Sans', sans-serif;
            color: #1e293b;
        }

        .main-content {
            transition: all 0.3s ease;
        }

        .page-header {
            margin-bottom: 2rem;
        }

        .page-header h1 {
            font-size: 1.875rem;
            font-weight: 800;
            color: #0f172a;
            letter-spacing: -0.025em;
        }

        .page-header p {
            color: #64748b;
            margin-top: 0.5rem;
        }

        /* Summary Cards */
        .summary-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .summary-card {
            background: #ffffff;
            padding: 1.5rem;
            border-radius: 1.25rem;
            border: 1px solid #f1f5f9;
            box-shadow: var(--card-shadow);
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .card-icon {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
        }

        .icon-pending { background: var(--warning-light); color: var(--warning); }
        .icon-approved { background: var(--success-light); color: var(--success); }

        .card-info h3 {
            font-size: 0.875rem;
            color: #64748b;
            font-weight: 600;
            margin: 0;
        }

        .card-info .count {
            font-size: 1.5rem;
            font-weight: 800;
            color: #0f172a;
            margin-top: 0.25rem;
        }

        /* Table Card */
        .absence-table-card {
            background: #ffffff;
            border-radius: 1.25rem;
            border: 1px solid #f1f5f9;
            box-shadow: var(--card-shadow);
            overflow: hidden;
        }

        .table-header {
            padding: 1.5rem;
            border-bottom: 1px solid #f1f5f9;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .table-header h2 {
            font-size: 1.125rem;
            font-weight: 700;
        }

        .table-responsive {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background: #f8fafc;
            padding: 1rem 1.5rem;
            text-align: left;
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            color: #64748b;
        }

        td {
            padding: 1.25rem 1.5rem;
            border-bottom: 1px solid #f1f5f9;
            vertical-align: middle;
        }

        .student-info {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .student-avatar {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            background: #f1f5f9;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #4f46e5;
            font-weight: 700;
        }

        .student-details h4 {
            font-size: 0.9375rem;
            font-weight: 700;
            margin: 0;
        }

        .student-details p {
            font-size: 0.8125rem;
            color: #64748b;
            margin-top: 0.125rem;
        }

        .session-badge {
            display: inline-flex;
            align-items: center;
            padding: 0.25rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 600;
            background: var(--primary-light);
            color: var(--primary);
        }

        .reason-box {
            max-width: 300px;
            font-size: 0.875rem;
            line-height: 1.5;
            color: #475569;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .action-group {
            display: flex;
            gap: 0.5rem;
        }

        .btn {
            height: 38px;
            padding: 0 1rem;
            border-radius: 10px;
            font-size: 0.875rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            cursor: pointer;
            border: none;
            transition: all 0.2s;
        }

        .btn-approve {
            background-color: var(--success);
            color: white;
        }

        .btn-approve:hover {
            background-color: #059669;
            transform: translateY(-2px);
        }

        .btn-reject-modal {
            background-color: var(--danger-light);
            color: var(--danger);
        }

        .btn-reject-modal:hover {
            background-color: var(--danger);
            color: white;
            transform: translateY(-2px);
        }

        /* Modal styling */
        .modal {
            display: none;
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(15, 23, 42, 0.6);
            backdrop-filter: blur(4px);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }

        .modal.active { display: flex; }

        .modal-content {
            background: white;
            width: 100%;
            max-width: 450px;
            border-radius: 1.5rem;
            padding: 2rem;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            animation: modalIn 0.3s ease-out;
        }

        @keyframes modalIn {
            from { transform: translateY(20px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        .modal-header {
            margin-bottom: 1.5rem;
        }

        .modal-header h3 {
            font-size: 1.25rem;
            font-weight: 800;
            color: #0f172a;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            font-size: 0.875rem;
            font-weight: 700;
            color: #475569;
            margin-bottom: 0.5rem;
        }

        .form-control {
            width: 100%;
            padding: 0.75rem 1rem;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
            font-family: inherit;
            resize: none;
            transition: all 0.2s;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px var(--primary-light);
        }

        .modal-footer {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
        }

        .btn-ghost {
            background: #f1f5f9;
            color: #64748b;
        }

        .empty-state {
            padding: 5rem 2rem;
            text-align: center;
        }

        .empty-state i {
            font-size: 4rem;
            color: #e2e8f0;
            margin-bottom: 1.5rem;
        }

        .empty-state h3 {
            font-size: 1.25rem;
            color: #64748b;
        }
    </style>
</head>
<body>

<jsp:include page="../common/sidebar.jsp" />

<div class="main-content">
    <jsp:include page="../common/header.jsp" />

    <div style="padding: 2.5rem;">
        <header class="page-header">
            <h1>Duyệt đơn xin nghỉ</h1>
            <p>Quản lý và phê duyệt các yêu cầu nghỉ học từ học sinh & phụ huynh.</p>
        </header>

        <div class="summary-grid">
            <div class="summary-card">
                <div class="card-icon icon-pending">
                    <span class="material-symbols-rounded">pending_actions</span>
                </div>
                <div class="card-info">
                    <h3>Chờ xử lý</h3>
                    <div class="count">${fn:length(requests)}</div>
                </div>
            </div>
            <div class="summary-card">
                <div class="card-icon icon-approved">
                    <span class="material-symbols-rounded">check_circle</span>
                </div>
                <div class="card-info">
                    <h3>Hệ thống ổn định</h3>
                    <div class="count">100%</div>
                </div>
            </div>
        </div>

        <div class="absence-table-card">
            <div class="table-header">
                <h2>Danh sách đơn chờ duyệt</h2>
            </div>

            <div class="table-responsive">
                <c:choose>
                    <c:when test="${not empty requests}">
                        <table>
                            <thead>
                            <tr>
                                <th>Học sinh & Lớp</th>
                                <th>Buổi học</th>
                                <th>Lý do</th>
                                <th>Thao tác</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="absence" items="${requests}">
                                <tr>
                                    <td>
                                        <div class="student-info">
                                            <div class="student-avatar">
                                                ${fn:substring(absence.student.fullName, 0, 1)}
                                            </div>
                                            <div class="student-details">
                                                <h4><c:out value="${absence.student.fullName}" /></h4>
                                                <p><c:out value="${absence.session.classEntity.className}" /></p>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="session-badge">
                                            <i class="fa-regular fa-calendar-check" style="margin-right: 6px;"></i>
                                            <c:out value="${absence.session.sessionDate}" />
                                        </div>
                                        <div style="font-size: 0.75rem; color: #94a3b8; margin-top: 4px; padding-left: 4px;">
                                            <c:out value="${absence.session.startTime}" /> - <c:out value="${absence.session.endTime}" />
                                        </div>
                                    </td>
                                    <td>
                                        <div class="reason-box" title="${absence.reason}">
                                            <c:out value="${absence.reason}" />
                                        </div>
                                    </td>
                                    <td>
                                        <div class="action-group">
                                            <form action="${pageContext.request.contextPath}/admin/absence/approve" method="post" style="margin:0">
                                                <input type="hidden" name="requestId" value="${absence.requestId}">
                                                <button type="submit" class="btn btn-approve">
                                                    <span class="material-symbols-rounded" style="font-size: 18px;">check</span>
                                                    Duyệt
                                                </button>
                                            </form>
                                            <button type="button" class="btn btn-reject-modal" 
                                                    onclick="openRejectModal('${absence.requestId}', '${absence.student.fullName}')">
                                                <span class="material-symbols-rounded" style="font-size: 18px;">close</span>
                                                Từ chối
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <span class="material-symbols-rounded">check_circle</span>
                            <h3>Không có đơn xin nghỉ nào cần duyệt</h3>
                            <p>Tất cả các yêu cầu đã được xử lý xong.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<!-- Reject Modal -->
<div id="rejectModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3>Từ chối đơn xin nghỉ</h3>
            <p id="studentDisplay" style="color: #64748b; font-size: 0.875rem; margin-top: 4px; font-weight: 500;"></p>
        </div>
        <form action="${pageContext.request.contextPath}/admin/absence/reject" method="post">
            <input type="hidden" name="requestId" id="rejectRequestId">
            <div class="form-group">
                <label for="rejectReason">Lý do từ chối</label>
                <textarea id="rejectReason" name="reason" class="form-control" rows="4" 
                          placeholder="Nhập lý do gửi đến phụ huynh..." required></textarea>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-ghost" onclick="closeRejectModal()">Hủy bỏ</button>
                <button type="submit" class="btn" style="background: var(--danger); color: white;">Xác nhận từ chối</button>
            </div>
        </form>
    </div>
</div>

<script>
    function openRejectModal(id, name) {
        document.getElementById('rejectRequestId').value = id;
        document.getElementById('studentDisplay').innerText = 'Học sinh: ' + name;
        document.getElementById('rejectModal').classList.add('active');
    }

    function closeRejectModal() {
        document.getElementById('rejectModal').classList.remove('active');
    }

    // Close modal when clicking outside
    window.onclick = function(event) {
        const modal = document.getElementById('rejectModal');
        if (event.target === modal) {
            closeRejectModal();
        }
    }
</script>

</body>
</html>