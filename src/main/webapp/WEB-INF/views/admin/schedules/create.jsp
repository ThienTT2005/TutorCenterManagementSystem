<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm lịch học</title>

    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0"/>
    <link rel="stylesheet" href="<c:url value='/css/core-dashboard.css' />">

    <style>
        body {
            margin: 0;
            background: #f7faff;
            font-family: Inter, system-ui, sans-serif;
            color: #0f172a;
        }

        .schedule-page {
            padding: 28px;
        }

        .breadcrumb {
            font-size: 13px;
            color: #94a3b8;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .breadcrumb span {
            color: #2563eb;
        }

        .page-title {
            font-size: 30px;
            font-weight: 900;
            margin-bottom: 32px;
        }

        .layout {
            display: grid;
            grid-template-columns: 300px 1fr;
            gap: 24px;
        }

        .left-col {
            display: flex;
            flex-direction: column;
            gap: 24px;
        }

        .card {
            background: #fff;
            border: 1px solid #e5edf7;
            border-radius: 18px;
            box-shadow: 0 10px 25px rgba(15, 23, 42, 0.04);
        }

        .class-card,
        .form-card {
            padding: 24px;
        }

        .tag {
            display: inline-block;
            padding: 8px 14px;
            background: #eaf3ff;
            color: #2563eb;
            border-radius: 999px;
            font-size: 11px;
            font-weight: 900;
            margin-bottom: 18px;
        }

        .class-name {
            font-size: 20px;
            font-weight: 900;
            margin-bottom: 22px;
        }

        .info-row {
            display: flex;
            gap: 12px;
            align-items: center;
            margin-bottom: 14px;
        }

        .info-icon {
            width: 34px;
            height: 34px;
            border-radius: 10px;
            background: #eef6ff;
            color: #2563eb;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .info-row small {
            display: block;
            font-size: 11px;
            color: #94a3b8;
            font-weight: 800;
            text-transform: uppercase;
        }

        .info-row b {
            font-size: 14px;
        }

        .form-title {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 18px;
            font-weight: 900;
            margin-bottom: 24px;
        }

        label {
            display: block;
            font-size: 11px;
            color: #64748b;
            font-weight: 900;
            text-transform: uppercase;
            margin-bottom: 8px;
        }

        select,
        input[type="time"] {
            width: 100%;
            height: 44px;
            border: 1px solid #dbe3ef;
            background: #f8fafc;
            border-radius: 12px;
            padding: 0 14px;
            font-size: 14px;
            font-weight: 700;
            outline: none;
            color: #334155;
        }

        select:focus,
        input[type="time"]:focus {
            border-color: #2563eb;
            background: white;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.08);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .time-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 14px;
        }

        .submit-btn {
            width: 100%;
            height: 46px;
            border: none;
            border-radius: 12px;
            background: #0563d9;
            color: white;
            font-size: 14px;
            font-weight: 900;
            cursor: pointer;
            box-shadow: 0 8px 18px rgba(5, 99, 217, 0.25);
        }

        .submit-btn:hover {
            background: #0057bf;
        }

        .error-box {
            background: #fef2f2;
            color: #b91c1c;
            border: 1px solid #fecaca;
            border-radius: 14px;
            padding: 14px;
            font-size: 13px;
            font-weight: 700;
            margin-bottom: 18px;
        }

        .summary-card {
            background: #0563d9;
            color: white;
            padding: 22px;
            border-radius: 18px;
            box-shadow: 0 12px 24px rgba(5, 99, 217, 0.25);
        }

        .summary-card small {
            display: block;
            opacity: 0.8;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .summary-card b {
            font-size: 22px;
        }

        .schedule-list-card {
            overflow: hidden;
        }

        .list-header {
            padding: 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #edf2f7;
        }

        .list-title {
            display: flex;
            gap: 14px;
            align-items: center;
        }

        .list-title-icon {
            width: 42px;
            height: 42px;
            border-radius: 14px;
            background: #f1f5f9;
            color: #64748b;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .list-title h2 {
            margin: 0;
            font-size: 20px;
            font-weight: 900;
        }

        .list-title p {
            margin: 4px 0 0;
            font-size: 12px;
            color: #94a3b8;
            font-weight: 600;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            text-align: left;
            padding: 18px 24px;
            font-size: 11px;
            color: #94a3b8;
            font-weight: 900;
            text-transform: uppercase;
            background: #fbfdff;
        }

        td {
            padding: 18px 24px;
            border-top: 1px solid #f1f5f9;
            font-size: 14px;
            font-weight: 700;
        }

        .day-cell {
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .day-number {
            width: 42px;
            height: 42px;
            border-radius: 14px;
            background: #dbeafe;
            color: #2563eb;
            font-weight: 900;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .time-badge {
            display: inline-block;
            margin-left: 12px;
            padding: 7px 10px;
            border-radius: 8px;
            background: #f1f5f9;
            color: #64748b;
            font-size: 11px;
            font-weight: 900;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 10px 18px;
            border-radius: 999px;
            background: #dcfce7;
            color: #16a34a;
            font-size: 12px;
            font-weight: 900;
        }

        .dot {
            width: 7px;
            height: 7px;
            background: #22c55e;
            border-radius: 50%;
        }

        .empty {
            padding: 60px;
            text-align: center;
            color: #94a3b8;
            font-weight: 700;
        }

        .list-footer {
            padding: 20px 24px;
            border-top: 1px solid #f1f5f9;
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: #64748b;
            font-size: 13px;
            font-weight: 700;
        }

        .back-btn {
            display: inline-block;
            padding: 12px 18px;
            border: 1px solid #dbe3ef;
            border-radius: 12px;
            text-decoration: none;
            color: #334155;
            font-weight: 800;
            background: white;
        }
        .delete-btn {
            width: 34px;
            height: 34px;
            border: none;
            border-radius: 10px;
            background: #fee2e2;
            color: #dc2626;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .delete-btn:hover {
            background: #dc2626;
            color: white;
        }

        @media (max-width: 1000px) {
            .layout {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>

<body>
<c:set var="activePage" value="classes" scope="request"/>

<jsp:include page="../common/sidebar.jsp"/>

<main class="main-content">
    <jsp:include page="../common/header.jsp"/>

    <div class="schedule-page">

        <div class="breadcrumb">
            Admin &nbsp;›&nbsp; Lớp học &nbsp;›&nbsp; <span>Thêm lịch</span>
        </div>

        <div class="page-title">Thêm lịch học</div>

        <div class="layout">

            <div class="left-col">

                <section class="card class-card">
                    <div class="tag">THÔNG TIN LỚP</div>

                    <div class="class-name">
                        ${classItem.className}
                    </div>

                    <div class="info-row">
                        <div class="info-icon">
                            <span class="material-symbols-rounded">person</span>
                        </div>
                        <div>
                            <small>Giảng viên</small>
                            <b>
                                <c:choose>
                                    <c:when test="${not empty classItem.tutor}">
                                        ${classItem.tutor.fullName}
                                    </c:when>
                                    <c:otherwise>Chưa có gia sư</c:otherwise>
                                </c:choose>
                            </b>
                        </div>
                    </div>

                    <div class="info-row">
                        <div class="info-icon">
                            <span class="material-symbols-rounded">menu_book</span>
                        </div>
                        <div>
                            <small>Môn học</small>
                            <b>${classItem.subject}</b>
                        </div>
                    </div>
                </section>

                <section class="card form-card">
                    <div class="form-title">
                        <span class="material-symbols-rounded" style="color:#2563eb;">add_circle</span>
                        Tạo lịch học mới
                    </div>

                    <c:if test="${not empty error}">
                        <div class="error-box">
                                ${error}
                        </div>
                    </c:if>

                    <form id="scheduleForm"
                          method="post"
                          action="${pageContext.request.contextPath}/admin/classes/${classItem.classId}/schedules/create">

                        <input type="hidden" name="classId" value="${classItem.classId}"/>

                        <div id="hiddenScheduleInputs"></div>

                        <div class="form-group">
                            <label>Thứ trong tuần</label>
                            <select id="weekdayInput">
                                <option value="">Chọn thứ</option>
                                <option value="2">Thứ Hai</option>
                                <option value="3">Thứ Ba</option>
                                <option value="4">Thứ Tư</option>
                                <option value="5">Thứ Năm</option>
                                <option value="6">Thứ Sáu</option>
                                <option value="7">Thứ Bảy</option>
                                <option value="8">Chủ nhật</option>
                            </select>
                        </div>

                        <div class="time-grid">
                            <div class="form-group">
                                <label>Giờ bắt đầu</label>
                                <input type="time" id="startTimeInput">
                            </div>

                            <div class="form-group">
                                <label>Giờ kết thúc</label>
                                <input type="time" id="endTimeInput">
                            </div>
                        </div>

                        <button type="button" class="submit-btn" onclick="addScheduleTemp()">
                            <span class="material-symbols-rounded" style="font-size:16px; vertical-align:middle;">add</span>
                            Thêm lịch
                        </button>

                        <div style="display:flex; gap:12px; margin-top:14px;">
                            <button type="submit" class="submit-btn" style="background:#16a34a;">
                                Lưu lịch
                            </button>

                            <a href="${pageContext.request.contextPath}/admin/classes/${classItem.classId}"
                               class="back-btn"
                               style="width:100%; text-align:center;">
                                Hủy
                            </a>
                        </div>
                    </form>
                </section>

                <section class="summary-card">
                    <small>Tổng số giờ học</small>
                    <b>Được tính sau khi lưu lịch</b>
                </section>

            </div>

            <section class="card schedule-list-card">
                <div class="list-header">
                    <div class="list-title">
                        <div class="list-title-icon">
                            <span class="material-symbols-rounded">calendar_month</span>
                        </div>
                        <div>
                            <h2>Danh sách lịch đã có</h2>
                            <p>Các lịch học cố định trong tuần</p>
                        </div>
                    </div>
                </div>

                <table>
                    <thead>
                    <tr>
                        <th>Thứ</th>
                        <th>Thời gian</th>
                        <th>Trạng thái</th>
                        <th>Xóa</th>
                    </tr>
                    </thead>

                    <tbody id="scheduleTableBody">
                    <c:choose>
                        <c:when test="${empty schedules}">
                            <tr>
                                <td colspan="4" class="empty">
                                    Lớp này chưa có lịch học nào.
                                </td>
                            </tr>
                        </c:when>

                        <c:otherwise>
                            <c:forEach var="schedule" items="${schedules}">
                                <tr>
                                    <td>
                                        <div class="day-cell">
                                            <div class="day-number">${schedule.weekday}</div>
                                            <div>
                                                <c:choose>
                                                    <c:when test="${schedule.weekday == 2}">Thứ Hai</c:when>
                                                    <c:when test="${schedule.weekday == 3}">Thứ Ba</c:when>
                                                    <c:when test="${schedule.weekday == 4}">Thứ Tư</c:when>
                                                    <c:when test="${schedule.weekday == 5}">Thứ Năm</c:when>
                                                    <c:when test="${schedule.weekday == 6}">Thứ Sáu</c:when>
                                                    <c:when test="${schedule.weekday == 7}">Thứ Bảy</c:when>
                                                    <c:when test="${schedule.weekday == 8}">Chủ nhật</c:when>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </td>

                                    <td>
                                            ${schedule.startTime} - ${schedule.endTime}
                                    </td>

                                    <td>
                                        <span class="status-badge">
                                            <span class="dot"></span>
                                            Đang áp dụng
                                        </span>
                                    </td>
                                    <td>---</td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>

                <div class="list-footer">
                    <span>
                        Tổng số:
                        <c:choose>
                            <c:when test="${empty schedules}">0</c:when>
                            <c:otherwise>${schedules.size()}</c:otherwise>
                        </c:choose>
                        lịch học cố định trong tuần
                    </span>

                    <a class="back-btn" href="${pageContext.request.contextPath}/admin/classes/${classItem.classId}">
                        Xem lớp chi tiết
                    </a>
                </div>
            </section>

        </div>
    </div>
</main>
<script src="${pageContext.request.contextPath}/js/admin-schedule.js"></script>


</body>
</html>
