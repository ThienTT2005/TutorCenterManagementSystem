<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="activePage" value="classes" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết lớp học | TCMS Admin</title>

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
            margin: 0;
            font-size: 26px;
            line-height: 32px;
            color: #0f172a;
            font-weight: 800;
        }

        .status-pill {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 7px 12px;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 800;
            margin-left: 12px;
            vertical-align: middle;
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

        .btn-soft {
            min-height: 40px;
            padding: 0 15px;
            border-radius: 10px;
            border: 1px solid #e2e8f0;
            background: #fff;
            font-size: 14px;
            font-weight: 700;
            color: #334155;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 7px;
            text-decoration: none;
        }

        .btn-soft:hover {
            background: #f8fafc;
            border-color: #cbd5e1;
        }

        .top-grid,
        .main-grid {
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
            font-weight: 800;
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
            font-weight: 800;
            margin-bottom: 6px;
        }

        .info-value {
            font-size: 14px;
            line-height: 24px;
            color: #0f172a;
            font-weight: 700;
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
            font-weight: 800;
            color: #0f172a;
        }

        .tutor-major {
            color: #0057bf;
            font-size: 14px;
            font-weight: 700;
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
        }

        .tutor-line span:first-child {
            color: #64748b;
            font-weight: 700;
        }

        .tutor-line span:last-child {
            color: #0f172a;
            font-weight: 700;
            text-align: right;
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
            flex-shrink: 0;
        }

        .mini-stat-title {
            color: #64748b;
            font-size: 12px;
            font-weight: 700;
        }

        .mini-stat-value {
            margin-top: 4px;
            color: #0f172a;
            font-size: 24px;
            line-height: 32px;
            font-weight: 900;
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
            font-weight: 800;
            color: #0f172a;
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
            font-weight: 800;
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
            font-weight: 700;
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
        .badge.blue {
            background: #dbeafe;
            color: #2563eb;
        }

        .badge.red {
            background: #fee2e2;
            color: #dc2626;
        }

        .badge.orange {
            background: #ffedd5;
            color: #ea580c;
        }

        .badge.gray {
            background: #f1f5f9;
            color: #64748b;
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
            font-weight: 900;
            font-size: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex: 0 0 auto;
        }

        .schedule-main {
            flex: 1;
        }

        .schedule-time {
            font-weight: 800;
            color: #0f172a;
            font-size: 14px;
        }

        .schedule-note {
            color: #64748b;
            font-size: 12px;
            margin-top: 3px;
        }

        .empty-row {
            text-align: center;
            color: #64748b;
            padding: 30px !important;
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

        @media (max-width: 700px) {
            .stats-grid-detail,
            .class-info-grid {
                grid-template-columns: 1fr;
            }

            .class-detail-header {
                flex-direction: column;
            }
        }
    </style>
</head>

<body>

<jsp:include page="../common/sidebar.jsp"/>

<main class="main-content">
    <jsp:include page="../common/header.jsp"/>

    <div class="dashboard-body detail-page">

        <div>
            <div class="breadcrumb">
                Admin / Lớp học / <span>Chi tiết</span>
            </div>

            <div class="class-detail-header">
                <div class="class-title-box">
                    <h2>
                        <c:out value="${empty classItem.className ? 'Chi tiết lớp học' : classItem.className}" />

                        <c:choose>
                            <c:when test="${classItem.status == true}">
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
                    <a class="btn-soft" href="${pageContext.request.contextPath}/admin/classes">
                        <span class="material-symbols-rounded">arrow_back</span>
                        Quay lại danh sách
                    </a>

                    <a class="btn-soft" href="${pageContext.request.contextPath}/admin/classes/${classItem.classId}/sessions/generate">
                        <span class="material-symbols-rounded">auto_awesome</span>
                        Sinh buổi học
                    </a>

                    <a class="btn-soft" href="${pageContext.request.contextPath}/admin/classes/${classItem.classId}/schedules/create">
                        <span class="material-symbols-rounded">event</span>
                        Thêm lịch học
                    </a>
                </div>
            </div>
        </div>

        <section class="stats-grid-detail">
            <div class="mini-stat">
                <div class="mini-icon">
                    <span class="material-symbols-rounded">groups</span>
                </div>
                <div>
                    <div class="mini-stat-title">Tổng số học sinh</div>
                    <div class="mini-stat-value">${empty enrollments ? 0 : fn:length(enrollments)}</div>
                </div>
            </div>

            <div class="mini-stat">
                <div class="mini-icon" style="background:#f3e8ff;color:#9333ea;">
                    <span class="material-symbols-rounded">history_edu</span>
                </div>
                <div>
                    <div class="mini-stat-title">Tổng số buổi học</div>
                    <div class="mini-stat-value">${empty sessions ? 0 : fn:length(sessions)}</div>
                </div>
            </div>

            <div class="mini-stat">
                <div class="mini-icon" style="background:#dcfce7;color:#16a34a;">
                    <span class="material-symbols-rounded">event</span>
                </div>
                <div>
                    <div class="mini-stat-title">Lịch học hàng tuần</div>
                    <div class="mini-stat-value">${empty schedules ? 0 : fn:length(schedules)}</div>
                </div>
            </div>

            <div class="mini-stat">
                <div class="mini-icon" style="background:#fee2e2;color:#dc2626;">
                    <span class="material-symbols-rounded">payments</span>
                </div>
                <div>
                    <div class="mini-stat-title">Học phí / buổi</div>
                    <div class="mini-stat-value" style="font-size:18px;">
                        <c:choose>
                            <c:when test="${not empty classItem.tuitionFeePerSession}">
                                <fmt:formatNumber value="${classItem.tuitionFeePerSession}" type="number"/>đ
                            </c:when>
                            <c:otherwise>---</c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </section>

        <section class="top-grid">
            <div class="info-card">
                <h3 class="card-title">Thông tin lớp học</h3>

                <div class="class-info-grid">
                    <div>
                        <div class="info-label">Mã lớp</div>
                        <div class="info-value primary">#<c:out value="${classItem.classId}" /></div>
                    </div>

                    <div>
                        <div class="info-label">Môn học</div>
                        <div class="info-value">
                            <c:out value="${empty classItem.subject ? '---' : classItem.subject}" />
                        </div>
                    </div>

                    <div>
                        <div class="info-label">Khối / Lớp</div>
                        <div class="info-value">
                            <c:out value="${empty classItem.grade ? '---' : classItem.grade}" />
                        </div>
                    </div>

                    <div>
                        <div class="info-label">Học phí</div>
                        <div class="info-value primary">
                            <c:choose>
                                <c:when test="${not empty classItem.tuitionFeePerSession}">
                                    <fmt:formatNumber value="${classItem.tuitionFeePerSession}" type="number"/> VNĐ / buổi
                                </c:when>
                                <c:otherwise>---</c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <div>
                        <div class="info-label">Số buổi yêu cầu</div>
                        <div class="info-value">
                            ${empty classItem.requiredSessions ? '---' : classItem.requiredSessions} buổi
                        </div>
                    </div>


                </div>

                <div class="description-box">
                    <div class="info-label">Mô tả chương trình học</div>
                    <c:out value="${empty classItem.description ? 'Chưa cập nhật mô tả chương trình học.' : classItem.description}" />
                </div>
            </div>

            <div class="info-card tutor-card">
                <h3 class="card-title" style="text-align:left;">Gia sư phụ trách</h3>

                <c:choose>
                    <c:when test="${not empty classItem.tutor}">
                        <img class="tutor-avatar"
                             src="${pageContext.request.contextPath}/images/default-avatar.png"
                             alt="Tutor avatar">

                        <div class="tutor-name">
                            <c:out value="${empty classItem.tutor.fullName ? 'Chưa cập nhật tên gia sư' : classItem.tutor.fullName}" />
                        </div>

                        <div class="tutor-major">
                            <c:out value="${empty classItem.tutor.major ? 'Chưa cập nhật chuyên ngành' : classItem.tutor.major}" />
                        </div>

                        <div class="tutor-line">
                            <span>Email</span>
                            <span><c:out value="${empty classItem.tutor.email ? '---' : classItem.tutor.email}" /></span>
                        </div>

                        <div class="tutor-line">
                            <span>SĐT</span>
                            <span><c:out value="${empty classItem.tutor.phone ? '---' : classItem.tutor.phone}" /></span>
                        </div>

                        <div class="tutor-line">
                            <span>Trường</span>
                            <span><c:out value="${empty classItem.tutor.school ? '---' : classItem.tutor.school}" /></span>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <p style="color:#64748b;">Lớp học chưa được phân công gia sư.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>

        <section class="main-grid">
            <div class="info-card">
                <div class="section-header">
                    <h3>Danh sách học sinh</h3>
                </div>

                <table class="student-table">
                    <thead>
                    <tr>
                        <th>Học sinh</th>
                        <th>Phụ huynh</th>
                        <th>Trường</th>
                        <th>Khối</th>
                        <th>Trạng thái</th>
                    </tr>
                    </thead>

                    <tbody>
                    <c:choose>
                        <c:when test="${not empty enrollments}">
                            <c:forEach items="${enrollments}" var="e">
                                <tr>
                                    <td>
                                        <div class="student-cell">
                                            <div class="avatar-small">
                                                <c:choose>
                                                    <c:when test="${not empty e.student and not empty e.student.fullName}">
                                                        ${fn:substring(e.student.fullName, 0, 1)}
                                                    </c:when>
                                                    <c:otherwise>?</c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div>
                                                <div class="name-main">
                                                    <c:out value="${empty e.student.fullName ? 'Học sinh' : e.student.fullName}" />
                                                </div>
                                                <div class="name-sub">
                                                    ID:
                                                    <c:out value="${empty e.student.studentId ? '---' : e.student.studentId}" />
                                                </div>
                                            </div>
                                        </div>
                                    </td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty e.student.parent}">
                                                <div class="name-main">
                                                    <c:out value="${empty e.student.parent.fullName ? '---' : e.student.parent.fullName}" />
                                                </div>
                                                <div class="name-sub">
                                                    <c:out value="${empty e.student.parent.phone ? '---' : e.student.parent.phone}" />
                                                </div>
                                            </c:when>
                                            <c:otherwise>---</c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td><c:out value="${empty e.student.school ? '---' : e.student.school}" /></td>
                                    <td><c:out value="${empty e.student.grade ? '---' : e.student.grade}" /></td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${e.status == true}">
                                                <span class="badge green">Đang học</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge gray">Tạm dừng</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>

                        <c:otherwise>
                            <tr>
                                <td colspan="5" class="empty-row">
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
                </div>

                <c:choose>
                    <c:when test="${not empty schedules}">
                        <c:forEach items="${schedules}" var="schedule">
                            <div class="schedule-item">
                                <div class="day-chip">
                                    T<c:out value="${schedule.weekday}" />
                                </div>

                                <div class="schedule-main">
                                    <div class="schedule-time">
                                        <c:out value="${schedule.startTime}" />
                                        -
                                        <c:out value="${schedule.endTime}" />
                                    </div>
                                    <div class="schedule-note">Lịch học định kỳ</div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>

                    <c:otherwise>
                        <p style="color:#64748b;">Chưa có lịch học hàng tuần.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>

        <section class="info-card">
            <div class="section-header">
                <h3>Buổi học</h3>
            </div>

            <table class="session-table">
                <thead>
                <tr>
                    <th>Ngày giờ</th>
                    <th>Chủ đề bài học</th>
                    <th>Tình trạng</th>
                    <th>Mã điểm danh</th>
                </tr>
                </thead>

                <tbody>
                <c:choose>
                    <c:when test="${not empty sessions}">
                        <c:forEach items="${sessions}" var="ss">
                            <tr>
                                <td>
                                    <div class="name-main">
                                        <c:out value="${empty ss.sessionDate ? '---' : ss.sessionDate}" />
                                    </div>
                                    <div class="name-sub">
                                        <c:out value="${empty ss.startTime ? '' : ss.startTime}" />
                                        -
                                        <c:out value="${empty ss.endTime ? '' : ss.endTime}" />
                                    </div>
                                </td>

                                <td>
                                    <c:out value="${empty ss.topic ? 'Đang cập nhật' : ss.topic}" />
                                </td>

                                <td>
                                    <c:choose>

                                        <c:when test="${ss.status == 'COMPLETED'}">
                                            <span class="badge green">
                                                Hoàn thành
                                            </span>
                                        </c:when>

                                        <c:when test="${ss.status == 'ONGOING'}">
                                        <span class="badge orange">
                                            Đang diễn ra
                                        </span>
                                        </c:when>

                                        <c:when test="${ss.status == 'PLANNED'}">
                                            <span class="badge blue">
                                                Đã lên kế hoạch
                                            </span>
                                        </c:when>

                                        <c:when test="${ss.status == 'CANCELLED'}">
                                            <span class="badge red">
                                                Đã hủy
                                            </span>
                                        </c:when>

                                        <c:otherwise>
                                            <span class="badge gray">
                                                <c:out value="${empty ss.status ? 'Chưa học' : ss.status}" />
                                            </span>
                                        </c:otherwise>

                                    </c:choose>
                                </td>

                                <td>
                                    <c:out value="${empty ss.attendanceCode ? '---' : ss.attendanceCode}" />
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>

                    <c:otherwise>
                        <tr>
                            <td colspan="4" class="empty-row">
                                Chưa có buổi học.
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </section>

    </div>
</main>

</body>
</html>
