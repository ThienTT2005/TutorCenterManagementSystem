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
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0"/>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/tutor-dashboard.css">

    
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
