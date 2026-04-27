<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết lớp học | TCMS</title>

    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0"/>
    <link rel="stylesheet" href="<c:url value='/css/core-dashboard.css' />">

    <style>
        .detail-page {
            display: flex;
            flex-direction: column;
            gap: 22px;
        }

        .breadcrumb {
            font-size: 13px;
            color: #64748b;
            margin-bottom: 8px;
        }

        .breadcrumb span {
            color: #0057bf;
            font-weight: 700;
        }

        .class-detail-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 20px;
        }

        .class-title-box h2 {
            margin: 20px;
            font-size: 26px;
            line-height: 32px;
            color: #0f172a;
            font-weight: 700;
        }

        .status-pill {
            display: inline-flex;
            align-items: center;
            justify-content: center;

            gap: 6px;
            padding: 7px 12px;
            border-radius: 999px;
            font-size: 12px;
            line-height: 16px;
            font-weight: 600;
            text-align: center;
            margin-left: 12px;
        }

        .status-pill.active {
            background: #dcfce7;
            color: #16a34a;
        }

        .status-pill.inactive {
            background: #fee2e2;
            color: #dc2626;
        }

        .header-actions {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            justify-content: flex-end;
        }

        .btn-soft,
        .btn-danger-soft {
            height: 40px;
            padding: 0 15px;
            border-radius: 10px;
            border: 1px solid #e2e8f0;
            background: #fff;
            font-size: 14px;
            LINE-HEIGHT: 20px;
            font-weight: 500;
            color: #334155;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 7px;
            text-decoration: none;
        }

        .btn-danger-soft {
            background: #fee2e2;
            color: #dc2626;
            border-color: #fecaca;
        }

        .top-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 22px;
        }

        .info-card {
            background: #fff;
            border-radius: 18px;
            padding: 24px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 8px 24px rgba(15, 23, 42, 0.04);
        }

        .card-title {
            margin: 0 0 20px;
            font-size: 18px;
            line-height: 28px;
            color: #0f172a;
            font-weight: 700;
        }

        .class-info-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 22px;
        }

        .info-label {
            font-size: 11px;
            text-transform: uppercase;
            color: #94a3b8;
            font-weight: 500;
            margin-bottom: 6px;
        }

        .info-value {
            font-size: 14px;
            line-height: 24px;
            color: #0f172a;
            font-weight: 600;
        }

        .info-value.primary {
            color: #0057bf;
        }

        .description-box {
            margin-top: 24px;
            font-size: 14px;
            color: #475569;
            line-height: 1.7;
        }

        .tutor-card {
            text-align: center;
        }

        .tutor-avatar {
            width: 92px;
            height: 92px;
            border-radius: 18px;
            object-fit: cover;
            border: 4px solid #eef6ff;
            box-shadow: 0 8px 20px rgba(15, 23, 42, 0.12);
        }

        .tutor-name {
            margin-top: 14px;
            font-size: 20px;
            font-weight: 700;
            line-height: 28px;
            color: #0f172a;
        }

        .tutor-major {
            color: #0057bf;
            font-size: 14px;
            line-hegiht: 20px;
            font-weight: 500;
            margin-bottom: 16px;
        }

        .tutor-line {
            display: flex;
            justify-content: space-between;
            gap: 12px;
            background: #f8fafc;
            border-radius: 10px;
            padding: 11px 12px;
            margin-bottom: 10px;
            font-size: 14px;
            font-weight: 500;
            line-height: 20px;
        }

        .tutor-line span:first-child {
            color: #64748b;
            font-weight: 500;
        }

        .tutor-line span:last-child {
            color: #0f172a;
            font-weight: 500;
        }

        .btn-dark {
            margin-top: 10px;
            width: 100%;
            height: 42px;
            border-radius: 11px;
            background: #0f172a;
            color: #fff;
            border: none;
            font-size: 14px;
            line-height: 20px;
            font-weight: 700;
            cursor: pointer;
        }

        .stats-grid-detail {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 18px;
        }

        .mini-stat {
            background: #fff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            padding: 18px;
            display: flex;
            gap: 14px;
            align-items: center;
            box-shadow: 0 8px 24px rgba(15, 23, 42, 0.04);
        }

        .mini-icon {
            width: 42px;
            height: 42px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #eff6ff;
            color: #2563eb;
        }

        .mini-stat-title {
            color: #64748b;
            font-size: 12px;
            font-weight: 500;
        }

        .mini-stat-value {
            margin-top: 4px;
            color: #0f172a;
            font-size: 24px;
            line-height: 32px;
            letter-spacing: 0;
            font-weight: 700;
        }

        .main-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 22px;
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 18px;
        }

        .section-header h3 {
            margin: 0;
            font-size: 18px;
            line-height: 28px;
            font-weight: 700;
            color: #0f172a;
        }

        .small-link {
            color: #0057bf;
            font-size: 12px;
            font-weight: 900;
            text-decoration: none;
            background: transparent;
            border: none;
            cursor: pointer;
        }

        .student-table,
        .session-table {
            width: 100%;
            border-collapse: collapse;
        }

        .student-table th,
        .student-table td,
        .session-table th,
        .session-table td {
            padding: 13px 10px;
            border-bottom: 1px solid #f1f5f9;
            text-align: left;
            font-size: 13px;
        }

        .student-table th,
        .session-table th {
            color: #64748b;
            font-size: 11px;
            text-transform: uppercase;
            font-weight: 500;
        }

        .student-cell {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .avatar-small {
            width: 34px;
            height: 34px;
            border-radius: 50%;
            background: #e0f2fe;
            color: #0369a1;
            font-weight: 900;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            flex: 0 0 auto;
        }

        .name-main {
            color: #0f172a;
            font-weight: 500;
        }

        .name-sub {
            color: #94a3b8;
            font-size: 11px;
            margin-top: 2px;
        }

        .badge {
            width: fit-content;
            padding: 5px 9px;
            border-radius: 999px;
            font-size: 10px;
            font-weight: 900;
            text-transform: uppercase;
        }

        .badge.green {
            background: #dcfce7;
            color: #16a34a;
        }

        .badge.orange {
            background: #ffedd5;
            color: #ea580c;
        }

        .badge.gray {
            background: #f1f5f9;
            color: #64748b;
        }

        .action-mini {
            border: none;
            background: transparent;
            color: #94a3b8;
            cursor: pointer;
            padding: 5px;
        }

        .schedule-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 14px;
            border-radius: 14px;
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            margin-bottom: 12px;
        }

        .day-chip {
            width: 42px;
            height: 42px;
            border-radius: 13px;
            background: #dbeafe;
            color: #2563eb;
            font-weight: 700;
            font-size: 18px;
            line-height: 22.5px;

            display: flex;
            align-items: center;
            justify-content: center;
            flex: 0 0 auto;
        }

        .schedule-main {
            flex: 1;
        }

        .schedule-time {
            font-weight: 700;
            color: #0f172a;
            font-size: 14px;
        }

        .schedule-note {
            color: #64748b;
            font-size: 12px;
            margin-top: 3px;
        }

        .schedule-actions {
            display: flex;
            gap: 4px;
        }

        .add-schedule-box {
            border: 1px dashed #cbd5e1;
            background: #f8fafc;
            border-radius: 14px;
            padding: 14px;
            margin-top: 12px;
        }

        .schedule-form {
            display: none;
            gap: 10px;
            margin-bottom: 14px;
            padding: 14px;
            background: #f8fafc;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
        }

        .schedule-form.show {
            display: flex;
            flex-wrap: wrap;
        }

        .form-group-mini {
            flex: 1;
            min-width: 120px;
            display: flex;
            flex-direction: column;
            gap: 5px;
        }

        .mini-input {
            width: 100%;
            height: 36px !important;
            font-size: 13px !important;
            padding: 0 10px !important;
            border-radius: 8px !important;
            border: 1px solid #dbe3ef !important;
        }

        .btn-blue-mini {
            height: 36px;
            padding: 0 16px;
            background: #0057bf;
            color: #fff;
            border: none;
            border-radius: 8px;
            font-weight: 800;
            font-size: 13px;
            cursor: pointer;
            align-self: flex-end;
        }

        .btn-blue {
            height: 38px;
            border: none;
            border-radius: 9px;
            background: #0057bf;
            color: #fff;
            font-size: 13px;          /* từ 14 → 13 */
            font-weight: 500;
            cursor: pointer;
        }

        .session-header-actions {
            display: flex;
            gap: 8px;
            align-items: center;
        }

        .generate-form {
            display: none;
            gap: 8px;
            margin-bottom: 14px;
            padding: 14px;
            background: #f8fafc;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
        }

        .generate-form.show {
            display: flex;
            flex-wrap: wrap;
        }

        @media (max-width: 1100px) {
            .top-grid,
            .main-grid {
                grid-template-columns: 1fr;
            }

            .stats-grid-detail,
            .class-info-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            align-items: center;
            justify-content: center;
        }

        .modal.show {
            display: flex;
        }

        .modal-content {
            background-color: #fff;
            padding: 24px;
            border-radius: 18px;
            width: 90%;
            max-width: 600px;
            max-height: 80vh;
            overflow-y: auto;
            position: relative;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .modal-header h3 {
            margin: 0;
            font-size: 18px;
            font-weight: 700;
            line-height: 28px;
        }

        .close-modal {
            background: none;
            border: none;
            font-size: 24px;
            cursor: pointer;
            color: #64748b;
        }

        .student-list-modal {
            margin-bottom: 20px;
        }

        .student-item-modal {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px;
            border-bottom: 1px solid #f1f5f9;
        }

        .student-item-modal:last-child {
            border-bottom: none;
        }

        .student-item-modal input[type="checkbox"] {
            width: 18px;
            height: 18px;
            cursor: pointer;
        }

        .modal-actions {
            display: flex;
            justify-content: flex-end;
            gap: 12px;
            margin-top: 20px;
            font-size: 14px;
            line-height: 20px;
            font-weight: 500;
        }
        .btn-soft {
            display: inline-flex;
            align-items: center;
            gap: 6px;

            padding: 6px 10px;        /* nhỏ lại */
            border-radius: 10px;

            font-family: 'Inter', sans-serif;
            font-size: 13px;          /* từ 14 → 13 */
            font-weight: 500;

            border: 1px solid #e2e8f0;
            background: #fff;
            color: #334155;

            cursor: pointer;
            transition: all 0.2s ease;
        }
        .btn-soft .material-symbols-rounded {
            font-size: 14px;   /* nhỏ lại */
            font-weight: 500;
        }
        .btn-soft:hover {
            background: #f8fafc;
            border-color: #cbd5e1;
        }
    </style>
</head>

<body>

<c:set var="activePage" value="classes" scope="request"/>

<jsp:include page="../common/sidebar.jsp"/>

<main class="main-content">
    <jsp:include page="../common/header.jsp"/>

    <div class="dashboard-body detail-page">

        <!-- HEADER -->
        <div>
            <div class="breadcrumb">
                Admin / Lớp học / <span>Chi tiết</span>
            </div>

            <div class="class-detail-header">
                <div class="class-title-box">
                    <h2>
                        ${empty classDetail.className ? 'Chi tiết lớp học' : classDetail.className}

                        <c:choose>
                            <c:when test="${classDetail.status}">
                                <span class="status-pill active">
                                    <span class="material-symbols-rounded" style="font-size:15px;">fiber_manual_record</span>
                                    Đang hoạt động
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="status-pill inactive">
                                    <span class="material-symbols-rounded" style="font-size:15px;">fiber_manual_record</span>
                                    Tạm dừng
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </h2>
                </div>

                <div class="header-actions">
                    <a class="btn-soft"
                       href="${pageContext.request.contextPath}/admin/classes/${classDetail.id}/edit">
                        <span class="material-symbols-rounded">edit</span>
                        Chỉnh sửa
                    </a>

                    <button type="button" class="btn-soft" onclick="openStudentModal()">
                        <span class="material-symbols-rounded">group_add</span>
                        Thêm học sinh
                    </button>

                    <button type="button"
                            class="${classDetail.status ? 'btn-danger-soft' : 'btn-soft'}"
                            onclick="pauseClass('${classDetail.id}')">
                        <c:choose>
                            <c:when test="${classDetail.status}">
                                <span class="material-symbols-rounded">stop_circle</span>
                                Dừng lớp
                            </c:when>
                            <c:otherwise>
                                <span class="material-symbols-rounded">play_circle</span>
                                Kích hoạt lại
                            </c:otherwise>
                        </c:choose>
                    </button>
                </div>
            </div>
        </div>

        <!-- STATS -->
        <section class="stats-grid-detail">
            <div class="mini-stat">
                <div class="mini-icon">
                    <span class="material-symbols-rounded">groups</span>
                </div>
                <div>
                    <div class="mini-stat-title">Tổng số học sinh</div>
                    <div class="mini-stat-value">
                        ${stats.totalStudents} / ${empty classDetail.maxStudents ? '--' : classDetail.maxStudents}
                    </div>
                </div>
            </div>

            <div class="mini-stat">
                <div class="mini-icon" style="background:#f3e8ff;color:#9333ea;">
                    <span class="material-symbols-rounded">history_edu</span>
                </div>
                <div>
                    <div class="mini-stat-title">Số buổi đã dạy</div>
                    <div class="mini-stat-value">${stats.taughtSessions}</div>
                </div>
            </div>

            <div class="mini-stat">
                <div class="mini-icon" style="background:#dcfce7;color:#16a34a;">
                    <span class="material-symbols-rounded">payments</span>
                </div>
                <div>
                    <div class="mini-stat-title">Số buổi đã thu</div>
                    <div class="mini-stat-value">${stats.paidSessions}</div>
                </div>
            </div>

            <div class="mini-stat">
                <div class="mini-icon" style="background:#fee2e2;color:#dc2626;">
                    <span class="material-symbols-rounded">event_busy</span>
                </div>
                <div>
                    <div class="mini-stat-title">Số buổi chưa thu</div>
                    <div class="mini-stat-value">${stats.unpaidSessions}</div>
                </div>
            </div>
        </section>

        <!-- CLASS INFO + TUTOR -->
        <section class="top-grid">
            <div class="info-card">
                <h3 class="card-title">Thông tin lớp học</h3>

                <div class="class-info-grid">
                    <div>
                        <div class="info-label">Mã lớp</div>
                        <div class="info-value primary">
                            ${empty classDetail.classCode ? classDetail.id : classDetail.classCode}
                        </div>
                    </div>

                    <div>
                        <div class="info-label">Môn học</div>
                        <div class="info-value">
                            ${empty classDetail.subject ? '---' : classDetail.subject}
                        </div>
                    </div>

                    <div>
                        <div class="info-label">Khối / Lớp</div>
                        <div class="info-value">
                            ${empty classDetail.grade ? '---' : classDetail.grade}
                        </div>
                    </div>

                    <div>
                        <div class="info-label">Học phí</div>
                        <div class="info-value primary">
                            <fmt:formatNumber value="${classDetail.tuitionFeePerSession}" type="number"/> VNĐ / buổi
                        </div>
                    </div>

                    <div>
                        <div class="info-label">Số buổi dự kiến</div>
                        <div class="info-value">
                            ${empty classDetail.requiredSessions ? '---' : classDetail.requiredSessions} buổi
                        </div>
                    </div>

                    <div>
                        <div class="info-label">Ngày bắt đầu</div>
                        <div class="info-value">
                            <c:choose>
                                <c:when test="${not empty classDetail.createdAt}">
                                    ${classDetail.createdAt}
                                </c:when>
                                <c:otherwise>---</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <div class="description-box">
                    <div class="info-label">Mô tả chương trình học</div>
                    ${empty classDetail.description ? 'Chưa cập nhật mô tả chương trình học.' : classDetail.description}
                </div>
            </div>

            <div class="info-card tutor-card">
                <h3 class="card-title" style="text-align:left;">Gia sư phụ trách</h3>

                <c:choose>
                    <c:when test="${not empty tutor}">
                        <c:choose>
                            <c:when test="${not empty tutor.avatar}">
                                <img class="tutor-avatar"
                                     src="${pageContext.request.contextPath}/uploads/${tutor.avatar}"
                                     onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/default-avatar.png'">
                            </c:when>
                            <c:otherwise>
                                <img class="tutor-avatar"
                                     src="${pageContext.request.contextPath}/images/default-avatar.png">
                            </c:otherwise>
                        </c:choose>

                        <div class="tutor-name">${tutor.fullName}</div>
                        <div class="tutor-major">${empty tutor.major ? 'Chưa cập nhật chuyên ngành' : tutor.major}</div>

                        <div class="tutor-line">
                            <span>Email</span>
                            <span>${empty tutor.email ? '---' : tutor.email}</span>
                        </div>

                        <div class="tutor-line">
                            <span>SĐT</span>
                            <span>${empty tutor.phone ? '---' : tutor.phone}</span>
                        </div>

                        <div class="tutor-line">
                            <span>Trường</span>
                            <span>${empty tutor.school ? '---' : tutor.school}</span>
                        </div>

                        <button type="button"
                                class="btn-dark"
                                onclick="location.href='${pageContext.request.contextPath}/admin/accounts/${tutor.user.id}/detail'">
                            Xem chi tiết hồ sơ
                        </button>
                    </c:when>

                    <c:otherwise>
                        <p style="color:#64748b;">Lớp học chưa được phân công gia sư.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>

        <!-- STUDENTS + WEEKLY SCHEDULE -->
        <section class="main-grid">
            <div class="info-card">
                <div class="section-header">
                    <h3>Danh sách học sinh</h3>
                    <button type="button" class="small-link" onclick="openStudentModal()">
                        + Thêm học sinh
                    </button>
                </div>

                <table class="student-table">
                    <thead>
                    <tr>
                        <th>Học sinh</th>
                        <th>Phụ huynh</th>
                        <th>Trường</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                    </thead>

                    <tbody>
                    <c:choose>
                        <c:when test="${not empty students}">
                            <c:forEach items="${students}" var="student">
                                <tr>
                                    <td>
                                        <div class="student-cell">
                                            <div class="avatar-small">
                                                    ${empty student.fullName ? '?' : fn:substring(student.fullName, 0, 1)}
                                            </div>
                                            <div>
                                                <div class="name-main">${student.fullName}</div>
                                                <div class="name-sub">MSHS: ${student.id}</div>
                                            </div>
                                        </div>
                                    </td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty student.parent}">
                                                <div class="name-main">${student.parent.fullName}</div>
                                                <div class="name-sub">${student.parent.phone}</div>
                                            </c:when>
                                            <c:otherwise>
                                                <span style="color:#dc2626;font-weight:800;">Chưa có phụ huynh</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td>${empty student.school ? '---' : student.school}</td>

                                    <td>
                                        <span class="badge green">Đang học</span>
                                    </td>

                                    <td>
                                        <c:if test="${not empty student.user}">
                                            <button class="action-mini"
                                                    title="Xem chi tiết"
                                                    onclick="location.href='${pageContext.request.contextPath}/admin/accounts/${student.user.id}/detail'">
                                                <span class="material-symbols-rounded">visibility</span>
                                            </button>
                                        </c:if>

                                        <button class="action-mini"
                                                title="Xóa khỏi lớp"
                                                onclick="removeStudent('${classDetail.id}', '${student.id}')">
                                            <span class="material-symbols-rounded">delete</span>
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>

                        <c:otherwise>
                            <tr>
                                <td colspan="5" style="text-align:center;color:#64748b;padding:30px;">
                                    Chưa có học sinh trong lớp.
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>

            <div class="info-card">
                <div class="section-header">
                    <h3>Lịch học hàng tuần</h3>
                    <button class="small-link" type="button" onclick="toggleScheduleForm()">
                        + Thêm lịch
                    </button>
                </div>

                <c:choose>
                    <c:when test="${not empty schedules}">
                        <c:forEach items="${schedules}" var="schedule">
                            <div class="schedule-item">
                                <div class="day-chip">
                                    T${schedule.weekday}
                                </div>

                                <div class="schedule-main">
                                    <div class="schedule-time">
                                            ${schedule.startTime} - ${schedule.endTime}
                                    </div>
                                    <div class="schedule-note">Lịch học định kỳ</div>
                                </div>

                                <div class="schedule-actions">
                                    <button class="action-mini"
                                            onclick="editSchedule('${schedule.id}')">
                                        <span class="material-symbols-rounded">edit</span>
                                    </button>

                                    <button class="action-mini"
                                            onclick="deleteSchedule('${schedule.id}')">
                                        <span class="material-symbols-rounded">delete</span>
                                    </button>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>

                    <c:otherwise>
                        <p style="color:#64748b;">Chưa có lịch học hàng tuần.</p>
                    </c:otherwise>
                </c:choose>

                <form id="scheduleForm" class="schedule-form" onsubmit="addSchedule(event)">
                    <div class="form-group-mini">
                        <label style="font-size: 11px; text-transform: uppercase; color: #64748b; font-weight: 900;">Thứ</label>
                        <select id="weekday" class="mini-input" required>
                            <option value="2">Thứ 2</option>
                            <option value="3">Thứ 3</option>
                            <option value="4">Thứ 4</option>
                            <option value="5">Thứ 5</option>
                            <option value="6">Thứ 6</option>
                            <option value="7">Thứ 7</option>
                            <option value="1">Chủ Nhật</option>
                        </select>
                    </div>
                    <div class="form-group-mini">
                        <label style="font-size: 11px; text-transform: uppercase; color: #64748b; font-weight: 900;">Bắt đầu</label>
                        <input type="time" id="startTime" class="mini-input" required>
                    </div>
                    <div class="form-group-mini">
                        <label style="font-size: 11px; text-transform: uppercase; color: #64748b; font-weight: 900;">Kết thúc</label>
                        <input type="time" id="endTime" class="mini-input" required>
                    </div>
                    <button type="submit" class="btn-blue-mini">Lưu lịch</button>
                </form>
            </div>
        </section>

        <!-- SESSIONS -->
        <section class="info-card">
            <div class="section-header">
                <h3>Buổi học gần đây</h3>

                <div class="session-header-actions">
                    <button class="btn-soft" type="button" onclick="toggleGenerateForm()">
                        <span class="material-symbols-rounded">auto_awesome</span>
                        Sinh lịch tự động
                    </button>
                </div>
            </div>

            <form id="generateForm" class="generate-form" onsubmit="generateSessions(event)">
                <input type="date" id="generateStartDate" required>
                <input type="date" id="generateEndDate" required>
                <button class="btn-blue" type="submit">Sinh buổi học</button>
            </form>

            <table class="session-table">
                <thead>
                <tr>
                    <th>Ngày giờ</th>
                    <th>Chủ đề bài học</th>
                    <th>Tình trạng</th>
                    <th>Tài liệu</th>
                </tr>
                </thead>

                <tbody>
                <c:choose>
                    <c:when test="${not empty sessions}">
                        <c:forEach items="${sessions}" var="ss">
                            <tr>
                                <td>
                                    <div class="name-main">${ss.sessionDate}</div>
                                    <div class="name-sub">${ss.startTime} - ${ss.endTime}</div>
                                </td>

                                <td>
                                        ${empty ss.topic ? 'Đang cập nhật' : ss.topic}
                                </td>

                                <td>
                                    <c:choose>
                                        <c:when test="${ss.status == 'COMPLETED'}">
                                            <span class="badge green">Xong</span>
                                        </c:when>
                                        <c:when test="${ss.status == 'ONGOING'}">
                                            <span class="badge orange">Đang diễn ra</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge gray">Chưa học</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td>
                                    <button class="action-mini"
                                            title="Feedback">
                                        <span class="material-symbols-rounded">rate_review</span>
                                    </button>

                                    <button class="action-mini"
                                            title="Tài liệu">
                                        <span class="material-symbols-rounded">folder_open</span>
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>

                    <c:otherwise>
                        <tr>
                            <td colspan="4" style="text-align:center;color:#64748b;padding:30px;">
                                Chưa có buổi học. Bấm “Sinh lịch tự động” để tạo buổi học theo lịch hàng tuần.
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </section>

    </div>
