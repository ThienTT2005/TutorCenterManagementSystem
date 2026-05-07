<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="activePage" value="classes" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết lớp học | TCMS Tutor</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0"/>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/tutor-dashboard.css">

    <style>
        .class-detail-page {
            padding: 2rem;
        }

        /* ===== HEADER / HERO ===== */
        .class-hero {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 24px;
            padding: 1.75rem;
            box-shadow: 0 8px 24px rgba(15, 23, 42, 0.05);
            display: flex;
            flex-direction: column;
            margin-bottom: 1.5rem;
        }

        .class-hero-top {
            width: 100%;
            display: grid;
            grid-template-columns: minmax(0, 1fr) 280px;
            gap: 2rem;
            align-items: start;
        }

        .class-hero-main {
            min-width: 0;
        }

        .hero-badges {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            margin-bottom: 12px;
        }

        .badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 11px;
            border-radius: 999px;
            font-size: 11px;
            font-weight: 900;
            white-space: nowrap;
        }

        .badge.subject {
            background: #eff6ff;
            color: #0057bf;
        }

        .badge.grade {
            background: #f3e8ff;
            color: #7e22ce;
        }

        .badge.active {
            background: #dcfce7;
            color: #16a34a;
        }

        .badge.inactive {
            background: #fee2e2;
            color: #dc2626;
        }

        .badge.gray {
            background: #f1f5f9;
            color: #64748b;
        }

        .badge.orange {
            background: #fff7ed;
            color: #ea580c;
        }

        .class-hero h1 {
            font-size: 28px;
            line-height: 1.25;
            font-weight: 900;
            color: #0f172a;
            margin-bottom: 10px;
        }

        .hero-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 16px;
            color: #64748b;
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 14px;
        }

        .hero-meta span {
            display: inline-flex;
            align-items: center;
            gap: 7px;
        }

        .hero-desc {
            color: #475569;
            font-size: 14px;
            line-height: 1.65;
            max-width: 820px;
        }

        .hero-back-btn {
            min-height: 68px;
            width: 100%;
            max-width: 280px;
            border-radius: 999px;
            background: #0057bf;
            color: #ffffff;
            font-size: 14px;
            font-weight: 800;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            text-decoration: none;
            justify-self: end;
            margin-top: 3.8rem;
            border: 0;
            transition: all .2s ease;
        }

        .hero-back-btn:hover {
            background: #004da8;
            color: #ffffff;
            transform: translateY(-1px);
        }

        /* ===== QUICK INFO IN HERO ===== */
        .quick-card.quick-card-light {
            width: 100%;
            background: transparent;
            border: 0;
            box-shadow: none;
            border-radius: 0;
            padding: 1.25rem 0 0;
            margin-top: 1.5rem;
            border-top: 1px solid #eef2f7;
        }

        .quick-card.quick-card-light h3 {
            font-size: 20px;
            font-weight: 900;
            color: #0f172a;
            margin-bottom: 1.25rem;
        }

        .quick-info-grid {
            width: 100%;
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 16px;
        }

        .quick-info-box {
            min-height: 86px;
            background: #f8fafc;
            border-radius: 16px;
            padding: 16px 18px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .quick-info-box span {
            color: #64748b;
            font-size: 13px;
            font-weight: 800;
            margin-bottom: 8px;
        }

        .quick-info-box strong {
            color: #0f172a;
            font-size: 18px;
            font-weight: 900;
            line-height: 1.3;
        }

        .text-success {
            color: #16a34a !important;
        }

        .text-muted {
            color: #64748b !important;
        }

        /* Nếu HTML cũ vẫn còn nút này thì ẩn đi */
        .btn-back-list {
            display: none !important;
        }

        /* Nếu block STATS cũ vẫn còn trong JSP thì ẩn đi để tránh trùng dữ liệu */
        .stats-grid-detail {
            display: none;
        }

        /* ===== MAIN LAYOUT ===== */
        .detail-layout {
            display: block;
        }

        .detail-left {
            width: 100%;
            min-width: 0;
        }



        .panel-card,
        .session-card,
        .upcoming-section {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 22px;
            box-shadow: 0 8px 24px rgba(15, 23, 42, 0.05);
        }

        .panel-card {
            padding: 1.5rem;
        }

        .panel-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1.25rem;
        }

        .panel-header h2 {
            font-size: 18px;
            font-weight: 900;
            color: #0f172a;
        }
        .detail-sections {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        .detail-section-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 22px;
            box-shadow: 0 8px 24px rgba(15, 23, 42, 0.05);
            padding: 1.5rem;
        }

        .detail-section-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 1rem;
            margin-bottom: 1.25rem;
        }

        .detail-section-header h2 {
            font-size: 18px;
            font-weight: 900;
            color: #0f172a;
            margin: 0;
        }

        .detail-section-header p {
            margin: 6px 0 0;
            color: #64748b;
            font-size: 13px;
            font-weight: 600;
        }

        .section-count-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 7px 12px;
            border-radius: 999px;
            background: #eff6ff;
            color: #0057bf;
            font-size: 12px;
            font-weight: 900;
            white-space: nowrap;
        }

        .session-table-wrap {
            overflow-x: auto;
        }

        .session-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 900px;
        }

        .session-table th,
        .session-table td {
            padding: 14px 12px;
            border-bottom: 1px solid #f1f5f9;
            text-align: left;
            font-size: 13px;
            vertical-align: middle;
        }

        .session-table th {
            color: #64748b;
            font-size: 11px;
            text-transform: uppercase;
            font-weight: 900;
            letter-spacing: .3px;
        }

        .session-topic-cell strong {
            display: block;
            color: #0f172a;
            font-size: 14px;
            font-weight: 900;
            margin-bottom: 4px;
        }

        .session-topic-cell span {
            color: #64748b;
            font-size: 12px;
            font-weight: 600;
        }

        .session-code {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            color: #64748b;
            font-size: 12px;
            font-weight: 700;
        }

        .session-action-table {
            display: grid;
            grid-template-columns: repeat(2, minmax(105px, 1fr));
            gap: 8px;
        }

        @media (max-width: 760px) {
            .detail-section-header {
                flex-direction: column;
            }

            .session-action-table {
                grid-template-columns: 1fr;
            }
        }
        /* ===== STUDENT TABLE ===== */
        .student-table-wrap {
            overflow-x: auto;
        }

        .student-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 760px;
        }

        .student-table th,
        .student-table td {
            padding: 14px 12px;
            border-bottom: 1px solid #f1f5f9;
            text-align: left;
            font-size: 13px;
        }

        .student-table th {
            color: #64748b;
            font-size: 11px;
            text-transform: uppercase;
            font-weight: 900;
            letter-spacing: .3px;
        }

        .student-info {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .avatar {
            width: 36px;
            height: 36px;
            border-radius: 999px;
            background: #eff6ff;
            color: #0057bf;
            font-size: 13px;
            font-weight: 900;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            text-transform: uppercase;
        }

        .student-info strong {
            color: #0f172a;
            font-weight: 800;
        }

        .student-status {
            display: inline-flex;
            padding: 5px 10px;
            border-radius: 999px;
            font-size: 11px;
            font-weight: 900;
        }

        .student-status.active {
            background: #dcfce7;
            color: #16a34a;
        }

        .student-status.paused {
            background: #fee2e2;
            color: #dc2626;
        }

        .empty-card,
        .empty-row {
            text-align: center;
            color: #64748b;
            font-size: 14px;
            padding: 2rem !important;
        }

        /* ===== SESSIONS ===== */
        .session-list {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .session-card {
            padding: 1.25rem;
            display: grid;
            grid-template-columns: minmax(0, 1fr) auto;
            gap: 1rem;
            align-items: center;
            transition: all .2s ease;
        }

        .session-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 24px rgba(15, 23, 42, 0.08);
        }

        .session-main {
            min-width: 0;
        }

        .session-top {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            margin-bottom: 10px;
        }

        .session-main h3 {
            font-size: 16px;
            font-weight: 900;
            color: #0f172a;
            margin-bottom: 8px;
        }

        .session-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 14px;
            color: #64748b;
            font-size: 13px;
            font-weight: 600;
        }

        .session-meta span {
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .session-actions {
            display: grid;
            grid-template-columns: repeat(2, minmax(125px, 1fr));
            gap: 8px;
        }

        .session-action {
            min-height: 36px;
            border-radius: 10px;
            padding: 0 12px;
            font-size: 12px;
            font-weight: 900;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 7px;
            text-decoration: none;
            transition: all .2s ease;
            white-space: nowrap;
        }

        .session-action.blue {
            background: #eff6ff;
            color: #0057bf;
        }

        .session-action.green {
            background: #dcfce7;
            color: #16a34a;
        }

        .session-action.purple {
            background: #f3e8ff;
            color: #7e22ce;
        }

        .session-action.orange {
            background: #fff7ed;
            color: #ea580c;
        }

        .session-action.detail {
            background: #0f172a;
            color: #ffffff;
        }

        .session-action.disabled {
            background: #f1f5f9 !important;
            color: #94a3b8 !important;
            border: 1px solid #e2e8f0;
        }

        .session-action:hover {
            filter: brightness(.97);
            transform: translateY(-1px);
        }

        /* ===== UPCOMING ===== */
        .upcoming-section {
            padding: 1.5rem;
            margin-top: 1rem;
        }

        .upcoming-section h2 {
            font-size: 18px;
            font-weight: 900;
            color: #0f172a;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .upcoming-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 1rem;
        }

        .upcoming-card {
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            padding: 1rem;
            background: #f8fafc;
        }

        .upcoming-card h3 {
            font-size: 15px;
            font-weight: 900;
            color: #0f172a;
            margin: 8px 0;
        }

        .upcoming-card p {
            color: #64748b;
            font-size: 13px;
        }

        /* ===== RIGHT SIDEBAR OLD BLOCKS, IF STILL USED ===== */
        .detail-sidebar {
            display: none;
        }

        /* ===== RESPONSIVE ===== */
        @media (max-width: 1100px) {
            .class-hero-top {
                grid-template-columns: 1fr;
            }

            .hero-back-btn {
                justify-self: start;
                margin-top: 0;
                max-width: 260px;
                min-height: 48px;
                border-radius: 14px;
            }

            .quick-info-grid {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }
        }

        @media (max-width: 760px) {
            .class-detail-page {
                padding: 1rem;
            }

            .tabs {
                overflow-x: auto;
            }

            .tab-btn {
                white-space: nowrap;
            }

            .session-card {
                grid-template-columns: 1fr;
            }

            .session-actions {
                grid-template-columns: 1fr;
            }

            .upcoming-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 640px) {
            .class-hero {
                padding: 1.25rem;
            }

            .quick-info-grid {
                grid-template-columns: 1fr;
            }

            .hero-back-btn {
                width: 100%;
                max-width: none;
            }
        }
    </style>
</head>

<body>

<jsp:include page="../common/sidebar.jsp" />

<div class="main-content">
    <jsp:include page="../common/header.jsp" />

    <main class="class-detail-page">

        <!-- HEADER -->
        <section class="class-hero">

            <div class="class-hero-top">
                <div class="class-hero-main">
                    <div class="hero-badges">
                <span class="badge subject">
                    <i class="fa-solid fa-book-open"></i>
                    <c:out value="${empty classItem.subject ? 'Môn học' : classItem.subject}" />
                </span>

                        <span class="badge grade">
                    <i class="fa-solid fa-layer-group"></i>
                    Khối <c:out value="${empty classItem.grade ? '?' : classItem.grade}" />
                </span>

                        <c:choose>
                            <c:when test="${classItem.status == true}">
                        <span class="badge active">
                            <i class="fa-solid fa-circle-check"></i>
                            Đang hoạt động
                        </span>
                            </c:when>
                            <c:otherwise>
                        <span class="badge inactive">
                            <i class="fa-solid fa-circle-xmark"></i>
                            Đã kết thúc
                        </span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <h1>
                        <c:out value="${empty classItem.className ? 'Chi tiết lớp học' : classItem.className}" />
                    </h1>

                    <div class="hero-meta">
                <span>
                    <i class="fa-solid fa-users"></i>
                    ${empty enrollments ? 0 : fn:length(enrollments)} học sinh
                </span>

                        <span>
                    <i class="fa-solid fa-calendar-days"></i>
                    ${empty sessions ? 0 : fn:length(sessions)} buổi học đã tạo
                </span>

                        <span>
                    <i class="fa-solid fa-hashtag"></i>
                    Mã lớp #<c:out value="${classItem.classId}" />
                </span>
                    </div>

                    <p class="hero-desc">
                        <c:out value="${empty classItem.description ? 'Chưa có mô tả cho lớp học này.' : classItem.description}" />
                    </p>
                </div>

                <a href="${pageContext.request.contextPath}/tutor/classes" class="hero-back-btn">
                    <i class="fa-solid fa-arrow-left"></i>
                    Danh sách lớp
                </a>
            </div>

            <div class="quick-card quick-card-light">
                <h3>Thông tin nhanh</h3>

                <div class="quick-info-grid">
                    <div class="quick-info-box">
                        <span>Môn học</span>
                        <strong>
                            <c:out value="${empty classItem.subject ? '---' : classItem.subject}" />
                        </strong>
                    </div>

                    <div class="quick-info-box">
                        <span>Khối lớp</span>
                        <strong>
                            <c:out value="${empty classItem.grade ? '---' : classItem.grade}" />
                        </strong>
                    </div>

                    <div class="quick-info-box">
                        <span>Học phí</span>
                        <strong>
                            <fmt:formatNumber value="${empty classItem.tuitionFeePerSession ? 0 : classItem.tuitionFeePerSession}" pattern="#,###"/>đ/buổi
                        </strong>
                    </div>

                    <div class="quick-info-box">
                        <span>Số buổi yêu cầu</span>
                        <strong>${empty classItem.requiredSessions ? 0 : classItem.requiredSessions} buổi</strong>
                    </div>

                    <div class="quick-info-box">
                        <span>Trạng thái</span>
                        <strong class="${classItem.status ? 'text-success' : 'text-muted'}">
                            ${classItem.status ? 'Đang hoạt động' : 'Đã kết thúc'}
                        </strong>
                    </div>

                    <div class="quick-info-box">
                        <span>Số học sinh</span>
                        <strong>${empty enrollments ? 0 : fn:length(enrollments)} học sinh</strong>
                    </div>
                </div>
            </div>

        </section>
        <!-- STATS -->
        <section class="stats-grid-detail">
            <div class="mini-stat">
                <div class="mini-icon">
                    <i class="fa-solid fa-user-group"></i>
                </div>
                <div>
                    <div class="mini-label">Tổng học sinh</div>
                    <div class="mini-value">${empty enrollments ? 0 : fn:length(enrollments)}</div>
                </div>
            </div>

            <div class="mini-stat">
                <div class="mini-icon" style="background:#f3e8ff;color:#7e22ce;">
                    <i class="fa-solid fa-calendar-days"></i>
                </div>
                <div>
                    <div class="mini-label">Buổi học đã tạo</div>
                    <div class="mini-value">${empty sessions ? 0 : fn:length(sessions)}</div>
                </div>
            </div>

            <div class="mini-stat">
                <div class="mini-icon" style="background:#dcfce7;color:#16a34a;">
                    <i class="fa-solid fa-money-bill-wave"></i>
                </div>
                <div>
                    <div class="mini-label">Học phí / buổi</div>
                    <div class="mini-value" style="font-size:18px;">
                        <c:choose>
                            <c:when test="${not empty classItem.tuitionFeePerSession}">
                                <fmt:formatNumber value="${classItem.tuitionFeePerSession}" pattern="#,###" />đ
                            </c:when>
                            <c:otherwise>0đ</c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <div class="mini-stat">
                <div class="mini-icon" style="background:#fff7ed;color:#ea580c;">
                    <i class="fa-solid fa-list-check"></i>
                </div>
                <div>
                    <div class="mini-label">Số buổi yêu cầu</div>
                    <div class="mini-value">${empty classItem.requiredSessions ? 0 : classItem.requiredSessions}</div>
                </div>
            </div>
        </section>

        <!-- MAIN LAYOUT -->
        <section class="detail-layout">

            <!-- LEFT -->
            <div class="detail-left">
                <div class="detail-sections">
                    <section class="upcoming-section">
                        <h2>
                            <i class="fa-solid fa-calendar-plus"></i>
                            Buổi học gần nhất
                        </h2>

                        <div class="upcoming-grid">
                            <c:choose>
                                <c:when test="${not empty sessions}">
                                    <c:forEach var="s" items="${sessions}" begin="0" end="1">
                                        <div class="upcoming-card">
                                        <span class="badge subject">
                                            <c:out value="${empty s.sessionDate ? 'Chưa có ngày' : s.sessionDate}" />
                                        </span>

                                            <span class="badge gray">
                                            <c:out value="${empty s.status ? 'Chưa cập nhật' : s.status}" />
                                        </span>

                                            <h3>
                                                <c:out value="${empty s.topic ? 'Chưa cập nhật chủ đề' : s.topic}" />
                                            </h3>

                                            <p>
                                                <i class="fa-regular fa-clock"></i>
                                                <c:out value="${empty s.startTime ? '--:--' : s.startTime}" />
                                                -
                                                <c:out value="${empty s.endTime ? '--:--' : s.endTime}" />
                                            </p>
                                        </div>
                                    </c:forEach>
                                </c:when>

                                <c:otherwise>
                                    <div class="empty-card" style="grid-column: 1 / -1;">
                                        Chưa có buổi học gần nhất.
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </section>
                </div>
                    <!-- STUDENTS TABLE -->
                    <section class="detail-section-card">
                        <div class="detail-section-header">
                            <div>
                                <h2>
                                    Học sinh lớp
                                    <c:out value="${empty classItem.className ? '' : classItem.className}" />
                                </h2>
                                <p>Danh sách học sinh đang được đăng ký trong lớp học này.</p>
                            </div>

                            <span class="section-count-badge">
                <i class="fa-solid fa-users"></i>
                ${empty enrollments ? 0 : fn:length(enrollments)} học sinh
            </span>
                        </div>

                        <div class="student-table-wrap">
                            <table class="student-table">
                                <thead>
                                <tr>
                                    <th>Học sinh</th>
                                    <th>Giới tính</th>
                                    <th>Trường</th>
                                    <th>Khối</th>
                                    <th>Trạng thái</th>
                                </tr>
                                </thead>

                                <tbody>
                                <c:choose>
                                    <c:when test="${not empty enrollments}">
                                        <c:forEach var="e" items="${enrollments}">
                                            <tr>
                                                <td>
                                                    <div class="student-info">
                                                        <div class="avatar">
                                                            <c:choose>
                                                                <c:when test="${not empty e.student and not empty e.student.fullName}">
                                                                    ${fn:substring(e.student.fullName, 0, 1)}
                                                                </c:when>
                                                                <c:otherwise>?</c:otherwise>
                                                            </c:choose>
                                                        </div>

                                                        <strong>
                                                            <c:out value="${not empty e.student and not empty e.student.fullName ? e.student.fullName : 'Học sinh'}" />
                                                        </strong>
                                                    </div>
                                                </td>

                                                <td>
                                                    <c:out value="${not empty e.student and not empty e.student.gender ? e.student.gender : 'Chưa cập nhật'}" />
                                                </td>

                                                <td>
                                                    <c:out value="${not empty e.student and not empty e.student.school ? e.student.school : 'Chưa cập nhật'}" />
                                                </td>

                                                <td>
                                                    <c:out value="${not empty e.student and not empty e.student.grade ? e.student.grade : 'Chưa cập nhật'}" />
                                                </td>

                                                <td>
                                                    <c:choose>
                                                        <c:when test="${e.status == true}">
                                                            <span class="student-status active">Đang học</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="student-status paused">Tạm dừng</span>
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
                    </section>

                    <!-- SESSIONS TABLE -->
                    <section class="detail-section-card">
                        <div class="detail-section-header">
                            <div>
                                <h2>Lịch học cụ thể</h2>
                                <p>Danh sách các buổi học đã được tạo cho lớp này.</p>
                            </div>

                            <span class="section-count-badge">
                <i class="fa-solid fa-calendar-days"></i>
                ${empty sessions ? 0 : fn:length(sessions)} buổi học
            </span>
                        </div>

                        <div class="session-table-wrap">
                            <table class="session-table">
                                <thead>
                                <tr>
                                    <th>Ngày học</th>
                                    <th>Thời gian</th>
                                    <th>Chủ đề</th>
                                    <th>Mã điểm danh</th>
                                    <th>Trạng thái</th>
                                    <th>Thao tác</th>
                                </tr>
                                </thead>

                                <tbody>
                                <c:choose>
                                    <c:when test="${not empty sessions}">
                                        <c:forEach var="s" items="${sessions}">
                                            <tr>
                                                <td>
                                    <span class="badge subject">
                                        <i class="fa-regular fa-calendar"></i>
                                        <c:out value="${empty s.sessionDate ? 'Chưa có ngày' : s.sessionDate}" />
                                    </span>
                                                </td>

                                                <td>
                                    <span class="session-code">
                                        <i class="fa-regular fa-clock"></i>
                                        <c:out value="${empty s.startTime ? '--:--' : s.startTime}" />
                                        -
                                        <c:out value="${empty s.endTime ? '--:--' : s.endTime}" />
                                    </span>
                                                </td>

                                                <td>
                                                    <div class="session-topic-cell">
                                                        <strong>
                                                            <c:out value="${empty s.topic ? 'Chưa cập nhật chủ đề' : s.topic}" />
                                                        </strong>
                                                        <span>
                                            Buổi học #<c:out value="${s.sessionId}" />
                                        </span>
                                                    </div>
                                                </td>

                                                <td>
                                    <span class="session-code">
                                        <i class="fa-solid fa-key"></i>
                                        <c:out value="${empty s.attendanceCode ? 'Chưa có' : s.attendanceCode}" />
                                    </span>
                                                </td>

                                                <td>
                                    <span class="badge gray">
                                        <i class="fa-solid fa-circle-info"></i>
                                        <c:out value="${empty s.status ? 'Chưa cập nhật' : s.status}" />
                                    </span>
                                                </td>

                                                <td>
                                                    <div class="session-action-table">
                                                        <a class="session-action blue"
                                                           href="${pageContext.request.contextPath}/tutor/sessions/${s.sessionId}/attendance">
                                                            <i class="fa-solid fa-user-check"></i>
                                                            Điểm danh
                                                        </a>

                                                        <a class="session-action green"
                                                           href="${pageContext.request.contextPath}/tutor/sessions/${s.sessionId}/feedback">
                                                            <i class="fa-solid fa-comment-dots"></i>
                                                            Feedback
                                                        </a>

                                                        <a class="session-action purple"
                                                           href="${pageContext.request.contextPath}/tutor/sessions/${s.sessionId}/learning-plan">
                                                            <i class="fa-solid fa-clipboard-list"></i>
                                                            Kế hoạch
                                                        </a>

                                                        <a class="session-action orange"
                                                           href="${pageContext.request.contextPath}/tutor/homework/session/${s.sessionId}">
                                                            <i class="fa-solid fa-book-open-reader"></i>
                                                            Bài tập
                                                        </a>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>

                                    <c:otherwise>
                                        <tr>
                                            <td colspan="6" class="empty-row">
                                                Chưa có buổi học nào được tạo cho lớp này.
                                            </td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </section>

                </div>





                <!-- UPCOMING -->


            <!-- RIGHT SIDEBAR -->
            <aside class="detail-sidebar">


                <div class="quick-card">
                    <h3>Tiến độ tạo buổi học</h3>

                    <div class="progress-number">
                        <strong>${empty sessions ? 0 : fn:length(sessions)}</strong>
                        <span>/ ${empty classItem.requiredSessions ? 0 : classItem.requiredSessions} buổi đã tạo</span>
                    </div>

                    <div class="progress-bar">
                        <div style="width:
                        <c:choose>
                        <c:when test='${not empty classItem.requiredSessions and classItem.requiredSessions > 0 and not empty sessions}'>
                            ${fn:length(sessions) * 100 / classItem.requiredSessions}%
                        </c:when>
                        <c:otherwise>0%</c:otherwise>
                                </c:choose>">
                        </div>
                    </div>

                    <small>
                        Đây là tiến độ số buổi đã được tạo trên hệ thống, không phải số buổi đã hoàn thành.
                    </small>
                </div>

                <div class="quick-card">
                    <h3>Truy cập nhanh</h3>

                    <div class="quick-link-list">
                        <a href="${pageContext.request.contextPath}/tutor/classes" class="quick-link">
                            <i class="fa-solid fa-arrow-left"></i>
                            Lớp của tôi
                        </a>

                        <button type="button" class="quick-link" data-go-tab="sessions" style="border:0;cursor:pointer;width:100%;">
                            <i class="fa-solid fa-calendar-days"></i>
                            Xem lịch dạy
                        </button>

                        <button type="button" class="quick-link" data-go-tab="students" style="border:0;cursor:pointer;width:100%;">
                            <i class="fa-solid fa-users"></i>
                            Xem học sinh
                        </button>
                    </div>
                </div>

            </aside>
        </section>

    </main>
</div>
</body>
</html>
