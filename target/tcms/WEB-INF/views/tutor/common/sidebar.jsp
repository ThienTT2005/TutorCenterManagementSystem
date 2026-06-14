<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<aside class="sidebar">

    <div class="brand">
        <div class="brand-icon">
            <span class="material-symbols-rounded">school</span>
        </div>

        <div class="brand-text">
            <span class="brand-title">TCMS Tutor</span>
            <span class="brand-subtitle">TUTOR PORTAL</span>
        </div>
    </div>

    <ul class="nav-menu">

        <li>
            <a href="${pageContext.request.contextPath}/tutor/dashboard"
               class="nav-link ${activePage == 'dashboard' ? 'active' : ''}">
                <span class="material-symbols-rounded">dashboard</span>
                Bảng điều khiển
            </a>
        </li>

        <li>
            <a href="${pageContext.request.contextPath}/tutor/classes"
               class="nav-link ${activePage == 'classes' ? 'active' : ''}">
                <span class="material-symbols-rounded">groups</span>
                Lớp của tôi
            </a>
        </li>

        <li>
            <a href="${pageContext.request.contextPath}/payment/tutor"
               class="nav-link ${activePage == 'payment' ? 'active' : ''}">
                <span class="material-symbols-rounded">payments</span>
                Thanh toán
            </a>
        </li>

        <li>
            <a href="${pageContext.request.contextPath}/notifications"
               class="nav-link ${activePage == 'notifications' ? 'active' : ''}">
                <span class="material-symbols-rounded">notifications</span>
                Thông báo
            </a>
        </li>

    </ul>

    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/logout"
           class="nav-link"
           style="color: var(--danger);">
            <span class="material-symbols-rounded">logout</span>
            Đăng xuất
        </a>
    </div>

</aside>