</main>

    <!-- STUDENT MODAL -->
    <div id="studentModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>Thêm học sinh vào lớp</h3>
                <button type="button" class="close-modal" onclick="closeStudentModal()">&times;</button>
            </div>
            
            <div class="student-list-modal">
                <c:forEach items="${allStudents}" var="st">
                    <c:set var="isEnrolled" value="false" />
                    <c:forEach items="${students}" var="enrolled">
                        <c:if test="${enrolled.id == st.id}">
                            <c:set var="isEnrolled" value="true" />
                        </c:if>
                    </c:forEach>
                    
                    <c:if test="${!isEnrolled}">
                        <div class="student-item-modal">
                            <input type="checkbox" name="selectedStudents" value="${st.id}" id="st_${st.id}">
                            <label for="st_${st.id}" style="cursor:pointer; display:flex; align-items:center; gap:10px;">
                                <div class="avatar-small">
                                    ${empty st.fullName ? '?' : fn:substring(st.fullName, 0, 1)}
                                </div>
                                <div>
                                    <div class="name-main">${st.fullName}</div>
                                    <div class="name-sub">MSHS: ${st.id} | ${st.school}</div>
                                </div>
                            </label>
                        </div>
                    </c:if>
                </c:forEach>
                
                <c:if test="${empty allStudents}">
                    <p style="text-align:center; color:#64748b; padding:20px;">Không có học sinh khả dụng.</p>
                </c:if>
            </div>

            <div class="modal-actions">
                <button type="button" class="btn-soft" onclick="closeStudentModal()">Hủy</button>
                <button type="button" class="btn-blue" onclick="addSelectedStudents()">Thêm vào lớp</button>
            </div>
        </div>
    </div>

