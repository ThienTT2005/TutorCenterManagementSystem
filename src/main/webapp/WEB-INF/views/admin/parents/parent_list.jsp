<%@ page language="java" contentType="text/html; charset=UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Parent Management | TCMS Admin</title>
                <link rel="stylesheet"
                    href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0" />
                <link rel="stylesheet" href="<c:url value='/css/core-dashboard.css' />">
                <style>
                    .table-row:hover {
                        background-color: var(--bg-page);
                        cursor: pointer;
                    }
                </style>
            </head>

            <body>

                <c:set var="activePage" value="parents" scope="request" />

                <!-- Sidebar (Shared Component) -->
                <jsp:include page="../common/sidebar.jsp" />

                <!-- Main Content -->
                <main class="main-content">
                    <!-- Top Header -->
                    <jsp:include page="../common/header.jsp" />

                    <!-- Dashboard Body -->
                    <div class="dashboard-body">

                        <!-- Page Header -->
                        <div class="page-header">
                            <div class="page-title">
                                <h2>Quản lý phụ huynh</h2>
                                <p>Theo dõi tài khoản phụ huynh, con đang học và trạng thái thanh toán hệ thống.</p>
                            </div>
                            <button onclick="alert('Chức năng bung Form Thêm Phụ Huynh (Popup) đang được xử lý!')"
                                class="btn-primary">
                                <span class="material-symbols-rounded">person_add</span>
                                Thêm phụ huynh
                            </button>
                        </div>


                        <!-- Stats Grid -->
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
                                    <span
                                        style="color: var(--success); font-weight: 700; display: flex; align-items: center;"><span
                                            class="material-symbols-rounded" style="font-size: 16px;">trending_up</span>
                                        +12%</span>
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
                                    <span
                                        style="color: var(--success); font-weight: 700; display: flex; align-items: center;"><span
                                            class="material-symbols-rounded"
                                            style="font-size: 16px;">check_circle</span>
                                        <c:if test="${stats.totalParents > 0}">
                                            ${fn:substringBefore((stats.activeParents / stats.totalParents) * 100, '.')}
                                            %
                                        </c:if>
                                        <c:if test="${stats.totalParents == 0}">0%</c:if>
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
                                    <span
                                        style="color: var(--warning); font-weight: 700; display: flex; align-items: center;"><span
                                            class="material-symbols-rounded" style="font-size: 16px;">schedule</span>
                                        Cần xử lý gấp</span>
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
                                    <span
                                        style="color: var(--primary); font-weight: 700; display: flex; align-items: center;"><span
                                            class="material-symbols-rounded" style="font-size: 16px;">star</span> Top 5%
                                        tăng trưởng</span>
                                </div>
                            </div>
                        </section>

                        <!-- Filters -->
                        <form action="${pageContext.request.contextPath}/admin/parents" method="GET"
                            class="filters-toolbar">
                            <div class="filter-group">
                                <label>Tìm kiếm</label>
                                <div class="filter-input">
                                    <span class="material-symbols-rounded"
                                        style="color: var(--text-muted);">search</span>
                                    <input type="text" name="keyword" value="${param.keyword}"
                                        placeholder="Tên, số điện thoại, email...">
                                </div>
                            </div>

                            <div class="filter-group">
                                <label>Trạng thái</label>
                                <div class="filter-input">
                                    <select name="status">
                                        <option value="">Tất cả trạng thái</option>
                                        <option value="true" ${param.status=='true' ? 'selected' : '' }>Đang hoạt động
                                        </option>
                                        <option value="false" ${param.status=='false' ? 'selected' : '' }>Đã khóa
                                        </option>
                                    </select>
                                </div>
                            </div>

                            <div class="filter-group" style="flex: 0.5;">
                                <label>Số con</label>
                                <div class="filter-input">
                                    <select name="minChildren">
                                        <option value="">Tất cả</option>
                                        <option value="1" ${param.minChildren=='1' ? 'selected' : '' }>1</option>
                                        <option value="2" ${param.minChildren=='2' ? 'selected' : '' }>2+</option>
                                        <option value="3" ${param.minChildren=='3' ? 'selected' : '' }>3+</option>
                                        <option value="4" ${param.minChildren=='4' ? 'selected' : '' }>4+</option>
                                    </select>
                                </div>
                            </div>

                            <div class="filter-group">
                                <label>Thanh toán</label>
                                <div class="filter-input">
                                    <select disabled>
                                        <option>Tất cả giao dịch</option>
                                        <option>Đã hoàn tất</option>
                                        <option>Chờ xử lý</option>
                                    </select>
                                </div>
                            </div>

                            <div style="display:flex; gap:12px; align-items:center;">
                                <button type="submit" class="icon-btn"
                                    style="background: var(--bg-page); border: 1px solid var(--border-color); width: 44px; height: 44px;">
                                    <span class="material-symbols-rounded">filter_list</span>
                                </button>
                                <a href="${pageContext.request.contextPath}/admin/parents"
                                    style="color: var(--primary); font-size: 13px; font-weight: 600; text-decoration: none;">
                                    Xóa lọc
                                </a>
                            </div>
                        </form>

                        <!-- Data Table -->
                        <div class="card">
                            <div class="table-container">
                                <div class="table-header"
                                    style="grid-template-columns: 0.5fr 2fr 2fr 0.8fr 0.8fr 1.5fr 1fr;">
                                    <div class="th">STT</div>
                                    <div class="th">HỌ TÊN</div>
                                    <div class="th">LIÊN HỆ</div>
                                    <div class="th center">SỐ CON</div>
                                    <div class="th center">SỐ LỚP</div>
                                    <div class="th">THANH TOÁN</div>
                                    <div class="th">TRẠNG THÁI</div>
                                </div>

                                <c:forEach items="${parents}" var="parent" varStatus="status">
                                    <div class="table-row"
                                        style="grid-template-columns: 0.5fr 2fr 2fr 0.8fr 0.8fr 1.5fr 1fr;"
                                        onclick="window.location.href='${pageContext.request.contextPath}/admin/parents/${parent.id}'"
                                        ondblclick="window.location.href='${pageContext.request.contextPath}/admin/accounts/${parent.user.id}/detail'"
                                        title="Double click để xem chi tiết tài khoản">
                                        <div style="color: var(--text-muted); font-weight: 600;">${status.index + 1}
                                        </div>
                                        <div class="user-cell">
                                            <c:choose>
                                                <c:when
                                                    test="${not empty parent.user.avatar and parent.user.avatar != 'default-avatar.png' and parent.user.avatar != 'avatar-default.png'}">
                                                    <img src="${pageContext.request.contextPath}/uploads/${parent.user.avatar}"
                                                        class="user-initials"
                                                        style="width: 36px; height: 36px; object-fit: cover; border-radius: 8px;"
                                                        onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/images/default-avatar.png'">
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="user-initials initials-blue">
                                                        ${fn:substring(parent.fullName, 0, 1)}
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                            <div class="user-detail">
                                                <h4>${parent.fullName}</h4>
                                            </div>
                                        </div>
                                        <div class="subject-cell"
                                            style="display: flex; flex-direction: column; gap: 4px;">
                                            <span style="font-weight: 700;">${parent.phone}</span>
                                            <span
                                                style="font-size: 12px; color: var(--text-muted);">${parent.email}</span>
                                        </div>
                                        <div class="center">
                                            <span
                                                style="background: var(--bg-page); padding: 4px 12px; border-radius: 20px; font-weight: 700; font-size: 12px;">
                                                ${fn:length(parent.students)}
                                            </span>
                                        </div>
                                        <div class="center">
                                            <span
                                                style="background: var(--bg-page); padding: 4px 12px; border-radius: 20px; font-weight: 700; font-size: 12px;">
                                                <%-- This would ideally be calculated from class enrollments --%>
                                                    00
                                            </span>
                                        </div>
                                        <div>
                                            <%-- Dummy logic for demo, should be tied to actual payment records --%>
                                                <span class="status-badge status-approved"
                                                    style="background: var(--success-light); color: var(--success);">Đã
                                                    hoàn tất</span>
                                        </div>
                                        <div>
                                            <c:choose>
                                                <c:when test="${parent.user.status}">
                                                    <span class="status-badge status-approved"
                                                        style="background: var(--success-light); color: var(--success); width: 80px; text-align: center;">Active</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-badge status-cancelled"
                                                        style="background: #fee2e2; color: var(--danger); width: 80px; text-align: center;">Blocked</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </c:forEach>

                                <c:if test="${empty parents}">
                                    <div style="padding: 2rem; text-align: center; color: var(--text-muted);">
                                        Chưa có dữ liệu phụ huynh.
                                    </div>
                                </c:if>

                                <!-- Pagination -->
                                <div class="pagination-container" style="margin: 0 1.5rem 1.5rem;">
                                    <div class="pagination-info">
                                        Hiển thị <strong>${parents.size()}</strong> /
                                        <strong>${parentPage.totalElements}</strong> phụ huynh
                                    </div>
                                    <div class="pagination-controls">
                                        <%-- Nút Trước --%>
                                            <c:choose>
                                                <c:when test="${parentPage.number > 0}">
                                                    <a href="<c:url value='/admin/parents?keyword=${param.keyword}&status=${param.status}&minChildren=${param.minChildren}&page=${parentPage.number - 1}' />"
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
                                                <c:set var="total" value="${parentPage.totalPages}" />
                                                <c:set var="current" value="${parentPage.number}" />

                                                <c:if test="${total > 0}">
                                                <c:choose>
                                                    <c:when test="${total <= 7}">
                                                        <c:forEach begin="0" end="${total - 1}" var="p">
                                                            <a href="<c:url value='/admin/parents?keyword=${param.keyword}&status=${param.status}&minChildren=${param.minChildren}&page=${p}' />"
                                                                class="btn-page ${p == current ? 'active' : ''}">
                                                                ${p + 1}
                                                            </a>
                                                        </c:forEach>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <%-- Luôn hiện trang 1 --%>
                                                            <a href="<c:url value='/admin/parents?keyword=${param.keyword}&status=${param.status}&minChildren=${param.minChildren}&page=0' />"
                                                                class="btn-page ${0 == current ? 'active' : ''}">1</a>

                                                            <%-- Dấu ... đầu --%>
                                                                <c:if test="${current > 3}">
                                                                    <div class="pagination-dots">...</div>
                                                                </c:if>

                                                                <%-- Các trang giữa --%>
                                                                    <c:set var="start" value="${current - 1}" />
                                                                    <c:set var="end" value="${current + 1}" />

                                                                    <c:if test="${start < 1}">
                                                                        <c:set var="start" value="1" />
                                                                    </c:if>
                                                                    <c:if test="${end >= total - 1}">
                                                                        <c:set var="end" value="${total - 2}" />
                                                                    </c:if>
                                                                    <c:if test="${current <= 3}">
                                                                        <c:set var="end" value="4" />
                                                                    </c:if>
                                                                    <c:if test="${current >= total - 4}">
                                                                        <c:set var="start" value="${total - 5}" />
                                                                    </c:if>

                                                                    <c:forEach begin="${start}" end="${end}" var="p">
                                                                        <a href="<c:url value='/admin/parents?keyword=${param.keyword}&status=${param.status}&minChildren=${param.minChildren}&page=${p}' />"
                                                                            class="btn-page ${p == current ? 'active' : ''}">
                                                                            ${p + 1}
                                                                        </a>
                                                                    </c:forEach>

                                                                    <%-- Dấu ... cuối --%>
                                                                        <c:if test="${current < total - 4}">
                                                                            <div class="pagination-dots">...</div>
                                                                        </c:if>

                                                                        <%-- Luôn hiện trang cuối --%>
                                                                            <a href="<c:url value='/admin/parents?keyword=${param.keyword}&status=${param.status}&minChildren=${param.minChildren}&page=${total - 1}' />"
                                                                                class="btn-page ${total - 1 == current ? 'active' : ''}">${total}</a>
                                                    </c:otherwise>
                                                </c:choose>
                                                </c:if>

                                                <%-- Nút Tiếp --%>
                                                    <c:choose>
                                                        <c:when test="${parentPage.number < parentPage.totalPages - 1}">
                                                            <a href="<c:url value='/admin/parents?keyword=${param.keyword}&status=${param.status}&minChildren=${param.minChildren}&page=${parentPage.number + 1}' />"
                                                                class="btn-page">
                                                                <span
                                                                    class="material-symbols-rounded">chevron_right</span>
                                                            </a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="btn-page disabled">
                                                                <span
                                                                    class="material-symbols-rounded">chevron_right</span>
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                    </div>
                                </div>

                            </div>
                        </div>

                    </div>
                </main>

            </body>

            </html>