<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

            <c:set var="activePage" value="feedback" scope="request" />

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <title>Danh sách feedback chờ duyệt</title>
                <meta name="viewport" content="width=device-width, initial-scale=1.0">

                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

                <link rel="stylesheet"
                    href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0" />

                <link rel="stylesheet" href="<c:url value='/css/core-dashboard.css' />">
                <style>
                    @import url('https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap');

                    * {
                        box-sizing: border-box;
                        font-family: 'Plus Jakarta Sans', sans-serif;
                    }

                    body {
                        margin: 0;
                        background: #f8fafc;
                        color: #1e293b;
                    }

                    .main-content {
                        min-height: 100vh;
                        background: #f8fafc;
                    }

                    .feedback-page {
                        padding: 32px 40px;
                        max-width: 1600px;
                        margin: 0 auto;
                    }

                    .feedback-header {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        margin-bottom: 32px;
                    }

                    .feedback-title {
                        margin: 0;
                        color: #0f172a;
                        font-size: 28px;
                        font-weight: 800;
                        letter-spacing: -0.5px;
                    }

                    .feedback-subtitle {
                        margin: 8px 0 0;
                        color: #64748b;
                        font-size: 15px;
                        font-weight: 500;
                    }

                    .export-btn {
                        height: 44px;
                        padding: 0 20px;
                        border: none;
                        border-radius: 12px;
                        background: #0052cc;
                        color: #ffffff;
                        font-size: 14px;
                        font-weight: 700;
                        display: inline-flex;
                        align-items: center;
                        gap: 10px;
                        cursor: pointer;
                        transition: all 0.2s ease;
                        box-shadow: 0 4px 12px rgba(0, 82, 204, 0.15);
                    }

                    .export-btn:hover {
                        background: #0747a6;
                        transform: translateY(-1px);
                        box-shadow: 0 6px 16px rgba(0, 82, 204, 0.25);
                    }

                    /* Summary Cards */
                    .summary-grid {
                        display: grid;
                        grid-template-columns: repeat(4, 1fr);
                        gap: 24px;
                        margin-bottom: 32px;
                    }

                    .summary-card {
                        background: #ffffff;
                        border: 1px solid #f1f5f9;
                        border-radius: 20px;
                        padding: 24px;
                        display: flex;
                        align-items: center;
                        gap: 20px;
                        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -2px rgba(0, 0, 0, 0.05);
                        transition: transform 0.2s ease;
                    }

                    .summary-card:hover {
                        transform: translateY(-2px);
                    }

                    .summary-icon {
                        width: 56px;
                        height: 56px;
                        border-radius: 16px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        flex-shrink: 0;
                    }

                    .summary-icon.waiting {
                        background: #eff6ff;
                        color: #2563eb;
                    }

                    .summary-icon.pending {
                        background: #fffbeb;
                        color: #d97706;
                    }

                    .summary-icon.approved {
                        background: #f0fdf4;
                        color: #16a34a;
                    }

                    .summary-icon.rejected {
                        background: #fef2f2;
                        color: #dc2626;
                    }

                    .summary-label {
                        margin: 0 0 4px;
                        font-size: 13px;
                        color: #94a3b8;
                        font-weight: 600;
                    }

                    .summary-value {
                        margin: 0;
                        font-size: 24px;
                        color: #0f172a;
                        font-weight: 800;
                    }

                    /* Table Card & Toolbar */
                    .feedback-table-card {
                        background: #ffffff;
                        border: 1px solid #f1f5f9;
                        border-radius: 24px;
                        box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.04);
                        overflow: hidden;
                    }

                    .toolbar {
                        padding: 24px;
                        display: flex;
                        align-items: center;
                        justify-content: space-between;
                        gap: 20px;
                        background: #ffffff;
                    }

                    .search-box {
                        flex: 1;
                        max-width: 480px;
                        height: 48px;
                        border: 1px solid #e2e8f0;
                        border-radius: 14px;
                        background: #f8fafc;
                        display: flex;
                        align-items: center;
                        gap: 12px;
                        padding: 0 16px;
                        transition: all 0.2s ease;
                    }

                    .search-box:focus-within {
                        border-color: #0052cc;
                        background: #ffffff;
                        box-shadow: 0 0 0 4px rgba(0, 82, 204, 0.1);
                    }

                    .search-box i {
                        color: #94a3b8;
                        font-size: 18px;
                    }

                    .search-box input {
                        width: 100%;
                        border: none;
                        background: transparent;
                        outline: none;
                        font-size: 15px;
                        color: #1e293b;
                        font-weight: 500;
                    }

                    .filter-group {
                        display: flex;
                        align-items: center;
                        gap: 12px;
                    }

                    .filter-select {
                        height: 48px;
                        min-width: 140px;
                        border: 1px solid #e2e8f0;
                        border-radius: 14px;
                        background: #f8fafc;
                        padding: 0 16px;
                        color: #475569;
                        font-size: 14px;
                        font-weight: 600;
                        outline: none;
                        cursor: pointer;
                        appearance: none;
                        background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 24 24' stroke='%2364748b'%3E%3Cpath stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M19 9l-7 7-7-7'%3E%3C/path%3E%3C/svg%3E");
                        background-repeat: no-repeat;
                        background-position: right 12px center;
                        background-size: 16px;
                        padding-right: 40px;
                    }

                    .filter-icon-btn {
                        width: 48px;
                        height: 48px;
                        border: 1px solid #e2e8f0;
                        border-radius: 14px;
                        background: #f8fafc;
                        color: #64748b;
                        cursor: pointer;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        transition: all 0.2s ease;
                    }

                    .clear-btn {
                        height: 48px;
                        padding: 0 24px;
                        border: none;
                        border-radius: 14px;
                        background: #0052cc;
                        color: #ffffff;
                        font-size: 14px;
                        font-weight: 700;
                        text-decoration: none;
                        display: inline-flex;
                        align-items: center;
                        justify-content: center;
                        transition: all 0.2s ease;
                    }

                    /* Table Design */
                    table {
                        width: 100%;
                        border-collapse: collapse;
                    }

                    th {
                        padding: 16px 24px;
                        text-align: left;
                        color: #64748b;
                        font-size: 11px;
                        font-weight: 700;
                        text-transform: uppercase;
                        letter-spacing: 0.1em;
                        background: #fcfcfd;
                        border-bottom: 1px solid #f1f5f9;
                    }

                    td {
                        padding: 24px;
                        vertical-align: middle;
                        border-bottom: 1px solid #f1f5f9;
                        color: #334155;
                        font-size: 14px;
                    }

                    .tutor-cell {
                        display: flex;
                        align-items: center;
                        gap: 16px;
                    }

                    .avatar {
                        width: 44px;
                        height: 44px;
                        border-radius: 12px;
                        background: #e0e7ff;
                        color: #4338ca;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 14px;
                        font-weight: 700;
                    }

                    .avatar.purple {
                        background: #ede9fe;
                        color: #6d28d9;
                    }

                    .name-main {
                        margin: 0;
                        color: #0f172a;
                        font-size: 14px;
                        font-weight: 700;
                    }

                    .name-sub {
                        margin: 4px 0 0;
                        color: #94a3b8;
                        font-size: 12px;
                        font-weight: 500;
                    }

                    .class-badge {
                        display: inline-flex;
                        align-items: center;
                        padding: 6px 14px;
                        border-radius: 10px;
                        background: #eff6ff;
                        color: #1e40af;
                        font-size: 12px;
                        font-weight: 700;
                    }

                    .student-cell {
                        display: flex;
                        align-items: center;
                        gap: 8px;
                        color: #475569;
                        font-weight: 600;
                    }

                    .student-cell i {
                        color: #94a3b8;
                        font-size: 14px;
                    }

                    .feedback-content {
                        max-width: 450px;
                    }

                    .rating-line {
                        margin-bottom: 8px;
                        color: #fbbf24;
                        font-size: 14px;
                    }

                    .rating-line span {
                        margin-left: 8px;
                        color: #0f172a;
                        font-size: 13px;
                        font-weight: 700;
                    }

                    .comment-text {
                        margin: 0;
                        color: #475569;
                        font-size: 14px;
                        line-height: 1.6;
                        font-weight: 500;
                    }

                    /* Action Buttons */
                    .action-row {
                        display: flex;
                        align-items: center;
                        justify-content: flex-end;
                        gap: 10px;
                    }

                    .btn {
                        height: 36px;
                        padding: 0 16px;
                        border-radius: 10px;
                        font-size: 13px;
                        font-weight: 700;
                        cursor: pointer;
                        border: 1px solid transparent;
                        transition: all 0.2s ease;
                    }

                    .btn-approve {
                        background: #f0fdf4;
                        color: #166534;
                        border-color: #dcfce7;
                    }

                    .btn-approve:hover {
                        background: #dcfce7;
                    }

                    .btn-reject {
                        background: #fef2f2;
                        color: #991b1b;
                        border-color: #fee2e2;
                    }

                    .btn-reject:hover {
                        background: #fee2e2;
                    }

                    .badge-processed {
                        padding: 6px 12px;
                        background: #f1f5f9;
                        color: #64748b;
                        border-radius: 8px;
                        font-size: 12px;
                        font-weight: 700;
                        display: inline-flex;
                        align-items: center;
                        gap: 6px;
                    }

                    /* Footer & Pagination */
                    .table-footer {
                        padding: 24px;
                        border-top: 1px solid #f1f5f9;
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        color: #64748b;
                        font-size: 14px;
                        font-weight: 500;
                    }

                    .pagination {
                        display: flex;
                        align-items: center;
                        gap: 8px;
                    }

                    .page-btn {
                        width: 36px;
                        height: 36px;
                        border-radius: 10px;
                        border: 1px solid #e2e8f0;
                        background: #ffffff;
                        color: #475569;
                        font-size: 14px;
                        font-weight: 600;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        cursor: pointer;
                        transition: all 0.2s ease;
                    }

                    .page-btn.active {
                        background: #0052cc;
                        border-color: #0052cc;
                        color: #ffffff;
                    }

                    .page-btn:hover:not(.active) {
                        background: #f8fafc;
                        border-color: #cbd5e1;
                    }

                    .process-section {
                        margin-top: 56px;
                        padding: 40px;
                        background: #ffffff;
                        border-radius: 24px;
                        border: 1px solid #f1f5f9;
                    }

                    .process-title {
                        margin: 0 0 24px;
                        color: #0f172a;
                        font-size: 20px;
                        font-weight: 800;
                    }

                    .process-item {
                        display: flex;
                        align-items: flex-start;
                        gap: 16px;
                        margin-bottom: 20px;
                    }

                    .process-number {
                        width: 28px;
                        height: 28px;
                        border-radius: 50%;
                        background: #eff6ff;
                        color: #2563eb;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 13px;
                        font-weight: 800;
                        flex-shrink: 0;
                    }

                    @media (max-width: 1400px) {
                        .summary-grid {
                            grid-template-columns: repeat(2, 1fr);
                        }
                    }

                    @media (max-width: 1024px) {
                        .feedback-page {
                            padding: 24px;
                        }

                        .toolbar {
                            flex-direction: column;
                            align-items: stretch;
                        }

                        .search-box {
                            max-width: none;
                        }

                        .summary-grid {
                            grid-template-columns: 1fr;
                        }
                    }
                    .page-btn:disabled {
                        opacity: 0.45;
                        cursor: not-allowed;
                        background: #f1f5f9;
                    }
                </style>
            </head>

            <body>

                <jsp:include page="../common/sidebar.jsp" />

                <c:set var="pendingCount" value="0" />

                <c:forEach var="feedback" items="${feedbacks}">
                    <c:set var="pendingCount" value="${pendingCount + 1}" />
                </c:forEach>

                <main class="main-content">
                    <jsp:include page="../common/header.jsp" />

                    <div class="feedback-page">

                        <div class="feedback-header">
                            <div>
                                <h1 class="feedback-title">Danh sách feedback chờ duyệt</h1>
                                <p class="feedback-subtitle">
                                    Quản lý và phê duyệt các đánh giá từ gia sư về tiến độ học tập của học sinh.
                                </p>
                            </div>


                        </div>

                        <div class="summary-grid">
                            <div class="summary-card">
                                <div class="summary-icon waiting">
                                    <span class="material-symbols-rounded">description</span>
                                </div>
                                <div>
                                    <p class="summary-label">Feedback đang chờ xử lý</p>
                                    <p class="summary-value">${pendingCount}</p>
                                </div>
                            </div>

                            <div class="summary-card">
                                <div class="summary-icon pending">
                                    <span class="material-symbols-rounded">star_half</span>
                                </div>
                                <div>
                                    <p class="summary-label">Chờ duyệt</p>
                                    <p class="summary-value">${pendingCount}</p>
                                </div>
                            </div>

                            <div class="summary-card">
                                <div class="summary-icon approved">
                                    <span class="material-symbols-rounded">check_circle</span>
                                </div>
                                <div>
                                    <p class="summary-label">Đã duyệt</p>
                                    <p class="summary-value">0</p>
                                </div>
                            </div>

                            <div class="summary-card">
                                <div class="summary-icon rejected">
                                    <span class="material-symbols-rounded">cancel</span>
                                </div>
                                <div>
                                    <p class="summary-label">Từ chối</p>
                                    <p class="summary-value">0</p>
                                </div>
                            </div>
                        </div>

                        <div class="feedback-table-card">

                            <form action="${pageContext.request.contextPath}/admin/feedback"
                                  method="GET"
                                  class="filters-toolbar"
                                  id="feedbackFilterForm">

                                <div class="filter-group" style="flex: 2;">
                                    <div class="filter-input">
                                        <span class="material-symbols-rounded" style="color: var(--text-muted);">
                                            search
                                        </span>

                                        <input type="text"
                                               id="feedbackKeyword"
                                               name="keyword"
                                               value="${param.keyword}"
                                               placeholder="Tìm gia sư, lớp, học sinh, nội dung feedback...">
                                    </div>
                                </div>

                                <div class="filter-group">
                                    <div class="filter-input">
                                        <select id="feedbackClass" name="className">
                                            <option value="">Lớp</option>

                                            <c:forEach var="feedback" items="${feedbacks}">
                                                <c:set var="currentClassName"
                                                       value="${not empty feedback.session
                                                        and not empty feedback.session.classEntity
                                                        ? feedback.session.classEntity.className : ''}" />

                                                <c:if test="${not empty currentClassName}">
                                                    <option value="${currentClassName}"
                                                        ${param.className == currentClassName ? 'selected' : ''}>
                                                        <c:out value="${currentClassName}" />
                                                    </option>
                                                </c:if>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>

                                <div class="filter-group">
                                    <div class="filter-input">
                                        <select id="feedbackStatus" name="status">
                                            <option value="">Trạng thái</option>
                                            <option value="PENDING" ${param.status == 'PENDING' ? 'selected' : ''}>
                                                Chờ duyệt
                                            </option>
                                            <option value="APPROVED" ${param.status == 'APPROVED' ? 'selected' : ''}>
                                                Đã duyệt
                                            </option>
                                            <option value="REJECTED" ${param.status == 'REJECTED' ? 'selected' : ''}>
                                                Từ chối
                                            </option>
                                        </select>
                                    </div>
                                </div>

                                <button type="submit"
                                        id="applyFeedbackFilter"
                                        class="icon-btn"
                                        style="background: var(--bg-page); border: 1px solid var(--border-color); width: 44px; height: 44px;">
                                    <span class="material-symbols-rounded">filter_list</span>
                                </button>

                                <a href="${pageContext.request.contextPath}/admin/feedback"
                                   id="clearFeedbackFilter"
                                   style="color: var(--primary); font-size: 13px; font-weight: 700; text-decoration: none;">
                                    Xóa lọc
                                </a>
                            </form>

                            <c:choose>
                                <c:when test="${empty feedbacks}">
                                    <div class="empty-box" style="padding: 60px; text-align: center; color: #94a3b8;">
                                        <img src="https://illustrations.popsy.co/blue/waiting.svg"
                                            style="width: 200px; margin-bottom: 20px;" />
                                        <p style="font-size: 16px; font-weight: 600;">Không có feedback nào đang chờ
                                            duyệt.</p>
                                    </div>
                                </c:when>

                                <c:otherwise>
                                    <table>
                                        <thead>
                                            <tr>
                                                <th>Gia sư</th>
                                                <th>Lớp</th>
                                                <th>Học sinh</th>
                                                <th>Nội dung feedback</th>
                                                <th style="text-align: right;">Hành động</th>
                                            </tr>
                                        </thead>

                                        <tbody>
                                        <c:forEach var="feedback" items="${feedbacks}" varStatus="loop">
                                            <tr class="feedback-row"
                                                data-status="${feedback.status}"
                                                data-class="${not empty feedback.session
                                                      and not empty feedback.session.classEntity
                                                      ? feedback.session.classEntity.className : ''}">
                                                    <td>
                                                        <div class="tutor-cell">
                                                            <div class="avatar ${loop.index % 2 == 0 ? '' : 'purple'}">
                                                                <c:choose>
                                                                    <c:when
                                                                        test="${not empty feedback.session.classEntity.tutor.fullName}">
                                                                        <c:out
                                                                            value="${fn:substring(feedback.session.classEntity.tutor.fullName, 0, 1)}" />
                                                                    </c:when>
                                                                    <c:otherwise>GS</c:otherwise>
                                                                </c:choose>
                                                            </div>

                                                            <div>
                                                                <p class="name-main">
                                                                    <c:out value="${not empty feedback.session
                                                                        and not empty feedback.session.classEntity
                                                                        and not empty feedback.session.classEntity.tutor
                                                                        ? feedback.session.classEntity.tutor.fullName : 'Chưa có gia sư'}" />
                                                                </p>
                                                                <p class="name-sub">
                                                                    ID:
                                                                    <c:out value="${feedback.feedbackId}" />
                                                                    <br>
                                                                    GS-2024-00${loop.index + 1}
                                                                </p>
                                                            </div>
                                                        </div>
                                                    </td>

                                                    <td>
                                                        <span class="class-badge">
                                                            <c:out value="${not empty feedback.session
                                                                and not empty feedback.session.classEntity
                                                                ? feedback.session.classEntity.className : 'Chưa có lớp'}"  />
                                                        </span>
                                                    </td>

                                                    <td>
                                                        <div class="student-cell">
                                                            <span class="material-symbols-rounded"
                                                                style="font-size: 20px; color: #94a3b8;">person</span>
                                                            <c:out value="${not empty feedback.student ? feedback.student.fullName : 'Chưa có học sinh'}" />                                                        </div>
                                                    </td>

                                                    <td>
                                                        <div class="feedback-content">
                                                            <div class="rating-line">
                                                                <c:choose>
                                                                    <c:when test="${feedback.rating == 'Xuất sắc'}">
                                                                        <c:set var="ratingNumber" value="5" />
                                                                    </c:when>
                                                                    <c:when test="${feedback.rating == 'Giỏi'}">
                                                                        <c:set var="ratingNumber" value="4" />
                                                                    </c:when>
                                                                    <c:when test="${feedback.rating == 'Khá'}">
                                                                        <c:set var="ratingNumber" value="3" />
                                                                    </c:when>
                                                                    <c:when test="${feedback.rating == 'Trung bình'}">
                                                                        <c:set var="ratingNumber" value="2" />
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <c:set var="ratingNumber" value="1" />
                                                                    </c:otherwise>
                                                                </c:choose>

                                                                <c:forEach begin="1" end="5" var="i">
                                                                    <i class="fa-solid fa-star"
                                                                       style="color: ${i <= ratingNumber ? '#fbbf24' : '#e2e8f0'}"></i>
                                                                </c:forEach>

                                                                <span>
                                                                    <c:out value="${feedback.rating}" />
                                                                </span>
                                                            </div>

                                                            <p class="comment-text">
                                                                “
                                                                <c:out value="${feedback.comment}" />”
                                                            </p>
                                                        </div>
                                                    </td>

                                                    <td style="text-align: right;">
                                                        <div class="action-row">
                                                            <c:choose>
                                                                <c:when test="${feedback.status == 'PENDING'}">
                                                                    <form
                                                                        action="${pageContext.request.contextPath}/admin/feedback/${feedback.feedbackId}/approve"
                                                                        method="post">
                                                                        <button type="submit" class="btn btn-approve">
                                                                            Duyệt
                                                                        </button>
                                                                    </form>

                                                                    <form
                                                                        action="${pageContext.request.contextPath}/admin/feedback/${feedback.feedbackId}/reject"
                                                                        method="post">
                                                                        <button type="submit" class="btn btn-reject">
                                                                            Từ chối
                                                                        </button>
                                                                    </form>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="badge-processed">
                                                                        <span class="material-symbols-rounded"
                                                                            style="font-size: 16px;">check_circle</span>
                                                                        Đã xử lý
                                                                    </span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            <tr id="noFeedbackResultRow" style="display: none;">
                                                <td colspan="5" style="padding: 40px; text-align: center; color: #64748b; font-weight: 600;">
                                                    Không tìm thấy feedback phù hợp với điều kiện lọc.
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>

                                    <div class="table-footer">
                                        <span id="feedbackPageInfo">
                                            Hiển thị 1 - ${pendingCount} trên tổng số ${pendingCount} feedback
                                        </span>

                                        <div class="pagination" id="feedbackPagination">

                                            <button type="button" class="page-btn" id="prevPage">
                                                <i class="fa-solid fa-chevron-left" style="font-size: 12px;"></i>
                                            </button>

                                            <div id="pageNumbers" style="display: flex; gap: 8px;"></div>

                                            <span id="currentPageText"
                                                  style="display:flex;align-items:center;font-weight:600;color:#334155;">
                                            </span>

                                            <button type="button" class="page-btn" id="nextPage">
                                                <i class="fa-solid fa-chevron-right" style="font-size: 12px;"></i>
                                            </button>

                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>

                        </div>

                        <section class="process-section">
                            <h2 class="process-title">Quy trình phê duyệt</h2>

                            <p class="process-desc">
                                Hệ thống TCMS Admin giúp bạn kiểm soát chất lượng giảng dạy thông qua
                                việc xem xét kỹ lưỡng các phản hồi từ gia sư. Đảm bảo mọi thông tin
                                được gửi tới phụ huynh đều chính xác, chuyên nghiệp và có tính xây dựng cao.
                            </p>

                            <div class="process-list">
                                <div class="process-item">
                                    <span class="process-number">1</span>
                                    <span>
                                        <strong>Kiểm tra nội dung:</strong>
                                        Đảm bảo ngôn ngữ lịch sự và thông tin học tập chính xác.
                                    </span>
                                </div>

                                <div class="process-item">
                                    <span class="process-number">2</span>
                                    <span>
                                        <strong>Phản hồi gia sư:</strong>
                                        Nếu bị từ chối, hãy cung cấp lý do để gia sư điều chỉnh.
                                    </span>
                                </div>
                            </div>
                        </section>

                    </div>
                </main>
                <script>
                    document.addEventListener('DOMContentLoaded', function () {
                        const keywordInput = document.getElementById('feedbackKeyword');
                        const classSelect = document.getElementById('feedbackClass');
                        const statusSelect = document.getElementById('feedbackStatus');
                        const applyButton = document.getElementById('applyFeedbackFilter');
                        const clearButton = document.getElementById('clearFeedbackFilter');
                        const filterForm = document.getElementById('feedbackFilterForm');

                        const rows = Array.from(document.querySelectorAll('.feedback-row'));
                        const noResultRow = document.getElementById('noFeedbackResultRow');
                        const pageInfo = document.getElementById('feedbackPageInfo');

                        const prevPageBtn = document.getElementById('prevPage');
                        const nextPageBtn = document.getElementById('nextPage');
                        const pageNumbers = document.getElementById('pageNumbers');
                        const currentPageText = document.getElementById('currentPageText');

                        const pageSize = 5;
                        let currentPage = 1;
                        let filteredRows = [...rows];

                        function normalizeText(value) {
                            return (value || '')
                                .toString()
                                .toLowerCase()
                                .normalize('NFD')
                                .replace(/[\u0300-\u036f]/g, '')
                                .trim();
                        }

                        function applyFeedbackFilter() {
                            const keyword = normalizeText(keywordInput ? keywordInput.value : '');
                            const selectedClass = normalizeText(classSelect ? classSelect.value : '');
                            const selectedStatus = statusSelect ? statusSelect.value : '';

                            filteredRows = rows.filter(function (row) {
                                const rowText = normalizeText(row.innerText);
                                const rowClass = normalizeText(row.getAttribute('data-class') || '');
                                const rowStatus = row.getAttribute('data-status') || '';

                                return (keyword === '' || rowText.includes(keyword))
                                    && (selectedClass === '' || rowClass === selectedClass)
                                    && (selectedStatus === '' || rowStatus === selectedStatus);
                            });

                            currentPage = 1;
                            renderPagination();
                        }

                        function renderPagination() {
                            rows.forEach(function (row) {
                                row.style.display = 'none';
                            });

                            const totalRows = filteredRows.length;
                            const totalPages = Math.ceil(totalRows / pageSize);

                            if (currentPageText) {
                                currentPageText.innerText = totalPages === 0
                                    ? 'Trang 0 / 0'
                                    : 'Trang ' + currentPage + ' / ' + totalPages;
                            }

                            if (noResultRow) {
                                noResultRow.style.display = totalRows === 0 ? '' : 'none';
                            }

                            if (totalRows === 0) {
                                if (pageInfo) {
                                    pageInfo.innerText = 'Hiển thị 0 / ' + rows.length + ' feedback';
                                }

                                if (pageNumbers) {
                                    pageNumbers.innerHTML = '';
                                }

                                if (prevPageBtn) prevPageBtn.disabled = true;
                                if (nextPageBtn) nextPageBtn.disabled = true;

                                return;
                            }

                            if (currentPage > totalPages) {
                                currentPage = totalPages;
                            }

                            const startIndex = (currentPage - 1) * pageSize;
                            const endIndex = Math.min(startIndex + pageSize, totalRows);

                            filteredRows.slice(startIndex, endIndex).forEach(function (row) {
                                row.style.display = '';
                            });

                            if (pageInfo) {
                                pageInfo.innerText = 'Hiển thị ' + (startIndex + 1) + ' - ' + endIndex
                                    + ' trên tổng số ' + totalRows + ' feedback';
                            }

                            renderPageButtons(totalPages);

                            if (prevPageBtn) {
                                prevPageBtn.disabled = currentPage <= 1;
                            }

                            if (nextPageBtn) {
                                nextPageBtn.disabled = currentPage >= totalPages;
                            }

                            if (currentPageText) {
                                currentPageText.innerText = 'Trang ' + currentPage + ' / ' + totalPages;
                            }
                        }

                        function renderPageButtons(totalPages) {
                            if (!pageNumbers) return;

                            pageNumbers.innerHTML = '';

                            for (let i = 1; i <= totalPages; i++) {
                                const btn = document.createElement('button');
                                btn.type = 'button';
                                btn.className = 'page-btn' + (i === currentPage ? ' active' : '');
                                btn.innerText = i;

                                btn.addEventListener('click', function () {
                                    currentPage = i;
                                    renderPagination();
                                });

                                pageNumbers.appendChild(btn);
                            }
                        }

                        if (prevPageBtn) {
                            prevPageBtn.addEventListener('click', function () {
                                if (currentPage > 1) {
                                    currentPage--;
                                    renderPagination();
                                }
                            });
                        }

                        if (nextPageBtn) {
                            nextPageBtn.addEventListener('click', function () {
                                const totalPages = Math.ceil(filteredRows.length / pageSize);

                                if (currentPage < totalPages) {
                                    currentPage++;
                                    renderPagination();
                                }
                            });
                        }

                        if (filterForm) {
                            filterForm.addEventListener('submit', function (event) {
                                event.preventDefault();
                                applyFeedbackFilter();
                            });
                        }

                        if (applyButton) {
                            applyButton.addEventListener('click', function (event) {
                                event.preventDefault();
                                applyFeedbackFilter();
                            });
                        }

                        if (clearButton) {
                            clearButton.addEventListener('click', function (event) {
                                event.preventDefault();

                                if (keywordInput) keywordInput.value = '';
                                if (classSelect) classSelect.value = '';
                                if (statusSelect) statusSelect.value = '';

                                filteredRows = [...rows];
                                currentPage = 1;
                                renderPagination();
                            });
                        }

                        if (keywordInput) {
                            keywordInput.addEventListener('keyup', function (event) {
                                if (event.key === 'Enter') {
                                    applyFeedbackFilter();
                                }
                            });
                        }

                        if (classSelect) {
                            classSelect.addEventListener('change', applyFeedbackFilter);
                        }

                        if (statusSelect) {
                            statusSelect.addEventListener('change', applyFeedbackFilter);
                        }

                        renderPagination();
                    });
                </script>
            </body>

            </html>