<script>
    const contextPath = '${pageContext.request.contextPath}';
    const classId = '${classDetail.id}';

    function openStudentModal() {
        document.getElementById('studentModal').classList.add('show');
    }

    function closeStudentModal() {
        document.getElementById('studentModal').classList.remove('show');
    }

    async function addSelectedStudents() {
        const checkboxes = document.querySelectorAll('input[name="selectedStudents"]:checked');
        const studentIds = Array.from(checkboxes).map(cb => Number(cb.value));

        if (studentIds.length === 0) {
            alert('Vui lòng chọn ít nhất một học sinh');
            return;
        }

        const res = await fetch(contextPath + '/api/admin/classes/' + classId + '/students', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify({ studentIds: studentIds })
        });

        if (res.ok) {
            alert('Đã thêm học sinh thành công');
            location.reload();
        } else {
            alert('Thêm học sinh thất bại');
        }
    }

    function toggleScheduleForm() {
        document.getElementById('scheduleForm').classList.toggle('show');
    }

    function toggleGenerateForm() {
        document.getElementById('generateForm').classList.toggle('show');
    }

    async function addSchedule(event) {
        event.preventDefault();

        const data = {
            weekday: Number(document.getElementById('weekday').value),
            startTime: document.getElementById('startTime').value,
            endTime: document.getElementById('endTime').value
        };

        const res = await fetch(contextPath + '/api/admin/classes/' + classId + '/schedule', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify(data)
        });

        if (res.ok) {
            alert('Thêm lịch học thành công');
            location.reload();
        } else {
            alert('Thêm lịch học thất bại');
        }
    }

    async function deleteSchedule(scheduleId) {
        if (!confirm('Bạn có chắc muốn xóa lịch học này?')) return;

        const res = await fetch(contextPath + '/api/admin/classes/' + classId + '/schedule/' + scheduleId, {
            method: 'DELETE'
        });

        if (res.ok) {
            alert('Đã xóa lịch học');
            location.reload();
        } else {
            alert('Xóa lịch học thất bại');
        }
    }

    function editSchedule(scheduleId) {
        location.href = contextPath + '/admin/classes/' + classId + '/schedule/' + scheduleId + '/edit';
    }

    async function generateSessions(event) {
        event.preventDefault();

        const data = {
            startDate: document.getElementById('generateStartDate').value,
            endDate: document.getElementById('generateEndDate').value
        };

        const res = await fetch(contextPath + '/api/admin/classes/' + classId + '/sessions/generate', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify(data)
        });

        if (res.ok) {
            alert('Sinh lịch tự động thành công');
            location.reload();
        } else {
            alert('Sinh lịch tự động thất bại');
        }
    }

    async function removeStudent(classId, studentId) {
        if (!confirm('Bạn có chắc muốn xóa học sinh khỏi lớp này?')) return;

        const res = await fetch(contextPath + '/api/admin/classes/' + classId + '/students/' + studentId, {
            method: 'DELETE'
        });

        if (res.ok) {
            alert('Đã xóa học sinh khỏi lớp');
            location.reload();
        } else {
            alert('Xóa học sinh thất bại');
        }
    }

    async function pauseClass(classId) {
        const label = ${classDetail.status == true} ? 'dừng' : 'kích hoạt lại';
        if (!confirm('Bạn có chắc muốn ' + label + ' lớp này?')) return;

        const form = document.createElement('form');
        form.method = 'POST';
        form.action = contextPath + '/admin/classes/' + classId + '/toggle-status';
        document.body.appendChild(form);
        form.submit();
    }
</script>

</body>
</html>