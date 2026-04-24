<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết tài khoản | TCMS</title>

    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded" />
    <link rel="stylesheet" href="<c:url value='/css/core-dashboard.css' />">

    <style>
        .detail-page {
            padding: 28px;
            background: #f4f8fc;
            min-height: 100vh;
        }

        .breadcrumb {
            font-size: 12px;
            color: #94a3b8;
            margin-bottom: 8px;
            font-weight: 600;
        }

        .breadcrumb span {
            color: #2563eb;
        }

        .detail-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 28px;
        }

        .detail-header h1 {
            font-size: 24px;
            color: #1e3a5f;
            margin: 0;
            font-weight: 900;
        }

        .edit-btn {
            background: #0066cc;
            color: white;
            padding: 12px 20px;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 800;
            box-shadow: 0 6px 16px rgba(0, 102, 204, 0.25);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .detail-layout {
            display: grid;
            grid-template-columns: 300px 1fr;
            gap: 24px;
        }

        .left-column {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .profile-card,
        .account-card,
        .content-card,
        .small-card {
            background: white;
            border-radius: 18px;
            box-shadow: 0 8px 24px rgba(15, 23, 42, 0.06);
            border: 1px solid #eaf0f6;
        }

        .profile-card {
            text-align: center;
            overflow: hidden;
            padding-bottom: 24px;
        }

        .profile-cover {
            height: 90px;
            background: #e9faff;
        }

        .avatar-wrap {
            width: 110px;
            height: 110px;
            margin: -55px auto 12px;
            position: relative;
        }

        .avatar {
            width: 110px;
            height: 110px;
            object-fit: cover;
            border-radius: 22px;
            border: 5px solid white;
            box-shadow: 0 8px 18px rgba(15, 23, 42, 0.18);
        }

        .online-dot {
            position: absolute;
            right: 3px;
            bottom: 8px;
            width: 20px;
            height: 20px;
            background: #22c55e;
            border: 4px solid white;
            border-radius: 50%;
        }

        .profile-card h2 {
            margin: 8px 0 4px;
            font-size: 20px;
            color: #0f172a;
        }

        .profile-card p {
            margin: 0 0 12px;
            color: #64748b;
            font-size: 13px;
            font-weight: 600;
        }

        .status-pill {
            display: inline-block;
            padding: 6px 14px;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 800;
            margin-bottom: 18px;
        }

        .active {
            background: #dcfce7;
            color: #16a34a;
        }

        .locked {
            background: #fee2e2;
            color: #dc2626;
        }

        .btn-dark,
        .btn-light {
            width: calc(100% - 48px);
            border: none;
            border-radius: 10px;
            padding: 13px;
            margin: 6px 24px;
            font-weight: 800;
            cursor: pointer;
        }

        .btn-dark {
            background: #0f172a;
            color: white;
        }

        .btn-light {
            background: #f1f5f9;
            color: #475569;
        }

        .account-card {
            padding: 22px;
        }

        .card-title {
            font-size: 15px;
            font-weight: 900;
            color: #0f172a;
            margin: 0 0 18px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            padding: 14px 0;
            border-bottom: 1px solid #f1f5f9;
            font-size: 13px;
        }

        .info-row:last-child {
            border-bottom: none;
        }

        .info-row span {
            color: #64748b;
            font-weight: 600;
        }

        .info-row strong {
            color: #0f172a;
            font-weight: 800;
        }

        .role-badge {
            padding: 5px 10px;
            border-radius: 6px;
            font-size: 11px;
            font-weight: 900;
            color: #2563eb;
            background: #eff6ff;
        }

        .content-card {
            padding: 24px;
            margin-bottom: 24px;
        }

        .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 24px 70px;
        }

        .field-label {
            display: block;
            font-size: 11px;
            text-transform: uppercase;
            color: #94a3b8;
            font-weight: 900;
            margin-bottom: 6px;
        }

        .field-value {
            margin: 0;
            font-size: 14px;
            color: #0f172a;
            font-weight: 700;
        }

        .full-row {
            grid-column: span 2;
        }

        .parent-box {
            margin-top: 24px;
            background: #f8fafc;
            border-radius: 14px;
            padding: 16px;
        }

        .parent-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .parent-content a {
            background: white;
            border: 1px solid #e2e8f0;
            color: #0f172a;
            padding: 8px 14px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 12px;
            font-weight: 800;
        }

        .table-card table {
            width: 100%;
            border-collapse: collapse;
        }

        .table-card th {
            text-align: left;
            color: #94a3b8;
            font-size: 11px;
            text-transform: uppercase;
            padding: 14px 12px;
            background: #f8fafc;
        }

        .table-card td {
            padding: 16px 12px;
            font-size: 13px;
            color: #0f172a;
            font-weight: 700;
            border-bottom: 1px solid #f1f5f9;
        }

        .green-badge {
            background: #dcfce7;
            color: #16a34a;
            padding: 5px 10px;
            border-radius: 999px;
            font-size: 11px;
            font-weight: 900;
        }

        .blue-badge {
            background: #eff6ff;
            color: #2563eb;
            padding: 5px 10px;
            border-radius: 999px;
            font-size: 11px;
            font-weight: 900;
        }

        .bottom-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 24px;
        }

        .small-card {
            padding: 22px;
        }

        .timeline-item {
            display: flex;
            gap: 12px;
            margin: 18px 0;
        }

        .dot {
            width: 9px;
            height: 9px;
            background: #2563eb;
            border-radius: 50%;
            margin-top: 6px;
        }

        .timeline-title {
            font-size: 14px;
            font-weight: 900;
            color: #0f172a;
            margin: 0;
        }

        .timeline-desc {
            font-size: 12px;
            color: #64748b;
            margin: 4px 0 0;
        }

        .money {
            font-size: 28px;
            font-weight: 900;
            color: #0f172a;
        }

        @media (max-width: 1000px) {
            .detail-layout {
                grid-template-columns: 1fr;
            }

            .bottom-grid,
            .info-grid {
                grid-template-columns: 1fr;
            }

            .full-row {
                grid-column: span 1;
            }
        }
    </style>
