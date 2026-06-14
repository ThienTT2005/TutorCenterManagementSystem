<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="activePage" value="classes" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Kế hoạch học tập</title>

    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0" />

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/parent-dashboard.css">

    <style>
        body {
            margin: 0;
            background: #f7faff;
            color: #0f172a;
            font-family: 'Inter', system-ui, sans-serif;
        }

        .page-wrap {
            padding: 24px 28px;
        }

        .breadcrumb {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 12px;
            color: #64748b;
            margin-bottom: 12px;
        }

        .breadcrumb a {
            color: #2563eb;
            text-decoration: none;
            font-weight: 600;
        }

        .page-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 28px;
        }

        .title-box {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .title-box h1 {
            margin: 0;
            font-size: 28px;
            font-weight: 900;
            color: #111827;
        }

        .status-badge {
            background: #e2e8f0;
            color: #64748b;
            font-size: 11px;
            font-weight: 900;
            padding: 5px 11px;
            border-radius: 999px;
            text-transform: uppercase;
        }

        .status-badge.planned {
            background: #dcfce7;
            color: #16a34a;
        }

        .status-badge.cancelled {
            background: #fee2e2;
            color: #dc2626;
        }

        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            height: 42px;
            padding: 0 18px;
            background: #fff;
            border: 1px solid #e2e8f0;
            color: #334155;
            border-radius: 12px;
            text-decoration: none;
            font-weight: 700;
            font-size: 13px;
            box-shadow: 0 4px 12px rgba(15, 23, 42, 0.04);
        }

        .back-btn:hover {
            background: #f8fafc;
            color: #2563eb;
        }

        .layout {
            display: grid;
            grid-template-columns: minmax(0, 1fr) 340px;
            gap: 24px;
            align-items: start;
        }

        .left-col {
            display: flex;
            flex-direction: column;
            gap: 16px;
            min-width: 0;
        }

        .content-card {
            background: #fff;
            border: 1px solid #e8eef7;
            border-left: 5px solid #2563eb;
            border-radius: 20px;
            padding: 24px;
            box-shadow: 0 10px 28px rgba(15, 23, 42, 0.06);
            height: auto !important;
        }

        .content-card.cyan {
            border-left-color: #06b6d4;
        }

        .card-heading {
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .icon-box {
            width: 34px;
            height: 34px;
            border-radius: 10px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            background: #eff6ff;
            color: #2563eb;
        }

        .icon-box.cyan {
            background: #ecfeff;
            color: #0891b2;
        }

        .card-heading h2 {
            margin: 0;
            font-size: 17px;
            font-weight: 900;
            color: #0f172a;
        }

        .plain-content {
            color: #475569;
            font-size: 14px;
            line-height: 1.7;
            white-space: normal;
            height: auto !important;
            min-height: 0 !important;
            padding: 16px 16px 16px 48px;
            margin-left: 0;
        }

        .info-card {
            grid-column: 2;
            grid-row: 1 / span 2;
            background: #fff;
            border-radius: 18px;
            overflow: hidden;
            border: 1px solid #e8eef7;
            box-shadow: 0 10px 28px rgba(15, 23, 42, 0.08);
            align-self: start;
        }

        .info-header {
            background: #075ecb;
            color: white;
            padding: 24px 26px;
        }

        .info-header span {
            font-size: 11px;
            font-weight: 800;
            opacity: 0.8;
            letter-spacing: 0.08em;
            text-transform: uppercase;
        }

        .info-header h3 {
            margin: 8px 0 0;
            font-size: 20px;
            font-weight: 900;
        }

        .info-row {
            display: grid;
            grid-template-columns: 34px 1fr auto;
            gap: 10px;
            align-items: center;
            padding: 18px 24px;
            border-bottom: 1px solid #f1f5f9;
            font-size: 13px;
        }

        .info-row:last-child {
            border-bottom: none;
        }

        .info-row .material-symbols-rounded {
            font-size: 20px;
            color: #94a3b8;
        }

        .info-label {
            color: #64748b;
            font-weight: 600;
        }

        .info-value {
            color: #0f172a;
            font-weight: 900;
            text-align: right;
        }

        .empty-card {
            background: #fff;
            border: 1px dashed #cbd5e1;
            border-radius: 18px;
            padding: 42px;
            text-align: center;
            color: #64748b;
        }

        .empty-card .material-symbols-rounded {
            font-size: 54px;
            color: #94a3b8;
            margin-bottom: 12px;
        }

        @media (max-width: 1100px) {
            .layout {
                grid-template-columns: 1fr;
            }

            .info-card {
                grid-column: auto;
                grid-row: auto;
            }
        }

        @media (max-width: 600px) {
            .plain-content {
                padding-left: 0;
            }

            .page-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 12px;
            }
        }
    </style>
</head>

<body>

<jsp:include page="../common/sidebar.jsp" />

