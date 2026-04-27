<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Sửa thông tin lớp học | TCMS</title>

    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0"/>

    <link rel="stylesheet" href="<c:url value='/css/core-dashboard.css'/>">

    <style>
        body {
            background: #f8fafc;
            color: #0f172a;
        }

        .update-page {
            display: flex;
            flex-direction: column;
            gap: 22px;
        }

        .breadcrumb {
            font-size: 13px;
            color: #64748b;
            font-weight: 700;
        }

        .breadcrumb span {
            color: #0057bf;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 16px;
        }

        .page-title h2 {
            margin: 6px 0 0;
            font-size: 20px;
            font-weight: 700;
            line-height: 25px;
        }

        .header-actions,
        .bottom-actions {
            display: flex;
            gap: 12px;
            align-items: center;
        }

        .btn {
            height: 42px;
            padding: 0 18px;
            border-radius: 10px;
            border: 1px solid #e2e8f0;
            background: #fff;
            color: #334155;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 7px;
        }

        .btn-primary {
            background: #0057bf;
            color: #fff;
            border-color: #0057bf;
            box-shadow: 0 8px 18px rgba(0, 87, 191, 0.22);
        }

        .btn-danger {
            color: #dc2626;
            background: transparent;
            border: none;
        }

        .notice {
            background: #eff6ff;
            color: #2563eb;
            border: 1px solid #bfdbfe;
            padding: 13px 16px;
            border-radius: 13px;
            font-size: 13px;
            font-weight: 400;
            display: flex;
            gap: 8px;
            align-items: center;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 18px;
        }

        .stat-card {
            background: #fff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            padding: 18px;
            display: flex;
            gap: 14px;
            align-items: center;
            box-shadow: 0 8px 22px rgba(15, 23, 42, 0.04);
        }

        .stat-icon {
            width: 44px;
            height: 44px;
            border-radius: 13px;
            background: #eff6ff;
            color: #2563eb;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .stat-label {
            color: #64748b;
            font-size: 12px;
            font-weight: 500;
            line-height: 16px;
            text-transform: uppercase;
        }

        .stat-value {
            margin-top: 4px;
            font-size: 22px;
            line-height: 28px;
            font-weight: 700;
        }

        .layout-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 22px;
        }

        .card {
            background: #fff;
            border-radius: 18px;
            border: 1px solid #e2e8f0;
            padding: 22px;
            box-shadow: 0 8px 22px rgba(15, 23, 42, 0.04);
        }

        .card-title {
            margin: 0 0 18px;
            font-size: 16px;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 16px 18px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 7px;
        }

        .form-group.full {
            grid-column: 1 / -1;
        }

        label {
            font-size: 12px;
            text-transform: uppercase;
            color: #64748b;
            font-weight: 100;
            line-height: 16px;
        }

        input,
        select,
        textarea {
            height: 42px;
            border-radius: 10px;
            border: 1px solid #dbe3ef;
            padding: 0 12px;
            outline: none;
            font-size: 14px;
            background: #fff;
        }

        textarea {
            height: 100px;
            padding-top: 12px;
            resize: vertical;
        }

        input:focus,
        select:focus,
        textarea:focus {
            border-color: #0057bf;
            box-shadow: 0 0 0 3px rgba(0, 87, 191, 0.1);
        }

        .status-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 12px 14px;
            margin-bottom: 18px;
            font-size: 12px;
            font-weight: 400;
        }
        .status-row span{
            font-weight: 700;
            font-size: 12px;
            color: #475569;
            letter-spacing: 0.3px;
        }

        .switch {
            position: relative;
            width: 48px;
            height: 26px;
        }

        .switch input {
            display: none;
        }

        .slider {
            position: absolute;
            inset: 0;
            border-radius: 999px;
            background: #cbd5e1;
            cursor: pointer;
        }

        .slider:before {
            content: "";
            position: absolute;
            width: 20px;
            height: 20px;
            left: 3px;
            top: 3px;
            background: #fff;
            border-radius: 50%;
            transition: 0.2s;
        }

        .switch input:checked + .slider {
            background: #0057bf;
        }

        .switch input:checked + .slider:before {
            transform: translateX(22px);
        }

        .search-box {
            height: 40px;
            width: 100%;
            margin-bottom: 12px;
            background: #f8fafc;
        }

        .tutor-selected {
            border: 1px solid #bfdbfe;
            background: #eff6ff;
            border-radius: 14px;
            padding: 12px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .avatar {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            object-fit: cover;
        }

        .tutor-name {
            font-weight: 700;
        }

        .tutor-major {
            color: #0057bf;
            font-size: 12px;
            font-weight: 800;
        }

        .schedule-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 11px 12px;
            margin-bottom: 10px;
            font-size: 13px;
            font-weight: 800;
        }

        .schedule-form {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 8px;
            margin-top: 14px;
        }

        .schedule-form select,
        .schedule-form input {
            height: 38px;
            font-size: 13px;
        }

        .schedule-form .btn {
            grid-column: 1 / -1;
            justify-content: center;
            height: 38px;
        }

        .progress-bar {
            width: 100%;
            height: 9px;
            background: #e2e8f0;
            border-radius: 999px;
            overflow: hidden;
            margin: 10px 0;
        }

        .progress-fill {
            width: 22%;
            height: 100%;
            background: #0057bf;
        }

        .bottom-bar {
            position: sticky;
            bottom: 0;
            background: #fff;
            border-top: 1px solid #e2e8f0;
            padding: 16px 24px;
            margin: 10px -24px -24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-radius: 0 0 18px 18px;
        }

        .small-link {
            font-size: 13px;
            color: #0057bf;
            font-weight: 800;
            cursor: pointer;
            text-decoration: none;
            background: none;
            border: none;
            padding: 0;
        }

        .generate-form {
            display: none;
            gap: 10px;
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

        @media (max-width: 1100px) {
            .stats-grid,
            .layout-grid,
            .form-grid {
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

    <div class="dashboard-body update-page">

        <form method="post"
              action="${pageContext.request.contextPath}/admin/classes/${classDetail.id}/update">

            <div class="page-header">
                <div class="page-title">
                    <div class="breadcrumb">
                        Lớp học / Chi tiết lớp học / <span>Sửa thông tin lớp</span>
                    </div>
                    <h2>Sửa thông tin lớp học</h2>
                </div>

                <div class="header-actions">
                    <a class="btn" href="${pageContext.request.contextPath}/admin/classes/${classDetail.id}">
                        ← Quay lại
                    </a>

                    <button type="submit" class="btn btn-primary">
                        Lưu thay đổi
                    </button>
                </div>
            </div>

            <section class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon">
                        <span class="material-symbols-rounded">groups</span>
                    </div>
                    <div>
                        <div class="stat-label">Tổng học sinh</div>
                        <div class="stat-value">${stats.totalStudents}</div>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon" style="background:#ecfeff;color:#0891b2;">
                        <span class="material-symbols-rounded">event_repeat</span>
                    </div>
                    <div>
                        <div class="stat-label">Lịch học hằng tuần</div>
                        <div class="stat-value">${stats.weeklySchedules}</div>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon" style="background:#fff7ed;color:#f97316;">
                        <span class="material-symbols-rounded">event_available</span>
                    </div>
                    <div>
                        <div class="stat-label">Số buổi đã tạo</div>
                        <div class="stat-value">${stats.totalSessions}</div>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon" style="background:#dcfce7;color:#16a34a;">
                        <span class="material-symbols-rounded">verified</span>
                    </div>
                    <div>
                        <div class="stat-label">Đã hoàn thành</div>
                        <div class="stat-value">${stats.completedSessions}</div>
                    </div>
                </div>
            </section>

            <div class="notice">
                <span class="material-symbols-rounded">info</span>
                Lưu ý: Nếu thay đổi lịch học hằng tuần, các buổi học đã sinh trước đó sẽ không tự động đổi theo cho tới khi sinh lại lịch buổi học.
            </div>

            <section class="layout-grid">

                <div>
                    <div class="card">
                        <div class="status-row">
                            <div>
                                <strong>Trạng thái:</strong>
                                <span id="statusText"
                                      style="font-weight:900; color:${classDetail.status ? '#16a34a' : '#dc2626'};">
                                    ${classDetail.status ? 'Đang hoạt động' : 'Tạm dừng'}
                                </span>
                            </div>

                            <label class="switch">
                                <input type="checkbox"
                                       id="statusToggle"
                                       name="status"
                                       value="true"
                                       <c:if test="${classDetail.status}">checked</c:if>
                                       onchange="changeStatusText()">
                                <span class="slider"></span>
                            </label>
                        </div>

                        <h3 class="card-title">
                            <span class="material-symbols-rounded">edit_note</span>
                            Thông tin lớp học
                        </h3>

                        <div class="form-grid">
                            <div class="form-group">
                                <label>Tên lớp</label>
                                <input type="text" name="className"
                                       value="${classDetail.className}"
                                       placeholder="IELTS Master 6.5 - K24" required>
                            </div>

                            <div class="form-group">
                                <label>Môn học</label>
                                <select name="subject" required>
                                    <option value="Tiếng Anh" ${classDetail.subject == 'Tiếng Anh' ? 'selected' : ''}>Tiếng Anh</option>
                                    <option value="Toán" ${classDetail.subject == 'Toán' ? 'selected' : ''}>Toán</option>
                                    <option value="Vật lý" ${classDetail.subject == 'Vật lý' ? 'selected' : ''}>Vật lý</option>
                                    <option value="Hóa học" ${classDetail.subject == 'Hóa học' ? 'selected' : ''}>Hóa học</option>
                                    <option value="Ngữ văn" ${classDetail.subject == 'Ngữ văn' ? 'selected' : ''}>Ngữ văn</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label>Khối / Trình độ</label>
                                <input type="text" name="grade"
                                       value="${classDetail.grade}"
                                       placeholder="Đại học / Người đi làm">
                            </div>

                            <div class="form-group">
                                <label>Học phí VNĐ/buổi</label>
                                <input type="number" name="tuitionFeePerSession"
                                       value="${classDetail.tuitionFeePerSession}"
                                       placeholder="350000" min="0">
                            </div>

                            <div class="form-group">
                                <label>Tổng số buổi dự kiến</label>
                                <input type="number" name="requiredSessions"
                                       value="${classDetail.requiredSessions}"
                                       placeholder="48" min="1">
                            </div>

                            <div class="form-group">
                                <label>Mã lớp</label>
                                <input type="text" name="classCode"
                                       value="${classDetail.classCode}"
                                       placeholder="HS-CLASS-001">
                            </div>

                            <div class="form-group full">
                                <label>Mô tả chương trình học</label>
                                <textarea name="description"
                                          placeholder="Nhập mô tả chương trình học...">${classDetail.description}</textarea>
                            </div>
                        </div>
                    </div>

                    <div class="card" style="margin-top:22px;">
                        <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:14px;">
                            <h3 class="card-title" style="margin:0;">
                                <span class="material-symbols-rounded">group</span>
                                Danh sách học sinh (${stats.totalStudents})
                            </h3>
                            <button type="button" class="small-link" onclick="openStudentModal()">+ Thêm học sinh</button>
                        </div>

                        <table style="width:100%;border-collapse:collapse;">
                            <thead>
                            <tr style="color:#64748b;font-size:11px;text-transform:uppercase;">
                                <th style="text-align:left;padding:10px;">Mã HS</th>
                                <th style="text-align:left;padding:10px;">Học sinh</th>
                                <th style="text-align:left;padding:10px;">Phụ huynh</th>
                                <th style="text-align:left;padding:10px;">SĐT liên hệ</th>
                                <th style="text-align:center;padding:10px;">Xóa</th>
                            </tr>
                            </thead>

                            <tbody>
                            <c:forEach items="${students}" var="student">
                                <tr style="border-top:1px solid #f1f5f9;">
                                    <td style="padding:12px;color:#0057bf;font-weight:700;">
                                        HS-${student.id}
                                    </td>
                                    <td style="padding:12px;font-weight:700;">
                                        ${student.fullName}
                                    </td>
                                    <td style="padding:12px;color:#475569;">
                                        <c:if test="${not empty student.parent}">${student.parent.fullName}</c:if>
                                    </td>
                                    <td style="padding:12px;color:#475569;">
                                        <c:if test="${not empty student.parent}">${student.parent.phone}</c:if>
                                    </td>
                                    <td style="padding:12px;text-align:center;">
                                        <button type="button"
                                                onclick="removeStudent('${student.id}')"
                                                style="border:none;background:transparent;color:#dc2626;cursor:pointer;" title="Xóa khỏi lớp">
                                            <span class="material-symbols-rounded" style="font-size:18px;">delete</span>
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <aside>
                    <div class="card">
                        <h3 class="card-title">
                            <span class="material-symbols-rounded">account_circle</span>
                            Gia sư phụ trách
                        </h3>

                        <input type="hidden" name="tutorId" id="tutorId" value="${tutor.id}">

                        <div id="currentTutorBox" class="tutor-selected" style="align-items: flex-start; gap: 16px; padding: 16px;">
                            <img id="tutorAvatar" class="avatar" style="width: 60px; height: 60px; border-radius: 12px;"
                                 src="${not empty tutor.avatar ? (tutor.avatar.startsWith('http') ? tutor.avatar : (pageContext.request.contextPath.concat('/uploads/').concat(tutor.avatar))) : (pageContext.request.contextPath.concat('/images/default-avatar.png'))}">

                            <div style="flex:1;">
                                <div class="tutor-name" id="currentTutorName" style="font-size: 15px; margin-bottom: 2px;">
                                    ${empty tutor.fullName ? 'Chưa có gia sư' : tutor.fullName}
                                </div>
                                <div class="tutor-major" id="currentTutorMajor" style="margin-bottom: 8px;">
                                    ${empty tutor.major ? '---' : tutor.major}
                                </div>
                                
                                <div id="tutorExtraInfo" style="display: ${empty tutor ? 'none' : 'block'};">
                                    <div style="font-size: 12px; color: #64748b; display: flex; align-items: center; gap: 6px; margin-bottom: 4px;">
                                        <span class="material-symbols-rounded" style="font-size: 16px;">school</span>
                                        <span id="currentTutorSchool">${empty tutor.school ? 'Chưa cập nhật trường' : tutor.school}</span>
                                    </div>
                                    <div style="font-size: 12px; color: #64748b; display: flex; align-items: center; gap: 6px; margin-bottom: 4px;">
                                        <span class="material-symbols-rounded" style="font-size: 16px;">call</span>
                                        <span id="currentTutorPhone">${empty tutor.phone ? '---' : tutor.phone}</span>
                                    </div>
                                    <div style="font-size: 12px; color: #64748b; display: flex; align-items: center; gap: 6px;">
                                        <span class="material-symbols-rounded" style="font-size: 16px;">mail</span>
                                        <span id="currentTutorEmail">${empty tutor.email ? '---' : tutor.email}</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div style="margin-top: 15px;">
                            <label style="font-size: 11px; text-transform: uppercase; color: #64748b; font-weight: 900; margin-bottom: 8px; display: block;">Chọn gia sư mới</label>
                            <select id="tutorSelect" class="mini-input" style="width: 100%;" onchange="handleTutorChange(this)">
                                <option value="">-- Chọn gia sư --</option>
                                <c:forEach items="${tutors}" var="t">
                                    <option value="${t.id}" 
                                            data-name="${t.fullName}" 
                                            data-major="${empty t.major ? 'Chưa cập nhật chuyên ngành' : t.major}"
                                            data-school="${empty t.school ? 'Chưa cập nhật trường' : t.school}"
                                            data-phone="${empty t.phone ? '---' : t.phone}"
                                            data-email="${empty t.email ? '---' : t.email}"
                                            data-avatar="${t.avatar}"
                                            ${tutor.id == t.id ? 'selected' : ''}>
                                        ${t.fullName} (${empty t.major ? 'N/A' : t.major})
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="card" style="margin-top:22px;">
                        <div class="section-header" style="display:flex; justify-content:space-between; align-items:center; margin-bottom:15px;">
                            <h3 class="card-title" style="margin:0;">
                                <span class="material-symbols-rounded">calendar_month</span>
                                Lịch học hằng tuần
                            </h3>
                            <button type="button" class="small-link" onclick="toggleScheduleForm()">
                                + Thêm lịch
                            </button>
                        </div>

                        <div id="scheduleForm" class="generate-form">
                            <div class="form-group-mini">
                                <label>Thứ</label>
                                <select id="weekday" class="mini-input">
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
                                <label>Bắt đầu</label>
                                <input type="time" id="startTime" class="mini-input">
                            </div>
                            <div class="form-group-mini">
                                <label>Kết thúc</label>
                                <input type="time" id="endTime" class="mini-input">
                            </div>
                            <button type="button" class="btn-blue-mini" onclick="addSchedule()">Lưu</button>
                        </div>

                        <div id="scheduleList">
                            <c:forEach items="${weeklySchedules}" var="schedule">
                                <div class="schedule-item">
                                    <span>Thứ ${schedule.weekday}</span>
                                    <span>${schedule.startTime} - ${schedule.endTime}</span>
                                    <button type="button"
                                            onclick="removeSchedule('${schedule.id}')"
                                            style="border:none;background:transparent;color:#64748b;cursor:pointer;">
                                        <span class="material-symbols-rounded" style="font-size:18px;">delete</span>
                                    </button>
                                </div>
                            </c:forEach>
                        </div>
                    </div>


                </aside>
            </section>

            <!-- SESSIONS TABLE -->
            <section class="card" style="margin-top:22px;">
                <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:16px;">
                    <h3 class="card-title" style="margin:0;">
                        <span class="material-symbols-rounded">calendar_view_week</span>
                        Lịch các buổi học
                    </h3>
                    <span style="font-size:13px;color:#64748b;font-weight:700;">${stats.totalSessions} buổi</span>
                </div>

                <table style="width:100%;border-collapse:collapse;">
                    <thead>
                    <tr style="color:#64748b;font-size:11px;text-transform:uppercase;background:#f8fafc;">
                        <th style="padding:12px;text-align:left;">Ngày</th>
                        <th style="padding:12px;text-align:left;">Giờ</th>
                        <th style="padding:12px;text-align:left;">Trạng thái</th>
                        <th style="padding:12px;text-align:left;">Ghi chú</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${not empty sessions}">
                            <c:forEach items="${sessions}" var="ss">
                                <tr style="border-top:1px solid #f1f5f9;">
                                    <td style="padding:12px;font-weight:800;">${ss.sessionDate}</td>
                                    <td style="padding:12px;color:#475569;">${ss.startTime} - ${ss.endTime}</td>
                                    <td style="padding:12px;">
                                        <c:choose>
                                            <c:when test="${ss.status == 'COMPLETED'}">
                                                <span style="background:#dcfce7;color:#16a34a;padding:4px 10px;border-radius:999px;font-size:11px;font-weight:700;">Đã dạy</span>
                                            </c:when>
                                            <c:when test="${ss.status == 'CANCELLED'}">
                                                <span style="background:#fee2e2;color:#dc2626;padding:4px 10px;border-radius:999px;font-size:11px;font-weight:700;">Hủy</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span style="background:#f1f5f9;color:#64748b;padding:4px 10px;border-radius:999px;font-size:11px;font-weight:700;">Kế hoạch</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td style="padding:12px;color:#64748b;font-size:13px;">${empty ss.topic ? '---' : ss.topic}</td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr><td colspan="4" style="text-align:center;color:#64748b;padding:30px;">Chưa có buổi học. Bấm "Sinh lịch buổi học" để tạo.</td></tr>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </section>

            <div class="bottom-bar">
                <button type="button" class="btn-danger"
                        onclick="deleteClass('${classDetail.id}')">
                    Xóa lớp học
                </button>

                <div class="bottom-actions">
                    <a class="btn" href="${pageContext.request.contextPath}/admin/classes/${classDetail.id}">
                        Hủy bỏ
                    </a>

                    <button type="submit" class="btn">
                        Lưu
                    </button>


                </div>
            </div>

        </form>

    </div>
</main>

<!-- STUDENT MODAL -->
<div id="studentModal" class="modal" style="display:none;position:fixed;z-index:1000;left:0;top:0;width:100%;height:100%;background:rgba(0,0,0,0.5);align-items:center;justify-content:center;">
    <div style="background:#fff;padding:24px;border-radius:18px;width:90%;max-width:580px;max-height:80vh;overflow-y:auto;box-shadow:0 10px 40px rgba(0,0,0,0.2);">
        <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:20px;">
            <h3 style="margin:0;font-size:20px;font-weight:700;">Thêm học sinh vào lớp</h3>
            <button type="button" onclick="closeStudentModal()" style="background:none;border:none;font-size:24px;cursor:pointer;color:#64748b;">&times;</button>
        </div>

        <div id="studentListModal">
            <c:forEach items="${allStudents}" var="st">
                <c:set var="isEnrolled" value="false" />
                <c:forEach items="${students}" var="enrolled">
                    <c:if test="${enrolled.id == st.id}">
                        <c:set var="isEnrolled" value="true" />
                    </c:if>
                </c:forEach>
                <c:if test="${!isEnrolled}">
                    <div style="display:flex;align-items:center;gap:12px;padding:10px;border-bottom:1px solid #f1f5f9;">
                        <input type="checkbox" name="selectedStudents" value="${st.id}" id="mst_${st.id}" style="width:18px;height:18px;cursor:pointer;">
                        <label for="mst_${st.id}" style="cursor:pointer;display:flex;align-items:center;gap:10px;">
                            <div style="width:36px;height:36px;border-radius:50%;background:linear-gradient(135deg,#0057bf,#60a5fa);color:#fff;display:flex;align-items:center;justify-content:center;font-weight:700;font-size:14px;">
                                ${empty st.fullName ? '?' : fn:substring(st.fullName, 0, 1)}
                            </div>
                            <div>
                                <div style="font-weight:700;font-size:14px;">${st.fullName}</div>
                                <div style="font-size:12px;color:#64748b;">MSHS: ${st.id} | ${st.school}</div>
                            </div>
                        </label>
                    </div>
                </c:if>
            </c:forEach>
        </div>

        <div style="display:flex;justify-content:flex-end;gap:12px;margin-top:20px;">
            <button type="button" onclick="closeStudentModal()" style="height:40px;padding:0 18px;border-radius:10px;border:1px solid #e2e8f0;background:#fff;font-weight:700;cursor:pointer;">Hủy</button>
            <button type="button" onclick="addSelectedStudents()" style="height:40px;padding:0 18px;border-radius:10px;background:#0057bf;color:#fff;border:none;font-weight:700;cursor:pointer;">Thêm vào lớp</button>
        </div>
    </div>
</div>

<script>
    const contextPath = '${pageContext.request.contextPath}';
    const classId = '${classDetail.id}';

    function toggleScheduleForm() {
        document.getElementById('scheduleForm').classList.toggle('show');
    }

    async function addSchedule() {
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

    async function removeSchedule(scheduleId) {
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

    async function deleteClass(classId) {
        if (!confirm('Bạn có chắc muốn xóa lớp học này?')) return;

        const res = await fetch(contextPath + '/api/admin/classes/' + classId, {
            method: 'DELETE'
        });

        if (res.ok) {
            alert('Đã xóa lớp học');
            location.href = contextPath + '/admin/classes';
        } else {
            alert('Xóa lớp học thất bại');
        }
    }

    function openStudentModal() {
        const m = document.getElementById('studentModal');
        m.style.display = 'flex';
    }

    function closeStudentModal() {
        document.getElementById('studentModal').style.display = 'none';
    }

    async function addSelectedStudents() {
        const checkboxes = document.querySelectorAll('input[name="selectedStudents"]:checked');
        const studentIds = Array.from(checkboxes).map(cb => Number(cb.value));
        if (studentIds.length === 0) { alert('Vui lòng chọn ít nhất một học sinh'); return; }
        const res = await fetch(contextPath + '/api/admin/classes/' + classId + '/students', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify({ studentIds: studentIds })
        });
        if (res.ok) { alert('Đã thêm học sinh thành công'); location.reload(); }
        else { alert('Thêm học sinh thất bại'); }
    }

    async function removeStudent(studentId) {
        if (!confirm('Bạn có chắc muốn xóa học sinh này khỏi lớp?')) return;
        const res = await fetch(contextPath + '/api/admin/classes/' + classId + '/students/' + studentId, {
            method: 'DELETE'
        });
        if (res.ok) { alert('Đã xóa học sinh khỏi lớp'); location.reload(); }
        else { alert('Xóa học sinh thất bại'); }
    }

       // Thay đổi trạng thái lớp học
    function changeStatusText() {
        const toggle = document.getElementById('statusToggle');
        const text = document.getElementById('statusText');

        if (toggle.checked) {
            text.innerText = 'Đang hoạt động';
            text.style.color = '#16a34a';
        } else {
            text.innerText = 'Tạm dừng';
            text.style.color = '#dc2626';
        }
    }
    // lâys thông tin gia sư
    function handleTutorChange(select) {
        const option = select.options[select.selectedIndex];
        if (!option.value) return;
        
        const tutorData = {
            id: option.value,
            name: option.getAttribute('data-name'),
            major: option.getAttribute('data-major'),
            school: option.getAttribute('data-school'),
            phone: option.getAttribute('data-phone'),
            email: option.getAttribute('data-email'),
            avatar: option.getAttribute('data-avatar')
        };
        
        selectTutor(tutorData);
    }

    function selectTutor(data) {
        document.getElementById('tutorId').value = data.id;
        document.getElementById('currentTutorName').innerText = data.name;
        document.getElementById('currentTutorMajor').innerText = data.major;
        document.getElementById('currentTutorSchool').innerText = data.school;
        document.getElementById('currentTutorPhone').innerText = data.phone;
        document.getElementById('currentTutorEmail').innerText = data.email;
        
        document.getElementById('tutorExtraInfo').style.display = 'block';

        let avatarPath = data.avatar;
        if (!avatarPath || avatarPath === '') {
            avatarPath = contextPath + '/images/default-avatar.png';
        } else if (!avatarPath.startsWith('http')) {
            avatarPath = contextPath + '/uploads/' + avatarPath;
        }
        document.getElementById('tutorAvatar').src = avatarPath;
    }
</script>

</body>
</html>