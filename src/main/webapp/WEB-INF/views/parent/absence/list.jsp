<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="activePage" value="absence" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Lịch sử xin nghỉ | TCMS Parent</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap">

    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0"/>

    <link rel="stylesheet" href="<c:url value='/css/student-dashboard.css' />">

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
            --text-main: #1e293b;
            --text-muted: #64748b;
            --card-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.04), 0 8px 10px -6px rgba(0, 0, 0, 0.04);
        }

        body {
            background-color: var(--bg-page);
            font-family: 'Plus Jakarta Sans', sans-serif;
            color: var(--text-main);
            margin: 0;
        }

        .main-content {
            transition: all 0.3s ease;
        }

        .page-content {
            padding: 2.5rem;
        }

        .page-header {
            margin-bottom: 2rem;
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
        }

        .header-left h1 {
            font-size: 1.875rem;
            font-weight: 800;
            color: #0f172a;
            letter-spacing: -0.025em;
            margin: 0;
        }

        .header-left p {
            color: var(--text-muted);
            margin-top: 0.5rem;
            font-size: 0.9375rem;
        }

        /* Summary Stats */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2.5rem;
        }

        .stat-card {
            background: #ffffff;
            padding: 1.5rem;
            border-radius: 1.25rem;
            border: 1px solid #f1f5f9;
            box-shadow: var(--card-shadow);
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .stat-icon {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
        }

        .icon-total { background: var(--primary-light); color: var(--primary); }
        .icon-pending { background: var(--warning-light); color: var(--warning); }
        .icon-approved { background: var(--success-light); color: var(--success); }
        .icon-rejected { background: var(--danger-light); color: var(--danger); }

        .stat-info h3 {
            font-size: 0.8125rem;
            color: var(--text-muted);
            font-weight: 600;
            margin: 0;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .stat-info .value {
            font-size: 1.5rem;
            font-weight: 800;
            color: #0f172a;
            margin-top: 0.25rem;
        }

        /* Table Design */
        .list-card {
            background: #ffffff;
            border-radius: 1.5rem;
            border: 1px solid #f1f5f9;
            box-shadow: var(--card-shadow);
            overflow: hidden;
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
            color: var(--text-muted);
            border-bottom: 1px solid #f1f5f9;
        }

        td {
            padding: 1.25rem 1.5rem;
            border-bottom: 1px solid #f1f5f9;
            vertical-align: middle;
        }

        .student-cell {
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
            color: var(--primary);
            font-weight: 700;
            font-size: 0.875rem;
        }

        .student-details h4 {
            font-size: 0.9375rem;
            font-weight: 700;
            margin: 0;
            color: #0f172a;
        }

        .student-details p {
            font-size: 0.8125rem;
            color: var(--text-muted);
            margin-top: 0.125rem;
        }

        .session-info h5 {
            font-size: 0.875rem;
            font-weight: 600;
            margin: 0;
            color: #334155;
        }

        .session-info p {
            font-size: 0.75rem;
            color: var(--text-muted);
            margin-top: 0.25rem;
        }

        .reason-text {
            font-size: 0.875rem;
            color: #475569;
            max-width: 300px;
            line-height: 1.5;
        }

        /* Status Badges */
        .badge {
            display: inline-flex;
            align-items: center;
            padding: 0.375rem 0.75rem;
            border-radius: 8px;
            font-size: 0.75rem;
            font-weight: 700;
            gap: 0.375rem;
        }

        .badge-pending { background: var(--warning-light); color: var(--warning); }
        .badge-approved { background: var(--success-light); color: var(--success); }
        .badge-rejected { background: var(--danger-light); color: var(--danger); }

        .rejection-reason {
            margin-top: 0.5rem;
            padding: 0.5rem 0.75rem;
            background: var(--danger-light);
            border-radius: 6px;
            font-size: 0.75rem;
            color: var(--danger);
            border-left: 3px solid var(--danger);
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
            color: var(--text-muted);
        }
    </style>
</head>
<body>

<jsp:include page="../common/sidebar.jsp" />

<div class="main-content">
    <jsp:include page="../common/header.jsp" />

    <div class="page-content">
        <header class="page-header">
            <div class="header-left">
                <h1>Lịch sử xin nghỉ</h1>
                <p>Theo dõi trạng thái các yêu cầu xin nghỉ đã gửi đến trung tâm.</p>
            </div>
        </header>

        <c:set var="total" value="0" />
        <c:set var="pending" value="0" />
        <c:set var="approved" value="0" />
        <c:set var="rejected" value="0" />
        <c:forEach var="r" items="${requests}">
            <c:set var="total" value="${total + 1}" />
            <c:if test="${r.status == 'PENDING'}"><c:set var="pending" value="${pending + 1}" /></c:if>
            <c:if test="${r.status == 'APPROVED'}"><c:set var="approved" value="${approved + 1}" /></c:if>
            <c:if test="${r.status == 'REJECTED'}"><c:set var="rejected" value="${rejected + 1}" /></c:if>
        </c:forEach>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon icon-total">
                    <span class="material-symbols-rounded">description</span>
                </div>
                <div class="stat-info">
                    <h3>Tổng số đơn</h3>
                    <div class="value">${total}</div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon icon-pending">
                    <span class="material-symbols-rounded">hourglass_empty</span>
                </div>
                <div class="stat-info">
                    <h3>Chờ duyệt</h3>
                    <div class="value">${pending}</div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon icon-approved">
                    <span class="material-symbols-rounded">check_circle</span>
                </div>
                <div class="stat-info">
                    <h3>Đã duyệt</h3>
                    <div class="value">${approved}</div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon icon-rejected">
                    <span class="material-symbols-rounded">cancel</span>
                </div>
                <div class="stat-info">
                    <h3>Từ chối</h3>
                    <div class="value">${rejected}</div>
                </div>
            </div>
        </div>

        <div class="list-card">
            <div class="table-responsive">
                <c:choose>
                    <c:when test="${not empty requests}">
                        <table>
                            <thead>
                            <tr>
                                <th>Học sinh</th>
                                <th>Buổi học</th>
                                <th>Lý do</th>
                                <th>Trạng thái</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="absence" items="${requests}">
                                <tr>
                                    <td>
                                        <div class="student-cell">
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
                                        <div class="session-info">
                                            <h5><c:out value="${absence.session.sessionDate}" /></h5>
                                            <p><c:out value="${absence.session.startTime}" /> - <c:out value="${absence.session.endTime}" /></p>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="reason-text">
                                            <c:out value="${absence.reason}" />
                                        </div>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${absence.status == 'PENDING'}">
                                                <span class="badge badge-pending">
                                                    <span class="material-symbols-rounded" style="font-size: 14px;">hourglass_bottom</span>
                                                    Chờ duyệt
                                                </span>
                                            </c:when>
                                            <c:when test="${absence.status == 'APPROVED'}">
                                                <span class="badge badge-approved">
                                                    <span class="material-symbols-rounded" style="font-size: 14px;">check_circle</span>
                                                    Chấp nhận
                                                </span>
                                            </c:when>
                                            <c:when test="${absence.status == 'REJECTED'}">
                                                <span class="badge badge-rejected">
                                                    <span class="material-symbols-rounded" style="font-size: 14px;">error</span>
                                                    Từ chối
                                                </span>
                                                <c:if test="${not empty absence.rejectionReason}">
                                                    <div class="rejection-reason" title="Lý do từ chối">
                                                        <i class="fa-solid fa-comment-dots" style="margin-right: 4px;"></i>
                                                        <c:out value="${absence.rejectionReason}" />
                                                    </div>
                                                </c:if>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <span class="material-symbols-rounded">history</span>
                            <h3>Bạn chưa gửi đơn xin nghỉ nào</h3>
                            <p>Các đơn xin nghỉ bạn gửi sẽ xuất hiện tại đây.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

</body>
</html>