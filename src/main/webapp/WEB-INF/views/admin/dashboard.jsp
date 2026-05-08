<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | TCMS</title>
    <!-- Use Google Material Symbols Rounded for icons -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0" />
    <link rel="stylesheet" href="<c:url value='/css/core-dashboard.css' />">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>

    <c:set var="activePage" value="dashboard" scope="request" />
    
    <!-- Sidebar -->
    <jsp:include page="common/sidebar.jsp" />

    <!-- Main Content -->
    <main class="main-content">
        <!-- Top Header -->
        <jsp:include page="common/header.jsp" />

        <!-- Dashboard Body -->
        <div class="dashboard-body">
            
            <!-- Greeting -->
            <section class="greeting-section">
                <div>
                    <h1>Chào ${not empty loggedInUser.username ? loggedInUser.username : 'Admin'}!</h1>
                    <p>Chào mừng bạn quay trở lại hệ thống quản lý trung tâm gia sư.</p>
                </div>
                <a href="${pageContext.request.contextPath}/admin/classes/create" class="btn-primary">
                    <span class="material-symbols-rounded">add</span>
                    Tạo lớp học mới
                </a>
            </section>

            <!-- Stats Grid -->
            <section class="stats-grid">
                <div class="stat-card">
                    <div class="stat-header">
                        <div class="stat-icon blue">
                            <span class="material-symbols-rounded">group</span>
                        </div>

                    </div>
                    <div class="stat-title">TỔNG HỌC SINH</div>
                    <div class="stat-value">
                        <fmt:formatNumber value="${empty stats.totalStudents ? 0 : stats.totalStudents}" pattern="#,###" />
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-header">
                        <div class="stat-icon cyan">
                            <span class="material-symbols-rounded">how_to_reg</span>
                        </div>

                    </div>
                    <div class="stat-title">GIA SƯ ĐANG DẠY</div>
                    <div class="stat-value">
                        <fmt:formatNumber value="${empty stats.totalTutors ? 0 : stats.totalTutors}" pattern="#,###" />
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-header">
                        <div class="stat-icon red">
                            <span class="material-symbols-rounded">payments</span>
                        </div>

                    </div>
                    <div class="stat-title">SỐ LỚP THÁNG NÀY</div>
                    <div class="stat-value">
                        <fmt:formatNumber value="${empty stats.monthlyRevenue ? 0 : stats.monthlyRevenue}" pattern="#,###" />                        <span style="font-size: 14px; color: var(--text-muted); font-weight: 500;">VNĐ</span>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-header">
                        <div class="stat-icon yellow">
                            <span class="material-symbols-rounded">assignment_late</span>
                        </div>
                        <span class="stat-badge warning">Chờ duyệt</span>
                    </div>
                    <div class="stat-title">THANH TOÁN</div>
                    <div class="stat-value">
                        <fmt:formatNumber value="${empty stats.pendingPayments? 0 : stats.pendingPayments}" pattern="#,###" />
                    </div>
                </div>
            </section>

            <!-- Layout Grid -->
            <section class="layout-grid">
                
                <!-- Left Column -->
                <div class="left-column">
                    <!-- Chart Card -->
                    <div class="card">
                        <div class="card-header">
                            <div>
                                <h3 class="card-title">Số lớp trong tuần</h3>
                                <p style="font-size: 13px; color: var(--text-muted); margin-top: 4px;">
                                    Thống kê số lớp học cố định theo từng ngày trong tuần
                                </p>
                            </div>
                        </div>
                        <div class="chart-container">
                            <canvas id="growthChart"></canvas>
                        </div>
                    </div>

                    <!-- Recent Notifications Card -->
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">
                                Thông báo gần đây
                                <c:if test="${unreadCount gt 0}">
                <span class="stat-badge warning" style="margin-left: 8px;">
                    ${unreadCount} chưa đọc
                </span>
                                </c:if>
                            </h3>
                            <a href="${pageContext.request.contextPath}/notifications" class="card-action">
                                Xem tất cả
                            </a>
                        </div>

                        <div class="table-container">
                            <div class="table-header">
                                <div class="th">THÔNG BÁO</div>
                                <div class="th">LOẠI</div>
                                <div class="th">TRẠNG THÁI</div>
                                <div class="th right">THỜI GIAN</div>
                            </div>

                            <c:choose>
                                <c:when test="${not empty recentNotifications}">
                                    <c:forEach items="${recentNotifications}" var="notification">
                                        <div class="table-row">
                                            <div class="user-cell">
                                                <div class="user-initials ${notification.isRead eq true ? 'initials-blue' : 'initials-yellow'}">
                                <span class="material-symbols-rounded" style="font-size: 18px;">
                                    notifications
                                </span>
                                                </div>

                                                <div class="user-detail">
                                                    <h4>
                                                        <c:out value="${empty notification.title ? 'Thông báo' : notification.title}" />
                                                    </h4>
                                                    <p>
                                                        <c:out value="${empty notification.content ? 'Không có nội dung' : notification.content}" />
                                                    </p>
                                                </div>
                                            </div>

                                            <div class="subject-cell">
                                                <c:choose>
                                                    <c:when test="${not empty notification.type}">
                                                        <c:out value="${notification.type}" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        Chung
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>

                                            <div>
                                                <c:choose>
                                                    <c:when test="${notification.isRead eq true}">
                                                        <span class="status-badge status-approved">ĐÃ ĐỌC</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-badge status-pending">CHƯA ĐỌC</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>

                                            <div class="date-cell">
                                                <c:choose>
                                                    <c:when test="${not empty notification.createdAt}">
                                                        <c:set var="createdAtText"
                                                               value="${fn:replace(notification.createdAt, 'T', ' ')}" />

                                                        <span class="date-primary">
                                                                ${fn:substring(createdAtText, 0, 10)}
                                                        </span>
                                                        <span class="date-secondary">
                                                                ${fn:substring(createdAtText, 11, 16)}
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="date-secondary">Chưa có thời gian</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>

                                <c:otherwise>
                                    <div class="table-row">
                                        <div class="user-cell">
                                            <div class="user-initials initials-blue">
                            <span class="material-symbols-rounded" style="font-size: 18px;">
                                notifications_off
                            </span>
                                            </div>
                                            <div class="user-detail">
                                                <h4>Chưa có thông báo</h4>
                                                <p>Hiện tại bạn chưa có thông báo nào.</p>
                                            </div>
                                        </div>
                                        <div class="subject-cell">-</div>
                                        <div>
                                            <span class="status-badge status-approved">TRỐNG</span>
                                        </div>
                                        <div class="date-cell">
                                            <span class="date-secondary">-</span>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <!-- Right Column -->
                <div class="right-column">
                    
                    <!-- Active Widget -->
                    <div class="active-widget">
                        <div class="active-header">
                            <div class="widget-icon">
                                <span class="material-symbols-rounded">school</span>
                            </div>
                            <span class="widget-badge">Active Now</span>
                        </div>
                        <div class="widget-title">Active Classes</div>
                        <div class="widget-value">
                            <fmt:formatNumber value="${empty stats.activeClasses ? 0 : stats.activeClasses}" pattern="#,###" />
                        </div>
                    </div>

                    <!-- Quick Actions -->
                    <div>
                        <h3 style="font-size: 16px; font-weight: 700; margin-bottom: 12px;">Quick Actions</h3>
                        <div class="quick-actions">
                            <a href="${pageContext.request.contextPath}/admin/classes/create" class="action-btn">
                                <div class="action-icon"><span class="material-symbols-rounded">add_box</span></div>
                                Create Class
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/users/create" class="action-btn">
                                <div class="action-icon"><span class="material-symbols-rounded">person_add</span></div>
                                Create Account
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/feedback/pending" class="action-btn">
                                <div class="action-icon"><span class="material-symbols-rounded">calendar_add_on</span></div>
                                View Feedback
                            </a>
                            <a href="${pageContext.request.contextPath}/payment/admin" class="action-btn">
                                <div class="action-icon"><span class="material-symbols-rounded">fact_check</span></div>
                                Approve Payment
                            </a>
                        </div>
                    </div>
                </div>

            </section>
        </div>
    </main>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var canvas = document.getElementById('growthChart');

            if (!canvas) {
                return;
            }

            var ctx = canvas.getContext('2d');

            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: [
                        <c:choose>
                        <c:when test="${not empty stats and not empty stats.weeklyClasses}">
                        <c:forEach items="${stats.weeklyClasses}" var="entry" varStatus="status">
                        '${entry.key}'${not status.last ? ',' : ''}
                        </c:forEach>
                        </c:when>
                        <c:otherwise>
                        'T2','T3','T4','T5','T6','T7','CN'
                        </c:otherwise>
                        </c:choose>
                    ],
                    datasets: [{
                        label: 'Số lớp trong tuần',
                        data: [
                            <c:choose>
                            <c:when test="${not empty stats and not empty stats.weeklyClasses}">
                            <c:forEach items="${stats.weeklyClasses}" var="entry" varStatus="status">
                            ${entry.value}${not status.last ? ',' : ''}
                            </c:forEach>
                            </c:when>
                            <c:otherwise>
                            0,0,0,0,0,0,0
                            </c:otherwise>
                            </c:choose>
                        ],
                        backgroundColor: [
                            'rgba(0, 87, 191, 0.1)',
                            'rgba(0, 87, 191, 0.2)',
                            'rgba(0, 87, 191, 0.15)',
                            'rgba(0, 87, 191, 0.35)',
                            'rgba(0, 87, 191, 0.25)',
                            'rgba(0, 87, 191, 0.4)'
                        ],
                        borderRadius: 6,
                        borderSkipped: false,
                        barPercentage: 0.6
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: { display: false },
                        tooltip: {
                            backgroundColor: '#1e293b',
                            padding: 12,
                            titleFont: { size: 11 },
                            bodyFont: { size: 14, weight: 'bold' }
                        }
                    },
                    scales: {
                        x: {
                            grid: { display: false },
                            ticks: {
                                font: { size: 10, weight: 'bold' },
                                color: '#64748b'
                            }
                        },
                        y: {
                            display: false,
                            beginAtZero: true
                        }
                    }
                }
            });
        });
    </script>
</body>
</html>
