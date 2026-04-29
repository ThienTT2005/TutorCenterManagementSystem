<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                    <h1>Chào ${empty loggedInUser.fullName ? 'Admin' : loggedInUser.fullName}!</h1>
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
                        <span class="stat-badge positive">+12%</span>
                    </div>
                    <div class="stat-title">TỔNG HỌC SINH</div>
                    <div class="stat-value">
                        <fmt:formatNumber value="${stats.totalStudents}" pattern="#,###" />
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-header">
                        <div class="stat-icon cyan">
                            <span class="material-symbols-rounded">how_to_reg</span>
                        </div>
                        <span class="stat-badge positive">+5%</span>
                    </div>
                    <div class="stat-title">GIA SƯ ĐANG DẠY</div>
                    <div class="stat-value">
                        <fmt:formatNumber value="${stats.totalTutors}" pattern="#,###" />
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-header">
                        <div class="stat-icon red">
                            <span class="material-symbols-rounded">payments</span>
                        </div>
                        <span class="stat-badge negative">-2%</span>
                    </div>
                    <div class="stat-title">DOANH THU THÁNG</div>
                    <div class="stat-value">
                        <fmt:formatNumber value="${stats.monthlyRevenue}" pattern="#,###" />
                        <span style="font-size: 14px; color: var(--text-muted); font-weight: 500;">VNĐ</span>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-header">
                        <div class="stat-icon yellow">
                            <span class="material-symbols-rounded">assignment_late</span>
                        </div>
                        <span class="stat-badge warning">Chờ duyệt</span>
                    </div>
                    <div class="stat-title">LỚP HỌC CHỜ</div>
                    <div class="stat-value">
                        <fmt:formatNumber value="${stats.waitingClasses}" pattern="#,###" />
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
                                <h3 class="card-title">Biểu đồ tăng trưởng</h3>
                                <p style="font-size: 13px; color: var(--text-muted); margin-top: 4px;">Số lượng học sinh mới trong 6 tháng qua</p>
                            </div>
                            <select style="border: none; background: var(--bg-page); padding: 6px 12px; border-radius: var(--radius-sm); font-size: 12px; font-weight: 700; color: var(--text-dark); cursor: pointer;">
                                <option>Năm 2026</option>
                                <option>Năm 2025</option>
                            </select>
                        </div>
                        <div class="chart-container">
                            <canvas id="growthChart"></canvas>
                        </div>
                    </div>

                    <!-- Recent Activity Card -->
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Hoạt động gần đây</h3>
                            <a href="#" class="card-action">Xem tất cả</a>
                        </div>
                        <div class="table-container">
                            <div class="table-header">
                                <div class="th">HỌC SINH / GIA SƯ</div>
                                <div class="th">MÔN HỌC</div>
                                <div class="th">TRẠNG THÁI</div>
                                <div class="th right">NGÀY ĐĂNG KÝ</div>
                            </div>
                            <!-- Row 1 -->
                            <div class="table-row">
                                <div class="user-cell">
                                    <div class="user-initials initials-blue">NL</div>
                                    <div class="user-detail">
                                        <h4>Nguyễn Lam</h4>
                                        <p>Gia sư Toán Cao cấp</p>
                                    </div>
                                </div>
                                <div class="subject-cell">Toán học 12</div>
                                <div><span class="status-badge status-approved">ĐÃ DUYỆT</span></div>
                                <div class="date-cell">
                                    <span class="date-primary">Hôm nay,</span>
                                    <span class="date-secondary">14:30</span>
                                </div>
                            </div>
                            <!-- Row 2 -->
                            <div class="table-row">
                                <div class="user-cell">
                                    <div class="user-initials initials-yellow">TH</div>
                                    <div class="user-detail">
                                        <h4>Trần Hưng</h4>
                                        <p>Học sinh lớp 9</p>
                                    </div>
                                </div>
                                <div class="subject-cell">Tiếng Anh Giao tiếp</div>
                                <div><span class="status-badge status-pending">CHỜ XỬ LÝ</span></div>
                                <div class="date-cell">
                                    <span class="date-primary">Hôm nay,</span>
                                    <span class="date-secondary">11:20</span>
                                </div>
                            </div>
                            <!-- Row 3 -->
                            <div class="table-row">
                                <div class="user-cell">
                                    <div class="user-initials initials-red">PA</div>
                                    <div class="user-detail">
                                        <h4>Phạm Anh</h4>
                                        <p>Học sinh lớp 11</p>
                                    </div>
                                </div>
                                <div class="subject-cell">Vật Lý</div>
                                <div><span class="status-badge status-cancelled">HỦY BỎ</span></div>
                                <div class="date-cell">
                                    <span class="date-primary">Hôm qua,</span>
                                    <span class="date-secondary">18:45</span>
                                </div>
                            </div>
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
                        <div class="widget-value">842</div>
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
                            <a href="${pageContext.request.contextPath}/admin/schedules" class="action-btn">
                                <div class="action-icon"><span class="material-symbols-rounded">calendar_add_on</span></div>
                                Add Schedule
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/payments/approve" class="action-btn">
                                <div class="action-icon"><span class="material-symbols-rounded">fact_check</span></div>
                                Approve Payment
                            </a>
                        </div>
                    </div>

                    <!-- System News -->
                    <div class="card news-card">
                        <div class="news-header">
                            <h3>Tin vắn hệ thống</h3>
                            <div class="dot"></div>
                        </div>
                        <div class="news-list">
                            <!-- News 1 -->
                            <div class="news-item finance">
                                <div class="news-item-header">
                                    <span class="material-symbols-rounded" style="font-size: 16px;">account_balance_wallet</span>
                                    TÀI CHÍNH
                                </div>
                                <h4>3 thanh toán mới</h4>
                                <p>Tổng cộng 12.5M VNĐ vừa được ghi nhận.</p>
                            </div>
                            <!-- News 2 -->
                            <div class="news-item schedule">
                                <div class="news-item-header">
                                    <span class="material-symbols-rounded" style="font-size: 16px;">event_busy</span>
                                    LỊCH HỌC
                                </div>
                                <h4>1 lịch trùng</h4>
                                <p>Lớp Toán 12 (Gia sư Lam) trùng lịch thi.</p>
                            </div>
                            <!-- News 3 -->
                            <div class="news-item hr">
                                <div class="news-item-header">
                                    <span class="material-symbols-rounded" style="font-size: 16px;">person_off</span>
                                    NHÂN SỰ
                                </div>
                                <h4>2 yêu cầu nghỉ</h4>
                                <p>Gia sư Minh và Gia sư Hoa xin nghỉ đột xuất.</p>
                            </div>
                        </div>
                    </div>

                </div>

            </section>
        </div>
    </main>

    <script>
        // Setup mock chart to perfectly match the blue bar chart in the image
        document.addEventListener('DOMContentLoaded', function() {
            var ctx = document.getElementById('growthChart').getContext('2d');
            
            // Gradient fill for the highest bar
            var gradientBlue = ctx.createLinearGradient(0, 0, 0, 400);
            gradientBlue.addColorStop(0, '#0057bf');
            gradientBlue.addColorStop(1, '#003e8c');

            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: ['THÁNG 1', 'THÁNG 2', 'THÁNG 3', 'THÁNG 4', 'THÁNG 5', 'THÁNG 6', 'THÁNG 7', 'THÁNG 8', 'THÁNG 9', 'THÁNG 10', 'THÁNG 11', 'THÁNG 12'],
                    datasets: [{
                        label: 'Học sinh mới',
                        data: [<c:forEach items="${stats.growthData}" var="count" varStatus="status">${count}${not status.last ? ',' : ''}</c:forEach>],
                        backgroundColor: [
                            'rgba(0, 87, 191, 0.1)', 'rgba(0, 87, 191, 0.2)', 'rgba(0, 87, 191, 0.15)',
                            'rgba(0, 87, 191, 0.35)', 'rgba(0, 87, 191, 0.25)', 'rgba(0, 87, 191, 0.4)',
                            'rgba(0, 87, 191, 0.3)', 'rgba(0, 87, 191, 0.45)', 'rgba(0, 87, 191, 0.5)',
                            'rgba(0, 87, 191, 0.6)', 'rgba(0, 87, 191, 0.7)', '#0057bf'
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
                        tooltip: { backgroundColor: '#1e293b', padding: 12, titleFont: {size: 11}, bodyFont: {size: 14, weight: 'bold'} }
                    },
                    scales: { 
                        x: { grid: { display: false, drawBorder: false }, ticks: { font: {size: 10, weight: 'bold'}, color: '#64748b' } },
                        y: { display: false, beginAtZero: true } // Hide Y axis per design
                    }
                }
            });
        });
    </script>
</body>
</html>
