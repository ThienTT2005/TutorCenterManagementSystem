<%@ page language="java" contentType="text/html; charset=UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <title>Quản lý gia sư | TCMS Admin</title>

                <link rel="stylesheet"
                    href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0" />
                <link rel="stylesheet" href="<c:url value='/css/core-dashboard.css' />">

                <style>
                    .tutor-header-actions {
                        display: flex;
                        gap: 12px;
                        align-items: center;
                    }

                    .btn-export {
                        height: 44px;
                        padding: 0 18px;
                        border-radius: 12px;
                        border: 1px solid var(--border-color);
                        background: white;
                        color: var(--text-dark);
                        font-weight: 700;
                        text-decoration: none;
                        display: inline-flex;
                        align-items: center;
                        gap: 8px;
                    }

                    .tutor-table-header,
                    .tutor-table-row {
                        display: grid;
                        grid-template-columns: 0.5fr 2fr 2fr 2fr 1.2fr 1.2fr 1.4fr;
                        align-items: center;
                    }

                    .tutor-table-row {
                        padding: 18px 24px;
                        border-bottom: 1px solid #f1f5f9;
                    }

                    .tutor-table-row:hover {
                        background: var(--bg-page);
                    }

                    .tutor-id {
                        font-size: 11px;
                        color: var(--text-muted);
                        font-weight: 600;
                    }

                    .contact-info,
                    .school-info {
                        display: flex;
                        flex-direction: column;
                        gap: 4px;
                        font-size: 13px;
                    }

                    .contact-info strong,
                    .school-info strong {
                        color: var(--text-dark);
                    }

                    .contact-info span,
                    .school-info span {
                        color: var(--text-muted);
                        font-size: 12px;
                    }

                    .class-count {
                        width: fit-content;
                        padding: 6px 12px;
                        border-radius: 999px;
                        background: #eef2ff;
                        color: #4f46e5;
                        font-size: 12px;
                        font-weight: 900;
                    }

                    .account-status {
                        width: fit-content;
                        padding: 6px 12px;
                        border-radius: 999px;
                        font-size: 11px;
                        font-weight: 900;
                        text-transform: uppercase;
                        display: inline-flex;
                        align-items: center;
                        gap: 6px;
                    }

                    .account-status.active {
                        background: #dcfce7;
                        color: #16a34a;
                    }

                    .account-status.blocked {
                        background: #fee2e2;
                        color: #dc2626;
                    }

                    .status-dot-small {
                        width: 6px;
                        height: 6px;
                        border-radius: 50%;
                        background: currentColor;
                    }

                    .actions-cell {
                        display: flex;
                        gap: 8px;
                        justify-content: center;
                    }

                    .action-btn {
                        width: 34px;
                        height: 34px;
                        border-radius: 8px;
                        border: none;
                        background: transparent;
                        color: #94a3b8;
                        cursor: pointer;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                    }

                    .action-btn:hover {
                        background: #e0f2fe;
                        color: var(--primary);
                    }

                    .action-btn.danger:hover {
                        background: #fee2e2;
                        color: var(--danger);
                    }

                    .pagination-container {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        padding: 20px 24px;
                        background: #fff;
                        border-top: 1px solid #f1f5f9;
                    }

                    .pagination-info {
                        font-size: 13px;
                        color: #64748b;
                        font-weight: 500;
                    }

                    .pagination-info strong {
                        color: #1e293b;
                        font-weight: 800;
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
                        min-width: 36px;
                        height: 36px;
                        padding: 0 6px;
                        border-radius: 10px;
                        border: 1px solid #e2e8f0;
                        background: #fff;
                        color: #334155;
                        font-size: 14px;
                        font-weight: 700;
                        text-decoration: none;
                    }

                    .btn-page.active {
                        background: #0057bf;
                        color: white;
                        border-color: #0057bf;
                    }

                    .btn-page.disabled {
                        opacity: 0.5;
                        pointer-events: none;
                    }
                </style>
            </head>

            <body>

                <c:set var="activePage" value="tutors" scope="request" />

                <jsp:include page="../common/sidebar.jsp" />

                <main class="main-content">
                    <jsp:include page="../common/header.jsp" />

                    <div class="dashboard-body">

                        <!-- HEADER -->
                        <div class="page-header">
                            <div class="page-title">
                                <h2>Quản lý gia sư</h2>
                                <p>Theo dõi hồ sơ, chuyên môn và trạng thái giảng dạy của đội ngũ gia sư.</p>
                            </div>

                            <div class="tutor-header-actions">
                                <a href="${pageContext.request.contextPath}/admin/tutors/export" class="btn-export">
                                    <span class="material-symbols-rounded">download</span>
                                    Xuất báo cáo
                                </a>

                                <a href="${pageContext.request.contextPath}/admin/accounts/create?role=TUTOR"
                                    class="btn-primary" style="text-decoration:none;">
                                    <span class="material-symbols-rounded">person_add</span>
                                    Thêm gia sư
                                </a>
                            </div>
                        </div>

                        <!-- STATS -->
                        <section class="stats-grid">
                            <div class="stat-card">
                                <div class="stat-header">
                                    <div class="stat-icon blue">
                                        <span class="material-symbols-rounded">groups</span>
                                    </div>
                                </div>
                                <div class="stat-title">Tổng gia sư</div>
                                <div class="stat-value">${stats.totalTutors}</div>
                            </div>

                            <div class="stat-card">
                                <div class="stat-header">
                                    <div class="stat-icon cyan">
                                        <span class="material-symbols-rounded">verified_user</span>
                                    </div>
                                </div>
                                <div class="stat-title">Đang hoạt động</div>
                                <div class="stat-value">${stats.activeTutors}</div>
                            </div>

                            <div class="stat-card">
                                <div class="stat-header">
                                    <div class="stat-icon purple">
                                        <span class="material-symbols-rounded">school</span>
                                    </div>
                                </div>
                                <div class="stat-title">Đang giảng dạy</div>
                                <div class="stat-value">${stats.teachingTutors}</div>
                            </div>

                            <div class="stat-card" style="border-left: 4px solid #facc15;">
                                <div class="stat-header">
                                    <div class="stat-icon yellow">
                                        <span class="material-symbols-rounded">payments</span>
                                    </div>
                                </div>
                                <div class="stat-title">Chờ duyệt payments</div>
                                <div class="stat-value">${stats.pendingPayments}</div>
                            </div>
                        </section>

                        <!-- FILTER -->
                        <form action="${pageContext.request.contextPath}/admin/tutors" method="GET"
                            class="filters-toolbar">

                            <div class="filter-group" style="flex: 2;">
                                <div class="filter-input">
                                    <span class="material-symbols-rounded"
                                        style="color: var(--text-muted);">search</span>
                                    <input type="text" name="keyword" value="${param.keyword}"
                                        placeholder="Tìm tên, số điện thoại, email...">
                                </div>
                            </div>

                            <div class="filter-group">
                                <div class="filter-input">
                                    <select name="school">
                                        <option value="">Tất cả trường</option>
                                        <c:forEach items="${schools}" var="s">
                                            <option value="${s}" ${param.school==s ? 'selected' : '' }>${s}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>

                            <div class="filter-group">
                                <div class="filter-input">
                                    <select name="major">
                                        <option value="">Tất cả chuyên ngành</option>
                                        <c:forEach items="${majors}" var="m">
                                            <option value="${m}" ${param.major==m ? 'selected' : '' }>${m}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>

                            <div class="filter-group">
                                <div class="filter-input">
                                    <select name="status">
                                        <option value="">Trạng thái</option>
                                        <option value="true" ${param.status=='true' ? 'selected' : '' }>Đang hoạt động
                                        </option>
                                        <option value="false" ${param.status=='false' ? 'selected' : '' }>Đã khóa
                                        </option>
                                    </select>
                                </div>
                            </div>

                            <button type="submit" class="icon-btn"
                                style="background: var(--bg-page); border: 1px solid var(--border-color); width: 44px; height: 44px;">
                                <span class="material-symbols-rounded">filter_list</span>
                            </button>

                            <a href="${pageContext.request.contextPath}/admin/tutors"
                                style="color: var(--primary); font-size: 13px; font-weight: 700; text-decoration: none;">
                                Xóa lọc
                            </a>
                        </form>

                        <!-- TABLE -->
                        <div class="card">
                            <div class="table-container">

                                <div class="table-header tutor-table-header">
                                    <div class="th center">STT</div>
                                    <div class="th">GIA SƯ</div>
                                    <div class="th">LIÊN HỆ</div>
                                    <div class="th">TRƯỜNG / CHUYÊN NGÀNH</div>
                                    <div class="th center">SỐ LỚP</div>
                                    <div class="th">TRẠNG THÁI TK</div>
                                    <div class="th center">THAO TÁC</div>
                                </div>

                                <c:choose>
                                    <c:when test="${not empty tutors}">
                                        <c:forEach items="${tutors}" var="tutor" varStatus="status">

                                            <div class="tutor-table-row">

                                                <!-- STT -->
                                                <div class="center" style="color: var(--text-muted); font-weight: 700;">
                                                    ${tutorPage.number * tutorPage.size + status.index + 1}
                                                </div>

                                                <!-- GIA SƯ -->
                                                <div class="user-cell">
                                                    <c:choose>
                                                        <c:when
                                                            test="${not empty tutor.avatar and tutor.avatar != 'default-avatar.png'}">
                                                            <img src="${pageContext.request.contextPath}/uploads/${tutor.avatar}"
                                                                class="user-initials"
                                                                style="width: 38px; height: 38px; object-fit: cover; border-radius: 50%;"
                                                                onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/images/default-avatar.png'">
                                                        </c:when>

                                                        <c:otherwise>
                                                            <div class="user-initials initials-purple">
                                                                <c:choose>
                                                                    <c:when test="${not empty tutor.fullName}">
                                                                        ${fn:substring(tutor.fullName, 0, 1)}
                                                                    </c:when>
                                                                    <c:otherwise>?</c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>

                                                    <div class="user-detail">
                                                        <h4 style="margin:0;">
                                                            ${empty tutor.fullName ? 'Chưa cập nhật' : tutor.fullName}
                                                        </h4>
                                                        <span class="tutor-id">
                                                            ID: ${empty tutor.id ? '---' : tutor.id}
                                                        </span>
                                                    </div>
                                                </div>

                                                <!-- LIÊN HỆ -->
                                                <div class="contact-info">
                                                    <strong>${empty tutor.phone ? '---' : tutor.phone}</strong>
                                                    <span>${empty tutor.email ? '---' : tutor.email}</span>
                                                </div>

                                                <!-- TRƯỜNG + CHUYÊN NGÀNH -->
                                                <div class="school-info">
                                                    <strong>${empty tutor.school ? 'Chưa cập nhật trường' :
                                                        tutor.school}</strong>
                                                    <span>${empty tutor.major ? 'Chưa cập nhật chuyên ngành' :
                                                        tutor.major}</span>
                                                </div>

                                                <!-- SỐ LỚP -->
                                                <div class="center">
                                                    <span class="class-count">0 lớp</span>
                                                </div>

                                                <!-- TRẠNG THÁI TK -->
                                                <div>
                                                    <c:choose>
                                                        <c:when test="${not empty tutor.user and tutor.user.status}">
                                                            <span class="account-status active">
                                                                <span class="status-dot-small"></span>
                                                                Active
                                                            </span>
                                                        </c:when>

                                                        <c:otherwise>
                                                            <span class="account-status blocked">
                                                                <span class="status-dot-small"></span>
                                                                Blocked
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>

                                                <!-- THAO TÁC -->
                                                <div class="actions-cell">
                                                    <c:choose>
                                                        <c:when test="${not empty tutor.user}">
                                                            <button type="button" class="action-btn"
                                                                title="Xem chi tiết"
                                                                onclick="goDetail(event, '${tutor.user.id}')">
                                                                <span class="material-symbols-rounded">visibility</span>
                                                            </button>

                                                            <button type="button" class="action-btn" title="Sửa"
                                                                onclick="goEdit(event, '${tutor.user.id}')">
                                                                <span class="material-symbols-rounded">edit_note</span>
                                                            </button>

                                                            <c:choose>
                                                                <c:when test="${tutor.user.status}">
                                                                    <button type="button" class="action-btn danger"
                                                                        title="Khóa tài khoản"
                                                                        onclick="lockUser(event, '${tutor.user.id}')">
                                                                        <span
                                                                            class="material-symbols-rounded">lock</span>
                                                                    </button>
                                                                </c:when>

                                                                <c:otherwise>
                                                                    <button type="button" class="action-btn"
                                                                        title="Mở khóa tài khoản"
                                                                        onclick="unlockUser(event, '${tutor.user.id}')">
                                                                        <span
                                                                            class="material-symbols-rounded">lock_open</span>
                                                                    </button>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:when>

                                                        <c:otherwise>
                                                            <span style="font-size:12px;color:var(--text-muted);">
                                                                Chưa có TK
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>

                                            </div>
                                        </c:forEach>
                                    </c:when>

                                    <c:otherwise>
                                        <div style="padding: 60px 20px; text-align: center; color: var(--text-muted);">
                                            <span class="material-symbols-rounded"
                                                style="font-size: 56px; opacity: 0.4;">person_off</span>
                                            <h4>Chưa có dữ liệu gia sư</h4>
                                            <p>Thử thay đổi bộ lọc hoặc thêm gia sư mới.</p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>

                                <!-- PAGINATION -->
                                <div class="pagination-container">
                                    <div class="pagination-info">
                                        Hiển thị <strong>${empty tutors ? 0 : tutors.size()}</strong> /
                                        <strong>${tutorPage.totalElements}</strong> gia sư
                                    </div>

                                    <div class="pagination-controls">

                                        <c:choose>
                                            <c:when test="${tutorPage.number > 0}">
                                                <a class="btn-page"
                                                    href="<c:url value='/admin/tutors?keyword=${param.keyword}&school=${param.school}&major=${param.major}&status=${param.status}&page=${tutorPage.number - 1}' />">
                                                    <span class="material-symbols-rounded">chevron_left</span>
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="btn-page disabled">
                                                    <span class="material-symbols-rounded">chevron_left</span>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>

                                        <c:set var="total" value="${tutorPage.totalPages}" />
                                        <c:set var="current" value="${tutorPage.number}" />

                                        <c:if test="${total > 0}">
                                            <c:forEach begin="0" end="${total - 1}" var="p">
                                                <a class="btn-page ${p == current ? 'active' : ''}"
                                                    href="<c:url value='/admin/tutors?keyword=${param.keyword}&school=${param.school}&major=${param.major}&status=${param.status}&page=${p}' />">
                                                    ${p + 1}
                                                </a>
                                            </c:forEach>
                                        </c:if>

                                        <c:choose>
                                            <c:when test="${tutorPage.number < tutorPage.totalPages - 1}">
                                                <a class="btn-page"
                                                    href="<c:url value='/admin/tutors?keyword=${param.keyword}&school=${param.school}&major=${param.major}&status=${param.status}&page=${tutorPage.number + 1}' />">
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

                    </div>
                </main>

                <script>
                    const contextPath = '${pageContext.request.contextPath}';

                    function goDetail(event, userId) {
                        event.stopPropagation();
                        window.location.href = contextPath + '/admin/accounts/' + userId + '/detail';
                    }

                    function goEdit(event, userId) {
                        event.stopPropagation();
                        window.location.href = contextPath + '/admin/accounts/' + userId + '/edit';
                    }

                    async function lockUser(event, userId) {
                        event.stopPropagation();

                        if (!confirm('Bạn có chắc muốn khóa tài khoản gia sư này?')) return;

                        try {
                            const response = await fetch(contextPath + '/api/admin/users/' + userId + '/lock', {
                                method: 'PATCH'
                            });

                            const data = await response.json();

                            if (!response.ok) {
                                alert(data.message || 'Khóa tài khoản thất bại');
                                return;
                            }

                            alert(data.message || 'Đã khóa tài khoản');
                            location.reload();
                        } catch (e) {
                            alert('Khóa tài khoản thất bại');
                        }
                    }

                    async function unlockUser(event, userId) {
                        event.stopPropagation();

                        if (!confirm('Bạn có chắc muốn mở khóa tài khoản gia sư này?')) return;

                        try {
                            const response = await fetch(contextPath + '/api/admin/users/' + userId + '/unlock', {
                                method: 'PATCH'
                            });

                            const data = await response.json();

                            if (!response.ok) {
                                alert(data.message || 'Mở khóa tài khoản thất bại');
                                return;
                            }

                            alert(data.message || 'Đã mở khóa tài khoản');
                            location.reload();
                        } catch (e) {
                            alert('Mở khóa tài khoản thất bại');
                        }
                    }
                </script>

            </body>

            </html>