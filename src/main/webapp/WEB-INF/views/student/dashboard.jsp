<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="activePage" value="dashboard" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Dashboard Học sinh | TCMS</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0" />

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student-dashboard.css">
</head>

<body>

<jsp:include page="common/sidebar.jsp" />

<main class="main-content">
    <jsp:include page="common/header.jsp" />

    <div class="dashboard-body">

        <!-- TITLE -->
        <section class="dashboard-title-row">
            <div>
                <h1>Xin chào, học sinh</h1>
                <p>Theo dõi lớp học, buổi học hôm nay, bài tập và tiến độ học tập của bạn.</p>
            </div>

            <div class="quick-actions">
                <a href="${pageContext.request.contextPath}/student/classes" class="btn-view-schedule">
                    <span class="material-symbols-rounded">menu_book</span>
                    Lớp học của tôi
                </a>

                <a href="${pageContext.request.contextPath}/student/homework" class="btn-primary-action">
                    <span class="material-symbols-rounded">assignment</span>
                    Xem bài tập
                </a>
            </div>
        </section>

        <!-- STATS -->
        <section class="student-stats-grid">

            <div class="stat-card">
                <div class="stat-icon-box bg-light-blue">
                    <span class="material-symbols-rounded">menu_book</span>
                </div>
                <div class="stat-value">${empty stats.totalClasses ? 0 : stats.totalClasses}</div>
                <div class="stat-label">Tổng lớp đang học</div>
            </div>

            <div class="stat-card">
                <div class="stat-icon-box bg-light-green">
                    <span class="material-symbols-rounded">today</span>
                </div>
                <div class="stat-value">${empty stats.todaySessions ? 0 : stats.todaySessions}</div>
                <div class="stat-label">Buổi học hôm nay</div>
            </div>

            <div class="stat-card">
                <div class="stat-icon-box bg-light-orange">
                    <span class="material-symbols-rounded">assignment</span>
                </div>
                <div class="stat-value">${empty stats.pendingHomework ? 0 : stats.pendingHomework}</div>
                <div class="stat-label">Bài tập cần làm</div>
            </div>

            <div class="stat-card">
                <div class="stat-icon-box bg-light-purple">
                    <span class="material-symbols-rounded">rate_review</span>
                </div>
                <div class="stat-value">${empty stats.latestFeedback ? 0 : stats.latestFeedback}</div>
                <div class="stat-label">Feedback gần đây</div>
            </div>

            <div class="stat-card">
                <div class="stat-icon-box bg-light-red">
                    <span class="material-symbols-rounded">event_busy</span>
                </div>
                <div class="stat-value">${empty stats.absenceRequests ? 0 : stats.absenceRequests}</div>
                <div class="stat-label">Yêu cầu xin nghỉ</div>
            </div>

        </section>

        <!-- MAIN GRID -->
        <section class="student-dashboard-grid">

            <!-- LEFT COLUMN -->
            <div class="dashboard-left">

                <!-- UPCOMING SESSIONS -->
                <div class="section-container">
                    <div class="section-header">
                        <h2>Buổi học sắp tới</h2>
                        <a href="${pageContext.request.contextPath}/student/classes">Xem lớp học</a>
                    </div>

                    <div class="content-card">
                        <c:choose>
                            <c:when test="${not empty upcomingSessions}">
                                <c:forEach var="s" items="${upcomingSessions}">
                                    <div class="session-row">
                                        <div class="session-icon">
                                            <span class="material-symbols-rounded">schedule</span>
                                        </div>

                                        <div class="session-info">
                                            <h3>
                                                <c:choose>
                                                    <c:when test="${not empty s.classEntity and not empty s.classEntity.className}">
                                                        ${s.classEntity.className}
                                                    </c:when>
                                                    <c:otherwise>Buổi học</c:otherwise>
                                                </c:choose>
                                            </h3>

                                            <p>
                                                <c:choose>
                                                    <c:when test="${not empty s.topic}">
                                                        ${s.topic}
                                                    </c:when>
                                                    <c:otherwise>Chưa cập nhật chủ đề</c:otherwise>
                                                </c:choose>
                                            </p>
                                        </div>

                                        <div class="session-time">
                                            <strong>${empty s.sessionDate ? '' : s.sessionDate}</strong>
                                            <span>${empty s.startTime ? '' : s.startTime} - ${empty s.endTime ? '' : s.endTime}</span>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>

                            <c:otherwise>
                                <div class="empty-card">
                                    <span class="material-symbols-rounded">event_available</span>
                                    <p>Chưa có dữ liệu buổi học sắp tới.</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- HOMEWORK -->
                <div class="section-container">
                    <div class="section-header">
                        <h2>Bài tập cần làm</h2>
                        <a href="${pageContext.request.contextPath}/student/homework">Xem tất cả</a>
                    </div>

                    <div class="content-card">
                        <c:choose>
                            <c:when test="${not empty pendingHomeworkList}">
                                <c:forEach var="hw" items="${pendingHomeworkList}">
                                    <div class="homework-row">
                                        <div class="homework-icon">
                                            <span class="material-symbols-rounded">assignment</span>
                                        </div>

                                        <div class="homework-info">
                                            <h3>
                                                <c:choose>
                                                    <c:when test="${not empty hw.title}">
                                                        ${hw.title}
                                                    </c:when>
                                                    <c:otherwise>Bài tập</c:otherwise>
                                                </c:choose>
                                            </h3>

                                            <p>
                                                <c:choose>
                                                    <c:when test="${not empty hw.session and not empty hw.session.classEntity}">
                                                        ${hw.session.classEntity.className}
                                                    </c:when>
                                                    <c:otherwise>Lớp học</c:otherwise>
                                                </c:choose>
                                            </p>
                                        </div>

                                        <a href="${pageContext.request.contextPath}/student/homework/detail/${hw.homeworkId}"
                                           class="btn-small">
                                            Làm bài
                                        </a>
                                    </div>
                                </c:forEach>
                            </c:when>

                            <c:otherwise>
                                <div class="empty-card">
                                    <span class="material-symbols-rounded">assignment_turned_in</span>
                                    <p>
                                        Hiện có
                                        <strong>${empty stats.pendingHomework ? 0 : stats.pendingHomework}</strong>
                                        bài tập cần làm.
                                    </p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- FEEDBACK -->
                <div class="section-container">
                    <div class="section-header">
                        <h2>Feedback gần đây</h2>
                    </div>

                    <div class="content-card">
                        <c:choose>
                            <c:when test="${not empty latestFeedbackList}">
                                <c:forEach var="fb" items="${latestFeedbackList}">
                                    <div class="feedback-card">
                                        <div class="feedback-top">
                                            <h3>
                                                <c:choose>
                                                    <c:when test="${not empty fb.session and not empty fb.session.classEntity}">
                                                        ${fb.session.classEntity.className}
                                                    </c:when>
                                                    <c:otherwise>Feedback học tập</c:otherwise>
                                                </c:choose>
                                            </h3>

                                            <span>${empty fb.submittedAt ? '' : fb.submittedAt}</span>
                                        </div>

                                        <p>
                                            <c:choose>
                                                <c:when test="${not empty fb.comment}">
                                                    ${fb.comment}
                                                </c:when>
                                                <c:otherwise>Chưa có nội dung feedback.</c:otherwise>
                                            </c:choose>
                                        </p>
                                    </div>
                                </c:forEach>
                            </c:when>

                            <c:otherwise>
                                <div class="empty-card">
                                    <span class="material-symbols-rounded">rate_review</span>
                                    <p>
                                        Có
                                        <strong>${empty stats.latestFeedback ? 0 : stats.latestFeedback}</strong>
                                        feedback gần đây.
                                    </p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

            </div>

            <!-- RIGHT COLUMN -->
            <aside class="dashboard-right">


                <!-- ABSENCE -->
                <div class="side-card">
                    <div class="side-card-header">
                        <h2>Yêu cầu xin nghỉ</h2>
                    </div>

                    <div class="absence-summary">
                        <div class="absence-icon">
                            <span class="material-symbols-rounded">event_busy</span>
                        </div>

                        <div>
                            <strong>${empty stats.absenceRequests ? 0 : stats.absenceRequests}</strong>
                            <p>Yêu cầu xin nghỉ đã gửi</p>
                        </div>
                    </div>
                </div>

                <!-- QUICK LINKS -->
                <div class="side-card">
                    <div class="side-card-header">
                        <h2>Truy cập nhanh</h2>
                    </div>

                    <div class="quick-link-list">
                        <a href="${pageContext.request.contextPath}/student/classes">
                            <span class="material-symbols-rounded">menu_book</span>
                            Lớp học của tôi
                        </a>

                        <a href="${pageContext.request.contextPath}/student/homework">
                            <span class="material-symbols-rounded">assignment</span>
                            Bài tập
                        </a>

                        <a href="${pageContext.request.contextPath}/notifications">
                            <span class="material-symbols-rounded">notifications</span>
                            Thông báo
                        </a>

                        <a href="${pageContext.request.contextPath}/profile">
                            <span class="material-symbols-rounded">account_circle</span>
                            Hồ sơ cá nhân
                        </a>
                    </div>
                </div>

            </aside>
        </section>

    </div>
</main>

</body>
</html>
