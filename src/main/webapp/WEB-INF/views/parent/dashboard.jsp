<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="activePage" value="dashboard" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Dashboard Phụ huynh | TCMS</title>
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
                <c:choose>
                    <c:when test="${not empty loggedInUser and not empty loggedInUser.fullName}">
                        <c:set var="displayTitle" value="${loggedInUser.fullName}" />
                    </c:when>
                    <c:when test="${not empty currentUser and not empty currentUser.username}">
                        <c:set var="displayTitle" value="${currentUser.username}" />
                    </c:when>
                    <c:otherwise>
                        <c:set var="displayTitle" value="phụ huynh" />
                    </c:otherwise>
                </c:choose>
                <h1>Xin chào, <c:out value="${displayTitle}" /></h1>
                <p>Theo dõi lớp học, lịch học, bài tập, feedback và thanh toán của con.</p>
            </div>

            <div class="quick-actions">
                <a href="${pageContext.request.contextPath}/parent/classes" class="btn-view-schedule">
                    <span class="material-symbols-rounded">menu_book</span>
                    Xem lớp của con
                </a>

                <a href="${pageContext.request.contextPath}/parent/absence/create" class="btn-primary-action">
                    <span class="material-symbols-rounded">event_busy</span>
                    Tạo đơn xin nghỉ
                </a>
            </div>
        </section>

        <!-- STATS -->
        <section class="parent-stats-grid">

            <div class="stat-card">
                <div class="stat-icon-box bg-light-blue">
                    <span class="material-symbols-rounded">menu_book</span>
                </div>
                <div class="stat-value">${empty stats.totalClasses ? 0 : stats.totalClasses}</div>
                <div class="stat-label">Tổng lớp đang theo dõi</div>
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
                <div class="stat-label">Bài tập cần theo dõi</div>
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
                    <span class="material-symbols-rounded">payments</span>
                </div>
                <div class="stat-value">${empty stats.pendingPayments ? 0 : stats.pendingPayments}</div>
                <div class="stat-label">Thanh toán chờ xử lý</div>
            </div>

            <div class="stat-card">
                <div class="stat-icon-box bg-light-yellow">
                    <span class="material-symbols-rounded">event_busy</span>
                </div>
                <div class="stat-value">${empty stats.absenceRequests ? 0 : stats.absenceRequests}</div>
                <div class="stat-label">Yêu cầu xin nghỉ</div>
            </div>

        </section>

        <!-- MAIN GRID -->
        <section class="parent-dashboard-grid">

            <!-- LEFT COLUMN -->
            <div class="dashboard-left">

                <!-- TODAY SESSIONS -->
                <div class="section-container">
                    <div class="section-header">
                        <h2>Lịch học hôm nay</h2>
                        <a href="${pageContext.request.contextPath}/parent/classes">Xem tất cả</a>
                    </div>

                    <div class="content-card">
                        <c:choose>
                            <c:when test="${not empty todaySessions}">
                                <c:forEach var="s" items="${todaySessions}">
                                    <div class="session-row">
                                        <div class="session-icon">
                                            <span class="material-symbols-rounded">schedule</span>
                                        </div>

                                        <div class="session-info">
                                            <h3><c:out value="${empty s.classEntity.className ? 'Lớp học' : s.classEntity.className}" /></h3>
                                            <p><c:out value="${empty s.classEntity.subject ? 'Môn học' : s.classEntity.subject}" /></p>
                                        </div>

                                        <div class="session-time">
                                            <c:out value="${s.startTime}"/> - <c:out value="${s.endTime}"/>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>

                            <c:otherwise>
                                <div class="empty-card">
                                    <span class="material-symbols-rounded">event_available</span>
                                    <p>Chưa có dữ liệu lịch học hôm nay.</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- QUICK ACCESS -->
                <div class="section-container">
                    <div class="section-header">
                        <h2>Các lớp của con</h2>
                        <a href="${pageContext.request.contextPath}/parent/classes">Xem chi tiết</a>
                    </div>

                    <div class="content-card">
                        <div class="empty-card">
                            <span class="material-symbols-rounded">school</span>
                            <p>
                                Hiện tại có <strong>${empty stats.totalClasses ? 0 : stats.totalClasses}</strong> lớp đang theo dõi.
                            </p>
                        </div>
                    </div>
                </div>

            </div>

            <!-- RIGHT COLUMN -->
            <aside class="dashboard-right">

                <!-- QUICK LINKS -->
                <div class="side-card">
                    <div class="side-card-header">
                        <h2>Truy cập nhanh</h2>
                    </div>

                    <div class="quick-link-list">
                        <a href="${pageContext.request.contextPath}/parent/classes">
                            <span class="material-symbols-rounded">menu_book</span>
                            Lớp của con
                        </a>

                        <a href="${pageContext.request.contextPath}/parent/absence/create">
                            <span class="material-symbols-rounded">event_busy</span>
                            Tạo đơn xin nghỉ
                        </a>

                        <a href="${pageContext.request.contextPath}/payment/parent">
                            <span class="material-symbols-rounded">payments</span>
                            Thanh toán
                        </a>
                    </div>
                </div>

                <!-- HELP CENTER -->
                <div class="side-card help-card">
                    <div class="side-card-body">
                        <span class="material-symbols-rounded">support_agent</span>
                        <h3>Trung tâm hỗ trợ</h3>
                        <p>Cần hỗ trợ về kỹ thuật hoặc học tập?</p>
                        <a href="#" class="btn-help">Liên hệ ngay</a>
                    </div>
                </div>

            </aside>
        </section>

    </div>
</main>

</body>
</html>
