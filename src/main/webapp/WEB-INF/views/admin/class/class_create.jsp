<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tạo lớp học mới</title>

    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0"/>
    <link rel="stylesheet" href="<c:url value='/css/core-dashboard.css' />">

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            background: #f7faff;
            font-family: 'Inter', system-ui, sans-serif;
            color: #0f172a;
        }

        .create-page {
            padding: 26px 28px 96px;
        }

        .page-title {
            margin-bottom: 28px;
        }

        .page-title h1 {
            margin: 0;
            font-size: 26px;
            font-weight: 800;
        }

        .page-title p {
            margin: 8px 0 0;
            color: #64748b;
            font-size: 14px;
        }

        .create-form {
            display: grid;
            grid-template-columns: minmax(0, 2fr) 360px;
            gap: 26px;
        }

        .left-col,
        .right-col {
            display: flex;
            flex-direction: column;
            gap: 24px;
        }

        .card {
            background: #fff;
            border: 1px solid #edf2f7;
            border-radius: 18px;
            padding: 24px;
            box-shadow: 0 10px 28px rgba(15, 23, 42, 0.04);
        }

        .card-title {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 22px;
        }

        .card-title h2 {
            margin: 0;
            font-size: 17px;
            font-weight: 800;
        }

        .title-icon {
            width: 36px;
            height: 36px;
            border-radius: 10px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 21px;
        }

        .blue {
            background: #eff6ff;
            color: #2563eb;
        }

        .cyan {
            background: #cffafe;
            color: #0891b2;
        }

        .purple {
            background: #f3e8ff;
            color: #7c3aed;
        }

        .orange {
            background: #fff7ed;
            color: #f97316;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 18px;
        }

        .form-group {
            margin-bottom: 18px;
        }

        .form-group.full {
            width: 100%;
        }

        label {
            display: block;
            font-size: 11px;
            color: #64748b;
            font-weight: 800;
            text-transform: uppercase;
            margin-bottom: 8px;
        }

        input,
        select,
        textarea {
            width: 100%;
            height: 44px;
            border: 1px solid #dbe3ef;
            background: #fff;
            border-radius: 10px;
            padding: 0 14px;
            outline: none;
            font-size: 14px;
            color: #334155;
        }

        textarea {
            height: 120px;
            padding-top: 14px;
            resize: vertical;
        }

        input:focus,
        select:focus,
        textarea:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.08);
        }

        .status-box {
            margin-top: 4px;
            padding: 17px 18px;
            background: #f8fafc;
            border-radius: 14px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .status-box b {
            font-size: 14px;
        }

        .status-box p {
            margin: 4px 0 0;
            font-size: 12px;
            color: #64748b;
        }

        .status-right {
            display: flex;
            align-items: center;
            gap: 12px;
            color: #16a34a;
            font-size: 12px;
            font-weight: 800;
        }

        .switch {
            position: relative;
            width: 48px;
            height: 26px;
        }

        .switch input {
            display: none;
        }

        .switch span {
            position: absolute;
            inset: 0;
            background: #cbd5e1;
            border-radius: 999px;
            cursor: pointer;
        }

        .switch span:before {
            content: "";
            position: absolute;
            width: 20px;
            height: 20px;
            top: 3px;
            left: 3px;
            border-radius: 50%;
            background: #fff;
            transition: 0.2s;
        }

        .switch input:checked + span {
            background: #2563eb;
        }

        .switch input:checked + span:before {
            transform: translateX(22px);
        }

        .right-card-large {
            min-height: 360px;
        }

        .search-select {
            position: relative;
        }

        .search-select .material-symbols-rounded {
            position: absolute;
            left: 12px;
            top: 12px;
            font-size: 19px;
            color: #94a3b8;
        }

        .search-select select {
            padding-left: 40px;
        }

        .student-head {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 14px;
            margin-bottom: 14px;
        }

        .student-head .card-title {
            margin: 0;
        }

        .student-tools {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .student-search {
            position: relative;
            width: 230px;
        }

        .student-search input {
            height: 38px;
            padding-left: 38px;
        }

        .student-search .material-symbols-rounded {
            position: absolute;
            left: 12px;
            top: 9px;
            font-size: 19px;
            color: #94a3b8;
        }

        .filter-btn {
            width: 38px;
            height: 38px;
            border-radius: 10px;
            border: 1px solid #dbe3ef;
            background: #fff;
            color: #64748b;
            cursor: pointer;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            text-align: left;
            padding: 12px 10px;
            color: #64748b;
            font-size: 11px;
            font-weight: 900;
            text-transform: uppercase;
            border-bottom: 1px solid #edf2f7;
        }

        td {
            padding: 13px 10px;
            border-bottom: 1px solid #f1f5f9;
            font-size: 13px;
        }

        .student-cell {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .avatar-mini {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            background: #e2e8f0;
            color: #475569;
            font-weight: 800;
            font-size: 11px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .student-cell b {
            font-size: 13px;
        }

        .more {
            color: #64748b;
            font-weight: 900;
            text-align: center;
        }

        .schedule-current {
            border: 1px solid #edf2f7;
            border-radius: 14px;
            padding: 13px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 18px;
            border-left: 5px solid #2563eb;
        }

        .schedule-current b {
            font-size: 13px;
        }

        .schedule-current p {
            margin: 4px 0 0;
            font-size: 12px;
            color: #64748b;
        }

        .schedule-form {
            background: #f8fafc;
            border-radius: 14px;
            padding: 16px;
        }

        .schedule-form label {
            margin-top: 10px;
        }

        .time-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
        }

        .add-schedule-btn {
            width: 100%;
            margin-top: 14px;
            height: 42px;
            border: 1px solid #dbe3ef;
            background: #fff;
            border-radius: 10px;
            font-weight: 800;
            color: #334155;
            cursor: pointer;
        }

        .footer-actions {
            position: fixed;
            left: var(--sidebar-width, 260px);
            right: 0;
            bottom: 0;
            height: 72px;
            background: #fff;
            border-top: 1px solid #e2e8f0;
            box-shadow: 0 -8px 20px rgba(15, 23, 42, 0.06);
            padding: 14px 32px;
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 18px;
            z-index: 1000;
        }

        .cancel-btn {
            color: #334155;
            text-decoration: none;
            font-weight: 700;
            font-size: 14px;
        }

        .submit-btn {
            height: 42px;
            padding: 0 30px;
            border-radius: 12px;
            border: none;
            background: #2563eb;
            color: white;
            font-weight: 800;
            cursor: pointer;
            box-shadow: 0 8px 18px rgba(37, 99, 235, 0.25);
        }

        .empty-cell {
            text-align: center;
            color: #64748b;
            padding: 24px;
        }

        @media (max-width: 1100px) {
            .create-form {
                grid-template-columns: 1fr;
            }

            .footer-actions {
                left: 0;
            }
        }

        /* UI IMPROVEMENTS */
        input[type="checkbox"] {
            width: 16px;
            height: 16px;
            cursor: pointer;
        }

        .schedule-input-row {
            display: grid;
            grid-template-columns: 1.2fr 1fr 1fr auto;
            gap: 12px;
            align-items: flex-end;
            margin-bottom: 12px;
            background: #f8fafc;
            padding: 12px;
            border-radius: 12px;
            border: 1px solid #edf2f7;
        }

        .schedule-input-row label {
            font-size: 10px;
            margin-bottom: 4px;
        }

        .schedule-input-row select,
        .schedule-input-row input {
            height: 36px;
            font-size: 13px;
        }

        .remove-schedule-btn {
            width: 36px;
            height: 36px;
            border-radius: 10px;
            border: 1px solid #fee2e2;
            background: #fef2f2;
            color: #ef4444;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: 0.2s;
        }

        .remove-schedule-btn:hover {
            background: #ef4444;
            color: white;
        }

        .selected-tutor-card {
            margin-top: 20px;
            padding: 16px;
            background: #f8fafc;
            border-radius: 14px;
            display: flex;
            align-items: center;
            gap: 16px;
            border: 1px solid #edf2f7;
            animation: slideUp 0.3s ease;
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .selected-tutor-card.hidden {
            display: none;
        }

        #tutorAvatar {
            width: 70px;
            height: 70px;
            border-radius: 14px;
            object-fit: cover;
            border: 2px solid white;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }

        .tutor-info-content h3 {
            margin: 0;
            font-size: 15px;
            font-weight: 800;
            color: #0f172a;
        }

        .tutor-info-content .major-tag {
            display: inline-block;
            margin: 4px 0 8px;
            font-size: 12px;
            color: #2563eb;
            font-weight: 700;
        }

        .tutor-contact-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 4px;
        }

        .tutor-contact-item {
            display: flex;
            align-items: center;
            gap: 6px;
            font-size: 12px;
            color: #64748b;
        }

        .tutor-contact-item .material-symbols-rounded {
            font-size: 16px;
            color: #94a3b8;
        }

        .tutor-contact-item b {
            color: #475569;
        }
    </style>
</head>

<body>
<c:set var="activePage" value="classes" scope="request"/>
<jsp:include page="../common/sidebar.jsp"/>

<main class="main-content">
    <jsp:include page="../common/header.jsp"/>

    <div class="dashboard-body">
        <div class="create-page">

            <div class="page-title">
                <h1>Tạo lớp học mới</h1>
                <p>Vui lòng điền đầy đủ các thông tin bên dưới để khởi tạo một khóa học mới trên hệ thống.</p>
            </div>

            <c:if test="${not empty error}">
                <div style="background: #fee2e2; color: #dc2626; padding: 14px; border-radius: 12px; margin-bottom: 20px; font-weight: 700; border: 1px solid #fecaca; display: flex; align-items: center; gap: 10px;">
                    <span class="material-symbols-rounded">error</span>
                    ${error}
                </div>
            </c:if>

            <form method="post"
                  action="${pageContext.request.contextPath}/admin/classes/create"
                  class="create-form">

                <div class="left-col">

                    <!-- THÔNG TIN LỚP -->
                    <section class="card">
                        <div class="card-title">
                            <span class="title-icon blue material-symbols-rounded">info</span>
                            <h2>Thông tin lớp học</h2>
                        </div>

                        <div class="form-group full">
                            <label>Tên lớp học</label>
                            <input type="text"
                                   name="className"
                                   placeholder="Ví dụ: Anh Văn Giao Tiếp Cơ Bản A1"
                                   required>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label>Môn học</label>
                                <select name="subject" required>
                                    <option value="Tiếng Anh">Tiếng Anh</option>
                                    <option value="Toán học">Toán học</option>
                                    <option value="Vật lý">Vật lý</option>
                                    <option value="Hóa học">Hóa học</option>
                                    <option value="Ngữ văn">Ngữ văn</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label>Khối / trình độ</label>
                                <select name="grade" required>
                                    <option value="Người đi làm">Người đi làm</option>
                                    <option value="Lớp 10">Lớp 10</option>
                                    <option value="Lớp 11">Lớp 11</option>
                                    <option value="Lớp 12">Lớp 12</option>
                                    <option value="Đại học">Đại học</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label>Học phí (VNĐ/buổi)</label>
                                <input type="number"
                                       name="tuitionFeePerSession"
                                       placeholder="2.500.000"
                                       min="0"
                                       required>
                            </div>

                            <div class="form-group">
                                <label>Số buổi học yêu cầu</label>
                                <input type="number"
                                       name="requiredSessions"
                                       placeholder="24"
                                       min="1"
                                       required>
                            </div>
                        </div>

                        <div class="form-group full">
                            <label>Mô tả chi tiết</label>
                            <textarea name="description"
                                      placeholder="Nhập mục tiêu khóa học và các thông tin liên quan khác..."></textarea>
                        </div>

                        <div class="status-box">
                            <div>
                                <b>Trạng thái lớp học</b>
                                <p>Mặc định lớp sẽ được kích hoạt ngay khi tạo</p>
                            </div>

                            <div class="status-right">
                                <span>Đang hoạt động</span>
                                <label class="switch">
                                    <input type="checkbox" name="status" value="true" checked>
                                    <span></span>
                                </label>
                            </div>
                        </div>
                    </section>

                    <!-- DANH SÁCH HỌC SINH -->
                    <section class="card">
                        <div class="student-head">
                            <div class="card-title">
                                <span class="title-icon purple material-symbols-rounded">group_add</span>
                                <h2>Danh sách học sinh</h2>
                            </div>

                            <div class="student-tools">
                                <div class="student-search">
                                    <span class="material-symbols-rounded">search</span>
                                    <input type="text"
                                           id="studentSearch"
                                           placeholder="Tìm học sinh..."
                                           onkeyup="filterStudents()">
                                </div>

                                <button type="button" class="filter-btn">
                                    <span class="material-symbols-rounded">filter_list</span>
                                </button>
                            </div>
                        </div>

                        <table id="studentTable">
                            <thead>
                            <tr>
                                <th><input type="checkbox" id="checkAllStudents"></th>
                                <th>Học sinh</th>
                                <th>Mã số</th>
                                <th>Khối lớp</th>
                                <th>SĐT phụ huynh</th>
                                <th>Hành động</th>
                            </tr>
                            </thead>

                            <tbody>
                            <c:choose>
                                <c:when test="${empty students}">
                                    <tr>
                                        <td colspan="6" class="empty-cell">Chưa có học sinh</td>
                                    </tr>
                                </c:when>

                                <c:otherwise>
                                    <c:forEach var="student" items="${students}">
                                        <tr>
                                            <td>
                                                <input type="checkbox"
                                                       name="studentIds"
                                                       value="${student.id}">
                                            </td>

                                            <td>
                                                <div class="student-cell">
                                                    <div class="avatar-mini">
                                                        <c:choose>
                                                            <c:when test="${not empty student.fullName}">
                                                                ${fn:substring(student.fullName, 0, 1)}
                                                            </c:when>
                                                            <c:otherwise>HS</c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <b>${student.fullName}</b>
                                                </div>
                                            </td>

                                            <td>STU-${student.id}</td>
                                            <td>${student.grade}</td>

                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty student.parent.phone}">
                                                        ${student.parent.phone}
                                                    </c:when>
                                                    <c:otherwise>Chưa cập nhật</c:otherwise>
                                                </c:choose>
                                            </td>

                                            <td class="more">⋮</td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                            </tbody>
                        </table>
                    </section>
                </div>

                <div class="right-col">

                    <!-- GIA SƯ -->
                    <section class="card right-card-large">
                        <div class="card-title">
                            <span class="title-icon cyan material-symbols-rounded">manage_accounts</span>
                            <h2>Gia sư phụ trách</h2>
                        </div>

                        <div class="search-select">
                            <span class="material-symbols-rounded">search</span>

                            <select name="tutorId" id="tutorSelect" required onchange="showTutorInfo()">
                                <option value="">Chọn gia sư</option>

                                <c:forEach var="tutor" items="${tutors}">
                                    <option value="${tutor.id}"
                                            data-name="${tutor.fullName}"
                                            data-phone="${tutor.phone}"
                                            data-email="${tutor.email}"
                                            data-major="${tutor.major}"
                                            data-school="${tutor.school}"
                                            data-avatar="${not empty tutor.avatar ? tutor.avatar : '/images/default-avatar.png'}">
                                            ${tutor.fullName} - ${tutor.major}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div id="selectedTutorCard" class="selected-tutor-card hidden">
                            <img id="tutorAvatar"
                                 src="${pageContext.request.contextPath}/images/default-avatar.png"
                                 alt="Tutor">

                            <div class="tutor-info-content">
                                <h3 id="tutorName">Tên gia sư</h3>
                                <span id="tutorMajor" class="major-tag">Chuyên ngành</span>

                                <div class="tutor-contact-grid">
                                    <div class="tutor-contact-item">
                                        <span class="material-symbols-rounded">school</span>
                                        <b id="tutorSchool">Trường học</b>
                                    </div>

                                    <div class="tutor-contact-item">
                                        <span class="material-symbols-rounded">call</span>
                                        <b id="tutorPhone">SĐT</b>
                                    </div>

                                    <div class="tutor-contact-item">
                                        <span class="material-symbols-rounded">mail</span>
                                        <b id="tutorEmail">Email</b>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>

                    <!-- LỊCH HỌC -->
                    <section class="card">
                        <div class="card-title">
                            <span class="title-icon orange material-symbols-rounded">calendar_month</span>
                            <h2>Lịch học dự kiến</h2>
                        </div>

                        <div id="scheduleContainer">
                            <div class="schedule-input-row">
                                <div>
                                    <label>Chọn thứ</label>
                                    <select name="weekdays" required>
                                        <option value="2">Thứ 2</option>
                                        <option value="3">Thứ 3</option>
                                        <option value="4">Thứ 4</option>
                                        <option value="5">Thứ 5</option>
                                        <option value="6">Thứ 6</option>
                                        <option value="7">Thứ 7</option>
                                        <option value="8">Chủ nhật</option>
                                    </select>
                                </div>

                                <div>
                                    <label>Giờ bắt đầu</label>
                                    <input type="time" name="startTimes" required>
                                </div>

                                <div>
                                    <label>Giờ kết thúc</label>
                                    <input type="time" name="endTimes" required>
                                </div>

                                <button type="button" class="remove-schedule-btn" onclick="removeSchedule(this)">
                                    ×
                                </button>
                            </div>
                        </div>

                        <button type="button" class="add-schedule-btn" onclick="addSchedule()">
                            ⊕ Thêm lịch học
                        </button>
                    </section>
                </div>

                <div class="footer-actions">
                    <a href="${pageContext.request.contextPath}/admin/classes" class="cancel-btn">
                        Hủy bỏ
                    </a>

                    <button type="submit" name="action" value="create" class="submit-btn">
                        Tạo lớp học
                    </button>
                </div>

            </form>
        </div>
    </div>
</main>

<script>
    function addSchedule() {
        const container = document.getElementById("scheduleContainer");

        const row = document.createElement("div");
        row.className = "schedule-input-row";

        row.innerHTML = `
        <div>
            <label>Thứ</label>
            <select name="weekdays" required>
                <option value="2">Thứ 2</option>
                <option value="3">Thứ 3</option>
                <option value="4">Thứ 4</option>
                <option value="5">Thứ 5</option>
                <option value="6">Thứ 6</option>
                <option value="7">Thứ 7</option>
                <option value="8">Chủ nhật</option>
            </select>
        </div>

        <div>
            <label>Bắt đầu</label>
            <input type="time" name="startTimes" required>
        </div>

        <div>
            <label>Kết thúc</label>
            <input type="time" name="endTimes" required>
        </div>

        <button type="button" class="remove-schedule-btn" onclick="removeSchedule(this)">
            ×
        </button>
    `;

        container.appendChild(row);
    }
    function filterStudents() {
        const keyword = document.getElementById("studentSearch").value.toLowerCase();
        const rows = document.querySelectorAll("#studentTable tbody tr");

        rows.forEach(row => {
            row.style.display = row.innerText.toLowerCase().includes(keyword) ? "" : "none";
        });
    }

    document.getElementById("checkAllStudents")?.addEventListener("change", function () {
        document.querySelectorAll("input[name='studentIds']").forEach(cb => {
            cb.checked = this.checked;
        });
    });

    const contextPath = "${pageContext.request.contextPath}";


    function showTutorInfo() {
        const select = document.getElementById("tutorSelect");
        const option = select.options[select.selectedIndex];
        const card = document.getElementById("selectedTutorCard");

        if (!option.value) {
            card.classList.add("hidden");
            return;
        }

        document.getElementById("tutorName").innerText =
            option.getAttribute("data-name") || "Chưa có tên";

        document.getElementById("tutorMajor").innerText =
            option.getAttribute("data-major") || "Chưa cập nhật";

        document.getElementById("tutorSchool").innerText =
            option.getAttribute("data-school") || "Chưa cập nhật trường";

        document.getElementById("tutorPhone").innerText =
            option.getAttribute("data-phone") || "Chưa có SĐT";

        document.getElementById("tutorEmail").innerText =
            option.getAttribute("data-email") || "Chưa có email";

        let avatar = option.getAttribute("data-avatar") || "/images/default-avatar.png";

        if (!avatar.startsWith("http") && !avatar.startsWith("/")) {
            avatar = contextPath + "/uploads/" + avatar;
        } else if (avatar.startsWith("/")) {
            avatar = contextPath + avatar;
        }

        document.getElementById("tutorAvatar").src = avatar;
        card.classList.remove("hidden");
    }
</script>

</body>
</html>