<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tutor Dashboard | TCMS</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/core-dashboard.css">
    <script src="https://unpkg.com/html5-qrcode"></script>
</head>
<body>

    <!-- Sidebar -->
    <aside class="sidebar">
        <div class="brand">
            <div class="brand-icon">
                <span class="material-symbols-rounded">person_celebrate</span>
            </div>
            <div class="brand-text">
                <span class="brand-title">TCMS</span>
                <span class="brand-subtitle">TUTOR PORTAL</span>
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
                    <span class="material-symbols-rounded">calendar_month</span>
                    Lịch dạy
                </a>
            </li>
            <li>
                <a href="javascript:void(0)" onclick="openScanner()" class="nav-link" style="background: var(--primary-light); color: var(--primary); font-weight: 700;">
                    <span class="material-symbols-rounded" style="font-weight: 700;">qr_code_scanner</span>
                    Điểm danh học sinh
                </a>
            </li>
            <li>
                <a href="#" class="nav-link">
                    <span class="material-symbols-rounded">description</span>
                    Bài tập & Tài liệu
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
                <input type="text" placeholder="Tìm kiếm lớp học, học sinh...">
            </div>
            <div class="header-actions">
                <button class="icon-btn">
                    <span class="material-symbols-rounded">notifications</span>
                </button>
                <div class="user-profile">
                    <div class="user-info">
                        <div class="user-name">Hồ Văn A</div>
                        <div class="user-role">Gia sư hạng xuất sắc</div>
                    </div>
                    <div class="avatar" style="background-color: #10b981; display: flex; justify-content: center; align-items: center; color: white; font-weight: bold;">G</div>
                </div>
            </div>
        </header>

        <!-- Dashboard Body -->
        <div class="dashboard-body">
            
            <!-- Greeting -->
            <section class="greeting-section">
                <div>
                    <h1>Chào buổi tối, Gia sư!</h1>
                    <p>Bạn có 3 lớp học sẽ diễn ra vào tối nay.</p>
                </div>
                <button onclick="openScanner()" class="btn-primary">
                    <span class="material-symbols-rounded">qr_code_scanner</span>
                    Bật máy quét điểm danh
                </button>
            </section>

            <!-- Stats Grid -->
            <section class="stats-grid">
                <div class="stat-card">
                    <div class="stat-header">
                        <div class="stat-icon blue">
                            <span class="material-symbols-rounded">meeting_room</span>
                        </div>
                    </div>
                    <div class="stat-title">LỚP HÔM NAY</div>
                    <div class="stat-value">3</div>
                </div>

                <div class="stat-card">
                    <div class="stat-header">
                        <div class="stat-icon cyan">
                            <span class="material-symbols-rounded">account_balance_wallet</span>
                        </div>
                    </div>
                    <div class="stat-title">HỌC PHÍ TẠM TÍNH</div>
                    <div class="stat-value">12.5M VNĐ</div>
                </div>
            </section>

            <!-- Layout Grid -->
            <section class="layout-grid" style="grid-template-columns: 1fr;">
                
                <!-- Full Width Table -->
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">Buổi học hôm nay</h3>
                        <a href="#" class="card-action">Mở xem toàn lịch</a>
                    </div>
                    <div class="table-container">
                        <div class="table-header" style="grid-template-columns: 2fr 1.5fr 1.5fr 1fr;">
                            <div class="th">LỚP MÔN HỌC</div>
                            <div class="th">THỜI GIAN</div>
                            <div class="th">TRẠNG THÁI</div>
                            <div class="th right">HÀNH ĐỘNG</div>
                        </div>
                        
                        <!-- Row 1 -->
                        <div class="table-row" style="grid-template-columns: 2fr 1.5fr 1.5fr 1fr;">
                            <div class="user-cell">
                                <div class="user-initials initials-blue" style="font-size: 16px;"><span class="material-symbols-rounded" style="font-size: 20px;">calculate</span></div>
                                <div class="user-detail">
                                    <h4>Toán 12 - A1</h4>
                                    <p>Ôn luyện thi Đại học</p>
                                </div>
                            </div>
                            <div class="subject-cell" style="display: flex; flex-direction: column; gap: 2px;">
                                <span style="font-weight: 700; color: var(--text-dark);">19:00 - 21:00</span>
                                <span style="font-size: 11px; color: var(--text-muted);">Phòng ảo 01</span>
                            </div>
                            <div>
                                <span class="status-badge status-approved" style="background: var(--success-light); color: var(--success);">ĐANG DIỄN RA</span>
                            </div>
                            <div class="date-cell">
                                <button onclick="openScanner(101)" class="btn-primary" style="padding: 6px 12px; border-radius: 6px; font-size: 12px; margin-left: auto;">Điểm danh</button>
                            </div>
                        </div>
                    </div>
                </div>

            </section>
        </div>
    </main>

    <!-- Scanner Modal directly embedded using Figma style overlay -->
    <div id="scannerModal" class="modal-overlay">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Quét mã học sinh</h3>
                <button class="close-btn" onclick="closeScanner()">
                    <span class="material-symbols-rounded">close</span>
                </button>
            </div>
            
            <div id="reader"></div>
            
            <div id="scanResult" style="margin-top: 1.5rem; color: var(--primary); font-weight: 700; text-align: center; padding: 1rem; background: var(--primary-light); border-radius: var(--radius-sm); border: 1px dashed rgba(0,87,191,0.3); display: none;">
                Chưa quét thấy mã
            </div>
        </div>
    </div>

    <script>
        let html5QrCode;
        let currentSessionId;

        function openScanner(sessionId) {
            currentSessionId = sessionId;
            document.getElementById('scannerModal').style.display = 'flex';
            
            document.getElementById('scanResult').style.display = 'none';
            document.getElementById('scanResult').innerText = "Đang chờ...";

            html5QrCode = new Html5Qrcode("reader");
            const config = { fps: 10, qrbox: { width: 250, height: 250 } };

            html5QrCode.start({ facingMode: "environment" }, config, onScanSuccess)
            .catch(err => {
                console.error("Camera error:", err);
                // Fallback debug logic
                document.getElementById('scanResult').style.display = 'block';
                document.getElementById('scanResult').innerText = "Lỗi Camera: Tính năng giả lập điểm danh thành công.";
                setTimeout(() => closeScanner(), 2000);
            });
        }

        function closeScanner() {
            document.getElementById('scannerModal').style.display = 'none';
            if (html5QrCode) {
                html5QrCode.stop().then(() => {
                    console.log("Scanner stopped.");
                }).catch((err) => {
                    console.warn("Unable to stop scanner.", err);
                });
            }
        }

        function onScanSuccess(decodedText, decodedResult) {
            console.log(`Scan matched: ${decodedText}`);
            document.getElementById('scanResult').style.display = 'block';
            document.getElementById('scanResult').innerText = "Đang xử lý: " + decodedText;
            
            // Stop scanning after success
            html5QrCode.stop().then(() => {
                // Call API to record attendance
                fetch('${pageContext.request.contextPath}/api/tutor/attendance/scan', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        sessionId: currentSessionId,
                        qrCode: decodedText
                    })
                })
                .then(response => response.text())
                .then(data => {
                    alert("Thành công: " + data);
                    closeScanner();
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert("Lỗi khi điểm danh!");
                });
            });
        }
    </script>
</body>
</html>