<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Báo cáo & Thống kê | TCMS</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded" />
    <link rel="stylesheet" href="<c:url value='/css/core-dashboard.css' />">

    <style>
        .reports-page { padding: 28px; background: #f4f8fc; min-height: 100vh; }
        .page-header h1 { font-size: 24px; color: #1e3a5f; margin: 0 0 8px; font-weight: 900; }
        .page-header p { color: #64748b; font-size: 14px; margin: 0 0 28px; }

        .stats-grid { display: grid; grid-template-columns: repeat(5, 1fr); gap: 20px; margin-bottom: 28px; }
        .stat-card { background: white; border-radius: 16px; padding: 24px; box-shadow: 0 4px 16px rgba(15, 23, 42, 0.06); border: 1px solid #eaf0f6; }
        .stat-card .stat-label { font-size: 12px; color: #94a3b8; font-weight: 700; text-transform: uppercase; margin-bottom: 8px; }
        .stat-card .stat-value { font-size: 28px; font-weight: 900; color: #0f172a; }

        .analytics-grid { display: grid; grid-template-columns: minmax(0, 1.3fr) minmax(320px, 1.7fr); gap: 24px; margin-bottom: 26px; }
        .analysis-card { background: white; border: 1px solid #e2e8f0; border-radius: 20px; padding: 32px; box-shadow: 0 12px 30px rgba(15, 23, 42, 0.04); }
        .card-header h2 { margin: 0; color: #0f172a; font-size: 20px; font-weight: 900; }
        .card-header p { margin: 6px 0 32px; color: #94a3b8; font-size: 14px; font-weight: 600; }

        .ratio-layout { display: grid; grid-template-columns: 200px 1fr; gap: 48px; align-items: center; }
        .donut-wrap { width: 180px; height: 180px; border-radius: 50%; display: flex; align-items: center; justify-content: center; position: relative; }
        .donut-wrap::after { content: ""; width: 130px; height: 130px; border-radius: 50%; background: white; position: absolute; }
        .donut-center { position: relative; z-index: 2; text-align: center; }
        .donut-center strong { display: block; font-size: 32px; font-weight: 900; color: #0f172a; line-height: 1; }
        .donut-center span { font-size: 11px; color: #94a3b8; font-weight: 800; text-transform: uppercase; margin-top: 4px; display: block; }

        .ratio-list { display: flex; flex-direction: column; gap: 24px; }
        .ratio-item { position: relative; }
        .ratio-info { display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px; }
        .ratio-label { display: flex; align-items: center; gap: 8px; font-size: 15px; font-weight: 800; color: #334155; }
        .ratio-dot { width: 10px; height: 10px; border-radius: 50%; display: inline-block; }
        .ratio-dot.student { background: #0057bf; }
        .ratio-dot.tutor { background: #22c1dc; }
        .ratio-count { font-size: 15px; font-weight: 800; color: #94a3b8; }
        .ratio-bar { height: 6px; background: #f1f5f9; border-radius: 4px; overflow: hidden; width: 100%; }
        .ratio-fill { height: 100%; border-radius: 4px; transition: width 0.6s ease; }
        .ratio-fill.student { background: #0057bf; }
        .ratio-fill.tutor { background: #22c1dc; }

        .ratio-quote { margin-top: 32px; border-top: 1px solid #f1f5f9; padding-top: 24px; color: #64748b; font-size: 14px; font-style: italic; font-weight: 600; line-height: 1.6; }

        .classes-card { background: white; border: 1px solid #e2e8f0; border-radius: 20px; box-shadow: 0 12px 30px rgba(15, 23, 42, 0.04); overflow: hidden; }
        .classes-header { padding: 20px 24px; border-bottom: 1px solid #f1f5f9; display: flex; justify-content: space-between; align-items: center; }
        .classes-header h2 { margin: 0; font-size: 17px; font-weight: 900; color: #1e3a5f; }
        .report-table { width: 100%; border-collapse: collapse; }
        .report-table th { background: #f8fafc; padding: 14px 18px; color: #94a3b8; font-size: 11px; font-weight: 900; text-transform: uppercase; text-align: left; }
        .report-table td { padding: 16px 18px; border-top: 1px solid #f1f5f9; font-size: 13px; font-weight: 600; color: #334155; }
        .status-badge { padding: 4px 12px; border-radius: 999px; font-size: 11px; font-weight: 800; }
        .status-active { background: #dcfce7; color: #166534; }
        .status-inactive { background: #fee2e2; color: #991b1b; }
        .btn-detail { padding: 6px 12px; border-radius: 8px; background: #eff6ff; color: #2563eb; text-decoration: none; font-weight: 700; font-size: 12px; }

        @media (max-width: 1200px) { .stats-grid { grid-template-columns: repeat(3, 1fr); } .analytics-grid { grid-template-columns: 1fr; } }
        @media (max-width: 768px) { .stats-grid { grid-template-columns: repeat(2, 1fr); } }
    </style>
</head>
<body>

<c:set var="activePage" value="reports" scope="request" />
<jsp:include page="../common/sidebar.jsp" />

<main class="main-content">
    <jsp:include page="../common/header.jsp" />

    <div class="reports-page">
        <div class="page-header">
            <h1>Báo cáo & Thống kê</h1>
            <p>Phân tích dữ liệu thực tế từ hệ thống quản lý.</p>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-label">Lớp học</div>
                <div class="stat-value"><fmt:formatNumber value="${totalClasses}" type="number" /></div>
            </div>
            <div class="stat-card">
                <div class="stat-label">Học sinh</div>
                <div class="stat-value"><fmt:formatNumber value="${totalStudents}" type="number" /></div>
            </div>
            <div class="stat-card">
                <div class="stat-label">Gia sư</div>
                <div class="stat-value"><fmt:formatNumber value="${totalTutors}" type="number" /></div>
            </div>
            <div class="stat-card">
                <div class="stat-label">Phụ huynh</div>
                <div class="stat-value"><fmt:formatNumber value="${totalParents}" type="number" /></div>
            </div>
            <div class="stat-card">
                <div class="stat-label">Tổng doanh thu</div>
                <div class="stat-value" style="color: #10b981;">
                    <fmt:formatNumber value="${totalRevenue}" type="number" /> nghìn đồng
                </div>
            </div>
        </div>

        <div class="analytics-grid">
            <div class="analysis-card">
                <div class="card-header">
                    <h2>Tỷ lệ học sinh / gia sư</h2>
                    <p>Phân tích cân bằng nhân sự đào tạo</p>
                </div>
                <div class="ratio-layout">
                    <div class="donut-wrap" id="donutChart">
                        <div class="donut-center">
                            <strong><fmt:formatNumber value="${safeTotalTutors > 0 ? safeTotalStudents / safeTotalTutors : 0}" maxFractionDigits="1" /></strong>
                            <span>HỌC VIÊN/GS</span>
                        </div>
                    </div>
                    <div class="ratio-list">
                        <div class="ratio-item">
                            <div class="ratio-info">
                                <div class="ratio-label">
                                    <span class="ratio-dot student"></span>
                                    Học sinh (${studentPercent}%)
                                </div>
                                <div class="ratio-count">
                                    <fmt:formatNumber value="${safeTotalStudents}" type="number" />
                                </div>
                            </div>
                            <div class="ratio-bar">
                                <div class="ratio-fill student" style="width: ${studentPercent}%"></div>
                            </div>
                        </div>

                        <div class="ratio-item">
                            <div class="ratio-info">
                                <div class="ratio-label">
                                    <span class="ratio-dot tutor"></span>
                                    Gia sư (${tutorPercent}%)
                                </div>
                                <div class="ratio-count">
                                    <fmt:formatNumber value="${safeTotalTutors}" type="number" />
                                </div>
                            </div>
                            <div class="ratio-bar">
                                <div class="ratio-fill tutor" style="width: ${tutorPercent}%"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="ratio-quote">
                    "Tỷ lệ hiện tại đang ở mức ổn định cho chất lượng đào tạo nhóm nhỏ."
                </div>
            </div>

            <div class="analysis-card">
                <div class="card-header">
                    <h2>Biểu đồ doanh thu thực tế</h2>
                    <p>Tổng các khoản thanh toán COMPLETED theo từng tháng.</p>
                </div>
                <div style="height: 250px;">
                    <canvas id="revenueChart"></canvas>
                </div>
            </div>
        </div>

        <section class="classes-card">
            <div class="classes-header">
                <h2>Lớp học gần đây</h2>
                <a href="${pageContext.request.contextPath}/admin/classes" style="color: #2563eb; font-weight: 700; font-size: 13px; text-decoration: none;">Xem tất cả</a>
            </div>
            <table class="report-table">
                <thead>
                    <tr>
                        <th>Tên lớp</th>
                        <th>Môn học</th>
                        <th>Gia sư</th>
                        <th>Học phí</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${topClasses}" var="clazz">
                        <tr>
                            <td><strong>${clazz.className}</strong><br><small style="color: #94a3b8">ID: CL-${clazz.classId}</small></td>
                            <td>${clazz.subject} - ${clazz.grade}</td>
                            <td>${not empty clazz.tutor ? clazz.tutor.fullName : 'Chưa phân công'}</td>
                            <td><fmt:formatNumber value="${clazz.tuitionFeePerSession}" type="number" /> nghìn đồng</td>
                            <td>
                                <span class="status-badge ${clazz.status ? 'status-active' : 'status-inactive'}">
                                    ${clazz.status ? 'Hoạt động' : 'Tạm dừng'}
                                </span>
                            </td>
                            <td><a href="${pageContext.request.contextPath}/admin/classes/${clazz.classId}" class="btn-detail">Chi tiết</a></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </section>
    </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Biểu đồ doanh thu
        const ctx = document.getElementById('revenueChart').getContext('2d');
        const labels = [];
        const data = [];
        <c:forEach items="${revenueLabels}" var="l">labels.push('${l}');</c:forEach>
        <c:forEach items="${revenueData}" var="d">data.push(${d});</c:forEach>

        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels.length > 0 ? labels : ['Chưa có dữ liệu'],
                datasets: [{
                    label: 'Doanh thu (VNĐ)',
                    data: data.length > 0 ? data : [0],
                    backgroundColor: 'rgba(16, 185, 129, 0.2)',
                    borderColor: '#10b981',
                    borderWidth: 2,
                    borderRadius: 8
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: { legend: { display: false } },
                scales: { 
                    y: { 
                        beginAtZero: true,
                        ticks: { callback: (val) => new Intl.NumberFormat('vi-VN').format(val) + ' nghìn đồng' }
                    }
                }
            }
        });

        // Donut Chart
        const donut = document.getElementById('donutChart');
        const sPercent = ${studentPercent};
        donut.style.background = `conic-gradient(#0057bf 0% ${sPercent}%, #22c1dc ${sPercent}% 100%)`;
    });
</script>

</body>
</html>