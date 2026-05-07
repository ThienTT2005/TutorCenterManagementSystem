<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

            <c:set var="activePage" value="homework" scope="request" />

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <title>Bài tập buổi học | TCMS Tutor</title>
                <meta name="viewport" content="width=device-width, initial-scale=1.0">

                <link rel="stylesheet"
                      href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0"/>

                <link rel="stylesheet"
                      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

                <link rel="stylesheet"
                      href="${pageContext.request.contextPath}/css/tutor-dashboard.css">

                <style>
                    .homework-page {
                        padding: 2rem;
                    }

                    .homework-hero {
                        background: #ffffff;
                        border: 1px solid #e2e8f0;
                        border-radius: 24px;
                        padding: 1.75rem;
                        box-shadow: 0 8px 24px rgba(15, 23, 42, 0.05);
                        display: flex;
                        justify-content: space-between;
                        align-items: flex-start;
                        gap: 1.5rem;
                        margin-bottom: 1.5rem;
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

                    .badge.blue {
                        background: #eff6ff;
                        color: #0057bf;
                    }

                    .badge.green {
                        background: #dcfce7;
                        color: #16a34a;
                    }

                    .badge.orange {
                        background: #fff7ed;
                        color: #ea580c;
                    }

                    .badge.purple {
                        background: #f3e8ff;
                        color: #7e22ce;
                    }

                    .badge.gray {
                        background: #f1f5f9;
                        color: #64748b;
                    }

                    .homework-hero h1 {
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
                    }

                    .hero-meta span {
                        display: inline-flex;
                        align-items: center;
                        gap: 7px;
                    }

                    .hero-actions {
                        display: flex;
                        gap: 10px;
                        flex-wrap: wrap;
                        justify-content: flex-end;
                    }

                    .btn-soft,
                    .btn-primary {
                        min-height: 42px;
                        padding: 0 18px;
                        border-radius: 12px;
                        font-size: 14px;
                        font-weight: 850;
                        display: inline-flex;
                        align-items: center;
                        justify-content: center;
                        gap: 8px;
                        text-decoration: none;
                        transition: all .2s ease;
                    }

                    .btn-soft {
                        background: #ffffff;
                        color: #0f172a;
                        border: 1px solid #e2e8f0;
                    }

                    .btn-soft:hover {
                        background: #eff6ff;
                        color: #0057bf;
                        border-color: #0057bf;
                    }

                    .btn-primary {
                        background: #0057bf;
                        color: #ffffff;
                        border: 1px solid #0057bf;
                        box-shadow: 0 8px 18px rgba(0, 87, 191, 0.18);
                    }

                    .btn-primary:hover {
                        background: #004da8;
                    }

                    .stats-grid {
                        display: grid;
                        grid-template-columns: repeat(4, minmax(0, 1fr));
                        gap: 1rem;
                        margin-bottom: 1.5rem;
                    }

                    .stat-mini {
                        background: #ffffff;
                        border: 1px solid #e2e8f0;
                        border-radius: 18px;
                        padding: 1.25rem;
                        box-shadow: 0 4px 12px rgba(15, 23, 42, 0.04);
                    }

                    .stat-mini span {
                        display: block;
                        color: #64748b;
                        font-size: 12px;
                        font-weight: 800;
                        margin-bottom: 6px;
                    }

                    .stat-mini strong {
                        color: #0f172a;
                        font-size: 24px;
                        font-weight: 900;
                    }

                    .homework-layout {
                        display: grid;
                        grid-template-columns: minmax(0, 1.8fr) 360px;
                        gap: 1.5rem;
                        align-items: start;
                    }

                    .panel-card,
                    .side-card,
                    .homework-card {
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
                        align-items: flex-start;
                        gap: 1rem;
                        margin-bottom: 1.25rem;
                    }

                    .panel-header h2,
                    .side-card h3 {
                        font-size: 18px;
                        font-weight: 900;
                        color: #0f172a;
                    }

                    .panel-header p {
                        margin-top: 5px;
                        color: #64748b;
                        font-size: 13px;
                        line-height: 1.5;
                    }

                    .homework-list {
                        display: flex;
                        flex-direction: column;
                        gap: 1rem;
                    }

                    .homework-card {
                        padding: 1.25rem;
                        transition: all .2s ease;
                    }

                    .homework-card:hover {
                        transform: translateY(-2px);
                        box-shadow: 0 12px 28px rgba(15, 23, 42, 0.08);
                    }

                    .homework-top {
                        display: flex;
                        justify-content: space-between;
                        align-items: flex-start;
                        gap: 1rem;
                        margin-bottom: 12px;
                    }

                    .homework-title {
                        font-size: 17px;
                        font-weight: 900;
                        color: #0f172a;
                        margin-bottom: 8px;
                    }

                    .homework-content {
                        color: #475569;
                        font-size: 14px;
                        line-height: 1.55;
                        margin-bottom: 1rem;
                    }

                    .homework-meta {
                        display: grid;
                        grid-template-columns: repeat(3, minmax(0, 1fr));
                        gap: 12px;
                        margin-bottom: 1rem;
                    }

                    .meta-box {
                        background: #f8fafc;
                        border-radius: 14px;
                        padding: 12px;
                    }

                    .meta-box span {
                        display: block;
                        color: #64748b;
                        font-size: 11px;
                        font-weight: 800;
                        margin-bottom: 5px;
                        text-transform: uppercase;
                    }

                    .meta-box strong,
                    .meta-box a {
                        color: #0f172a;
                        font-size: 13px;
                        font-weight: 850;
                        text-decoration: none;
                        word-break: break-word;
                    }

                    .homework-actions {
                        display: flex;
                        justify-content: flex-end;
                        gap: 10px;
                        flex-wrap: wrap;
                    }

                    .btn-card {
                        min-height: 36px;
                        padding: 0 14px;
                        border-radius: 10px;
                        font-size: 12px;
                        font-weight: 900;
                        display: inline-flex;
                        align-items: center;
                        gap: 7px;
                        text-decoration: none;
                        transition: all .2s ease;
                    }

                    .btn-card.blue {
                        background: #eff6ff;
                        color: #0057bf;
                    }

                    .btn-card.gray {
                        background: #f1f5f9;
                        color: #64748b;
                    }

                    .btn-card:hover {
                        filter: brightness(.97);
                        transform: translateY(-1px);
                    }

                    .side-column {
                        display: flex;
                        flex-direction: column;
                        gap: 1rem;
                        position: sticky;
                        top: 86px;
                    }

                    .side-card {
                        padding: 1.35rem;
                    }

                    .info-list {
                        display: flex;
                        flex-direction: column;
                    }

                    .info-row {
                        display: flex;
                        justify-content: space-between;
                        gap: 12px;
                        padding: 12px 0;
                        border-bottom: 1px solid #f1f5f9;
                        font-size: 13px;
                    }

                    .info-row:last-child {
                        border-bottom: 0;
                    }

                    .info-row span {
                        color: #64748b;
                        font-weight: 700;
                    }

                    .info-row strong {
                        color: #0f172a;
                        font-weight: 900;
                        text-align: right;
                    }

                    .quick-link-list {
                        display: flex;
                        flex-direction: column;
                        gap: 10px;
                    }

                    .quick-link {
                        min-height: 42px;
                        border-radius: 12px;
                        background: #f8fafc;
                        color: #0f172a;
                        display: flex;
                        align-items: center;
                        gap: 10px;
                        padding: 0 14px;
                        font-size: 14px;
                        font-weight: 850;
                        text-decoration: none;
                        transition: all .2s ease;
                    }

                    .quick-link:hover {
                        background: #eff6ff;
                        color: #0057bf;
                    }

                    .empty-card {
                        text-align: center;
                        color: #64748b;
                        padding: 3rem 1rem;
                    }

                    .empty-card i {
                        font-size: 42px;
                        color: #cbd5e1;
                        margin-bottom: 12px;
                    }

                    .empty-card h3 {
                        color: #0f172a;
                        font-size: 18px;
                        font-weight: 900;
                        margin-bottom: 6px;
                    }

                    .empty-card p {
                        font-size: 14px;
                        margin-bottom: 1rem;
                    }

                    @media (max-width: 1100px) {
                        .homework-layout {
                            grid-template-columns: 1fr;
                        }

                        .side-column {
                            position: static;
                        }

                        .stats-grid {
                            grid-template-columns: repeat(2, minmax(0, 1fr));
                        }
                    }

                    @media (max-width: 760px) {
                        .homework-page {
                            padding: 1rem;
                        }

                        .homework-hero,
                        .homework-top {
                            flex-direction: column;
                        }

                        .homework-meta {
                            grid-template-columns: 1fr;
                        }

                        .stats-grid {
                            grid-template-columns: 1fr;
                        }
                    }
                </style>
            </head>

            <body>

                <jsp:include page="../common/sidebar.jsp" />

                <div class="main-content">
                    <jsp:include page="../common/header.jsp" />

                    <main class="homework-page">

                        <section class="homework-hero">
                            <div>
                                <div class="hero-badges">
                                    <span class="badge blue">
                                        <i class="fa-solid fa-book-open"></i>
                                        <c:choose>
                                            <c:when test="${not empty sessionItem.classEntity}">
                                                <c:out value="${sessionItem.classEntity.className}" />
                                            </c:when>
                                            <c:otherwise>Lớp học</c:otherwise>
                                        </c:choose>
                                    </span>

                                    <span class="badge gray">
                                        <i class="fa-solid fa-circle-info"></i>
                                        <c:out
                                            value="${empty sessionItem.status ? 'Chưa cập nhật' : sessionItem.status}" />
                                    </span>
                                </div>

                                <h1>Bài tập buổi học</h1>

                                <div class="hero-meta">
                                    <span>
                                        <i class="fa-regular fa-calendar"></i>
                                        <c:out
                                            value="${empty sessionItem.sessionDate ? 'Chưa có ngày' : sessionItem.sessionDate}" />
                                    </span>

                                    <span>
                                        <i class="fa-regular fa-clock"></i>
                                        <c:out
                                            value="${empty sessionItem.startTime ? '--:--' : sessionItem.startTime}" />
                                        -
                                        <c:out value="${empty sessionItem.endTime ? '--:--' : sessionItem.endTime}" />
                                    </span>

                                    <span>
                                        <i class="fa-solid fa-pen-to-square"></i>
                                        ${empty homeworks ? 0 : fn:length(homeworks)} bài tập
                                    </span>
                                </div>
                            </div>

                            <div class="hero-actions">
                                <c:choose>
                                    <c:when test="${not empty sessionItem.classEntity}">
                                        <a href="${pageContext.request.contextPath}/tutor/classes/${sessionItem.classEntity.classId}"
                                            class="btn-soft">
                                            <i class="fa-solid fa-arrow-left"></i>
                                            Quay lại lớp học
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/tutor/classes" class="btn-soft">
                                            <i class="fa-solid fa-arrow-left"></i>
                                            Quay lại lớp học
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                                <a href="${pageContext.request.contextPath}/tutor/homework/create?sessionId=${sessionItem.sessionId}"
                                   class="btn-primary">
                                    <i class="fa-solid fa-plus"></i>
                                    Tạo bài tập mới
                                </a>
                            </div>
                        </section>

                        <section class="stats-grid">
                            <div class="stat-mini">
                                <span>Tổng bài tập</span>
                                <strong>${empty homeworks ? 0 : fn:length(homeworks)}</strong>
                            </div>

                            <div class="stat-mini">
                                <span>Trắc nghiệm</span>
                                <strong>
                                    <c:set var="mcCount" value="0" />
                                    <c:forEach var="hw" items="${homeworks}">
                                        <c:if test="${hw.type == 'MULTIPLE_CHOICE'}">
                                            <c:set var="mcCount" value="${mcCount + 1}" />
                                        </c:if>
                                    </c:forEach>
                                    ${mcCount}
                                </strong>
                            </div>

                            <div class="stat-mini">
                                <span>Tự luận</span>
                                <strong>
                                    <c:set var="essayCount" value="0" />
                                    <c:forEach var="hw" items="${homeworks}">
                                        <c:if test="${hw.type == 'ESSAY'}">
                                            <c:set var="essayCount" value="${essayCount + 1}" />
                                        </c:if>
                                    </c:forEach>
                                    ${essayCount}
                                </strong>
                            </div>

                            <div class="stat-mini">
                                <span>Buổi học</span>
                                <strong>#
                                    <c:out value="${sessionItem.sessionId}" />
                                </strong>
                            </div>
                        </section>

                        <section class="homework-layout">

                            <div class="panel-card">
                                <div class="panel-header">
                                    <div>
                                        <h2>Danh sách bài tập</h2>
                                        <p>Các bài tập đã tạo cho buổi học này.</p>
                                    </div>
                                </div>

                                <c:choose>
                                    <c:when test="${not empty homeworks}">
                                        <div class="homework-list">
                                            <c:forEach var="hw" items="${homeworks}">
                                                <article class="homework-card">
                                                    <div class="homework-top">
                                                        <div>
                                                            <h3 class="homework-title">
                                                                <c:out
                                                                    value="${empty hw.title ? 'Bài tập' : hw.title}" />
                                                            </h3>

                                                            <div class="hero-badges">
                                                                <c:choose>
                                                                    <c:when test="${hw.type == 'MULTIPLE_CHOICE'}">
                                                                        <span class="badge purple">
                                                                            <i class="fa-solid fa-list-check"></i>
                                                                            Trắc nghiệm
                                                                        </span>
                                                                    </c:when>
                                                                    <c:when test="${hw.type == 'ESSAY'}">
                                                                        <span class="badge orange">
                                                                            <i class="fa-solid fa-file-lines"></i>
                                                                            Tự luận
                                                                        </span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="badge gray">
                                                                            <c:out
                                                                                value="${empty hw.type ? 'Chưa rõ loại' : hw.type}" />
                                                                        </span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <p class="homework-content">
                                                        <c:out
                                                            value="${empty hw.content ? 'Chưa có nội dung mô tả.' : hw.content}" />
                                                    </p>

                                                    <div class="homework-meta">
                                                        <div class="meta-box">
                                                            <span>Deadline</span>
                                                            <strong>
                                                                <c:out
                                                                    value="${empty hw.deadline ? 'Chưa cập nhật' : hw.deadline}" />
                                                            </strong>
                                                        </div>

                                                        <div class="meta-box">
                                                            <span>Câu hỏi</span>
                                                            <strong>
                                                                <c:choose>
                                                                    <c:when test="${not empty questionCountMap}">
                                                                        ${empty questionCountMap[hw.homeworkId] ? 0 :
                                                                        questionCountMap[hw.homeworkId]}
                                                                    </c:when>
                                                                    <c:otherwise>---</c:otherwise>
                                                                </c:choose>
                                                            </strong>
                                                        </div>

                                                        <div class="meta-box">
                                                            <span>Bài nộp</span>
                                                            <strong>
                                                                <c:choose>
                                                                    <c:when test="${not empty submissionCountMap}">
                                                                        ${empty submissionCountMap[hw.homeworkId] ? 0 :
                                                                        submissionCountMap[hw.homeworkId]}
                                                                    </c:when>
                                                                    <c:otherwise>---</c:otherwise>
                                                                </c:choose>
                                                            </strong>
                                                        </div>
                                                    </div>

                                                    <c:if test="${not empty hw.attachmentUrl}">
                                                        <div class="meta-box" style="margin-bottom: 1rem;">
                                                            <span>Tệp / Link đính kèm</span>
                                                            <a href="${hw.attachmentUrl}" target="_blank">
                                                                <i class="fa-solid fa-paperclip"></i>
                                                                Mở tài liệu
                                                            </a>
                                                        </div>
                                                    </c:if>

                                                    <div class="homework-actions">
                                                        <a href="${pageContext.request.contextPath}/tutor/homework/${hw.homeworkId}/edit"
                                                           class="btn-soft">
                                                            <i class="fa-solid fa-pen-to-square"></i>
                                                            Sửa bài tập
                                                        </a>

                                                        <a href="${pageContext.request.contextPath}/tutor/homework/submissions/homework/${hw.homeworkId}"
                                                           class="btn-soft">
                                                            <i class="fa-solid fa-users-viewfinder"></i>
                                                            Xem bài nộp
                                                        </a>
                                                    </div>
                                                </article>
                                            </c:forEach>
                                        </div>
                                    </c:when>

                                    <c:otherwise>
                                        <div class="empty-card">
                                            <i class="fa-regular fa-folder-open"></i>
                                            <h3>Chưa có bài tập</h3>
                                            <p>Hãy tạo bài tập đầu tiên cho buổi học này.</p>
                                            <a href="${pageContext.request.contextPath}/tutor/homework/create?sessionId=${sessionItem.sessionId}"
                                                class="btn-primary">
                                                <i class="fa-solid fa-plus"></i>
                                                Tạo bài tập mới
                                            </a>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <aside class="side-column">
                                <div class="side-card">
                                    <h3>Thông tin buổi học</h3>

                                    <div class="info-list">
                                        <div class="info-row">
                                            <span>Lớp</span>
                                            <strong>
                                                <c:choose>
                                                    <c:when test="${not empty sessionItem.classEntity}">
                                                        <c:out value="${sessionItem.classEntity.className}" />
                                                    </c:when>
                                                    <c:otherwise>---</c:otherwise>
                                                </c:choose>
                                            </strong>
                                        </div>

                                        <div class="info-row">
                                            <span>Ngày học</span>
                                            <strong>
                                                <c:out
                                                    value="${empty sessionItem.sessionDate ? '---' : sessionItem.sessionDate}" />
                                            </strong>
                                        </div>

                                        <div class="info-row">
                                            <span>Thời gian</span>
                                            <strong>
                                                <c:out
                                                    value="${empty sessionItem.startTime ? '--:--' : sessionItem.startTime}" />
                                                -
                                                <c:out
                                                    value="${empty sessionItem.endTime ? '--:--' : sessionItem.endTime}" />
                                            </strong>
                                        </div>

                                        <div class="info-row">
                                            <span>Chủ đề</span>
                                            <strong>
                                                <c:out
                                                    value="${empty sessionItem.topic ? 'Chưa cập nhật' : sessionItem.topic}" />
                                            </strong>
                                        </div>

                                        <div class="info-row">
                                            <span>Trạng thái</span>
                                            <strong>
                                                <c:out
                                                    value="${empty sessionItem.status ? '---' : sessionItem.status}" />
                                            </strong>
                                        </div>
                                    </div>
                                </div>

                                <div class="side-card">
                                    <h3>Thao tác nhanh</h3>

                                    <div class="quick-link-list">
                                        <a href="${pageContext.request.contextPath}/tutor/homework/create?sessionId=${sessionItem.sessionId}"
                                            class="quick-link">
                                            <i class="fa-solid fa-plus"></i>
                                            Tạo bài tập mới
                                        </a>

                                        <c:if test="${not empty sessionItem.classEntity}">
                                            <a href="${pageContext.request.contextPath}/tutor/classes/${sessionItem.classEntity.classId}"
                                                class="quick-link">
                                                <i class="fa-solid fa-arrow-left"></i>
                                                Quay lại chi tiết lớp
                                            </a>
                                        </c:if>

                                        <a href="${pageContext.request.contextPath}/tutor/sessions/${sessionItem.sessionId}/learning-plan"
                                            class="quick-link">
                                            <i class="fa-solid fa-clipboard-list"></i>
                                            Xem kế hoạch bài học
                                        </a>
                                    </div>
                                </div>
                            </aside>

                        </section>
                    </main>
                </div>

            </body>

            </html>