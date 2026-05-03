<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Parent Management | TCMS Admin</title>

    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0"/>
    <link rel="stylesheet" href="<c:url value='/css/core-dashboard.css' />">

    <style>
        .table-row {
        display: grid;
        grid-template-columns: 0.5fr 2fr 2fr 0.8fr 1.5fr 1fr 1.2fr;
        align-items: center;
        }

        .actions-cell {
            display: flex;
            justify-content: center;
            gap: 8px;
        }

        .action-btn {
            width: 34px;
            height: 34px;
            border: none;
            border-radius: 8px;
            background: var(--bg-page);
            color: var(--text-muted);
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
      

        .table-row[data-url]:hover {
            background-color: var(--bg-page);
            cursor: pointer;
        }

        .table-row:not([data-url]):hover {
            background-color: var(--bg-page);
            cursor: default;
        }

        .table-row.double-clicking {
            background-color: #eff6ff;
        }

        .hint-text {
            font-size: 12px;
            color: var(--text-muted);
            margin-top: 8px;
        }

        .payment-done {
            background: var(--success-light);
            color: var(--success);
        }

        .payment-pending {
            background: #fef3c7;
            color: #d97706;
        }
    </style>
</head>

<body>

<c:set var="activePage" value="parents" scope="request"/>

<jsp:include page="../common/sidebar.jsp"/>

<main class="main-content">
    <jsp:include page="../common/header.jsp"/>

    <div class="dashboard-body">

        <div class="page-header">
            <div class="page-title">
                <h2>Quản lý phụ huynh</h2>
                <p>Theo dõi tài khoản phụ huynh, con đang học và trạng thái thanh toán hệ thống.</p>
                <div class="hint-text">Double click vào một dòng để xem chi tiết tài khoản.</div>
            </div>

            <a href="${pageContext.request.contextPath}/admin/accounts/create?role=PARENT"
               class="btn-primary"
               style="text-decoration: none;">
                <span class="material-symbols-rounded">person_add</span>
                Thêm phụ huynh
            </a>
        </div>

        <section class="stats-grid">
            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-icon blue">
                        <span class="material-symbols-rounded">groups</span>
                    </div>
                </div>
                <div class="stat-title">TỔNG PHỤ HUYNH</div>
                <div class="stat-value">${stats.totalParents}</div>
                <div style="display: flex; gap: 8px; margin-top: 12px; font-size: 13px;">
                    <span style="color: var(--success); font-weight: 700; display: flex; align-items: center;">
                        <span class="material-symbols-rounded" style="font-size: 16px;">trending_up</span>
                        +12%
                    </span>
                    <span style="color: var(--text-muted);">vs tháng trước</span>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-icon cyan">
                        <span class="material-symbols-rounded">how_to_reg</span>
                    </div>
                </div>
                <div class="stat-title">ĐANG HOẠT ĐỘNG</div>
                <div class="stat-value">${stats.activeParents}</div>
                <div style="display: flex; gap: 8px; margin-top: 12px; font-size: 13px;">
                    <span style="color: var(--success); font-weight: 700; display: flex; align-items: center;">
                        <span class="material-symbols-rounded" style="font-size: 16px;">check_circle</span>
                        <c:choose>
                            <c:when test="${stats.totalParents > 0}">
                                ${fn:substringBefore((stats.activeParents / stats.totalParents) * 100, '.')}%
                            </c:when>
                            <c:otherwise>0%</c:otherwise>
                        </c:choose>
                    </span>
                    <span style="color: var(--text-muted);">tỉ lệ duy trì</span>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-icon yellow">
                        <span class="material-symbols-rounded">assignment_late</span>
                    </div>
                </div>
                <div class="stat-title">CHỜ XỬ LÝ THANH TOÁN</div>
                <div class="stat-value">${stats.pendingPayments}</div>
                <div style="display: flex; gap: 8px; margin-top: 12px; font-size: 13px;">
                    <span style="color: var(--warning); font-weight: 700; display: flex; align-items: center;">
                        <span class="material-symbols-rounded" style="font-size: 16px;">schedule</span>
                        Cần xử lý gấp
                    </span>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-icon purple">
                        <span class="material-symbols-rounded">person_add</span>
                    </div>
                </div>
                <div class="stat-title">MỚI THÊM (THÁNG)</div>
                <div class="stat-value">${stats.newParentsThisMonth}</div>
                <div style="display: flex; gap: 8px; margin-top: 12px; font-size: 13px;">
                    <span style="color: var(--primary); font-weight: 700; display: flex; align-items: center;">
                        <span class="material-symbols-rounded" style="font-size: 16px;">star</span>
                        Top 5% tăng trưởng
                    </span>
                </div>
            </div>
        </section>

        <form action="${pageContext.request.contextPath}/admin/users" method="GET" class="filters-toolbar">
            <div class="filter-group">
                <label>Tìm kiếm</label>
                <div class="filter-input">
                    <span class="material-symbols-rounded" style="color: var(--text-muted);">search</span>
                    <input type="text"
                           name="keyword"
                           value="${param.keyword}"
                           placeholder="Tên, số điện thoại, email...">
                </div>
            </div>

            <div class="filter-group">
                <label>Trạng thái</label>
                <div class="filter-input">
                    <select name="status">
                        <option value="">Tất cả trạng thái</option>
                        <option value="true" ${param.status == 'true' ? 'selected' : ''}>Đang hoạt động</option>
                        <option value="false" ${param.status == 'false' ? 'selected' : ''}>Đã khóa</option>
                    </select>
                </div>
            </div>

            <div class="filter-group" style="flex: 0.5;">
                <label>Số con</label>
                <div class="filter-input">
                    <select name="minChildren">
                        <option value="">Tất cả</option>
                        <option value="1" ${param.minChildren == '1' ? 'selected' : ''}>1+</option>
                        <option value="2" ${param.minChildren == '2' ? 'selected' : ''}>2+</option>
                        <option value="3" ${param.minChildren == '3' ? 'selected' : ''}>3+</option>
                        <option value="4" ${param.minChildren == '4' ? 'selected' : ''}>4+</option>
                    </select>
                </div>
            </div>

            <div class="filter-group">
                <label>Thanh toán</label>
                <div class="filter-input">
                    <select name="paymentStatus">
                        <option value="">Tất cả giao dịch</option>
                        <option value="COMPLETED" ${param.paymentStatus == 'COMPLETED' ? 'selected' : ''}>
                            Đã hoàn tất
                        </option>
                        <option value="PENDING" ${param.paymentStatus == 'PENDING' ? 'selected' : ''}>
                            Chờ xử lý
                        </option>
                    </select>
                </div>
            </div>

            <div style="display:flex; gap:12px; align-items:center;">
                <button type="submit"
                        class="icon-btn"
                        style="background: var(--bg-page); border: 1px solid var(--border-color); width: 44px; height: 44px;">
                    <span class="material-symbols-rounded">filter_list</span>
                </button>

                <a href="${pageContext.request.contextPath}/admin/users"
                   style="color: var(--primary); font-size: 13px; font-weight: 600; text-decoration: none;">
                    Xóa lọc
                </a>
            </div>
        </form>

        <div class="card">
            <div class="table-container">
                <div class="table-header"
                     style="grid-template-columns: 0.5fr 2fr 2fr 0.8fr 1.5fr 1fr 1.2fr;">
                    <div class="th">STT</div>
                    <div class="th">HỌ TÊN</div>
                    <div class="th">LIÊN HỆ</div>
                    <div class="th center">SỐ CON</div>
                    <div class="th">THANH TOÁN</div>
                    <div class="th">TRẠNG THÁI</div>
                    <div class="th">THAO TÁC</div>
                </div>

                <c:choose>
                    <c:when test="${not empty parents}">
                        <c:forEach items="${parents}" var="parent" varStatus="status">
                            <c:set var="accountId" value="${parent.id}"/>

                            <div class="table-row"
                                 <c:if test="${not empty parent.id}">
                                     data-url="${pageContext.request.contextPath}/admin/accounts/${parent.id}/detail"
                                     title="Double click để xem chi tiết tài khoản"
                                 </c:if>
                                 <c:if test="${empty parent.user or empty parent.user.id}">
                                     title="Tài khoản chưa được liên kết"
                                 </c:if>>

                                <div style="color: var(--text-muted); font-weight: 600;">
                                        ${status.index + 1}
                                </div>

                                <div class="user-cell">
                                    <c:choose>
                                                        <c:when test="${not empty parent.avatar and parent.avatar != 'default-avatar.png'}">
                                                            <img src="${pageContext.request.contextPath}/uploads/${parent.avatar}"
                                                 onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/images/default-avatar.png'">
                                        </c:when>

                                        <c:otherwise>
                                            <div class="user-initials initials-blue">
                                                <c:choose>
                                                    <c:when test="${not empty parent.fullName}">
                                                        ${fn:substring(parent.fullName, 0, 1)}
                                                    </c:when>
                                                    <c:otherwise>?</c:otherwise>
                                                </c:choose>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>

                                    <div class="user-detail">
                                        <h4>${empty parent.fullName ? 'Chưa cập nhật' : parent.fullName}</h4>
                                                        <span style="font-size: 11px; color: var(--text-muted);">
                                                            <c:choose>
                                                                <c:when test="${not empty parent.id}">
                                                                    Double click để xem hồ sơ
                                                                </c:when>
                                                                <c:otherwise>
                                                                    Tài khoản chưa liên kết
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </span>
                                                    </div>
                                </div>

                                <div class="subject-cell" style="display: flex; flex-direction: column; gap: 4px;">
                                    <span style="font-weight: 700;">${empty parent.phone ? '---' : parent.phone}</span>
                                    <span style="font-size: 12px; color: var(--text-muted);">
                                            ${empty parent.email ? '---' : parent.email}
                                    </span>
                                </div>

                                <div class="center">
                                    <span style="background: var(--bg-page); padding: 4px 12px; border-radius: 20px; font-weight: 700; font-size: 12px;">
                                                        0

                                <!-- status payment  -->

                                <div>
                                    <c:choose>
                                        <c:when test="${param.paymentStatus == 'PENDING'}">
                                            <span class="status-badge payment-pending">Chờ xử lý</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge payment-done">Đã hoàn tất</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <!-- status account  -->
                                <div>
                                    <c:choose>
                                        <c:when test="${parent.status}">
                                            <span class="status-badge status-approved"
                                                  style="background: var(--success-light); color: var(--success); width: 80px; text-align: center;">
                                                Active
                                            </span>
                                        </c:when>

                                        <c:otherwise>
                                            <span class="status-badge status-cancelled"
                                                  style="background: #fee2e2; color: var(--danger); width: 80px; text-align: center;">
                                                Blocked
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <!-- thao tác  -->

                                <div class="actions-cell">
                                    <button type="button"
                                            class="action-btn"
                                            title="Xem chi tiết"
                                            onclick="goDetail(event, '${parent.id}')">
                                        <span class="material-symbols-rounded">visibility</span>
                                    </button>

                                    <button type="button"
                                            class="action-btn"
                                            title="Sửa"
                                            onclick="goEdit(event, '${parent.id}')">
                                        <span class="material-symbols-rounded">edit</span>
                                    </button>

                                    <c:choose>
                                        <c:when test="${parent.status}">
                                            <button type="button"
                                                    class="action-btn danger"
                                                    title="Khóa tài khoản"
                                                    onclick="lockUser(event, '${parent.id}')">
                                                <span class="material-symbols-rounded">lock</span>
                                            </button>
                                        </c:when>

                                        <c:otherwise>
                                            <button type="button"
                                                    class="action-btn"
                                                    title="Mở khóa tài khoản"
                                                    onclick="unlockUser(event, '${parent.id}')">
                                                <span class="material-symbols-rounded">lock_open</span>
                                            </button>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>

                    <c:otherwise>
                        <div style="padding: 2rem; text-align: center; color: var(--text-muted);">
                            Chưa có dữ liệu phụ huynh.
                        </div>
                    </c:otherwise>
                </c:choose>

                <div class="pagination-container" style="margin: 0 1.5rem 1.5rem;">
                    <div class="pagination-info">
                        Hiển thị <strong>${parents.size()}</strong> /
                        <strong>${parentPage.totalElements}</strong> phụ huynh
                    </div>

                    <div class="pagination-controls">
                        <c:choose>
                            <c:when test="${parentPage.number > 0}">
                                <a href="<c:url value='/admin/users?keyword=${param.keyword}&status=${param.status}&minChildren=${param.minChildren}&paymentStatus=${param.paymentStatus}&page=${parentPage.number - 1}' />"
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

                        <c:set var="total" value="${parentPage.totalPages}"/>
                        <c:set var="current" value="${parentPage.number}"/>

                        <c:if test="${total > 0}">
                            <c:choose>
                                <c:when test="${total <= 7}">
                                    <c:forEach begin="0" end="${total - 1}" var="p">
                                        <a href="<c:url value='/admin/users?keyword=${param.keyword}&status=${param.status}&minChildren=${param.minChildren}&paymentStatus=${param.paymentStatus}&page=${p}' />"
                                           class="btn-page ${p == current ? 'active' : ''}">
                                                ${p + 1}
                                        </a>
                                    </c:forEach>
                                </c:when>

                                <c:otherwise>
                                    <a href="<c:url value='/admin/users?keyword=${param.keyword}&status=${param.status}&minChildren=${param.minChildren}&paymentStatus=${param.paymentStatus}&page=0' />"
                                       class="btn-page ${0 == current ? 'active' : ''}">
                                        1
                                    </a>

                                    <c:if test="${current > 3}">
                                        <div class="pagination-dots">...</div>
                                    </c:if>

                                    <c:set var="start" value="${current - 1}"/>
                                    <c:set var="end" value="${current + 1}"/>

                                    <c:if test="${start < 1}">
                                        <c:set var="start" value="1"/>
                                    </c:if>

                                    <c:if test="${end >= total - 1}">
                                        <c:set var="end" value="${total - 2}"/>
                                    </c:if>

                                    <c:if test="${current <= 3}">
                                        <c:set var="end" value="4"/>
                                    </c:if>

                                    <c:if test="${current >= total - 4}">
                                        <c:set var="start" value="${total - 5}"/>
                                    </c:if>

                                    <c:forEach begin="${start}" end="${end}" var="p">
                                        <a href="<c:url value='/admin/users?keyword=${param.keyword}&status=${param.status}&minChildren=${param.minChildren}&paymentStatus=${param.paymentStatus}&page=${p}' />"
                                           class="btn-page ${p == current ? 'active' : ''}">
                                                ${p + 1}
                                        </a>
                                    </c:forEach>

                                    <c:if test="${current < total - 4}">
                                        <div class="pagination-dots">...</div>
                                    </c:if>

                                    <a href="<c:url value='/admin/users?keyword=${param.keyword}&status=${param.status}&minChildren=${param.minChildren}&paymentStatus=${param.paymentStatus}&page=${total - 1}' />"
                                       class="btn-page ${total - 1 == current ? 'active' : ''}">
                                            ${total}
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </c:if>

                        <c:choose>
                            <c:when test="${parentPage.number < parentPage.totalPages - 1}">
                                                <a href="<c:url value='/admin/users?keyword=${param.keyword}&status=${param.status}&minChildren=${param.minChildren}&paymentStatus=${param.paymentStatus}&page=${parentPage.number + 1}' />"
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

        if (!confirm('Bạn có chắc muốn khóa tài khoản này?')) return;

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

        if (!confirm('Bạn có chắc muốn mở khóa tài khoản này?')) return;

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
