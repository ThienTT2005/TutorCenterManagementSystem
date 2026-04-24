<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Account Management | TCMS Admin</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0" />
    <link rel="stylesheet" href="<c:url value='/css/core-dashboard.css' />">
    <style>
        .role-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 800;
            text-transform: upapercase;
            letter-spacing: 0.5px;
            display: inline-flex;
            align-items: center;
            gap: 4px;
        }
        .role-tutor { background: #e0f2fe; color: #0369a1; }
        .role-parent { background: #f3e8ff; color: #7e22ce; }
        .role-student { background: #ecfeff; color: #0891b2; }
        .role-admin { background: #f1f5f9; color: #475569; }

        .status-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            display: inline-block;
            margin-right: 6px;
        }
        .dot-active { background-color: var(--success); }
        .dot-blocked { background-color: var(--danger); }

        .actions-cell {
            display: flex;
            gap: 8px;
        }
        .action-btn {
            width: 32px;
            height: 32px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 1px solid var(--border-color);
            background: white;
            color: var(--text-muted);
            cursor: pointer;
            transition: all 0.2s;
        }
        .action-btn:hover {
            background: var(--bg-page);
            color: var(--primary);
            border-color: var(--primary);
        }
        .action-btn.delete:hover {
            color: var(--danger);
            border-color: var(--danger);
        }

        .modal-backdrop {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(15, 23, 42, 0.45);
            z-index: 9999;
            padding: 24px;
            overflow-y: auto;
        }
        .modal-box {
            width: 100%;
            max-width: 520px;
            background: #fff;
            border-radius: 20px;
            margin: 40px auto;
            padding: 24px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.18);
        }
        .modal-box h3 {
            margin: 0 0 16px;
            font-size: 20px;
        }
        .modal-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 12px;
        }
        .modal-field label {
            display: block;
            font-size: 12px;
            font-weight: 700;
            color: var(--text-muted);
            margin-bottom: 6px;
        }
        .modal-field input,
        .modal-field select {
            width: 100%;
            height: 42px;
            border-radius: 10px;
            border: 1px solid var(--border-color);
            padding: 0 12px;
            outline: none;
            background: #fff;
        }
        .modal-actions {
            margin-top: 18px;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }
        .btn-secondary {
            border: 1px solid var(--border-color);
            background: white;
            color: var(--text-dark);
            height: 40px;
            padding: 0 16px;
            border-radius: 10px;
            cursor: pointer;
            font-weight: 600;
        }
        .btn-primary-solid {
            border: none;
            background: var(--primary);
            color: white;
            height: 40px;
            padding: 0 16px;
            border-radius: 10px;
            cursor: pointer;
            font-weight: 600;
        }
        .detail-line {
            margin: 10px 0;
            font-size: 14px;
        }
        .detail-line strong {
            display: inline-block;
            min-width: 110px;
        }

        /* Pagination Styles */
        .pagination-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 24px;
            background: #fff;
            border-top: 1px solid #f1f5f9;
            margin-top: 0;
        }
        .pagination-info {
            font-size: 13px;
            color: #64748b;
            font-weight: 500;
        }
        .pagination-info strong {
            color: #1e293b;
            font-weight: 700;
        }
        .pagination-controls {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .btn-page {
            display: flex;
            align-items: center;
            justify-content: center;
            min-width: 40px;
            height: 40px;
            padding: 0 6px;
            border-radius: 10px;
            border: 1px solid #e2e8f0;
            background: #fff;
            color: #334155;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
            cursor: pointer;
        }
        .btn-page:hover:not(.active):not(.disabled) {
            background: #f8fafc;
            border-color: #cbd5e1;
            color: var(--primary);
            transform: translateY(-1px);
        }
        .btn-page.active {
            background: #0057bf;
            color: #fff;
            border-color: #0057bf;
            box-shadow: 0 4px 12px rgba(0, 87, 191, 0.2);
        }
        .btn-page.disabled {
            opacity: 0.5;
            cursor: not-allowed;
            pointer-events: none;
        }
        .btn-page .material-symbols-rounded {
            font-size: 20px;
        }
        .pagination-dots {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 32px;
            color: #94a3b8;
            font-weight: 800;
            letter-spacing: 2px;
        }
    </style>
</head>
<body>

<c:set var="activePage" value="accounts" scope="request" />

<jsp:include page="../common/sidebar.jsp" />

<main class="main-content">
    <jsp:include page="../common/header.jsp" />

    <div class="dashboard-body">

        <div class="page-header">
            <div class="page-title">
                <h2>Danh sách tài khoản</h2>
                <p>Quản lý và giám sát các nhóm người dùng trong hệ thống trung tâm.</p>
            </div>
            <a href="${pageContext.request.contextPath}/admin/accounts/create" class="btn-primary" style="text-decoration: none;">
                <span class="material-symbols-rounded">person_add</span>
                Tạo tài khoản
            </a>
        </div>

        <section class="stats-grid">
            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-icon blue">
                        <span class="material-symbols-rounded">groups</span>
                    </div>
                </div>
                <div class="stat-title">TỔNG TÀI KHOẢN</div>
                <div class="stat-value">${stats.total}</div>
                <div class="stat-trend ${stats.totalTrend >= 0 ? 'trend-up' : 'trend-down'}">
                    <span class="material-symbols-rounded">
                        ${stats.totalTrend >= 0 ? 'trending_up' : 'trending_down'}
                    </span>
                    ${stats.totalTrend >= 0 ? '+' : ''}${stats.totalTrend}%
                </div>
                <div style="font-size: 11px; color: var(--text-muted); margin-top: 4px; font-weight: 500;">so với tháng trước</div>
            </div>

            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-icon blue">
                        <span class="material-symbols-rounded">person_celebrate</span>
                    </div>
                </div>
                <div class="stat-title">GIA SƯ</div>
                <div class="stat-value">${stats.tutor}</div>
                <div class="stat-trend ${stats.tutorTrend >= 0 ? 'trend-up' : 'trend-down'}">
                    <span class="material-symbols-rounded">
                        ${stats.tutorTrend >= 0 ? 'trending_up' : 'trending_down'}
                    </span>
                    ${stats.tutorTrend >= 0 ? '+' : ''}${stats.tutorTrend}%
                </div>
                <div style="font-size: 11px; color: var(--text-muted); margin-top: 4px; font-weight: 500;">so với tháng trước</div>
            </div>

            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-icon purple">
                        <span class="material-symbols-rounded">family_restroom</span>
                    </div>
                </div>
                <div class="stat-title">PHỤ HUYNH</div>
                <div class="stat-value">${stats.parent}</div>
                <div class="stat-trend ${stats.parentTrend >= 0 ? 'trend-up' : 'trend-down'}">
                    <span class="material-symbols-rounded">
                        ${stats.parentTrend >= 0 ? 'trending_up' : 'trending_down'}
                    </span>
                    ${stats.parentTrend >= 0 ? '+' : ''}${stats.parentTrend}%
                </div>
                <div style="font-size: 11px; color: var(--text-muted); margin-top: 4px; font-weight: 500;">so với tháng trước</div>
            </div>

            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-icon purple">
                        <span class="material-symbols-rounded">face</span>
                    </div>
                </div>
                <div class="stat-title">HỌC SINH</div>
                <div class="stat-value">${stats.student}</div>
                <div class="stat-trend ${stats.studentTrend >= 0 ? 'trend-up' : 'trend-down'}">
                    <span class="material-symbols-rounded">
                        ${stats.studentTrend >= 0 ? 'trending_up' : 'trending_down'}
                    </span>
                    ${stats.studentTrend >= 0 ? '+' : ''}${stats.studentTrend}%
                </div>
                <div style="font-size: 11px; color: var(--text-muted); margin-top: 4px; font-weight: 500;">so với tháng trước</div>
            </div>
        </section>

        <form action="${pageContext.request.contextPath}/admin/accounts" method="GET" class="filters-toolbar">
            <div class="filter-group" style="flex: 1.5;">
                <div class="filter-input">
                    <span class="material-symbols-rounded" style="color: var(--text-muted);">search</span>
                    <input type="text" name="keyword" value="${param.keyword}" placeholder="Tìm Username, Họ tên, ID...">
                </div>
            </div>

            <div class="filter-group">
                <div class="filter-input">
                    <select name="role">
                        <option value="">Tất cả Role</option>
                        <option value="ADMIN" ${param.role == 'ADMIN' ? 'selected' : ''}>Admin</option>
                        <option value="TUTOR" ${param.role == 'TUTOR' ? 'selected' : ''}>Gia sư</option>
                        <option value="PARENT" ${param.role == 'PARENT' ? 'selected' : ''}>Phụ huynh</option>
                        <option value="STUDENT" ${param.role == 'STUDENT' ? 'selected' : ''}>Học sinh</option>
                    </select>
                </div>
            </div>

            <div class="filter-group">
                <div class="filter-input">
                    <select name="status">
                        <option value="">Trạng thái</option>
                        <option value="true" ${param.status == 'true' ? 'selected' : ''}>Active</option>
                        <option value="false" ${param.status == 'false' ? 'selected' : ''}>Blocked</option>
                    </select>
                </div>
            </div>

            <div style="display:flex; gap:12px; align-items:center;">
                <button type="submit" class="icon-btn"
                        style="background: var(--bg-page); border: 1px solid var(--border-color); width: 44px; height: 44px;">
                    <span class="material-symbols-rounded">filter_list</span>
                </button>
                <a href="${pageContext.request.contextPath}/admin/accounts"
                   style="color: var(--primary); font-size: 13px; font-weight: 600; text-decoration: none;">
                    Xóa lọc
                </a>
            </div>
        </form>

        <div class="card">
            <div class="table-container">
                <div class="table-header" style="grid-template-columns: 0.5fr 2fr 1.5fr 1fr 2fr 1fr 1.2fr 1.8fr;">
                    <div class="th">STT</div>
                    <div class="th">NGƯỜI DÙNG</div>
                    <div class="th">USERNAME / ID</div>
                    <div class="th">VAI TRÒ</div>
                    <div class="th">LIÊN HỆ</div>
                    <div class="th">TRẠNG THÁI</div>
                    <div class="th">NGÀY TẠO</div>
                    <div class="th">THAO TÁC</div>
                </div>

                <div id="userTableBody">
                    <c:choose>
                        <c:when test="${not empty users}">
                            <c:forEach items="${users}" var="user" varStatus="stt">
                                <div class="table-row" style="grid-template-columns: 0.5fr 2fr 1.5fr 1fr 2fr 1fr 1.2fr 1.8fr;">
                                    <div style="color: var(--text-muted); font-weight: 600;">
                                        <fmt:formatNumber value="${userPage.number * userPage.size + stt.index + 1}" pattern="00"/>
                                    </div>

                                    <div class="user-cell">
                                        <c:choose>
                                            <c:when test="${not empty user.avatar and user.avatar != 'default-avatar.png' and user.avatar != 'avatar-default.png'}">
                                                <img src="${pageContext.request.contextPath}/uploads/${user.avatar}" 
                                                     class="user-initials" 
                                                     style="width: 36px; height: 36px; object-fit: cover; border-radius: 8px;"
                                                     onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/images/default-avatar.png'">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="user-initials ${stt.index % 3 == 0 ? 'initials-blue' : (stt.index % 3 == 1 ? 'initials-purple' : 'initials-orange')}">
                                                    <c:set var="displayName" value="${not empty user.fullName ? user.fullName : user.username}" />
                                                    <c:choose>
                                                        <c:when test="${not empty displayName}">
                                                            ${fn:substring(displayName, 0, 1)}
                                                        </c:when>
                                                        <c:otherwise>?</c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                        <div class="user-detail">
                                            <h4 style="margin: 0; font-size: 14px;">${not empty user.fullName ? user.fullName : 'Chưa cập nhật'}</h4>
                                        </div>
                                    </div>

                                    <div style="display: flex; flex-direction: column; gap: 2px;">
                                        <span style="font-size: 13px; font-weight: 700; color: var(--text-dark);">@${user.username}</span>
                                        <span style="font-size: 11px; color: var(--text-muted); font-weight: 600;">ID: #${user.id}</span>
                                    </div>

                                    <div>
                                        <span class="role-badge role-${fn:toLowerCase(user.roleName)}">
                                            <c:choose>
                                                <c:when test="${user.roleName == 'ADMIN'}">Quản trị</c:when>
                                                <c:when test="${user.roleName == 'TUTOR'}">Gia sư</c:when>
                                                <c:when test="${user.roleName == 'PARENT'}">Phụ huynh</c:when>
                                                <c:when test="${user.roleName == 'STUDENT'}">Học sinh</c:when>
                                                <c:otherwise>${user.roleName}</c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>

                                    <div class="subject-cell" style="display: flex; flex-direction: column; gap: 2px;">
                                        <c:choose>
                                            <c:when test="${user.roleName == 'STUDENT'}">
                                                <c:choose>
                                                    <c:when test="${not empty user.parentName}">
                                                        <a href="<c:url value='/admin/accounts?keyword=${user.parentUserId}' />" 
                                                           style="color: var(--primary); font-weight: 700; font-size: 13px; text-decoration: none;">
                                                            PH: ${user.parentName}
                                                        </a>
                                                        <span style="font-size: 11px; color: var(--text-muted);">Phụ huynh học sinh</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span style="color: var(--danger); font-size: 12px; font-weight: 600;">Chưa gán PH</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                            <c:otherwise>
                                                <span style="font-weight: 700; font-size: 13px;">${not empty user.phone ? user.phone : '---'}</span>
                                                <span style="font-size: 11px; color: var(--text-muted);">${not empty user.email ? user.email : '---'}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <div style="font-size: 13px; font-weight: 600;">
                                        <span class="status-dot ${user.status ? 'dot-active' : 'dot-blocked'}"></span>
                                        ${user.status ? 'Active' : 'Blocked'}
                                    </div>

                                    <div style="font-size: 12px; color: var(--text-muted); font-weight: 500;">
                                        <c:choose>
                                            <c:when test="${not empty user.createdAt}">
                                                ${fn:substring(user.createdAt, 8, 10)}/${fn:substring(user.createdAt, 5, 7)}/${fn:substring(user.createdAt, 0, 4)}
                                            </c:when>
                                            <c:otherwise>---</c:otherwise>
                                        </c:choose>
                                    </div>

                                    <div class="actions-cell">
                                        <a class="action-btn"
                                           href="${pageContext.request.contextPath}/admin/accounts/${user.id}/detail"
                                           title="Xem chi tiết">
                                            <span class="material-symbols-rounded">visibility</span>
                                        </a>

                                        <a class="action-btn"
                                           href="${pageContext.request.contextPath}/admin/accounts/${user.id}/edit"
                                           title="Sửa">
                                            <span class="material-symbols-rounded">edit</span>
                                        </a>

                                        <c:choose>
                                            <c:when test="${user.status}">
                                                <button type="button"
                                                        class="action-btn delete"
                                                        title="Khóa tài khoản"
                                                        onclick="lockUser(${user.id})">
                                                    <span class="material-symbols-rounded">lock</span>
                                                </button>
                                            </c:when>

                                            <c:otherwise>
                                                <button type="button"
                                                        class="action-btn"
                                                        title="Mở khóa tài khoản"
                                                        onclick="unlockUser(${user.id})">
                                                    <span class="material-symbols-rounded">lock_open</span>
                                                </button>
                                            </c:otherwise>
                                        </c:choose>

                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div style="grid-column: 1 / -1; padding: 80px 20px; text-align: center; color: var(--text-muted); background: white; border-radius: 12px;">
                                <span class="material-symbols-rounded" style="font-size: 64px; margin-bottom: 1rem; display: block; opacity: 0.3; color: var(--text-muted);">person_off</span>
                                <h4 style="font-size: 20px; margin-bottom: 8px; color: var(--text-dark);">Không tìm thấy tài khoản nào</h4>
                                <p style="font-size: 14px; max-width: 400px; margin: 0 auto;">Thử thay đổi bộ lọc hoặc từ khóa tìm kiếm của bạn để tìm thấy kết quả mong muốn.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="pagination-container">
                    <div class="pagination-info">
                        Hiển thị <strong>${users.size()}</strong> / <strong>${userPage.totalElements}</strong> bản ghi
                    </div>
                    <div class="pagination-controls">
                        <%-- Nút Trước --%>
                        <c:choose>
                            <c:when test="${userPage.number > 0}">
                                <a href="<c:url value='/admin/accounts?keyword=${param.keyword}&role=${param.role}&status=${param.status}&page=${userPage.number - 1}' />" 
                                   class="btn-page">
                                    <span class="material-symbols-rounded">chevron_left</span>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <div class="btn-page disabled">
                                    <span class="material-symbols-rounded">chevron_left</span>
                                </div>
                            </c:otherwise>
                        </c:choose>
                        
                        <%-- Các trang số --%>
                        <c:set var="total" value="${userPage.totalPages}" />
                        <c:set var="current" value="${userPage.number}" />
                        
                        <c:if test="${total > 0}">
                        <c:choose>
                            <c:when test="${total <= 7}">
                                <c:forEach begin="0" end="${total - 1}" var="p">
                                    <a href="<c:url value='/admin/accounts?keyword=${param.keyword}&role=${param.role}&status=${param.status}&page=${p}' />" 
                                       class="btn-page ${p == current ? 'active' : ''}">
                                        ${p + 1}
                                    </a>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <%-- Luôn hiện trang 1 --%>
                                <a href="<c:url value='/admin/accounts?keyword=${param.keyword}&role=${param.role}&status=${param.status}&page=0' />" 
                                   class="btn-page ${0 == current ? 'active' : ''}">1</a>

                                <%-- Dấu ... đầu --%>
                                <c:if test="${current > 3}">
                                    <div class="pagination-dots">...</div>
                                </c:if>

                                <%-- Các trang giữa --%>
                                <c:set var="start" value="${current - 1}" />
                                <c:set var="end" value="${current + 1}" />
                                
                                <c:if test="${start < 1}"><c:set var="start" value="1" /></c:if>
                                <c:if test="${end >= total - 1}"><c:set var="end" value="${total - 2}" /></c:if>
                                <c:if test="${current <= 3}"><c:set var="end" value="4" /></c:if>
                                <c:if test="${current >= total - 4}"><c:set var="start" value="${total - 5}" /></c:if>

                                <c:forEach begin="${start}" end="${end}" var="p">
                                    <a href="<c:url value='/admin/accounts?keyword=${param.keyword}&role=${param.role}&status=${param.status}&page=${p}' />" 
                                       class="btn-page ${p == current ? 'active' : ''}">
                                        ${p + 1}
                                    </a>
                                </c:forEach>

                                <%-- Dấu ... cuối --%>
                                <c:if test="${current < total - 4}">
                                    <div class="pagination-dots">...</div>
                                </c:if>

                                <%-- Luôn hiện trang cuối --%>
                                <a href="<c:url value='/admin/accounts?keyword=${param.keyword}&role=${param.role}&status=${param.status}&page=${total - 1}' />" 
                                   class="btn-page ${total - 1 == current ? 'active' : ''}">${total}</a>
                            </c:otherwise>
                        </c:choose>
                        </c:if>

                        <%-- Nút Tiếp --%>
                        <c:choose>
                            <c:when test="${userPage.number < userPage.totalPages - 1}">
                                <a href="<c:url value='/admin/accounts?keyword=${param.keyword}&role=${param.role}&status=${param.status}&page=${userPage.number + 1}' />" 
                                   class="btn-page">
                                    <span class="material-symbols-rounded">chevron_right</span>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <div class="btn-page disabled">
                                    <span class="material-symbols-rounded">chevron_right</span>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

        <div style="margin-top: 1.5rem; display: flex; justify-content: space-between; align-items: center; color: var(--text-muted); font-size: 11px;">
            <span>Dữ liệu được cập nhật tự động mỗi 15 phút.</span>
            <div style="display: flex; gap: 1rem;">
                <span>VERSION 2.4.0</span>
                <a href="#" style="color: var(--text-muted); text-decoration: none;">SUPPORT CENTER</a>
            </div>
        </div>

    </div>
</main>

<div id="detailModal" class="modal-backdrop">
    <div class="modal-box">
        <h3>Chi tiết tài khoản</h3>
        <div id="detailContent"></div>
        <div class="modal-actions">
            <button class="btn-secondary" type="button" onclick="closeDetailModal()">Đóng</button>
        </div>
    </div>
</div>

<div id="editModal" class="modal-backdrop">
    <div class="modal-box">
        <h3>Sửa tài khoản</h3>
        <form id="editForm">
            <input type="hidden" id="editUserId">

            <div class="modal-grid">
                <div class="modal-field">
                    <label for="editUsername">Tên đăng nhập</label>
                    <input type="text" id="editUsername" required>
                </div>

                <div class="modal-field">
                    <label for="editRole">Vai trò</label>
                    <select id="editRole" required>
                        <option value="ADMIN">Admin</option>
                        <option value="TUTOR">Gia sư</option>
                        <option value="PARENT">Phụ huynh</option>
                        <option value="STUDENT">Học sinh</option>
                    </select>
                </div>

                <div class="modal-field">
                    <label for="editStatus">Trạng thái</label>
                    <select id="editStatus" required>
                        <option value="true">Active</option>
                        <option value="false">Blocked</option>
                    </select>
                </div>
            </div>

            <div class="modal-actions">
                <button class="btn-secondary" type="button" onclick="closeEditModal()">Hủy</button>
                <button class="btn-primary-solid" type="submit">Lưu thay đổi</button>
            </div>
        </form>
    </div>
</div>

<script>

    document.addEventListener('DOMContentLoaded', () => {
        const editForm = document.getElementById('editForm');
        if (editForm) {
            editForm.addEventListener('submit', submitEditUser);
        }
    });

    async function viewUser(userId) {
        try {
            const response = await fetch(`${contextPath}/api/admin/users/${userId}`, {
                method: 'GET',
                headers: { 'Content-Type': 'application/json' }
            });

            if (!response.ok) {
                throw new Error('Không lấy được chi tiết người dùng');
            }

            const data = await response.json();
            
            document.getElementById('detailContent').innerHTML = `
                <div class="detail-line"><strong>ID:</strong> \${data.id}</div>
                <div class="detail-line"><strong>Username:</strong> \${(data.username || '---')}</div>
                <div class="detail-line"><strong>Họ tên:</strong> \${(data.fullName || '---')}</div>
                <div class="detail-line"><strong>Vai trò:</strong> \${renderRoleName(data.roleName)}</div>
                <div class="detail-line"><strong>Email:</strong> \${(data.email || '---')}</div>
                <div class="detail-line"><strong>SĐT:</strong> \${(data.phone || '---')}</div>
                <div class="detail-line"><strong>Trạng thái:</strong> \${data.status ? 'Active' : 'Blocked'}</div>
                <div class="detail-line"><strong>Ngày tạo:</strong> \${formatDate(data.createdAt)}</div>
            `;

            document.getElementById('detailModal').style.display = 'block';
        } catch (error) {
            alert(error.message || 'Lỗi khi xem chi tiết');
        }
    }

    function renderRoleName(roleName) {
        switch (roleName) {
            case 'ADMIN': return 'Quản trị';
            case 'TUTOR': return 'Gia sư';
            case 'PARENT': return 'Phụ huynh';
            case 'STUDENT': return 'Học sinh';
            default: return roleName || '';
        }
    }

    function formatDate(dateStr) {
        if (!dateStr) return '---';
        const d = new Date(dateStr);
        if (isNaN(d.getTime())) return '---';
        const day = String(d.getDate()).padStart(2, '0');
        const month = String(d.getMonth() + 1).padStart(2, '0');
        const year = d.getFullYear();
        return `\${day}/\${month}/\${year}`;
    }

    function closeDetailModal() {
        document.getElementById('detailModal').style.display = 'none';
    }

    async function editUser(userId) {
        try {
            const response = await fetch(`${contextPath}/api/admin/users/${userId}`, {
                method: 'GET',
                headers: { 'Content-Type': 'application/json' }
            });

            if (!response.ok) {
                throw new Error('Không lấy được dữ liệu người dùng');
            }

            const data = await response.json();

            document.getElementById('editUserId').value = data.id;
            document.getElementById('editUsername').value = data.username || '';
            document.getElementById('editRole').value = data.roleName || 'STUDENT';
            document.getElementById('editStatus').value = String(data.status);

            document.getElementById('editModal').style.display = 'block';
        } catch (error) {
            alert(error.message || 'Lỗi khi tải dữ liệu sửa');
        }
    }

    async function submitEditUser(e) {
        e.preventDefault();

        const userId = document.getElementById('editUserId').value;
        const username = document.getElementById('editUsername').value.trim();
        const role = document.getElementById('editRole').value;
        const status = document.getElementById('editStatus').value === 'true';

        try {
            const response = await fetch(`${contextPath}/api/admin/users/${userId}`, {
                method: 'PUT',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ username, role, status })
            });

            const data = await response.json();

            if (!response.ok) {
                throw new Error(data.message || 'Cập nhật thất bại');
            }

            alert(data.message || 'Cập nhật tài khoản thành công');
            closeEditModal();
            window.location.reload();
        } catch (error) {
            alert(error.message || 'Lỗi khi cập nhật tài khoản');
        }
    }

    function closeEditModal() {
        document.getElementById('editModal').style.display = 'none';
    }

    const contextPath = '${pageContext.request.contextPath}';

    async function lockUser(userId) {
        if (!confirm('Bạn có chắc muốn khóa tài khoản này?')) return;

        try {
            const response = await fetch(contextPath + '/api/admin/users/' + userId + '/lock', {
                method: 'PATCH',
                headers: { 'Content-Type': 'application/json' }
            });

            const data = await response.json();

            if (!response.ok) {
                alert(data.message || 'Khóa tài khoản thất bại');
                return;
            }

            alert(data.message || 'Đã khóa tài khoản');
            window.location.reload();
        } catch (e) {
            alert('Khóa tài khoản thất bại');
        }
    }

    async function unlockUser(userId) {
        if (!confirm('Bạn có chắc muốn mở khóa tài khoản này?')) return;

        try {
            const response = await fetch(contextPath + '/api/admin/users/' + userId + '/unlock', {
                method: 'PATCH',
                headers: { 'Content-Type': 'application/json' }
            });

            const data = await response.json();

            if (!response.ok) {
                alert(data.message || 'Mở khóa tài khoản thất bại');
                return;
            }

            alert(data.message || 'Đã mở khóa tài khoản');
            window.location.reload();
        } catch (e) {
            alert('Mở khóa tài khoản thất bại');
        }
    }


</script>

</body>
</html>