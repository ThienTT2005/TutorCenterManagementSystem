<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<aside class="sidebar">
    <div class="brand">
        <div class="brand-icon-box">
            <i class="fa-solid fa-graduation-cap"></i>
        </div>
        <div class="brand-text">
            <span class="brand-title">TCMS</span>
            <span class="brand-subtitle">TUTOR</span>
        </div>
    </div>

    <ul class="nav-menu">
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/tutor/dashboard" class="nav-link ${activePage == 'dashboard' ? 'active' : ''}">
                <i class="fa-solid fa-table-columns"></i>
                Bảng điều khiển
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/tutor/classes" class="nav-link ${activePage == 'classes' ? 'active' : ''}">
                <i class="fa-solid fa-users-rectangle"></i>
                Lớp của tôi
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/tutor/schedule" class="nav-link ${activePage == 'schedule' ? 'active' : ''}">
                <i class="fa-solid fa-calendar-days"></i>
                Lịch dạy
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/tutor/curriculum" class="nav-link ${activePage == 'curriculum' ? 'active' : ''}">
                <i class="fa-solid fa-file-signature"></i>
                Kế hoạch giảng dạy
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/tutor/feedback" class="nav-link ${activePage == 'feedback' ? 'active' : ''}">
                <i class="fa-solid fa-comments"></i>
                Feedback
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/tutor/homework" class="nav-link ${activePage == 'homework' ? 'active' : ''}">
                <i class="fa-solid fa-book-open-reader"></i>
                Bài tập
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/tutor/progress" class="nav-link ${activePage == 'progress' ? 'active' : ''}">
                <i class="fa-solid fa-file-lines"></i>
                Tiến độ
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/payment/tutor" class="nav-link ${activePage == 'payment' ? 'active' : ''}">
                <i class="fa-solid fa-wallet"></i>
                Thanh toán
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/notifications" class="nav-link ${activePage == 'notifications' ? 'active' : ''}">
                <i class="fa-solid fa-bell"></i>
                Thông báo
            </a>
        </li>
    </ul>

    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/logout" class="logout-link">
            <i class="fa-solid fa-right-from-bracket"></i>
            Logout
        </a>
    </div>
</aside>
