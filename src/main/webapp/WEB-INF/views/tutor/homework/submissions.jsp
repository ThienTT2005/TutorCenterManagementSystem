<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="activePage" value="homework" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh sách bài nộp | TCMS Tutor</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/tutor-dashboard.css">

    <style>
        .submission-page {
            padding: 2rem;
        }

        .submission-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 24px;
            box-shadow: 0 8px 24px rgba(15, 23, 42, 0.05);
            overflow: hidden;
        }

        .submission-header {
            padding: 1.5rem 1.75rem;
            border-bottom: 1px solid #eef2f7;
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 1rem;
        }

        .submission-title-block h1 {
            font-size: 22px;
            font-weight: 900;
            color: #0f172a;
            margin-bottom: 6px;
        }

        .submission-title-block p {
            font-size: 13px;
            font-weight: 600;
            color: #64748b;
            line-height: 1.5;
        }

        .submission-actions-top {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .icon-soft-btn,
        .back-btn {
            min-height: 38px;
            border: 0;
            border-radius: 12px;
            background: #f8fafc;
            color: #64748b;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            text-decoration: none;
            cursor: pointer;
            transition: all .2s ease;
        }

        .icon-soft-btn {
            width: 38px;
            font-size: 14px;
        }

        .back-btn {
            padding: 0 14px;
            font-size: 13px;
            font-weight: 800;
        }

        .icon-soft-btn:hover,
        .back-btn:hover {
            background: #eff6ff;
            color: #0057bf;
        }

        .submission-summary {
            display: grid;
            grid-template-columns: repeat(4, minmax(0, 1fr));
            gap: 1rem;
            padding: 1.25rem 1.75rem;
            border-bottom: 1px solid #eef2f7;
            background: #fbfdff;
        }

        .summary-box {
            background: #ffffff;
            border: 1px solid #eef2f7;
            border-radius: 16px;
            padding: 1rem;
        }

        .summary-box span {
            display: block;
            font-size: 12px;
            font-weight: 800;
            color: #64748b;
            margin-bottom: 6px;
        }

        .summary-box strong {
            display: block;
            font-size: 22px;
            font-weight: 900;
            color: #0f172a;
            line-height: 1.1;
        }

        .table-wrap {
            width: 100%;
            overflow-x: auto;
        }

        .submission-table {
            width: 100%;
            min-width: 980px;
            border-collapse: collapse;
        }

        .submission-table th,
        .submission-table td {
            padding: 16px 18px;
            border-bottom: 1px solid #eef2f7;
            text-align: left;
            vertical-align: middle;
            font-size: 13px;
        }

        .submission-table th {
            color: #94a3b8;
            font-size: 11px;
            font-weight: 900;
            text-transform: uppercase;
            letter-spacing: .4px;
            background: #fbfdff;
        }

        .student-cell {
            display: flex;
            align-items: center;
            gap: 12px;
            min-width: 210px;
        }

        .avatar {
            width: 36px;
            height: 36px;
            border-radius: 999px;
            background: #eff6ff;
            color: #0057bf;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            font-weight: 900;
            flex-shrink: 0;
            text-transform: uppercase;
        }

        .avatar.color-1 {
            background: #eff6ff;
            color: #0057bf;
        }

        .avatar.color-2 {
            background: #ecfeff;
            color: #0891b2;
        }

        .avatar.color-3 {
            background: #fff7ed;
            color: #ea580c;
        }

        .avatar.color-4 {
            background: #f3e8ff;
            color: #7e22ce;
        }

        .avatar.color-5 {
            background: #fdf2f8;
            color: #db2777;
        }

        .student-info strong {
            display: block;
            color: #0f172a;
            font-size: 13px;
            font-weight: 900;
            margin-bottom: 3px;
        }

        .student-info span {
            display: block;
            color: #94a3b8;
            font-size: 12px;
            font-weight: 600;
        }

        .homework-title {
            color: #334155;
            font-weight: 700;
            line-height: 1.45;
            max-width: 180px;
        }

        .submit-time {
            color: #64748b;
            font-weight: 700;
            line-height: 1.45;
            white-space: nowrap;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 78px;
            padding: 6px 10px;
            border-radius: 999px;
            font-size: 10px;
            font-weight: 900;
            text-transform: uppercase;
        }

        .status-graded {
            background: #dcfce7;
            color: #16a34a;
            border: 1px solid #bbf7d0;
        }

        .status-submitted {
            background: #fff7ed;
            color: #ea580c;
            border: 1px solid #fed7aa;
        }

        .status-other {
            background: #f1f5f9;
            color: #64748b;
            border: 1px solid #e2e8f0;
        }

        .score-value {
            color: #0057bf;
            font-weight: 900;
        }

        .score-empty {
            color: #94a3b8;
            font-style: italic;
            font-weight: 700;
        }

        .attachment-link {
            color: #0057bf;
            font-size: 13px;
            font-weight: 800;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .attachment-link:hover {
            text-decoration: underline;
        }

        .attachment-empty {
            color: #94a3b8;
            font-size: 13px;
            font-weight: 700;
        }

        .row-actions {
            display: flex;
            justify-content: flex-end;
        }

        .detail-btn,
        .grade-btn {
            min-height: 36px;
            min-width: 92px;
            border-radius: 10px;
            border: 0;
            padding: 0 14px;
            font-size: 12px;
            font-weight: 900;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 7px;
            text-decoration: none;
            transition: all .2s ease;
        }

        .detail-btn {
            background: #f1f5f9;
            color: #0f172a;
        }

        .grade-btn {
            background: #0057bf;
            color: #ffffff;
            box-shadow: 0 8px 18px rgba(0, 87, 191, 0.16);
        }

        .detail-btn:hover {
            background: #e2e8f0;
        }

        .grade-btn:hover {
            background: #004da8;
            transform: translateY(-1px);
        }

        .empty-state {
            padding: 4rem 1.5rem;
            text-align: center;
            color: #64748b;
        }

        .empty-state i {
            font-size: 42px;
            color: #cbd5e1;
            margin-bottom: 14px;
        }

        .empty-state h2 {
            color: #0f172a;
            font-size: 20px;
            font-weight: 900;
            margin-bottom: 8px;
        }

        .empty-state p {
            font-size: 14px;
            font-weight: 600;
        }

        .submission-footer {
            padding: 1rem 1.75rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 1rem;
            color: #94a3b8;
            font-size: 12px;
            font-weight: 700;
            background: #ffffff;
        }

        .pagination-demo {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .page-btn {
            width: 32px;
            height: 32px;
            border-radius: 10px;
            border: 0;
            background: #ffffff;
            color: #64748b;
            font-size: 12px;
            font-weight: 800;
            cursor: pointer;
        }

        .page-btn.active {
            background: #0057bf;
            color: #ffffff;
        }

        .page-btn:hover {
            background: #eff6ff;
            color: #0057bf;
        }

        @media (max-width: 1100px) {
            .submission-summary {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }

            .submission-header {
                flex-direction: column;
            }

            .submission-actions-top {
                width: 100%;
                justify-content: space-between;
            }
        }

        @media (max-width: 700px) {
            .submission-page {
                padding: 1rem;
            }

            .submission-summary {
                grid-template-columns: 1fr;
            }

            .submission-footer {
                flex-direction: column;
                align-items: flex-start;
            }
        }
    </style>
</head>

<body>

<jsp:include page="../common/sidebar.jsp" />

<div class="main-content">
    <jsp:include page="../common/header.jsp" />

    <main class="submission-page">

        <section class="submission-card">

            <div class="submission-header">
                <div class="submission-title-block">
                    <h1>Chi tiết các bài nộp</h1>

                    <p>
                        <c:choose>
                            <c:when test="${not empty submissions}">
                                Bài tập:
                                <strong>
                                    <c:out value="${submissions[0].homework.title}" />
                                </strong>
                            </c:when>
                            <c:otherwise>
                                Bài tập #<c:out value="${homeworkId}" />
                            </c:otherwise>
                        </c:choose>
                    </p>
                </div>

                <div class="submission-actions-top">
                    <c:choose>
                        <c:when test="${not empty homework and not empty homework.session}">
                            <a href="${pageContext.request.contextPath}/tutor/homework/session/${homework.session.sessionId}" class="back-btn">
                                <i class="fa-solid fa-arrow-left"></i>
                                Quay lại
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/tutor/classes" class="back-btn">
                                <i class="fa-solid fa-arrow-left"></i>
                                Quay lại
                            </a>
                        </c:otherwise>
                    </c:choose>

                    <button type="button" class="icon-soft-btn" title="Lọc">
                        <i class="fa-solid fa-filter"></i>
                    </button>

                    <button type="button" class="icon-soft-btn" title="Tùy chọn">
                        <i class="fa-solid fa-ellipsis-vertical"></i>
                    </button>
                </div>
            </div>

            <c:set var="gradedCount" value="0" />
            <c:set var="submittedCount" value="0" />
            <c:set var="attachmentCount" value="0" />

            <c:forEach var="sub" items="${submissions}">
                <c:if test="${sub.status == 'GRADED'}">
                    <c:set var="gradedCount" value="${gradedCount + 1}" />
                </c:if>

                <c:if test="${sub.status == 'SUBMITTED'}">
                    <c:set var="submittedCount" value="${submittedCount + 1}" />
                </c:if>

                <c:if test="${not empty sub.attachmentUrl}">
                    <c:set var="attachmentCount" value="${attachmentCount + 1}" />
                </c:if>
            </c:forEach>

            <div class="submission-summary">
                <div class="summary-box">
                    <span>Tổng bài nộp</span>
                    <strong>${empty submissions ? 0 : fn:length(submissions)}</strong>
                </div>

                <div class="summary-box">
                    <span>Đã chấm</span>
                    <strong>${gradedCount}</strong>
                </div>

                <div class="summary-box">
                    <span>Chưa chấm</span>
                    <strong>${submittedCount}</strong>
                </div>

                <div class="summary-box">
                    <span>Có tệp đính kèm</span>
                    <strong>${attachmentCount}</strong>
                </div>
            </div>

            <c:choose>
                <c:when test="${not empty submissions}">
                    <div class="table-wrap">
                        <table class="submission-table">
                            <thead>
                            <tr>
                                <th>Sinh viên</th>
                                <th>Tên bài tập</th>
                                <th>Thời gian nộp</th>
                                <th>Trạng thái</th>
                                <th>Điểm số</th>
                                <th>Tệp đính kèm</th>
                                <th style="text-align:right;">Hành động</th>
                            </tr>
                            </thead>

                            <tbody>
                            <c:forEach var="sub" items="${submissions}" varStatus="loop">
                                <tr>
                                    <td>
                                        <div class="student-cell">
                                            <div class="avatar color-${(loop.index % 5) + 1}">
                                                <c:choose>
                                                    <c:when test="${not empty sub.student and not empty sub.student.fullName}">
                                                        ${fn:substring(sub.student.fullName, 0, 2)}
                                                    </c:when>
                                                    <c:otherwise>HS</c:otherwise>
                                                </c:choose>
                                            </div>

                                            <div class="student-info">
                                                <strong>
                                                    <c:out value="${not empty sub.student and not empty sub.student.fullName ? sub.student.fullName : 'Học sinh'}" />
                                                </strong>

                                                <span>
                                                    <c:choose>
                                                        <c:when test="${not empty sub.student and not empty sub.student.user and not empty sub.student.user.username}">
                                                            <c:out value="${sub.student.user.username}" />
                                                        </c:when>
                                                        <c:otherwise>
                                                            student-${empty sub.student ? 'unknown' : sub.student.studentId}
                                                        </c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </div>
                                        </div>
                                    </td>

                                    <td>
                                        <div class="homework-title">
                                            <c:choose>
                                                <c:when test="${not empty sub.homework and not empty sub.homework.title}">
                                                    <c:out value="${sub.homework.title}" />
                                                </c:when>
                                                <c:otherwise>
                                                    Bài tập #<c:out value="${homeworkId}" />
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </td>

                                    <td>
                                        <div class="submit-time">
                                            <c:out value="${empty sub.submittedAt ? 'Chưa cập nhật' : sub.submittedAt}" />
                                        </div>
                                    </td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${sub.status == 'GRADED'}">
                                                <span class="status-badge status-graded">GRADED</span>
                                            </c:when>
                                            <c:when test="${sub.status == 'SUBMITTED'}">
                                                <span class="status-badge status-submitted">SUBMITTED</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-badge status-other">
                                                    <c:out value="${empty sub.status ? 'UNKNOWN' : sub.status}" />
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty sub.score}">
                                                <span class="score-value">
                                                    <c:out value="${sub.score}" />
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="score-empty">Chưa có điểm</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty sub.attachmentUrl}">
                                                <a href="${sub.attachmentUrl}"
                                                   target="_blank"
                                                   class="attachment-link">
                                                    Mở bài làm
                                                    <i class="fa-solid fa-arrow-up-right-from-square"></i>
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="attachment-empty">Không có</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td>
                                        <div class="row-actions">
                                            <c:choose>
                                                <c:when test="${sub.status == 'GRADED'}">
                                                    <a href="${pageContext.request.contextPath}/tutor/homework/submissions/${sub.submissionId}"
                                                       class="detail-btn">
                                                        Xem chi tiết
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="${pageContext.request.contextPath}/tutor/homework/submissions/${sub.submissionId}"
                                                       class="grade-btn">
                                                        Chấm bài
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <div class="submission-footer">
                        <div>
                            Hiển thị 1 - ${fn:length(submissions)} trong số ${fn:length(submissions)} bài nộp
                        </div>

                        <div class="pagination-demo">
                            <button type="button" class="page-btn">
                                <i class="fa-solid fa-chevron-left"></i>
                            </button>
                            <button type="button" class="page-btn active">1</button>
                            <button type="button" class="page-btn">
                                <i class="fa-solid fa-chevron-right"></i>
                            </button>
                        </div>
                    </div>
                </c:when>

                <c:otherwise>
                    <div class="empty-state">
                        <i class="fa-regular fa-folder-open"></i>
                        <h2>Chưa có bài nộp</h2>
                        <p>
                            Hiện chưa có học sinh nào nộp bài tập #<c:out value="${homeworkId}" />.
                        </p>
                    </div>
                </c:otherwise>
            </c:choose>

        </section>

    </main>
</div>

</body>
</html>
