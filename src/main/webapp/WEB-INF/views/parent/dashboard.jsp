<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Parent Dashboard | TCMS</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/core-dashboard.css">
</head>
<body>

    <!-- Sidebar -->
    <aside class="sidebar">
        <div class="brand">
            <div class="brand-icon">
                <span class="material-symbols-rounded">family_restroom</span>
            </div>
            <div class="brand-text">
                <span class="brand-title">TCMS</span>
                <span class="brand-subtitle">PARENT PORTAL</span>
            </div>
        </div>

        <ul class="nav-menu">
            <li>
                <a href="#" class="nav-link active">
                    <span class="material-symbols-rounded">dashboard</span>
                    Tổng quan
                </a>
            </li>
            <li>
                <a href="#" class="nav-link">
                    <span class="material-symbols-rounded">payments</span>
                    Học phí
                </a>
            </li>
            <li>
                <a href="#" class="nav-link">
                    <span class="material-symbols-rounded">notifications</span>
                    Thông báo
                    <span style="background: var(--danger); color: white; padding: 2px 6px; border-radius: 50%; font-size: 10px; margin-left: auto;">3</span>
                </a>
            </li>
        </ul>

        <div class="sidebar-footer">
            <a href="#" class="nav-link">
                <span class="material-symbols-rounded">settings</span>
                Cài đặt
            </a>
            <a href="${pageContext.request.contextPath}/logout" class="nav-link" style="color: var(--danger);">
                <span class="material-symbols-rounded">logout</span>
                Đăng xuất
            </a>
        </div>
    </aside>

    <!-- Main Content -->
    <main class="main-content">
        <!-- Top Header -->
        <header class="top-header">
            <div class="search-bar">
                <span class="material-symbols-rounded">search</span>
                <input type="text" placeholder="Tìm kiếm thông tin...">
            </div>
            <div class="header-actions">
                <button class="icon-btn">
                    <span class="material-symbols-rounded">notifications</span>
                </button>
                <div class="user-profile">
                    <div class="user-info">
                        <div class="user-name">Ông Nguyễn Văn C</div>
                        <div class="user-role">Phụ huynh</div>
                    </div>
                    <div class="avatar" style="background-color: var(--text-dark); display: flex; justify-content: center; align-items: center; color: white; font-weight: bold;">P</div>
                </div>
            </div>
        </header>

        <!-- Dashboard Body -->
        <div class="dashboard-body">
            
            <!-- Greeting -->
            <section class="greeting-section">
                <div>
                    <h1>Xin chào, Phụ huynh!</h1>
                    <p>Chào mừng quay trở lại cổng thông tin phụ huynh.</p>
                </div>
            </section>

            <!-- Stats Grid -->
            <section class="stats-grid">
                <div class="stat-card">
                    <div class="stat-header">
                        <div class="stat-icon blue">
                            <span class="material-symbols-rounded">face</span>
                        </div>
                    </div>
                    <div class="stat-title">HỌC SINH ĐANG HỌC</div>
                    <div class="stat-value">2</div>
                </div>

                <div class="stat-card">
                    <div class="stat-header">
                        <div class="stat-icon red">
                            <span class="material-symbols-rounded">payments</span>
                        </div>
                        <span class="stat-badge warning">Chưa thanh toán</span>
                    </div>
                    <div class="stat-title" style="color: var(--danger);">HỌC PHÍ CẦN ĐÓNG</div>
                    <div class="stat-value" style="color: var(--danger);">4.2M VNĐ</div>
                </div>
            </section>

            <!-- Layout Grid -->
            <section class="layout-grid">
                
                <!-- Left Column -->
                <div class="left-column">
                    <!-- Progress Card -->
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Kết quả học tập</h3>
                            <a href="#" class="card-action">Xem chi tiết</a>
                        </div>
                        <div style="padding: 0 2rem 2rem;">
                            <div style="display: flex; gap: 1rem; align-items: center; margin-bottom: 2rem;">
                                <div class="avatar" style="background: var(--primary-light); color: var(--primary); font-weight: bold; display: flex; align-items: center; justify-content: center; width: 48px; height: 48px; font-size: 20px;">B</div>
                                <div>
                                    <h3 style="font-size: 16px; font-weight: 700;">Nguyễn Văn B</h3>
                                    <p style="color: var(--text-muted); font-size: 13px;">Lớp 12 - Toán, Lý</p>
                                </div>
                            </div>
                            
                            <div style="margin-bottom: 2rem;">
                                <div style="display: flex; justify-content: space-between; margin-bottom: 0.5rem;">
                                    <span style="font-size: 14px; font-weight: 600;">Chuyên cần</span>
                                    <span style="font-size: 14px; font-weight: 700; color: var(--success);">95%</span>
                                </div>
                                <div class="progress-bar-bg">
                                    <div class="progress-bar-fill" style="width: 95%;"></div>
                                </div>
                            </div>

                            <button style="width: 100%; padding: 12px; border: 1px solid var(--primary); color: var(--primary); background: transparent; border-radius: var(--radius-sm); cursor: pointer; font-weight: 600; font-size: 14px;">Xem bảng điểm chi tiết</button>
                        </div>
                    </div>
                </div>

                <!-- Right Column -->
                <div class="right-column">
                    <!-- Payment Card -->
                    <div class="card" style="border-top: 4px solid var(--danger);">
                        <div class="card-header">
                            <h3 class="card-title">Thanh toán sắp tới</h3>
                        </div>
                        <div style="padding: 0 2rem 2rem;">
                            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem;">
                                <div>
                                    <p style="font-weight: 700; font-size: 14px;">Học phí tháng 04/2026</p>
                                    <p style="color: var(--text-muted); font-size: 12px; margin-top: 4px;">Hạn nộp: 25/04/2026</p>
                                </div>
                                <span style="font-weight: 800; color: var(--danger); font-size: 18px;">4.200.000đ</span>
                            </div>
                            <button onclick="alert('Chức năng tải minh chứng đang được thực hiện')" class="btn-primary" style="width: 100%; justify-content: center; padding: 14px; font-size: 14px;">
                                <span class="material-symbols-rounded">account_balance_wallet</span>
                                Đóng học phí ngay
                            </button>
                        </div>
                    </div>
                </div>

            </section>
        </div>
    </main>

</body>
</html>
