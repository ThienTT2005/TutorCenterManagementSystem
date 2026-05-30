<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="activePage" value="profile" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hồ sơ Admin | TCMS</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0"/>

    <link rel="stylesheet" href="<c:url value='/css/core-dashboard.css' />">

    <style>
        .profile-page {
            padding: 2.5rem;
            background: #f8fafc;
            min-height: calc(100vh - 70px);
        }

        .profile-header {
            margin-bottom: 2rem;
        }

        .profile-header h1 {
            margin: 0;
            color: #0f172a;
            font-size: 1.875rem;
            font-weight: 800;
            letter-spacing: -0.03em;
        }

        .profile-header p {
            margin: 0.5rem 0 0;
            color: #64748b;
            font-size: 0.95rem;
            font-weight: 500;
        }

        .profile-layout {
            display: grid;
            grid-template-columns: 340px 1fr;
            gap: 1.5rem;
            align-items: start;
        }

        .profile-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 1.5rem;
            box-shadow: 0 10px 25px rgba(15, 23, 42, 0.05);
            overflow: hidden;
        }

        .profile-summary {
            padding: 2rem;
            text-align: center;
        }

        .admin-avatar {
            width: 112px;
            height: 112px;
            border-radius: 50%;
            margin: 0 auto 1rem;
            background: linear-gradient(135deg, #0057bf, #38bdf8);
            color: #ffffff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            font-weight: 800;
            box-shadow: 0 12px 30px rgba(0, 87, 191, 0.25);
        }

        .profile-name {
            margin: 0;
            color: #0f172a;
            font-size: 1.25rem;
            font-weight: 800;
        }

        .profile-role {
            display: inline-flex;
            align-items: center;
            gap: 0.375rem;
            margin-top: 0.75rem;
            padding: 0.45rem 0.85rem;
            border-radius: 999px;
            background: #eff6ff;
            color: #2563eb;
            font-size: 0.75rem;
            font-weight: 800;
            text-transform: uppercase;
        }

        .profile-status {
            margin-top: 1rem;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            color: #16a34a;
            font-size: 0.875rem;
            font-weight: 700;
        }

        .status-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: #16a34a;
        }

        .profile-actions {
            padding: 1.25rem 2rem 2rem;
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
        }

        .profile-btn {
            height: 44px;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
            background: #ffffff;
            color: #334155;
            text-decoration: none;
            font-size: 0.875rem;
            font-weight: 800;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            transition: all 0.2s ease;
        }

        .profile-btn:hover {
            background: #f8fafc;
            border-color: #cbd5e1;
        }

        .profile-btn.primary {
            background: #0057bf;
            color: #ffffff;
            border-color: #0057bf;
        }

        .profile-btn.primary:hover {
            background: #00469b;
        }

        .info-card {
            padding: 2rem;
        }

        .section-title {
            margin: 0 0 1.5rem;
            color: #0f172a;
            font-size: 1.125rem;
            font-weight: 800;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 1rem;
        }

        .info-item {
            padding: 1rem;
            border-radius: 1rem;
            background: #f8fafc;
            border: 1px solid #e2e8f0;
        }

        .info-label {
            margin: 0 0 0.4rem;
            color: #64748b;
            font-size: 0.75rem;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.04em;
        }

        .info-value {
            margin: 0;
            color: #0f172a;
            font-size: 0.95rem;
            font-weight: 700;
            word-break: break-word;
        }

        .note-box {
            margin-top: 1.5rem;
            padding: 1rem;
            border-radius: 1rem;
            background: #fff7ed;
            border: 1px solid #fed7aa;
            color: #9a3412;
            display: flex;
            gap: 0.75rem;
            align-items: flex-start;
            font-size: 0.875rem;
            line-height: 1.6;
        }

        .note-box .material-symbols-rounded {
            font-size: 22px;
            flex-shrink: 0;
        }

        @media (max-width: 1024px) {
            .profile-page {
                padding: 1.5rem;
            }

            .profile-layout {
                grid-template-columns: 1fr;
            }

            .info-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>

<body>

<jsp:include page="common/sidebar.jsp" />

<main class="main-content">
    <jsp:include page="common/header.jsp" />

    <div class="profile-page">
        <div class="profile-header">
            <h1>Hồ sơ Admin</h1>
            <p>Thông tin tài khoản quản trị viên hệ thống TCMS.</p>
        </div>

        <div class="profile-layout">

            <div class="profile-card">
                <div class="profile-summary">
                    <div class="admin-avatar">
                        <c:choose>
                            <c:when test="${not empty admin.username}">
                                ${admin.username.substring(0, 1).toUpperCase()}
                            </c:when>
                            <c:otherwise>A</c:otherwise>
                        </c:choose>
                    </div>

                    <h2 class="profile-name">
                        <c:out value="${empty admin.username ? 'Admin' : admin.username}" />
                    </h2>

                    <div class="profile-role">
                        <span class="material-symbols-rounded" style="font-size: 16px;">admin_panel_settings</span>
                        <c:choose>
                            <c:when test="${not empty admin.role and not empty admin.role.roleName}">
                                <c:out value="${admin.role.roleName}" />
                            </c:when>
                            <c:otherwise>ADMIN</c:otherwise>
                        </c:choose>
                    </div>

                    <div class="profile-status">
                        <span class="status-dot"></span>
                        Tài khoản đang hoạt động
                    </div>
                </div>

                <div class="profile-actions">
                    <a href="${pageContext.request.contextPath}/change-password"
                       class="profile-btn primary">
                        <span class="material-symbols-rounded">key</span>
                        Đổi mật khẩu
                    </a>

                    <a href="${pageContext.request.contextPath}/admin/dashboard"
                       class="profile-btn">
                        <span class="material-symbols-rounded">dashboard</span>
                        Về Dashboard
                    </a>
                </div>
            </div>

            <div class="profile-card info-card">
                <h3 class="section-title">Thông tin tài khoản</h3>

                <div class="info-grid">
                    <div class="info-item">
                        <p class="info-label">Mã tài khoản</p>
                        <p class="info-value">
                            #USER-<c:out value="${admin.userId}" />
                        </p>
                    </div>

                    <div class="info-item">
                        <p class="info-label">Tên đăng nhập</p>
                        <p class="info-value">
                            <c:out value="${empty admin.username ? 'admin' : admin.username}" />
                        </p>
                    </div>

                    <div class="info-item">
                        <p class="info-label">Vai trò</p>
                        <p class="info-value">
                            <c:choose>
                                <c:when test="${not empty admin.role and not empty admin.role.roleName}">
                                    <c:out value="${admin.role.roleName}" />
                                </c:when>
                                <c:otherwise>ADMIN</c:otherwise>
                            </c:choose>
                        </p>
                    </div>

                    <div class="info-item">
                        <p class="info-label">Loại hồ sơ</p>
                        <p class="info-value">Tài khoản quản trị mặc định</p>
                    </div>

                    <div class="info-item">
                        <p class="info-label">Quyền truy cập</p>
                        <p class="info-value">Toàn quyền hệ thống</p>
                    </div>

                    <div class="info-item">
                        <p class="info-label">Trạng thái</p>
                        <p class="info-value">Đang hoạt động</p>
                    </div>
                </div>


            </div>

        </div>
    </div>
</main>

</body>
</html>