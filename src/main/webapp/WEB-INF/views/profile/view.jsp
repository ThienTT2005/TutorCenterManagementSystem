<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="role" value="${sessionScope.role}" />

<c:set var="role" value="${sessionScope.role}" />

<c:if test="${empty role and not empty profile and not empty profile.user and not empty profile.user.role}">
    <c:set var="role" value="${profile.user.role.roleName}" />
</c:if>

<c:if test="${empty role}">
    <c:set var="role" value="GUEST" />
</c:if>

<c:set var="isEdit" value="${param.edit == 'true'}" />
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hồ sơ cá nhân | TCMS</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap">

    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0"/>

    <link rel="stylesheet" href="<c:url value='/css/core-dashboard.css' />">

    <style>
        :root {
            --primary: #0057bf;
            --primary-hover: #004da8;
            --primary-light: #eff6ff;
            --bg-page: #f7fbff;
            --bg-white: #ffffff;
            --text-dark: #0f172a;
            --text-muted: #64748b;
            --border: #dbe3ef;
            --soft-border: #edf2f7;
            --green: #16a34a;
            --green-light: #dcfce7;
            --danger: #dc2626;
            --danger-light: #fee2e2;
            --purple: #7c3aed;
            --purple-light: #f3e8ff;
            --sidebar-width: 260px;
        }

        * {
            box-sizing: border-box;
            font-family: 'Inter', Arial, sans-serif;
        }

        body {
            margin: 0;
            background: var(--bg-page);
            color: var(--text-dark);
        }

        .main-content {
            margin-left: var(--sidebar-width);
            width: calc(100% - var(--sidebar-width));
            min-height: 100vh;
            background: var(--bg-page);
        }

        .profile-page {
            padding: 24px 32px 48px;
            min-height: calc(100vh - 70px);
        }

        .profile-topbar {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 18px;
            margin-bottom: 24px;
        }

        .page-title h1 {
            margin: 0 0 6px;
            color: #173b73;
            font-size: 25px;
            font-weight: 900;
            line-height: 1.2;
        }

        .page-title p {
            margin: 0;
            color: var(--text-muted);
            font-size: 13px;
            font-weight: 500;
        }

        .top-actions {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .btn {
            min-height: 38px;
            padding: 0 18px;
            border-radius: 10px;
            border: 1px solid transparent;
            font-size: 13px;
            font-weight: 800;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            text-decoration: none;
            cursor: pointer;
            transition: .18s ease;
        }

        .btn-primary {
            background: var(--primary);
            color: #ffffff;
            box-shadow: 0 8px 18px rgba(0, 87, 191, .2);
        }

        .btn-primary:hover {
            background: var(--primary-hover);
        }

        .btn-outline {
            background: #ffffff;
            color: #334155;
            border-color: #cbd5e1;
        }

        .btn-outline:hover {
            background: #f8fafc;
        }

        .profile-layout {
            display: grid;
            grid-template-columns: 290px minmax(0, 1fr);
            gap: 28px;
            align-items: start;
            max-width: 1120px;
        }

        .left-column,
        .right-column {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .profile-card,
        .account-card,
        .info-card {
            background: #ffffff;
            border: 1px solid var(--border);
            border-radius: 14px;
            box-shadow: 0 10px 24px rgba(15, 23, 42, .04);
            overflow: hidden;
        }

        .profile-card {
            text-align: center;
            padding: 24px 22px 22px;
            position: relative;
        }

        .profile-card::before {
            content: "";
            position: absolute;
            inset: 0 0 auto 0;
            height: 96px;
            background: linear-gradient(90deg, #f0f8ff, #e9fbff);
        }

        .avatar-wrap {
            position: relative;
            width: 110px;
            height: 110px;
            margin: 0 auto 14px;
            z-index: 1;
        }

        .avatar-img,
        .avatar-placeholder {
            width: 110px;
            height: 110px;
            border-radius: 20px;
            border: 4px solid #ffffff;
            box-shadow: 0 12px 26px rgba(15, 23, 42, .12);
            object-fit: cover;
            background: #dbeafe;
        }

        .avatar-placeholder {
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary);
            font-size: 38px;
        }

        .avatar-status {
            position: absolute;
            right: -2px;
            bottom: 6px;
            width: 24px;
            height: 24px;
            border-radius: 999px;
            background: #22c55e;
            border: 4px solid #ffffff;
        }

        .avatar-upload-mini {
            position: absolute;
            right: 6px;
            bottom: 6px;
            width: 30px;
            height: 30px;
            border: none;
            border-radius: 999px;
            background: var(--primary);
            color: #ffffff;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            box-shadow: 0 8px 16px rgba(0, 87, 191, .25);
        }

        .profile-name {
            margin: 0;
            color: #173b73;
            font-size: 20px;
            font-weight: 900;
            line-height: 1.25;
            position: relative;
            z-index: 1;
        }

        .profile-code {
            margin: 4px 0 10px;
            color: var(--primary);
            font-size: 13px;
            font-weight: 800;
            position: relative;
            z-index: 1;
        }

        .active-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-height: 26px;
            padding: 0 13px;
            border-radius: 999px;
            background: var(--green-light);
            color: var(--green);
            font-size: 11px;
            font-weight: 900;
            position: relative;
            z-index: 1;
        }

        .account-card {
            padding: 18px 20px;
        }

        .small-card-title {
            display: flex;
            align-items: center;
            gap: 8px;
            margin: 0 0 18px;
            color: #173b73;
            font-size: 15px;
            font-weight: 900;
        }

        .small-card-title i,
        .small-card-title .material-symbols-rounded {
            color: var(--primary);
            font-size: 17px;
        }

        .account-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 14px;
            margin-bottom: 18px;
            color: var(--text-muted);
            font-size: 13px;
        }

        .account-row strong {
            color: #173b73;
            font-size: 13px;
            font-weight: 900;
            text-align: right;
        }

        .role-pill {
            padding: 4px 8px;
            border-radius: 6px;
            background: var(--primary-light);
            color: var(--primary);
            font-size: 10px;
            font-weight: 900;
            text-transform: uppercase;
        }

        .password-btn {
            width: 100%;
            min-height: 42px;
            border-radius: 10px;
            border: none;
            background: #f1f5f9;
            color: #334155;
            font-size: 13px;
            font-weight: 800;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            text-decoration: none;
        }

        .info-card-header {
            min-height: 62px;
            padding: 0 24px;
            border-bottom: 1px solid var(--border);
            background: #f1f3f5;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .info-card-header h2 {
            margin: 0;
            color: #173b73;
            font-size: 16px;
            font-weight: 900;
        }

        .info-card-header i,
        .info-card-header .material-symbols-rounded {
            color: var(--primary);
            font-size: 18px;
        }

        .info-card-body {
            padding: 26px 28px;
        }

        .profile-info-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            column-gap: 52px;
            row-gap: 24px;
        }

        .field-view {
            display: flex;
            flex-direction: column;
            gap: 7px;
        }

        .field-label {
            color: #94a3b8;
            font-size: 11px;
            font-weight: 900;
            text-transform: uppercase;
            letter-spacing: .4px;
        }

        .field-value {
            color: #0f172a;
            font-size: 14px;
            font-weight: 700;
            line-height: 1.5;
        }

        .edit-form {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 22px 26px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .form-group.full {
            grid-column: 1 / -1;
        }

        .form-group label {
            color: #0f172a;
            font-size: 11px;
            font-weight: 900;
            text-transform: uppercase;
        }

        .form-control {
            width: 100%;
            min-height: 38px;
            border: 1px solid #94a3b8;
            border-radius: 8px;
            background: #ffffff;
            color: #0f172a;
            font-size: 13px;
            font-weight: 600;
            padding: 0 12px;
            outline: none;
        }

        .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(0, 87, 191, .1);
        }

        textarea.form-control {
            min-height: 112px;
            padding: 12px;
            resize: vertical;
            line-height: 1.5;
        }

        .study-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 26px;
        }

        .study-box {
            min-height: 72px;
            background: #f8fafc;
            border-radius: 12px;
            padding: 18px 20px;
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .study-icon {
            width: 38px;
            height: 38px;
            border-radius: 10px;
            background: #ffffff;
            color: #94a3b8;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .study-text span {
            display: block;
            color: #94a3b8;
            font-size: 10px;
            font-weight: 900;
            text-transform: uppercase;
            margin-bottom: 5px;
        }

        .study-text strong {
            color: #0f172a;
            font-size: 14px;
            font-weight: 800;
        }

        .children-table {
            width: 100%;
            border-collapse: collapse;
        }

        .children-table th {
            text-align: left;
            padding: 0 0 16px;
            color: #64748b;
            font-size: 11px;
            font-weight: 900;
            text-transform: uppercase;
        }

        .children-table td {
            padding: 14px 0;
            color: #334155;
            font-size: 13px;
            font-weight: 600;
            border-top: 1px solid #f1f5f9;
        }

        .child-name-cell {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .child-avatar {
            width: 30px;
            height: 30px;
            border-radius: 999px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            background: #dbeafe;
            color: #2563eb;
            font-size: 11px;
            font-weight: 900;
        }

        .child-avatar.purple {
            background: var(--purple-light);
            color: var(--purple);
        }

        .linked-parent {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 18px;
        }

        .linked-parent-left {
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .parent-avatar {
            width: 48px;
            height: 48px;
            border-radius: 999px;
            background: #e2e8f0;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            color: var(--primary);
        }

        .linked-parent-name {
            margin: 0 0 4px;
            color: #0f172a;
            font-size: 14px;
            font-weight: 900;
        }

        .linked-parent-phone {
            margin: 0;
            color: var(--text-muted);
            font-size: 12px;
            font-weight: 600;
        }

        .view-small-btn {
            min-height: 34px;
            padding: 0 14px;
            border-radius: 9px;
            border: 1px solid var(--border);
            background: #ffffff;
            color: #334155;
            font-size: 12px;
            font-weight: 800;
            display: inline-flex;
            align-items: center;
            gap: 7px;
            text-decoration: none;
        }

        .empty-profile {
            padding: 80px 24px;
            text-align: center;
            color: var(--text-muted);
        }

        .empty-profile .material-symbols-rounded {
            font-size: 60px;
            margin-bottom: 14px;
            opacity: .35;
        }

        .hidden-file-input {
            display: none;
        }

        @media (max-width: 1050px) {
            .profile-layout {
                grid-template-columns: 1fr;
            }

            .left-column {
                max-width: 320px;
            }
        }

        @media (max-width: 760px) {
            .main-content {
                margin-left: 0;
                width: 100%;
            }

            .profile-page {
                padding: 18px;
            }

            .profile-topbar {
                flex-direction: column;
            }

            .top-actions {
                width: 100%;
            }

            .top-actions .btn {
                flex: 1;
            }

            .profile-info-grid,
            .edit-form,
            .study-grid {
                grid-template-columns: 1fr;
            }
        }
        /* =========================
   HEADER UI OVERRIDE
   Áp dụng cho student/tutor/parent/admin header
========================= */

        .top-header {
            height: 72px;
            min-height: 72px;
            background: #ffffff;
            border-bottom: 1px solid #e5edf7;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 32px;
            position: sticky;
            top: 0;
            z-index: 100;
            box-shadow: 0 4px 18px rgba(15, 23, 42, 0.035);
        }

        /* Search */
        .search-wrapper {
            width: 360px;
            height: 42px;
            background: #f5f8fc;
            border: 1px solid #e2e8f0;
            border-radius: 14px;
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 0 14px;
            transition: all 0.2s ease;
        }

        .search-wrapper:focus-within {
            background: #ffffff;
            border-color: #0057bf;
            box-shadow: 0 0 0 4px rgba(0, 87, 191, 0.08);
        }

        .search-wrapper i,
        .search-wrapper .material-symbols-rounded {
            color: #64748b;
            font-size: 16px;
            flex-shrink: 0;
        }

        .search-wrapper input {
            width: 100%;
            height: 100%;
            border: none;
            outline: none;
            background: transparent;
            color: #0f172a;
            font-size: 14px;
            font-weight: 600;
        }

        .search-wrapper input::placeholder {
            color: #94a3b8;
            font-weight: 500;
        }

        /* Right tools */
        .header-tools {
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .tool-icon {
            width: 40px;
            height: 40px;
            border: none;
            border-radius: 12px;
            background: #ffffff;
            color: #526680;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            position: relative;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.2s ease;
        }

        .tool-icon:hover {
            background: #eff6ff;
            color: #0057bf;
        }

        .tool-icon i {
            font-size: 17px;
        }

        .tool-icon .badge,
        .badge {
            position: absolute;
            top: 5px;
            right: 5px;
            min-width: 16px;
            height: 16px;
            padding: 0 5px;
            border-radius: 999px;
            background: #ef4444;
            color: #ffffff;
            font-size: 10px;
            font-weight: 900;
            line-height: 16px;
            text-align: center;
            border: 2px solid #ffffff;
        }

        /* User dropdown */
        .user-dropdown {
            position: relative;
        }

        .user-toggle {
            min-width: 132px;
            height: 48px;
            border: 1px solid transparent;
            border-radius: 16px;
            background: #ffffff;
            padding: 5px 10px 5px 6px;
            display: flex;
            align-items: center;
            gap: 10px;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .user-toggle:hover,
        .user-toggle.active {
            background: #f8fbff;
            border-color: #dbeafe;
            box-shadow: 0 8px 20px rgba(15, 23, 42, 0.06);
        }

        .header-avatar {
            width: 38px;
            height: 38px;
            border-radius: 12px;
            object-fit: cover;
            background: #dbeafe;
            border: 1px solid #bfdbfe;
            flex-shrink: 0;
        }

        .user-meta {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            line-height: 1.15;
            min-width: 0;
        }

        .user-meta strong {
            max-width: 88px;
            color: #0f172a;
            font-size: 13px;
            font-weight: 900;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .user-meta span {
            margin-top: 3px;
            color: #64748b;
            font-size: 11px;
            font-weight: 700;
        }

        .user-toggle > i,
        .user-toggle .fa-chevron-down {
            color: #64748b;
            font-size: 12px;
            margin-left: 2px;
            transition: transform 0.2s ease;
        }

        .user-toggle.active > i,
        .user-toggle.active .fa-chevron-down {
            transform: rotate(180deg);
        }

        /* Dropdown menu */
        .user-menu,
        .notification-menu {
            position: absolute;
            top: calc(100% + 10px);
            right: 0;
            min-width: 230px;
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            box-shadow: 0 18px 40px rgba(15, 23, 42, 0.14);
            padding: 10px;
            display: none;
            z-index: 300;
        }

        .user-menu.active,
        .notification-menu.active {
            display: block;
        }

        .user-menu-header {
            padding: 12px;
            border-radius: 12px;
            background: #f8fafc;
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        .user-menu-header strong {
            color: #0f172a;
            font-size: 14px;
            font-weight: 900;
        }

        .user-menu-header span {
            color: #64748b;
            font-size: 12px;
            font-weight: 700;
        }

        .user-menu a {
            min-height: 38px;
            padding: 0 12px;
            border-radius: 10px;
            color: #334155;
            font-size: 13px;
            font-weight: 700;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 10px;
            transition: all 0.2s ease;
        }

        .user-menu a:hover {
            background: #eff6ff;
            color: #0057bf;
        }

        .user-menu a i {
            width: 16px;
            text-align: center;
        }

        .menu-divider {
            height: 1px;
            background: #edf2f7;
            margin: 8px 0;
        }

        .logout-link {
            color: #dc2626 !important;
        }

        .logout-link:hover {
            background: #fee2e2 !important;
            color: #b91c1c !important;
        }

        /* Notification menu */
        .notification-dropdown {
            position: relative;
        }

        .noti-header {
            padding: 10px 12px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .noti-header strong {
            color: #0f172a;
            font-size: 14px;
            font-weight: 900;
        }

        .noti-header a {
            color: #0057bf;
            font-size: 12px;
            font-weight: 800;
            text-decoration: none;
        }

        .noti-list {
            max-height: 300px;
            overflow-y: auto;
        }

        .noti-item {
            padding: 12px;
            border-radius: 12px;
            transition: all 0.2s ease;
        }

        .noti-item:hover {
            background: #f8fafc;
        }

        .noti-item h4 {
            margin: 0 0 4px;
            color: #0f172a;
            font-size: 13px;
            font-weight: 900;
        }

        .noti-item p {
            margin: 0;
            color: #64748b;
            font-size: 12px;
            line-height: 1.45;
        }

        .noti-time {
            display: block;
            margin-top: 6px;
            color: #94a3b8;
            font-size: 11px;
            font-weight: 600;
        }

        .noti-empty {
            padding: 24px 12px;
            text-align: center;
            color: #94a3b8;
        }

        .noti-empty i {
            font-size: 22px;
            margin-bottom: 8px;
        }

        .noti-empty p {
            margin: 0;
            font-size: 13px;
            font-weight: 700;
        }

        /* Responsive */
        @media (max-width: 900px) {
            .top-header {
                padding: 0 18px;
            }

            .search-wrapper {
                width: 260px;
            }

            .user-meta {
                display: none;
            }

            .user-toggle {
                min-width: auto;
                padding: 5px 8px;
            }
        }

        @media (max-width: 640px) {
            .top-header {
                height: auto;
                min-height: 72px;
                gap: 12px;
                flex-wrap: wrap;
                padding: 12px 16px;
            }

            .search-wrapper {
                order: 2;
                width: 100%;
            }

            .header-tools {
                margin-left: auto;
            }
        }
    </style>
</head>

<body>

<c:choose>
    <c:when test="${role == 'TUTOR'}">
        <jsp:include page="../tutor/common/sidebar.jsp"/>
    </c:when>
    <c:when test="${role == 'STUDENT'}">
        <jsp:include page="../student/common/sidebar.jsp"/>
    </c:when>
    <c:when test="${role == 'PARENT'}">
        <jsp:include page="../parent/common/sidebar.jsp"/>
    </c:when>
    <c:when test="${role == 'ADMIN'}">
        <jsp:include page="../admin/common/sidebar.jsp"/>
    </c:when>
</c:choose>
<main class="main-content">

    <c:choose>
        <c:when test="${role == 'TUTOR'}">
            <jsp:include page="../tutor/common/header.jsp"/>
        </c:when>
        <c:when test="${role == 'STUDENT'}">
            <jsp:include page="../student/common/header.jsp"/>
        </c:when>
        <c:when test="${role == 'PARENT'}">
            <jsp:include page="../parent/common/header.jsp"/>
        </c:when>
        <c:when test="${role == 'ADMIN'}">
            <jsp:include page="../admin/common/header.jsp"/>
        </c:when>
    </c:choose>
    <section class="profile-page">

        <c:choose>
            <c:when test="${not empty profile}">

                <c:set var="displayName" value="Người dùng TCMS"/>
                <c:set var="displayCode" value="TCMS"/>
                <c:set var="displayUsername" value=""/>
                <c:set var="displayEmail" value=""/>
                <c:set var="displayPhone" value=""/>
                <c:set var="displayAvatar" value="${pageContext.request.contextPath}/images/default-avatar.png"/>

                <c:choose>
                    <c:when test="${role == 'ADMIN'}">
                        <c:set var="displayName" value="${profile.username}"/>
                        <c:set var="displayUsername" value="${profile.username}"/>
                        <c:set var="displayCode" value="ADMIN"/>
                    </c:when>

                    <c:otherwise>
                        <c:if test="${not empty profile.fullName}">
                            <c:set var="displayName" value="${profile.fullName}"/>
                        </c:if>

                        <c:if test="${not empty profile.user and not empty profile.user.username}">
                            <c:set var="displayUsername" value="${profile.user.username}"/>
                        </c:if>

                        <c:choose>
                            <c:when test="${role == 'TUTOR' or role == 'PARENT'}">
                                <c:if test="${not empty profile.email}">
                                    <c:set var="displayEmail" value="${profile.email}"/>
                                </c:if>

                                <c:if test="${not empty profile.phone}">
                                    <c:set var="displayPhone" value="${profile.phone}"/>
                                </c:if>
                            </c:when>

                            <c:when test="${role == 'STUDENT'}">
                                <c:if test="${not empty profile.user and not empty profile.user.username}">
                                    <c:set var="displayEmail" value="${profile.user.username}"/>
                                </c:if>

                                <c:if test="${not empty profile.parent and not empty profile.parent.phone}">
                                    <c:set var="displayPhone" value="${profile.parent.phone}"/>
                                </c:if>
                            </c:when>
                        </c:choose>

                        <c:if test="${not empty profile.avatar}">
                            <c:choose>
                                <c:when test="${fn:startsWith(profile.avatar, 'http')}">
                                    <c:set var="displayAvatar" value="${profile.avatar}"/>
                                </c:when>
                                <c:otherwise>
                                    <c:set var="displayAvatar" value="${pageContext.request.contextPath}/uploads/${profile.avatar}"/>
                                </c:otherwise>
                            </c:choose>
                        </c:if>

                        <c:choose>
                            <c:when test="${role == 'TUTOR'}">
                                <c:set var="displayCode" value="GS-${profile.tutorId}"/>
                            </c:when>
                            <c:when test="${role == 'STUDENT'}">
                                <c:set var="displayCode" value="HS-${profile.studentId}"/>
                            </c:when>
                            <c:when test="${role == 'PARENT'}">
                                <c:set var="displayCode" value="PH-${profile.parentId}"/>
                            </c:when>
                        </c:choose>
                    </c:otherwise>
                </c:choose>

                <div class="profile-topbar">
                    <div class="page-title">
                        <h1>
                            <c:choose>
                                <c:when test="${isEdit}">Chỉnh sửa hồ sơ</c:when>
                                <c:otherwise>Hồ sơ cá nhân</c:otherwise>
                            </c:choose>
                        </h1>
                        <p>
                            <c:choose>
                                <c:when test="${isEdit}">Cập nhật thông tin cá nhân và học vấn của bạn.</c:when>
                                <c:otherwise>Xem thông tin cá nhân của mình</c:otherwise>
                            </c:choose>
                        </p>
                    </div>

                    <div class="top-actions">
                        <c:choose>
                            <c:when test="${isEdit}">
                                <a href="${pageContext.request.contextPath}/profile" class="btn btn-outline">
                                    Hủy
                                </a>

                                <button type="submit"
                                        form="profileUpdateForm"
                                        class="btn btn-primary">
                                    <i class="fa-regular fa-floppy-disk"></i>
                                    Lưu thông tin
                                </button>
                            </c:when>

                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/profile?edit=true"
                                   class="btn btn-primary">
                                    <i class="fa-solid fa-pen"></i>
                                    Sửa hồ sơ
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="profile-layout">

                    <aside class="left-column">

                        <div class="profile-card">
                            <div class="avatar-wrap">
                                <c:choose>
                                    <c:when test="${not empty displayAvatar}">
                                        <img src="${displayAvatar}"
                                             class="avatar-img"
                                             alt="Avatar"
                                             onerror="this.src='${pageContext.request.contextPath}/images/default-avatar.png'">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="avatar-placeholder">
                                            <i class="fa-solid fa-user"></i>
                                        </div>
                                    </c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${isEdit and role != 'ADMIN'}">
                                        <form id="avatarUploadForm"
                                              action="${pageContext.request.contextPath}/profile/avatar"
                                              method="post"
                                              enctype="multipart/form-data">
                                            <label class="avatar-upload-mini" for="avatarInput">
                                                <i class="fa-solid fa-camera"></i>
                                            </label>
                                            <input id="avatarInput"
                                                   class="hidden-file-input"
                                                   type="file"
                                                   name="file"
                                                   accept="image/*"
                                                   onchange="document.getElementById('avatarUploadForm').submit();">
                                        </form>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="avatar-status"></span>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <h2 class="profile-name">
                                <c:out value="${displayName}"/>
                            </h2>

                            <p class="profile-code">
                                <c:out value="${displayCode}"/>
                            </p>

                            <span class="active-badge">Đang hoạt động</span>
                        </div>

                        <div class="account-card">
                            <h3 class="small-card-title">
                                <i class="fa-regular fa-circle-user"></i>
                                Thông tin tài khoản
                            </h3>

                            <div class="account-row">
                                <span>Tên đăng nhập</span>
                                <strong>
                                    <c:choose>
                                        <c:when test="${not empty displayUsername}">
                                            <c:out value="${displayUsername}"/>
                                        </c:when>
                                        <c:otherwise>
                                            <c:out value="${displayName}"/>
                                        </c:otherwise>
                                    </c:choose>
                                </strong>
                            </div>

                            <c:if test="${role == 'PARENT'}">
                                <div class="account-row">
                                    <span>Vai trò</span>
                                    <strong>
                                        <span class="role-pill">PARENT</span>
                                    </strong>
                                </div>
                            </c:if>

                            <div class="account-row">
                                <span>
                                    <c:choose>
                                        <c:when test="${role == 'PARENT'}">Ngày tạo</c:when>
                                        <c:otherwise>Ngày tham gia</c:otherwise>
                                    </c:choose>
                                </span>
                                <strong>
                                    <c:choose>
                                        <c:when test="${not empty profile.user and not empty profile.user.createdAt}">
                                            <c:out value="${profile.user.createdAt}"/>
                                        </c:when>
                                        <c:when test="${role == 'ADMIN' and not empty profile.createdAt}">
                                            <c:out value="${profile.createdAt}"/>
                                        </c:when>
                                        <c:otherwise>Chưa cập nhật</c:otherwise>
                                    </c:choose>
                                </strong>
                            </div>

                            <a href="${pageContext.request.contextPath}/change-password"
                               class="password-btn">
                                <i class="fa-solid fa-rotate-left"></i>
                                <c:choose>
                                    <c:when test="${role == 'PARENT'}">Reset mật khẩu</c:when>
                                    <c:otherwise>Đổi mật khẩu</c:otherwise>
                                </c:choose>
                            </a>
                        </div>
                    </aside>

                    <section class="right-column">

                        <div class="info-card">
                            <div class="info-card-header">
                                <i class="fa-regular fa-user"></i>
                                <h2>Thông tin cá nhân</h2>
                            </div>

                            <div class="info-card-body">

                                <c:choose>
                                    <c:when test="${isEdit and role != 'ADMIN'}">
                                        <form id="profileUpdateForm"
                                              action="${pageContext.request.contextPath}/profile/update"
                                              method="post"
                                              class="edit-form">

                                            <div class="form-group">
                                                <label>Họ và tên</label>
                                                <input class="form-control"
                                                       type="text"
                                                       name="fullName"
                                                       value="${profile.fullName}"
                                                       required>
                                            </div>

                                            <c:if test="${role == 'TUTOR' or role == 'PARENT'}">
                                                <div class="form-group">
                                                    <label>Số điện thoại (SĐT)</label>
                                                    <input class="form-control"
                                                           type="text"
                                                           name="phone"
                                                           value="${profile.phone}">
                                                </div>

                                                <div class="form-group">
                                                    <label>Email</label>
                                                    <input class="form-control"
                                                           type="email"
                                                           name="email"
                                                           value="${profile.email}">
                                                </div>
                                            </c:if>

                                            <c:if test="${role == 'STUDENT'}">
                                                <div class="form-group">
                                                    <label>Tài khoản đăng nhập</label>
                                                    <input class="form-control"
                                                           type="text"
                                                           value="${profile.user.username}"
                                                           readonly>
                                                </div>

                                                <div class="form-group">
                                                    <label>SĐT phụ huynh</label>
                                                    <input class="form-control"
                                                           type="text"
                                                           value="${profile.parent.phone}"
                                                           readonly>
                                                </div>
                                            </c:if>

                                            <div class="form-group">
                                                <label>Ngày sinh</label>
                                                <input class="form-control"
                                                       type="date"
                                                       name="dob"
                                                       value="${profile.dob}">
                                            </div>

                                            <div class="form-group">
                                                <label>Giới tính</label>
                                                <select class="form-control" name="gender">
                                                    <option value="">Chọn giới tính</option>
                                                    <option value="Nam" ${profile.gender == 'Nam' ? 'selected' : ''}>Nam</option>
                                                    <option value="Nữ" ${profile.gender == 'Nữ' ? 'selected' : ''}>Nữ</option>
                                                    <option value="Khác" ${profile.gender == 'Khác' ? 'selected' : ''}>Khác</option>
                                                </select>
                                            </div>

                                            <div class="form-group full">
                                                <label>Địa chỉ</label>
                                                <input class="form-control"
                                                       type="text"
                                                       name="address"
                                                       value="${profile.address}">
                                            </div>

                                            <c:if test="${role == 'TUTOR'}">
                                                <div class="form-group">
                                                    <label>Trường đại học</label>
                                                    <input class="form-control"
                                                           type="text"
                                                           name="school"
                                                           value="${profile.school}">
                                                </div>

                                                <div class="form-group">
                                                    <label>Chuyên ngành</label>
                                                    <input class="form-control"
                                                           type="text"
                                                           name="major"
                                                           value="${profile.major}">
                                                </div>

                                                <div class="form-group full">
                                                    <label>Mô tả bản thân & kinh nghiệm</label>
                                                    <textarea class="form-control"
                                                              name="description"><c:out value="${profile.description}"/></textarea>
                                                </div>
                                            </c:if>

                                            <c:if test="${role == 'STUDENT'}">
                                                <div class="form-group">
                                                    <label>Trường học</label>
                                                    <input class="form-control"
                                                           type="text"
                                                           name="school"
                                                           value="${profile.school}">
                                                </div>

                                                <div class="form-group">
                                                    <label>Lớp</label>
                                                    <input class="form-control"
                                                           type="text"
                                                           name="grade"
                                                           value="${profile.grade}">
                                                </div>
                                            </c:if>

                                        </form>
                                    </c:when>

                                    <c:otherwise>
                                        <div class="profile-info-grid">
                                            <div class="field-view">
                                                <span class="field-label">Họ và tên</span>
                                                <span class="field-value">
                                                    <c:out value="${displayName}"/>
                                                </span>
                                            </div>

                                            <div class="field-view">
                                                <span class="field-label">Số điện thoại</span>
                                                <span class="field-value">
                                                    <c:choose>
                                                        <c:when test="${not empty displayPhone}">
                                                            <c:out value="${displayPhone}"/>
                                                        </c:when>
                                                        <c:otherwise>Chưa cập nhật</c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </div>

                                            <div class="field-view">
                                                <span class="field-label">Email</span>
                                                <span class="field-value">
                                                    <c:choose>
                                                        <c:when test="${not empty displayEmail}">
                                                            <c:out value="${displayEmail}"/>
                                                        </c:when>
                                                        <c:otherwise>Chưa cập nhật</c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </div>

                                            <div class="field-view">
                                                <span class="field-label">Ngày sinh</span>
                                                <span class="field-value">
                                                    <c:choose>
                                                        <c:when test="${not empty profile.dob}">
                                                            <c:out value="${profile.dob}"/>
                                                        </c:when>
                                                        <c:otherwise>Chưa cập nhật</c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </div>

                                            <div class="field-view">
                                                <span class="field-label">Giới tính</span>
                                                <span class="field-value">
                                                    <c:choose>
                                                        <c:when test="${not empty profile.gender}">
                                                            <c:out value="${profile.gender}"/>
                                                        </c:when>
                                                        <c:otherwise>Chưa cập nhật</c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </div>

                                            <div class="field-view">
                                                <span class="field-label">Địa chỉ</span>
                                                <span class="field-value">
                                                    <c:choose>
                                                        <c:when test="${not empty profile.address}">
                                                            <c:out value="${profile.address}"/>
                                                        </c:when>
                                                        <c:otherwise>Chưa cập nhật</c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </div>
                                        </div>
                                    </c:otherwise>
                                </c:choose>

                            </div>
                        </div>

                        <c:if test="${role == 'TUTOR'}">
                            <div class="info-card">
                                <div class="info-card-header">
                                    <i class="fa-solid fa-graduation-cap"></i>
                                    <h2>Học vấn & Chuyên môn</h2>
                                </div>

                                <div class="info-card-body">
                                    <c:choose>
                                        <c:when test="${isEdit}">
                                        </c:when>

                                        <c:otherwise>
                                            <div class="profile-info-grid">
                                                <div class="field-view">
                                                    <span class="field-label">Trường đại học</span>
                                                    <span class="field-value">
                                                        <c:choose>
                                                            <c:when test="${not empty profile.school}">
                                                                <c:out value="${profile.school}"/>
                                                            </c:when>
                                                            <c:otherwise>Chưa cập nhật</c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </div>

                                                <div class="field-view">
                                                    <span class="field-label">Chuyên ngành</span>
                                                    <span class="field-value">
                                                        <c:choose>
                                                            <c:when test="${not empty profile.major}">
                                                                <c:out value="${profile.major}"/>
                                                            </c:when>
                                                            <c:otherwise>Chưa cập nhật</c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </div>

                                                <div class="field-view" style="grid-column: 1 / -1;">
                                                    <span class="field-label">Mô tả bản thân</span>
                                                    <span class="field-value">
                                                        <c:choose>
                                                            <c:when test="${not empty profile.description}">
                                                                <c:out value="${profile.description}"/>
                                                            </c:when>
                                                            <c:otherwise>Chưa cập nhật</c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </div>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </c:if>

                        <c:if test="${role == 'STUDENT'}">
                            <div class="info-card">
                                <div class="info-card-header">
                                    <span class="material-symbols-rounded">auto_stories</span>
                                    <h2>Thông tin học tập</h2>
                                </div>

                                <div class="info-card-body">
                                    <div class="study-grid">
                                        <div class="study-box">
                                            <span class="study-icon">
                                                <i class="fa-solid fa-school"></i>
                                            </span>
                                            <div class="study-text">
                                                <span>Trường học</span>
                                                <strong>
                                                    <c:choose>
                                                        <c:when test="${not empty profile.school}">
                                                            <c:out value="${profile.school}"/>
                                                        </c:when>
                                                        <c:otherwise>Chưa cập nhật</c:otherwise>
                                                    </c:choose>
                                                </strong>
                                            </div>
                                        </div>

                                        <div class="study-box">
                                            <span class="study-icon">
                                                <i class="fa-regular fa-building"></i>
                                            </span>
                                            <div class="study-text">
                                                <span>Lớp</span>
                                                <strong>
                                                    <c:choose>
                                                        <c:when test="${not empty profile.grade}">
                                                            <c:out value="${profile.grade}"/>
                                                        </c:when>
                                                        <c:otherwise>Chưa cập nhật</c:otherwise>
                                                    </c:choose>
                                                </strong>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="info-card">
                                <div class="info-card-header">
                                    <i class="fa-solid fa-people-roof" style="color: #ef4444;"></i>
                                    <h2>Phụ huynh liên kết</h2>
                                </div>

                                <div class="info-card-body">
                                    <div class="linked-parent">
                                        <div class="linked-parent-left">
                                            <div class="parent-avatar">
                                                <i class="fa-solid fa-user"></i>
                                            </div>

                                            <div>
                                                <p class="linked-parent-name">
                                                    <c:choose>
                                                        <c:when test="${not empty profile.parent and not empty profile.parent.fullName}">
                                                            <c:out value="${profile.parent.fullName}"/>
                                                        </c:when>
                                                        <c:otherwise>Chưa cập nhật</c:otherwise>
                                                    </c:choose>
                                                </p>

                                                <p class="linked-parent-phone">
                                                    <c:choose>
                                                        <c:when test="${not empty profile.parent and not empty profile.parent.phone}">
                                                            + <c:out value="${profile.parent.phone}"/>
                                                        </c:when>
                                                        <c:otherwise>Chưa cập nhật</c:otherwise>
                                                    </c:choose>
                                                </p>
                                            </div>
                                        </div>


                                    </div>
                                </div>
                            </div>
                        </c:if>

                        <c:if test="${role == 'PARENT'}">
                            <div class="info-card">
                                <div class="info-card-header">
                                    <h2>Danh sách con</h2>
                                </div>

                                <div class="info-card-body">
                                    <table class="children-table">
                                        <thead>
                                        <tr>
                                            <th>Tên học sinh</th>
                                            <th>Lớp</th>
                                            <th>Trường</th>
                                        </tr>
                                        </thead>

                                        <tbody>
                                        <c:choose>
                                            <c:when test="${not empty children}">
                                                <c:forEach var="child" items="${children}" varStatus="loop">
                                                    <tr>
                                                        <td>
                                                            <div class="child-name-cell">
                                                                <span class="child-avatar ${loop.index % 2 == 1 ? 'purple' : ''}">
                                                                    <c:choose>
                                                                        <c:when test="${not empty child.fullName}">
                                                                            <c:out value="${fn:substring(child.fullName, 0, 1)}"/>
                                                                        </c:when>
                                                                        <c:otherwise>HS</c:otherwise>
                                                                    </c:choose>
                                                                </span>
                                                                <c:out value="${child.fullName}"/>
                                                            </div>
                                                        </td>

                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${not empty child.grade}">
                                                                    Lớp <c:out value="${child.grade}"/>
                                                                </c:when>
                                                                <c:otherwise>Chưa cập nhật</c:otherwise>
                                                            </c:choose>
                                                        </td>

                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${not empty child.school}">
                                                                    <c:out value="${child.school}"/>
                                                                </c:when>
                                                                <c:otherwise>Chưa cập nhật</c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:when>

                                            <c:otherwise>
                                                <tr>
                                                    <td colspan="3">Chưa có dữ liệu học sinh.</td>
                                                </tr>
                                            </c:otherwise>
                                        </c:choose>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </c:if>

                    </section>
                </div>

            </c:when>

            <c:otherwise>
                <div class="empty-profile">
                    <span class="material-symbols-rounded">account_circle</span>
                    <h3>Không tìm thấy thông tin hồ sơ</h3>
                    <p>Vui lòng đăng nhập lại hoặc liên hệ quản trị viên.</p>
                </div>
            </c:otherwise>
        </c:choose>

    </section>
</main>

</body>
</html>