<main class="main-content">
    <jsp:include page="../common/header.jsp" />

    <div class="dashboard-body">
        <div class="page-wrap">

            <div class="breadcrumb">
                <a href="${pageContext.request.contextPath}/parent/dashboard">Dashboard</a>
                <span>›</span>
                <a href="${pageContext.request.contextPath}/parent/classes">Lớp học</a>
                <span>›</span>

                <c:choose>
                    <c:when test="${not empty plan and not empty plan.session and not empty plan.session.classEntity}">
                        <span>${plan.session.classEntity.className}</span>
                    </c:when>
                    <c:otherwise>
                        <span>Kế hoạch học tập</span>
                    </c:otherwise>
                </c:choose>
            </div>

            <c:choose>
                <c:when test="${empty plan}">
                    <div class="empty-card">
                        <span class="material-symbols-rounded">event_busy</span>
                        <h2>Chưa có kế hoạch học tập</h2>
                        <p>Buổi học này hiện chưa được gia sư cập nhật kế hoạch.</p>

                        <a class="back-btn" href="javascript:history.back()" style="margin-top: 16px;">
                            <span class="material-symbols-rounded">arrow_back</span>
                            Quay lại
                        </a>
                    </div>
                </c:when>

                <c:otherwise>
                    <div class="page-header">
                        <div class="title-box">
                            <h1>
                                <c:choose>
                                    <c:when test="${not empty plan.title}">
                                        ${plan.title}
                                    </c:when>
                                    <c:otherwise>
                                        Kế hoạch học tập
                                    </c:otherwise>
                                </c:choose>
                            </h1>

                            <span class="status-badge
                                ${plan.session.status == 'PLANNED' ? 'planned' : ''}
                                ${plan.session.status == 'CANCELLED' ? 'cancelled' : ''}">
                                    ${empty plan.session.status ? 'LESSON PLAN' : plan.session.status}
                            </span>
                        </div>

                        <a href="javascript:history.back()" class="back-btn">
                            <span class="material-symbols-rounded">arrow_back</span>
                            Quay lại
                        </a>
                    </div>

                    <div class="layout">
                        <div class="left-col">

                            <section class="content-card">
                                <div class="card-heading">
                                    <div class="icon-box">
                                        <span class="material-symbols-rounded">track_changes</span>
                                    </div>
                                    <h2>Mục tiêu học tập</h2>
                                </div>

                                <div class="plain-content">
                                    <c:choose>
                                        <c:when test="${not empty plan.objectives}">
                                            ${plan.objectives}
                                        </c:when>
                                        <c:otherwise>
                                            Chưa có mục tiêu học tập.
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </section>

                            <section class="content-card cyan">
                                <div class="card-heading">
                                    <div class="icon-box cyan">
                                        <span class="material-symbols-rounded">article</span>
                                    </div>
                                    <h2>Nội dung giảng dạy</h2>
                                </div>

                                <div class="plain-content">
                                    <c:choose>
                                        <c:when test="${not empty plan.content}">
                                            ${plan.content}
                                        </c:when>
                                        <c:otherwise>
                                            Chưa có nội dung chi tiết.
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </section>

                        </div>

                        <aside class="info-card">
                            <div class="info-header">
                                <span>Chi tiết lớp học</span>
                                <h3>
                                    <c:choose>
                                        <c:when test="${not empty plan.session.classEntity.className}">
                                            ${plan.session.classEntity.className}
                                        </c:when>
                                        <c:otherwise>
                                            Lớp học
                                        </c:otherwise>
                                    </c:choose>
                                </h3>
                            </div>

                            <div class="info-row">
                                <span class="material-symbols-rounded">subject</span>
                                <div class="info-label">Môn học</div>
                                <div class="info-value">
                                        ${plan.session.classEntity.subject}
                                </div>
                            </div>

                            <div class="info-row">
                                <span class="material-symbols-rounded">tag</span>
                                <div class="info-label">Khối</div>
                                <div class="info-value">
                                        ${plan.session.classEntity.grade}
                                </div>
                            </div>

                            <div class="info-row">
                                <span class="material-symbols-rounded">calendar_month</span>
                                <div class="info-label">Ngày học</div>
                                <div class="info-value">
                                    <c:choose>
                                        <c:when test="${not empty plan.session.sessionDate}">
                                            ${plan.session.sessionDate}
                                        </c:when>
                                        <c:otherwise>-</c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <div class="info-row">
                                <span class="material-symbols-rounded">schedule</span>
                                <div class="info-label">Thời gian</div>
                                <div class="info-value">
                                    <c:choose>
                                        <c:when test="${not empty plan.session.startTime and not empty plan.session.endTime}">
                                            ${fn:substring(plan.session.startTime, 0, 5)}
                                            -
                                            ${fn:substring(plan.session.endTime, 0, 5)}
                                        </c:when>
                                        <c:otherwise>-</c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </aside>
                    </div>
                </c:otherwise>
            </c:choose>

        </div>
    </div>
</main>

</body>
</html>