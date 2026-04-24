<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard | TCMS</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/core-dashboard.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/qrcodejs/1.0.0/qrcode.min.js"></script>
</head>
<body>

    <!-- Sidebar -->
    <aside class="sidebar">
        <div class="brand">
            <div class="brand-icon">
                <span class="material-symbols-rounded">school</span>
            </div>
            <div class="brand-text">
                <span class="brand-title">TCMS</span>
                <span class="brand-subtitle">STUDENT PORTAL</span>
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
                    <span class="material-symbols-rounded">menu_book</span>
                    Bài tập của tôi
                </a>
            </li>
            <li>
                <a href="#" class="nav-link">
                    <span class="material-symbols-rounded">trending_up</span>
                    Kết quả học tập
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
                <input type="text" placeholder="Tìm kiếm tài liệu, bài tập...">
            </div>
            <div class="header-actions">
                <button class="icon-btn">
                    <span class="material-symbols-rounded">notifications</span>
                </button>
                <div class="user-profile">
                    <div class="user-info">
                        <div class="user-name">Nguyễn Văn B</div>
                        <div class="user-role">Học viên lớp 12</div>
                    </div>
                    <div class="avatar" style="background-color: var(--primary); display: flex; justify-content: center; align-items: center; color: white; font-weight: bold;">S</div>
                </div>
            </div>
        </header>

        <!-- Dashboard Body -->
        <div class="dashboard-body">
            
            <!-- Greeting -->
            <section class="greeting-section">
                <div>
                    <h1>Xin chào, B!</h1>
                    <p>Hãy sẵn sàng cho buổi học tuyệt vời hôm nay.</p>
                </div>
                <a href="#" class="btn-primary" style="background: var(--warning); box-shadow: none;">
                    <span class="material-symbols-rounded">support_agent</span>
                    Hỗ trợ
                </a>
            </section>

            <!-- Layout Grid -->
            <section class="layout-grid">
                
                <!-- Left Column -->
                <div class="left-column">
                    <!-- Schedule Card -->
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Lịch học kế tiếp</h3>
                        </div>
                        <div style="padding: 0 2rem 2rem;">
                            <div style="display: flex; align-items: center; gap: 1rem; padding: 1.5rem; background: var(--primary-light); border-left: 4px solid var(--primary); border-radius: 8px;">
                                <div style="display: flex; flex-direction: column; gap: 4px;">
                                    <span style="color: var(--primary); font-weight: 700; font-size: 14px;">20:00 - Hôm nay</span>
                                    <h3 style="font-size: 18px; color: var(--text-dark);">Toán 12</h3>
                                    <p style="color: var(--text-muted); font-size: 13px;">Gia sư: Hồ Văn A</p>
                                </div>
                                <div style="margin-left: auto;">
                                    <span class="status-badge status-pending">Sắp diễn ra</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Assignments Card -->
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Bài tập cần làm</h3>
                            <a href="#" class="card-action">Xem tất cả</a>
                        </div>
                        <div style="padding: 0 2rem 2rem;">
                            <div style="display: flex; align-items: center; justify-content: center; padding: 3rem 1rem; text-align: center; color: var(--text-muted);">
                                <div style="display: flex; flex-direction: column; align-items: center; gap: 8px;">
                                    <span class="material-symbols-rounded" style="font-size: 48px; color: var(--border-color);">task</span>
                                    <p>Bạn không có bài tập nào sắp đến hạn.</p>
                                    <p style="font-size: 13px;">Thật tuyệt vời!</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Right Column -->
                <div class="right-column">
                    <!-- QR Code Widget -->
                    <div class="qr-container">
                        <div style="background: var(--primary-light); color: var(--primary); padding: 12px; border-radius: var(--radius-sm); margin-bottom: 8px;">
                            <span class="material-symbols-rounded" style="font-size: 32px;">qr_code_scanner</span>
                        </div>
                        <div>
                            <h3 style="font-size: 18px; font-weight: 700; margin-bottom: 4px;">Mã điểm danh</h3>
                            <p style="color: var(--text-muted); font-size: 13px;">Đưa mã này cho gia sư trước buổi học</p>
                        </div>
                        
                        <div class="qr-code" id="qrcode"></div>
                        
                        <p style="font-weight: 800; font-family: monospace; letter-spacing: 2px; font-size: 16px;">STUDENT_101</p>
                    </div>
                </div>

            </section>
        </div>
    </main>

    <script>
        // In a real app, the ID would come from the session/server
        const studentId = "101"; 
        new QRCode(document.getElementById("qrcode"), {
            text: "STUDENT_" + studentId,
            width: 180,
            height: 180,
            colorDark : "#0f172a",
            colorLight : "#f7f9fb",
            correctLevel : QRCode.CorrectLevel.H
        });
    </script>
</body>
</html>
