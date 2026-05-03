<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Gia sư | TCMS</title>
    <!-- FontAwesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/tutor-dashboard.css">
</head>
<body>

<c:set var="activePage" value="dashboard" scope="request" />

<!-- Sidebar -->
<jsp:include page="common/sidebar.jsp" />

<!-- Main Content -->
<div class="main-content">
    <!-- Header -->
    <jsp:include page="common/header.jsp"/>

    <!-- Dashboard Body -->
    <div class="dashboard-body">
        
        <!-- Greeting Row -->
        <div class="dashboard-title-row">
            <div>
                <h1>Xin chào, ${empty loggedInUser.fullName ? 'Gia sư' : loggedInUser.fullName}</h1>
                <p>Hôm nay là ${not empty now ? now : '28/04/2026'}</p>
            </div>
            <a href="${pageContext.request.contextPath}/tutor/schedule" class="btn-view-schedule">
                <i class="fa-solid fa-calendar-days"></i>
                Xem lịch dạy
            </a>
        </div>

        <!-- Stats Grid -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon-box bg-light-blue">
                    <i class="fa-solid fa-graduation-cap"></i>
                </div>
                <div class="stat-value">${empty stats.totalClasses ? 0 : stats.totalClasses}</div>
                <div class="stat-label">Tổng lớp</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon-box bg-light-green">
                    <i class="fa-solid fa-calendar-check"></i>
                </div>
                <div class="stat-value">${empty stats.todayClasses ? 0 : stats.todayClasses}</div>
                <div class="stat-label">Lớp hôm nay</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon-box bg-light-orange">
                    <i class="fa-solid fa-comments"></i>
                </div>
                <div class="stat-value">${empty stats.pendingFeedbacks ? 0 : stats.pendingFeedbacks}</div>
                <div class="stat-label">Feedback chờ</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon-box bg-light-purple">
                    <i class="fa-solid fa-book-open-reader"></i>
                </div>
                <div class="stat-value">${empty stats.homeworkToGrade ? 0 : stats.homeworkToGrade}</div>
                <div class="stat-label">Bài tập cần chấm</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon-box bg-light-red">
                    <i class="fa-solid fa-wallet"></i>
                </div>
                <div class="stat-value">${empty stats.pendingPayments ? 0 : stats.pendingPayments}</div>
                <div class="stat-label">Thanh toán chờ</div>
            </div>
        </div>

        <div class="dashboard-grid">
            <!-- LEFT COLUMN -->
            <div class="section-group">
                
                <!-- Today Sessions -->
                <div class="section-container">
                    <div class="section-header">
                        <h2>Lịch dạy hôm nay</h2>
                    </div>
                    
                    <c:choose>
                        <c:when test="${not empty todaySessions}">
                            <c:forEach var="s" items="${todaySessions}">
                                <div class="session-card">
                                    <div class="session-info">
                                        <div class="session-icon">
                                            <i class="fa-solid fa-book"></i>
                                        </div>
                                        <div class="session-details">
                                            <h3>${s.classEntity.className}</h3>
                                            <div class="session-time">
                                                <i class="fa-regular fa-clock"></i>
                                                ${s.startTime} - ${s.endTime}
                                            </div>
                                        </div>
                                    </div>
                                    <div class="session-meta">
                                        <span class="badge-status badge-upcoming">Sắp diễn ra</span>
                                        <a href="${pageContext.request.contextPath}/tutor/sessions/${s.sessionId}" class="btn-detail">Xem chi tiết</a>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-card">
                                Hôm nay chưa có lịch dạy.
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Feedback Section -->
                <div class="section-container">
                    <div class="section-header">
                        <h2>Feedback cần cập nhật</h2>
                    </div>
                    <div class="card-row">
                        <c:choose>
                            <c:when test="${not empty pendingFeedbacks}">
                                <c:forEach var="f" items="${pendingFeedbacks}">
                                    <div class="info-card">
                                        <div class="card-top">
                                            <h3>${f.session.classEntity.className}</h3>
                                            <span class="badge-card badge-orange">CHƯA CẬP NHẬT</span>
                                        </div>
                                        <p class="card-desc">${empty f.comment ? 'Cần cập nhật feedback sau buổi học.' : f.comment}</p>
                                        <a class="btn-action" href="${pageContext.request.contextPath}/tutor/feedback">
                                            <i class="fa-solid fa-pen-to-square"></i> Cập nhật ngay
                                        </a>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="empty-card" style="grid-column: span 2;">Không có feedback cần cập nhật.</div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Progress Section -->
                <div class="section-container">
                    <div class="section-header">
                        <h2>Tiến độ học tập chưa cập nhật</h2>
                    </div>
                    <div class="card-row">
                        <c:choose>
                            <c:when test="${not empty pendingProgress}">
                                <c:forEach var="s" items="${pendingProgress}">
                                    <div class="info-card purple">
                                        <div class="card-top">
                                            <h3>${s.classEntity.className}</h3>
                                            <span class="badge-card badge-purple">CHƯA CẬP NHẬT</span>
                                        </div>
                                        <p class="card-desc">Buổi học ngày ${s.sessionDate} chưa có báo cáo tiến độ học tập.</p>
                                        <a class="btn-action btn-purple" href="${pageContext.request.contextPath}/tutor/progress">
                                            <i class="fa-solid fa-chart-line"></i> Cập nhật ngay
                                        </a>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="empty-card" style="grid-column: span 2;">Không có tiến độ cần cập nhật.</div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <!-- RIGHT COLUMN -->
            <div class="section-group">
                
                <!-- Homework Widget -->
                <div class="section-container">
                    <div class="section-header">
                        <h2>Bài tập cần chấm</h2>
                    </div>
                    <div class="widget-card">
                        <c:choose>
                            <c:when test="${not empty pendingHomeworkSubmissions}">
                                <c:forEach var="sub" items="${pendingHomeworkSubmissions}">
                                    <div class="widget-item">
                                        <div class="widget-item-top">
                                            <h4>${sub.homework.title}</h4>
                                            <span class="widget-badge" style="background: var(--primary-light); color: var(--primary);">
                                                ${sub.student.fullName}
                                            </span>
                                        </div>
                                        <a href="${pageContext.request.contextPath}/tutor/homework/submissions/${sub.submissionId}" class="btn-widget btn-blue">
                                            Chấm bài
                                        </a>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="empty-card">Không có bài tập cần chấm.</div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Payment Widget -->
                <div class="section-container">
                    <div class="section-header">
                        <h2>Thanh toán</h2>
                    </div>
                    <div class="widget-card">
                        <c:choose>
                            <c:when test="${not empty dashboardPayments}">
                                <c:forEach var="p" items="${dashboardPayments}">
                                    <div class="payment-item">
                                        <div class="payment-row">
                                            <div>
                                                <h4>${p.classEntity.className}</h4>
                                                <small>Số buổi: ${p.totalSessions} buổi</small>
                                            </div>
                                            <div style="text-align: right;">
                                                <span class="widget-badge ${p.status == 'ADMIN_APPROVED' || p.status == 'COMPLETED' ? 'badge-green' : 'badge-yellow'}">
                                                    <c:choose>
                                                        <c:when test="${p.status == 'ADMIN_APPROVED' || p.status == 'COMPLETED'}">ĐÃ DUYỆT</c:when>
                                                        <c:otherwise>CHỜ DUYỆT</c:otherwise>
                                                    </c:choose>
                                                </span>
                                                <div class="payment-amount">
                                                    <fmt:formatNumber value="${empty p.amount ? 0 : p.amount}" pattern="#,###"/>đ
                                                </div>
                                            </div>
                                        </div>
                                        <a href="${pageContext.request.contextPath}/tutor/payment/${p.paymentId}" class="btn-outline-widget">Xem chi tiết</a>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="empty-card">Không có thanh toán.</div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</body>
</html>
