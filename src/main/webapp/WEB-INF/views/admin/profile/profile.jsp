<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ sơ cá nhân | TCMS Admin</title>
    <!-- Google Material Symbols & Font Awesome -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/core-dashboard.css">
    <style>
        .profile-wrapper {
            max-width: 1100px;
            margin: 0 auto;
            padding: 2rem;
        }

        /* Hero Section */
        .profile-hero {
            background: white;
            border-radius: 24px;
            overflow: hidden;
            border: 1px solid var(--border-color);
            box-shadow: var(--shadow-sm);
            margin-bottom: 2rem;
            position: relative;
        }

        .hero-banner {
            height: 160px;
            background: linear-gradient(135deg, #075985 0%, #0c4a6e 100%);
        }

        .hero-content {
            padding: 0 40px 30px;
            display: flex;
            align-items: flex-end;
            margin-top: -60px;
            gap: 24px;
        }

        .profile-avatar-container {
            position: relative;
            z-index: 2;
        }

        .hero-avatar {
            width: 140px;
            height: 140px;
            border-radius: 20px;
            object-fit: cover;
            border: 5px solid white;
            box-shadow: var(--shadow-md);
            background: #f8fafc;
        }

        .status-dot {
            position: absolute;
            bottom: 8px;
            right: 8px;
            width: 18px;
            height: 18px;
            background: #22c55e;
            border: 3px solid white;
            border-radius: 50%;
        }

        .hero-info {
            flex: 1;
            padding-bottom: 5px;
        }

        .hero-info .name-row {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 8px;
        }

        .hero-info h2 {
            font-size: 28px;
            font-weight: 800;
            color: var(--text-dark);
        }

        .status-badge-active {
            background: #ecfdf5;
            color: #059669;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .hero-meta {
            display: flex;
            gap: 20px;
            color: var(--text-muted);
            font-size: 14px;
            font-weight: 500;
        }

        .hero-meta span {
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .btn-edit-profile {
            background: #0284c7;
            color: white;
            padding: 10px 20px;
            border-radius: 12px;
            font-weight: 700;
            font-size: 14px;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.2s;
            margin-bottom: 5px;
        }

        .btn-edit-profile:hover {
            background: #0369a1;
            transform: translateY(-2px);
        }

        /* Two Column Layout */
        .profile-grid-main {
            display: grid;
            grid-template-columns: 1.8fr 1fr;
            gap: 2rem;
        }

        .info-section-card {
            background: white;
            border-radius: 20px;
            padding: 24px;
            border: 1px solid var(--border-color);
            box-shadow: var(--shadow-sm);
            margin-bottom: 2rem;
        }

        .card-header-with-icon {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 24px;
        }

        .icon-square {
            width: 40px;
            height: 40px;
            background: #f0f9ff;
            color: #0284c7;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .card-header-with-icon h3 {
            font-size: 18px;
            font-weight: 800;
            color: #1e293b;
        }

        .info-details-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 24px 40px;
        }

        .detail-item label {
            display: block;
            font-size: 11px;
            font-weight: 700;
            color: #94a3b8;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 6px;
        }

        .detail-item div {
            font-size: 15px;
            font-weight: 600;
            color: #334155;
        }

        .detail-item .dot-active {
            color: #10b981;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        /* Right Column Widgets */
        .widget-title {
            font-size: 14px;
            font-weight: 800;
            color: #475569;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 16px;
        }

        .actions-list {
            background: white;
            border-radius: 20px;
            padding: 12px;
            border: 1px solid var(--border-color);
            box-shadow: var(--shadow-sm);
            margin-bottom: 2rem;
        }

        .action-link {
            display: flex;
            align-items: center;
            padding: 14px 16px;
            border-radius: 14px;
            color: #334155;
            text-decoration: none;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.2s;
            margin-bottom: 4px;
            gap: 12px;
        }

        .action-link:hover {
            background: #f8fafc;
        }

        .action-link i {
            color: #64748b;
            font-size: 16px;
        }

        .action-link span {
            flex: 1;
        }

        .action-link.active-action {
            background: #f1f5f9;
        }

        .btn-logout-red {
            color: #ef4444;
            display: flex;
            align-items: center;
            gap: 10px;
            justify-content: center;
            padding: 16px;
            font-weight: 700;
            font-size: 15px;
            text-decoration: none;
            transition: all 0.2s;
        }

        .btn-logout-red:hover {
            opacity: 0.8;
        }

        /* Warning Card */
        .warning-alert-card {
            background: #fffbeb;
            border-radius: 20px;
            padding: 20px;
            border: 1px solid #fef3c7;
            display: flex;
            gap: 16px;
        }

        .warning-icon {
            width: 40px;
            height: 40px;
            background: #ffedd5;
            color: #d97706;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .warning-content h4 {
            font-size: 15px;
            font-weight: 800;
            color: #92400e;
            margin-bottom: 6px;
        }

        .warning-content p {
            font-size: 13px;
            color: #b45309;
            line-height: 1.5;
            margin-bottom: 12px;
        }

        .warning-content a {
            color: #92400e;
            font-weight: 700;
            font-size: 13px;
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <c:set var="activePage" value="profile" scope="request" />

    <!-- Sidebar -->
    <jsp:include page="../common/sidebar.jsp" />

    <main class="main-content">
        <!-- Top Header -->
        <jsp:include page="../common/header.jsp" />

        <div class="profile-wrapper">
            
            <!-- Hero Section -->
            <div class="profile-hero">
                <div class="hero-banner"></div>
                <div class="hero-content">
                    <div class="profile-avatar-container">
                        <img class="hero-avatar" 
                             src="${pageContext.request.contextPath}/images/default-avatar.png"
                             alt="Avatar"
                             onerror="this.src='https://i.pravatar.cc/150?u=admin_an'">
                        <div class="status-dot"></div>
                    </div>
                    <div class="hero-info">
                        <div class="name-row">
                            <h2>Nguyễn Văn An</h2>
                            <span class="status-badge-active">Đang hoạt động</span>
                        </div>
                        <div class="hero-meta">
                            <span><i class="fa-regular fa-at"></i> admin_an</span>
                            <span><i class="fa-regular fa-calendar"></i> Gia nhập: 15/05/2023</span>
                        </div>
                    </div>
                    <a href="#" class="btn-edit-profile">
                        <i class="fa-solid fa-pen"></i>
                        Chỉnh sửa hồ sơ
                    </a>
                </div>
            </div>

            <!-- Two Column Grid -->
            <div class="profile-grid-main">
                
                <!-- Left Column: Info Cards -->
                <div class="left-column">
                    
                    <!-- Account Info -->
                    <div class="info-section-card">
                        <div class="card-header-with-icon">
                            <div class="icon-square">
                                <span class="material-symbols-rounded">shield_person</span>
                            </div>
                            <h3>Thông tin tài khoản</h3>
                        </div>
                        <div class="info-details-grid">
                            <div class="detail-item">
                                <label>Tên đăng nhập</label>
                                <div>admin_an</div>
                            </div>
                            <div class="detail-item">
                                <label>Vai trò</label>
                                <div>Quản trị viên trung tâm</div>
                            </div>
                            <div class="detail-item">
                                <label>Trạng thái</label>
                                <div class="dot-active"><i class="fa-solid fa-circle" style="font-size: 8px;"></i> Đang hoạt động</div>
                            </div>
                            <div class="detail-item">
                                <label>Ngày tạo tài khoản</label>
                                <div>15/05/2023</div>
                            </div>
                        </div>
                    </div>

                    <!-- Personal Info -->
                    <div class="info-section-card">
                        <div class="card-header-with-icon">
                            <div class="icon-square">
                                <span class="material-symbols-rounded">badge</span>
                            </div>
                            <h3>Thông tin cá nhân</h3>
                        </div>
                        <div class="info-details-grid">
                            <div class="detail-item">
                                <label>Họ và tên</label>
                                <div>Nguyễn Văn An</div>
                            </div>
                            <div class="detail-item">
                                <label>Số điện thoại</label>
                                <div>+84 987 654 321</div>
                            </div>
                            <div class="detail-item">
                                <label>Email</label>
                                <div>an.nguyen@tcms.edu.vn</div>
                            </div>
                            <div class="detail-item">
                                <label>Ngày sinh</label>
                                <div>12/08/1992</div>
                            </div>
                            <div class="detail-item">
                                <label>Giới tính</label>
                                <div>Nam</div>
                            </div>
                            <div class="detail-item">
                                <label>Địa chỉ</label>
                                <div>24 Lý Thường Kiệt, Hoàn Kiếm, Hà Nội</div>
                            </div>
                        </div>
                    </div>

                </div>

                <!-- Right Column: Secondary Widgets -->
                <div class="right-column">
                    
                    <h3 class="widget-title">Hành động nhanh</h3>
                    <div class="actions-list">
                        <a href="${pageContext.request.contextPath}/profile/change-password" class="action-link">
                            <i class="fa-solid fa-rotate"></i>
                            <span>Đổi mật khẩu</span>
                            <i class="fa-solid fa-chevron-right" style="font-size: 12px; margin-left: auto;"></i>
                        </a>
                        <a href="#" class="action-link">
                            <i class="fa-solid fa-clock-rotate-left"></i>
                            <span>Lịch sử hoạt động</span>
                            <i class="fa-solid fa-chevron-right" style="font-size: 12px; margin-left: auto;"></i>
                        </a>
                        <div style="height: 1px; background: #f1f5f9; margin: 8px 16px;"></div>
                        <a href="${pageContext.request.contextPath}/logout" class="btn-logout-red">
                            <i class="fa-solid fa-right-from-bracket"></i>
                            Đăng xuất
                        </a>
                    </div>



                </div>

            </div>

        </div>
    </main>

</body>
</html>