</head>

<body>

<c:set var="activePage" value="accounts" scope="request" />

<jsp:include page="../common/sidebar.jsp" />

<main class="main-content">
    <jsp:include page="../common/header.jsp" />

    <div class="detail-page">

        <div class="breadcrumb">
            Hệ thống / Danh sách tài khoản / <span>Chi tiết hồ sơ</span>
        </div>

        <div class="detail-header">
            <h1>
                Hồ sơ
                <c:choose>
                    <c:when test="${user.roleName == 'STUDENT'}">Học sinh</c:when>
                    <c:when test="${user.roleName == 'PARENT'}">Phụ huynh</c:when>
                    <c:when test="${user.roleName == 'TUTOR'}">Gia sư</c:when>
                    <c:otherwise>Quản trị viên</c:otherwise>
                </c:choose>
                : ${user.fullName}
            </h1>

            <a class="edit-btn"
               href="${pageContext.request.contextPath}/admin/accounts/${user.id}/edit">
                <span class="material-symbols-rounded">edit</span>
                Sửa hồ sơ
            </a>
        </div>

        <div class="detail-layout">

            <!-- LEFT -->
            <aside class="left-column">

                <div class="profile-card">
                    <div class="profile-cover"></div>

                    <div class="avatar-wrap">
                        <c:choose>
                            <c:when test="${not empty user.avatar and user.avatar != 'default-avatar.png'}">
                                <img class="avatar" src="${pageContext.request.contextPath}/uploads/${user.avatar}">
                            </c:when>
                            <c:otherwise>
                                <img class="avatar" src="${pageContext.request.contextPath}/images/default-avatar.png">
                            </c:otherwise>
                        </c:choose>
                        <div class="online-dot"></div>
                    </div>

                    <h2>${user.fullName}</h2>
                    <p>ID: #${user.id}</p>

                    <c:choose>
                        <c:when test="${user.status}">
                            <span class="status-pill active">Đang hoạt động</span>
                            <button class="btn-dark" onclick="lockUser(${user.id})">
                                Khóa tài khoản
                            </button>
                        </c:when>
                        <c:otherwise>
                            <span class="status-pill locked">Đã khóa</span>
                            <button class="btn-dark" onclick="unlockUser(${user.id})">
                                Mở khóa tài khoản
                            </button>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="account-card">
                    <h3 class="card-title">
                        <span class="material-symbols-rounded">vpn_key</span>
                        Thông tin tài khoản
                    </h3>

                    <div class="info-row">
                        <span>Tên đăng nhập</span>
                        <strong>${user.username}</strong>
                    </div>

                    <div class="info-row">
                        <span>Vai trò</span>
                        <strong class="role-badge">${user.roleName}</strong>
                    </div>

                    <div class="info-row">
                        <span>Ngày tạo</span>
                        <strong>${user.createdAt}</strong>
                    </div>
                </div>

            </aside>

            <!-- RIGHT -->
            <section>

                <!-- COMMON INFO -->
                <div class="content-card">
                    <h3 class="card-title">
                        <span class="material-symbols-rounded">person</span>
                        Thông tin cá nhân
                    </h3>

                    <div class="info-grid">

                        <!-- STUDENT -->
                        <c:if test="${user.roleName == 'STUDENT'}">
                            <div>
                                <span class="field-label">Trường</span>
                                <p class="field-value">${empty user.school ? '---' : user.school}</p>
                            </div>

                            <div>
                                <span class="field-label">Lớp</span>
                                <p class="field-value">${empty user.grade ? '---' : user.grade}</p>
                            </div>

                            <div>
                                <span class="field-label">Ngày sinh</span>
                                <p class="field-value">${empty user.dob ? '---' : user.dob}</p>
                            </div>

                            <div>
                                <span class="field-label">Giới tính</span>
                                <p class="field-value">${empty user.gender ? '---' : user.gender}</p>
                            </div>

                            <div class="full-row">
                                <span class="field-label">Thông tin phụ huynh</span>

                                <div class="parent-box" style="margin-top: 8px;">
                                    <div class="parent-content">
                                        <div>
                                            <p class="field-value">
                                                    ${empty user.parentName ? 'Chưa gán phụ huynh' : user.parentName}
                                            </p>
                                            <p class="timeline-desc">
                                                ID phụ huynh: ${empty user.parentUserId ? '---' : user.parentUserId}
                                            </p>
                                        </div>

                                        <c:if test="${not empty user.parentUserId}">
                                            <a href="${pageContext.request.contextPath}/admin/accounts/${user.parentUserId}/detail">
                                                Xem hồ sơ
                                            </a>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </c:if>


                        <!-- TUTOR -->
                        <c:if test="${user.roleName == 'TUTOR'}">
                            <div>
                                <span class="field-label">Số điện thoại</span>
                                <p class="field-value">${empty user.phone ? '---' : user.phone}</p>
                            </div>

                            <div>
                                <span class="field-label">Email</span>
                                <p class="field-value">${empty user.email ? '---' : user.email}</p>
                            </div>

                            <div>
                                <span class="field-label">Ngày sinh</span>
                                <p class="field-value">${empty user.dob ? '---' : user.dob}</p>
                            </div>

                            <div>
                                <span class="field-label">Giới tính</span>
                                <p class="field-value">${empty user.gender ? '---' : user.gender}</p>
                            </div>

                            <div class="full-row">
                                <span class="field-label">Địa chỉ</span>
                                <p class="field-value">${empty user.address ? '---' : user.address}</p>
                            </div>

                            <div>
                                <span class="field-label">Trường</span>
                                <p class="field-value">${empty user.school ? '---' : user.school}</p>
                            </div>

                            <div>
                                <span class="field-label">Chuyên ngành</span>
                                <p class="field-value">${empty user.major ? '---' : user.major}</p>
                            </div>

                            <div class="full-row">
                                <span class="field-label">Mô tả</span>
                                <p class="field-value">${empty user.description ? '---' : user.description}</p>
                            </div>
                        </c:if>


                        <!-- PARENT -->
                        <c:if test="${user.roleName == 'PARENT'}">
                            <div>
                                <span class="field-label">Số điện thoại</span>
                                <p class="field-value">${empty user.phone ? '---' : user.phone}</p>
                            </div>

                            <div>
                                <span class="field-label">Email</span>
                                <p class="field-value">${empty user.email ? '---' : user.email}</p>
                            </div>

                            <div>
                                <span class="field-label">Ngày sinh</span>
                                <p class="field-value">${empty user.dob ? '---' : user.dob}</p>
                            </div>

                            <div>
                                <span class="field-label">Giới tính</span>
                                <p class="field-value">${empty user.gender ? '---' : user.gender}</p>
                            </div>

                            <div class="full-row">
                                <span class="field-label">Địa chỉ</span>
                                <p class="field-value">${empty user.address ? '---' : user.address}</p>
                            </div>
                        </c:if>


                        <!-- ADMIN -->
                        <c:if test="${user.roleName == 'ADMIN'}">
                            <div>
                                <span class="field-label">Username</span>
                                <p class="field-value">${user.username}</p>
                            </div>

                            <div>
                                <span class="field-label">Trạng thái</span>
                                <p class="field-value">${user.status ? 'Đang hoạt động' : 'Đã khóa'}</p>
                            </div>
                        </c:if>

                    </div>
                    
                </div>

                <!-- ROLE SPECIFIC -->
                <c:choose>

                    <%-- STUDENT --%>
                    <c:when test="${user.roleName == 'STUDENT'}">

                        <div class="content-card table-card">
                            <h3 class="card-title">
                                <span class="material-symbols-rounded">groups</span>
                                Lớp học đang tham gia
                            </h3>

                            <table>
                                <thead>
                                <tr>
                                    <th>Tên lớp</th>
                                    <th>Môn học</th>
                                    <th>Gia sư</th>
                                    <th>Lịch học</th>
                                    <th>Trạng thái</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${not empty classes}">
                                        <c:forEach items="${classes}" var="cls">
                                            <tr>
                                                <td>${cls.className}</td>
                                                <td>${cls.subject}</td>
                                                <td>${cls.tutorName}</td>
                                                <td>${cls.scheduleText}</td>
                                                <td><span class="green-badge">Đang học</span></td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="5">Chưa có lớp học</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                            </table>
                        </div>

                        <div class="bottom-grid">
                            <div class="small-card">
                                <h3 class="card-title">
                                    <span class="material-symbols-rounded">calendar_month</span>
                                    Lịch học tuần này
                                </h3>

                                <c:choose>
                                    <c:when test="${not empty schedules}">
                                        <c:forEach items="${schedules}" var="s">
                                            <div class="timeline-item">
                                                <div class="dot"></div>
                                                <div>
                                                    <p class="timeline-title">${s.subject}</p>
                                                    <p class="timeline-desc">${s.timeText} - ${s.tutorName}</p>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="timeline-desc">Chưa có lịch học.</p>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="small-card">
                                <h3 class="card-title">
                                    <span class="material-symbols-rounded">assignment</span>
                                    Thống kê học tập
                                </h3>

                                <div class="money">12/15</div>
                                <p class="timeline-desc">Bài tập đã hoàn thành</p>
                            </div>
                        </div>

                    </c:when>

                    <%-- PARENT --%>
                    <c:when test="${user.roleName == 'PARENT'}">

                        <div class="content-card table-card">
                            <h3 class="card-title">
                                <span class="material-symbols-rounded">family_restroom</span>
                                Danh sách con
                            </h3>

                            <table>
                                <thead>
                                <tr>
                                    <th>Tên học sinh</th>
                                    <th>Lớp</th>
                                    <th>Trường</th>
                                    <th>Thao tác</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${not empty children}">
                                        <c:forEach items="${children}" var="child">
                                            <tr>
                                                <td>${child.fullName}</td>
                                                <td>${child.grade}</td>
                                                <td>${child.school}</td>
                                                <td>
                                                    <a href="${pageContext.request.contextPath}/admin/accounts/${child.user.id}/detail">
                                                        Xem hồ sơ
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="4">Phụ huynh chưa có học sinh.</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                            </table>
                        </div>

                        <div class="bottom-grid">
                            <div class="small-card">
                                <h3 class="card-title">
                                    <span class="material-symbols-rounded">payments</span>
                                    Lịch sử thanh toán
                                </h3>

                                <div class="timeline-item">
                                    <div class="dot"></div>
                                    <div>
                                        <p class="timeline-title">Học phí tháng này</p>
                                        <p class="timeline-desc">2.500.000đ</p>
                                    </div>
                                </div>

                                <div class="timeline-item">
                                    <div class="dot"></div>
                                    <div>
                                        <p class="timeline-title">Học phí tháng trước</p>
                                        <p class="timeline-desc">2.500.000đ</p>
                                    </div>
                                </div>
                            </div>

                            <div class="small-card">
                                <h3 class="card-title">
                                    <span class="material-symbols-rounded">event</span>
                                    Lớp học đang theo
                                </h3>

                                <p class="timeline-desc">Danh sách lịch học của các con sẽ hiển thị tại đây.</p>
                            </div>
                        </div>

                    </c:when>

                    <%-- TUTOR --%>
                    <c:when test="${user.roleName == 'TUTOR'}">

                        <div class="content-card table-card">
                            <h3 class="card-title">
                                <span class="material-symbols-rounded">school</span>
                                Lớp đang phụ trách
                                <span class="blue-badge">3 lớp đang dạy</span>
                            </h3>

                            <table>
                                <thead>
                                <tr>
                                    <th>Tên lớp</th>
                                    <th>Môn</th>
                                    <th>Số HS</th>
                                    <th>Lịch học</th>
                                    <th>Trạng thái</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${not empty classes}">
                                        <c:forEach items="${classes}" var="cls">
                                            <tr>
                                                <td>${cls.className}</td>
                                                <td>${cls.subject}</td>
                                                <td>${cls.totalStudents}</td>
                                                <td>${cls.scheduleText}</td>
                                                <td><span class="green-badge">Ổn định</span></td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="5">Gia sư chưa phụ trách lớp nào.</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                            </table>
                        </div>

                        <div class="bottom-grid">
                            <div class="small-card">
                                <h3 class="card-title">
                                    <span class="material-symbols-rounded">calendar_today</span>
                                    Lịch dạy gần nhất
                                </h3>

                                <div class="timeline-item">
                                    <div class="dot"></div>
                                    <div>
                                        <p class="timeline-title">Toán 12-A1</p>
                                        <p class="timeline-desc">19:00 - 21:00 - Phòng 101</p>
                                    </div>
                                </div>

                                <div class="timeline-item">
                                    <div class="dot"></div>
                                    <div>
                                        <p class="timeline-title">Luyện đề 12-B</p>
                                        <p class="timeline-desc">08:00 - 11:30 - Phòng 101</p>
                                    </div>
                                </div>
                            </div>

                            <div class="small-card">
                                <h3 class="card-title">
                                    <span class="material-symbols-rounded">account_balance_wallet</span>
                                    Thu nhập & Thanh toán
                                </h3>

                                <p class="timeline-desc">Tháng này</p>
                                <div class="money">12.500.000đ</div>

                                <div class="info-row">
                                    <span>Đã thanh toán</span>
                                    <strong>8.200k</strong>
                                </div>

                                <div class="info-row">
                                    <span>Chờ duyệt</span>
                                    <strong>4.300k</strong>
                                </div>
                            </div>
                        </div>

                    </c:when>

                </c:choose>

            </section>
        </div>
    </div>
</main>

<script>
    const contextPath = '${pageContext.request.contextPath}';

    async function lockUser(userId) {
        if (!confirm('Bạn có chắc muốn khóa tài khoản này?')) return;

        try {
            const response = await fetch(contextPath + '/api/admin/users/' + userId + '/lock', {
                method: 'PATCH'
            });

            if (!response.ok) {
                throw new Error('Khóa tài khoản thất bại');
            }

            alert('Đã khóa tài khoản');
            window.location.reload();
        } catch (e) {
            alert(e.message);
        }
    }

    async function unlockUser(userId) {
        if (!confirm('Bạn có chắc muốn mở khóa tài khoản này?')) return;

        try {
            const response = await fetch(contextPath + '/api/admin/users/' + userId + '/unlock', {
                method: 'PATCH'
            });

            if (!response.ok) {
                throw new Error('Mở khóa tài khoản thất bại');
            }

            alert('Đã mở khóa tài khoản');
            window.location.reload();
        } catch (e) {
            alert(e.message);
        }
    }
</script>

</body>
</html>