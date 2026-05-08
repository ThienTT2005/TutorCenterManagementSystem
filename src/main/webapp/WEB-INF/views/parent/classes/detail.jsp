<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="activePage" value="classes" scope="request" />

<c:set var="activePage" value="classes" scope="request" />

<c:choose>
    <c:when test="${not empty student and not empty student.studentId}">
        <c:set var="currentStudentId" value="${student.studentId}" />
    </c:when>
    <c:otherwise>
        <c:set var="currentStudentId" value="" />
    </c:otherwise>
</c:choose>

<c:if test="${empty classItem and not empty sessions}">
    <c:set var="classItem" value="${sessions[0].classEntity}" />
</c:if>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết lớp học | TCMS Parent</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0"/>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/student-dashboard.css">

    <style>
        .parent-class-detail-page {
            padding: 2rem;
            background: #f8fafc;
            min-height: 100vh;
        }

        /* HERO */
        .class-hero {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 24px;
            padding: 1.9rem;
            box-shadow: 0 8px 24px rgba(15, 23, 42, 0.05);
            margin-bottom: 1.5rem;
        }

        .hero-top {
            display: grid;
            grid-template-columns: minmax(0, 1fr) 265px;
            gap: 2rem;
            align-items: start;
        }

        .tags {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            margin-bottom: 12px;
        }

        .tag {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 11px;
            border-radius: 999px;
            font-size: 11px;
            font-weight: 900;
        }

        .tag.subject {
            background: #eff6ff;
            color: #0057bf;
        }

        .tag.grade {
            background: #f3e8ff;
            color: #7e22ce;
        }

        .tag.active {
            background: #dcfce7;
            color: #16a34a;
        }

        .tag.inactive {
            background: #f1f5f9;
            color: #64748b;
        }

        .hero-title h1 {
            color: #0f172a;
            font-size: 32px;
            line-height: 1.2;
            font-weight: 900;
            margin: 0 0 12px;
        }

        .hero-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 16px;
            color: #64748b;
            font-size: 14px;
            font-weight: 800;
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
            line-height: 1.7;
            max-width: 820px;
            margin: 0;
        }

        .btn-back {
            min-height: 52px;
            border-radius: 15px;
            background: #0057bf;
            color: #ffffff;
            font-size: 14px;
            font-weight: 900;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            padding: 0 18px;
            margin-top: 32px;
            transition: all .25s ease;
        }

        .btn-back:hover {
            background: #004da8;
            transform: translateY(-2px);
        }

        /* QUICK */
        .quick-grid {
            margin-top: 1.6rem;
            padding-top: 1.6rem;
            border-top: 1px solid #eef2f7;

            display: grid;
            grid-template-columns: repeat(4, minmax(0, 1fr));
            gap: 14px;
        }

        .quick-box {
            background: #f8fafc;
            border-radius: 16px;
            padding: 16px 18px;
            min-height: 84px;

            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .quick-box span {
            color: #64748b;
            font-size: 12px;
            font-weight: 800;
            margin-bottom: 7px;
        }

        .quick-box strong {
            color: #0f172a;
            font-size: 18px;
            font-weight: 900;
        }

        /* LAYOUT */
        .layout {
            display: grid;
            grid-template-columns: minmax(0, 1fr) 375px;
            gap: 1.5rem;
            align-items: start;
        }

        .left-column,
        .right-column {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        /* CARD */
        .card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 22px;
            box-shadow: 0 8px 24px rgba(15, 23, 42, 0.05);
        }

        .card-body {
            padding: 1.5rem;
        }

        .card-title {
            display: flex;
            align-items: center;
            gap: 10px;

            color: #0f172a;
            font-size: 20px;
            font-weight: 900;

            margin-bottom: 1.5rem;
        }

        .card-title i {
            color: #0057bf;
        }

        /* SESSION */
        .session-list {
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        .session-card {
            background: #ffffff;
            border: 1px solid #dbeafe;
            border-radius: 24px;

            padding: 1.5rem;

            box-shadow: 0 8px 24px rgba(15, 23, 42, 0.04);

            transition: all .3s ease;

            display: flex;
            flex-direction: column;
            gap: 1.25rem;
        }

        .session-card:hover {
            transform: translateY(-4px);

            box-shadow: 0 15px 35px rgba(15, 23, 42, 0.08);

            border-color: #0057bf;
        }

        .session-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
        }

        .session-topic {
            font-size: 18px;
            font-weight: 900;
            color: #0f172a;
            margin: 0 0 8px;
        }

        .session-id-sub {
            display: block;
            color: #64748b;
            font-size: 12px;
            font-weight: 700;
            margin-top: -4px;
            margin-bottom: 8px;
        }

        .session-info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);

            gap: 12px;
            margin-bottom: 0.5rem;
        }

        .info-pill {
            display: flex;
            align-items: center;
            gap: 8px;

            color: #64748b;
            font-size: 13px;
            font-weight: 700;
        }

        .info-pill i {
            color: #0057bf;
        }

        .session-badge {
            padding: 6px 12px;
            border-radius: 999px;

            font-size: 11px;
            font-weight: 900;

            display: inline-flex;
            align-items: center;
            justify-content: center;

            min-width: 92px;

            text-transform: uppercase;
        }

        /* PLANNED */
        .session-badge.planned {
            background: #dcfce7;
            color: #16a34a;
        }

        /* CANCELLED */
        .session-badge.cancelled {
            background: #fee2e2;
            color: #dc2626;
        }

        /* DEFAULT */
        .session-badge.status {
            background: #eef2f7;
            color: #64748b;
        }

        /* ACTION BUTTONS */
        .action-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);

            gap: 12px;

            padding-top: 1.1rem;

            border-top: 1px solid #f1f5f9;
        }

        .action-btn {
            min-height: 46px;

            border-radius: 14px;

            font-size: 13px;
            font-weight: 800;

            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;

            text-decoration: none;

            transition: all .25s ease;

            border: 1px solid transparent;

            cursor: pointer;
        }

        .action-btn i {
            font-size: 14px;
        }

        /* HOMEWORK */
        .action-btn.btn-homework {
            background: #eff6ff !important;
            color: #2563eb !important;
            border: 1px solid #dbeafe !important;
        }

        .action-btn.btn-homework:hover {
            background: #2563eb !important;
            color: #ffffff !important;

            transform: translateY(-2px);

            box-shadow: 0 10px 20px rgba(37, 99, 235, 0.18);
        }

        /* PLAN */
        .action-btn.btn-progress {
            background: #f0fdf4 !important;
            color: #16a34a !important;
            border: 1px solid #dcfce7 !important;
        }

        .action-btn.btn-progress:hover {
            background: #16a34a !important;
            color: #ffffff !important;

            transform: translateY(-2px);

            box-shadow: 0 10px 20px rgba(22, 163, 74, 0.18);
        }

        /* FEEDBACK */
        .action-btn.btn-feedback {
            background: #fff7ed !important;
            color: #ea580c !important;
            border: 1px solid #ffedd5 !important;
        }

        .action-btn.btn-feedback:hover {
            background: #ea580c !important;
            color: #ffffff !important;

            transform: translateY(-2px);

            box-shadow: 0 10px 20px rgba(234, 88, 12, 0.18);
        }

        /* DISABLED */
        .action-btn.btn-disabled {
            background: #f8fafc !important;
            color: #94a3b8 !important;
            border: 1px solid #e2e8f0 !important;

            cursor: not-allowed;
        }

        .action-btn.btn-disabled:hover {
            transform: none;
            box-shadow: none;
        }

        /* TUTOR CARD */
        .tutor-card {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;

            padding: 1rem 0;
        }

        .tutor-avatar {
            width: 110px;
            height: 110px;

            border-radius: 30px;

            background: #eff6ff;

            margin-bottom: 1.25rem;

            position: relative;

            box-shadow: 0 10px 25px rgba(0, 87, 191, 0.1);

            display: flex;
            align-items: center;
            justify-content: center;

            color: #0057bf;
            font-size: 36px;
        }

        .tutor-avatar img {
            width: 100%;
            height: 100%;

            object-fit: cover;

            border-radius: 30px;
        }

        .tutor-avatar::after {
            content: "\f058";

            font-family: "Font Awesome 6 Free";
            font-weight: 900;

            position: absolute;

            bottom: -5px;
            right: -5px;

            background: #0057bf;
            color: #ffffff;

            width: 30px;
            height: 30px;

            border-radius: 10px;

            display: flex;
            align-items: center;
            justify-content: center;

            font-size: 14px;

            border: 3px solid #ffffff;
        }

        .tutor-info-header {
            margin-bottom: 1.5rem;
        }

        .tutor-info-header strong {
            display: block;

            font-size: 22px;
            font-weight: 900;

            color: #0f172a;

            margin-bottom: 6px;
        }

        .tutor-info-header span {
            display: block;

            font-size: 14px;
            font-weight: 700;

            color: #0057bf;
        }

        .tutor-contact-list {
            width: 100%;

            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .contact-item {
            background: #f8fafc;

            border-radius: 16px;

            padding: 14px 18px;

            display: flex;
            align-items: center;
            gap: 12px;

            color: #475569;
            font-size: 14px;
            font-weight: 700;

            transition: all 0.2s ease;
        }

        .contact-item i {
            color: #94a3b8;
            font-size: 16px;
            width: 24px;
            text-align: center;
        }

        .contact-item:hover {
            background: #f1f5f9;
            color: #0f172a;
        }

        /* EMPTY */
        .empty-card {
            padding: 2rem;
            text-align: center;

            color: #64748b;
        }

        /* RESPONSIVE */
        @media (max-width: 1100px) {

            .hero-top,
            .layout {
                grid-template-columns: 1fr;
            }

            .quick-grid {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }

            .btn-back {
                justify-self: start;
                margin-top: 0;
            }
        }

        @media (max-width: 700px) {

            .action-grid {
                grid-template-columns: 1fr;
            }

            .session-info-grid {
                grid-template-columns: 1fr;
            }

            .quick-grid {
                grid-template-columns: 1fr;
            }

            .parent-class-detail-page {
                padding: 1rem;
            }

            .hero-title h1 {
                font-size: 24px;
            }
        }
        .btn-absence-top {
            min-width: 120px;
            height: 42px;

            border-radius: 14px;

            background: #2563eb;
            color: #ffffff;

            border: 1px solid #2563eb;

            font-size: 13px;
            font-weight: 800;

            text-decoration: none;

            display: inline-flex;
            align-items: center;
            justify-content: center;

            gap: 8px;

            transition: all .25s ease;
        }

        .btn-absence-top:hover {
            background: #1d4ed8;
            border-color: #1d4ed8;

            color: #ffffff;

            transform: translateY(-2px);

            box-shadow: 0 10px 20px rgba(37, 99, 235, 0.18);
        }
        .btn-absence-top.disabled {
            background: #f1f5f9 !important;
            color: #94a3b8 !important;

            border: 1px solid #e2e8f0 !important;

            cursor: not-allowed;

            pointer-events: none;
        }

        .btn-absence-top.disabled i {
            color: #94a3b8 !important;
        }

        .btn-absence-top.disabled:hover {
            transform: none;
            box-shadow: none;
        }
    </style>
</head>

<body>

<jsp:include page="../common/sidebar.jsp" />

<div class="main-content">
    <jsp:include page="../common/header.jsp" />

    <main class="class-detail-page">

        <section class="class-hero">
            <div class="hero-top">
                <div class="hero-title">
                    <div class="tags">
                        <span class="tag subject">
                            <i class="fa-solid fa-book-open"></i>
                            <c:out value="${empty classItem.subject ? 'Môn học' : classItem.subject}" />
                        </span>

                        <span class="tag grade">
                            <i class="fa-solid fa-layer-group"></i>
                            Khối <c:out value="${empty classItem.grade ? '-' : classItem.grade}" />
                        </span>

                        <c:choose>
                            <c:when test="${classItem.status == true}">
                                <span class="tag active">
                                    <i class="fa-solid fa-circle-check"></i>
                                    Đang học
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="tag inactive">
                                    <i class="fa-solid fa-circle-minus"></i>
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
                            <i class="fa-solid fa-calendar-days"></i>
                            ${empty sessions ? 0 : fn:length(sessions)} buổi học
                        </span>

                        <span>
                            <i class="fa-solid fa-hashtag"></i>
                            Mã lớp #<c:out value="${empty classItem.classId ? '' : classItem.classId}" />
                        </span>
                    </div>

                    <p class="hero-desc">
                        <c:out value="${empty classItem.description ? 'Chưa có mô tả cho lớp học này.' : classItem.description}" />
                    </p>
                </div>

                <a href="${pageContext.request.contextPath}/parent/classes" class="btn-back">
                    <i class="fa-solid fa-arrow-left"></i>
                    Danh sách lớp
                </a>
            </div>

            <div class="quick-grid">
                <div class="quick-box">
                    <span>Môn học</span>
                    <strong>
                        <c:out value="${empty classItem.subject ? '---' : classItem.subject}" />
                    </strong>
                </div>

                <div class="quick-box">
                    <span>Khối lớp</span>
                    <strong>
                        <c:out value="${empty classItem.grade ? '---' : classItem.grade}" />
                    </strong>
                </div>

                <div class="quick-box">
                    <span>Số buổi yêu cầu</span>
                    <strong>${empty classItem.requiredSessions ? 0 : classItem.requiredSessions} buổi</strong>
                </div>

                <div class="quick-box">
                    <span>Trạng thái</span>
                    <strong>${classItem.status == true ? 'Đang học' : 'Đã kết thúc'}</strong>
                </div>
            </div>
        </section>

        <section class="layout">
            <div class="left-column">
                <div class="card">
                    <div class="card-body">
                        <h2 class="card-title">
                            <i class="fa-solid fa-calendar-days"></i>
                            Lịch học
                        </h2>

                        <c:choose>
                            <c:when test="${not empty sessions}">
                                <div class="session-list">
                                    <c:forEach var="s" items="${sessions}">
                                        <div class="session-card">
                                            <div class="session-header">
                                                <div>
                                                    <h3 class="session-topic">
                                                        <c:out value="${empty s.topic ? (empty s.lessonName ? 'Chủ đề chưa cập nhật' : s.lessonName) : s.topic}" />
                                                    </h3>
                                                    <span class="session-id-sub">Buổi học #<c:out value="${s.sessionId}" /></span>

                                                    <div class="session-info-grid">
                                                        <div class="info-pill">
                                                            <i class="fa-regular fa-calendar"></i>
                                                            <c:out value="${s.sessionDate}" />
                                                        </div>

                                                        <div class="info-pill">
                                                            <i class="fa-regular fa-clock"></i>
                                                            <c:out value="${s.startTime}"/> - <c:out value="${s.endTime}"/>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="session-actions-top">
                                                    <span class="session-badge
                                                        ${s.status == 'PLANNED' ? 'planned' : ''}
                                                        ${s.status == 'CANCELLED' ? 'cancelled' : ''}">
                                                        ${empty s.status ? 'N/A' : s.status}
                                                    </span>

                                                    <c:choose>

                                                        <c:when test="${s.status == 'CANCELLED'}">

                                                            <span class="btn-absence-top disabled">

                                                                <i class="fa-solid fa-calendar-xmark"></i>
                                                                Xin nghỉ

                                                            </span>

                                                        </c:when>

                                                        <c:otherwise>

                                                            <a href="${pageContext.request.contextPath}/parent/absence/create?sessionId=${s.sessionId}&studentId=${currentStudentId}"
                                                               class="btn-absence-top">

                                                                <i class="fa-solid fa-calendar-xmark"></i>
                                                                Xin nghỉ

                                                            </a>

                                                        </c:otherwise>

                                                    </c:choose>
                                                </div>
                                            </div>

                                            <div class="action-grid">

                                                <c:set var="sessionId" value="${s.sessionId}" />
                                                <c:set var="homeworks" value="${homeworkMap[sessionId]}" />
                                                <c:set var="feedback" value="${feedbackMap[sessionId]}" />
                                                <c:set var="learningPlan" value="${learningPlanMap[sessionId]}" />

                                                <c:choose>
                                                    <c:when test="${not empty homeworks}">
                                                        <a href="${pageContext.request.contextPath}/parent/homework/session/${s.sessionId}?studentId=${currentStudentId}"
                                                           class="action-btn btn-homework">
                                                            <i class="fa-solid fa-book-open"></i>
                                                            Bài tập
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="action-btn btn-disabled">
                                                            <i class="fa-solid fa-book-open"></i>
                                                            Chưa có bài tập
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>

                                                <c:choose>
                                                    <c:when test="${not empty learningPlan}">
                                                        <a href="${pageContext.request.contextPath}/parent/sessions/${s.sessionId}/learning-plan"
                                                           class="action-btn btn-progress">
                                                            <i class="fa-solid fa-clipboard-list"></i>
                                                            Kế hoạch
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="action-btn btn-disabled">
                                                            <i class="fa-solid fa-clipboard-list"></i>
                                                            Chưa có kế hoạch
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>

                                                <c:choose>
                                                    <c:when test="${not empty feedback}">
                                                        <a href="${pageContext.request.contextPath}/parent/sessions/${s.sessionId}/feedback"
                                                           class="action-btn btn-feedback">
                                                            <i class="fa-solid fa-comments"></i>
                                                            Feedback
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="action-btn btn-disabled">
                                                            <i class="fa-solid fa-comments"></i>
                                                            Chưa có feedback
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>

                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:when>

                            <c:otherwise>
                                <div class="empty-card">
                                    Chưa có lịch học cho lớp này.
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <aside class="right-column">
                <div class="card">
                    <div class="card-body">
                        <h2 class="card-title">
                            <i class="fa-solid fa-chalkboard-user"></i>
                            Gia sư phụ trách
                        </h2>

                        <div class="tutor-card">
                            <div class="tutor-avatar">
                                <c:choose>
                                    <c:when test="${not empty classItem.tutor and not empty classItem.tutor.avatar}">
                                        <c:choose>

                                            <%-- Không có avatar --%>
                                            <c:when test="${empty classItem.tutor.avatar}">
                                                <img src="${pageContext.request.contextPath}/images/default-avatar.png"
                                                     alt="Tutor">
                                            </c:when>

                                            <%-- Avatar là link online --%>
                                            <c:when test="${fn:startsWith(classItem.tutor.avatar, 'http')}">
                                                <img src="${classItem.tutor.avatar}"
                                                     alt="Tutor">
                                            </c:when>

                                            <%-- Avatar local --%>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}${classItem.tutor.avatar}"
                                                     alt="Tutor">
                                            </c:otherwise>

                                        </c:choose>
                                    </c:when>

                                    <c:otherwise>
                                        <i class="fa-solid fa-user-graduate"></i>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="tutor-info-header">
                                <strong>
                                    <c:out value="${empty classItem.tutor.fullName ? 'Chưa cập nhật' : classItem.tutor.fullName}" />
                                </strong>

                                <span>
                                    <c:out value="${empty classItem.tutor.major ? 'Gia sư' : classItem.tutor.major}" />

                                    <c:if test="${not empty classItem.tutor.school}">
                                        - <c:out value="${classItem.tutor.school}" />
                                    </c:if>
                                </span>
                            </div>

                            <div class="tutor-contact-list">
                                <div class="contact-item">
                                    <i class="fa-regular fa-envelope"></i>
                                    <c:out value="${empty classItem.tutor.email ? 'N/A' : classItem.tutor.email}" />
                                </div>

                                <div class="contact-item">
                                    <i class="fa-solid fa-phone"></i>
                                    <c:out value="${empty classItem.tutor.phone ? 'N/A' : classItem.tutor.phone}" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </aside>
        </section>

    </main>
</div>

</body>
</html>