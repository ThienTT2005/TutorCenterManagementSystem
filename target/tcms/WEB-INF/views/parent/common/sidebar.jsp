<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<aside class="sidebar">
    <div class="brand">
        <div class="brand-icon">
            <span class="material-symbols-rounded">family_restroom</span>
        </div>
        <div class="brand-text">
            <span class="brand-title">TCMS Parent</span>
            <span class="brand-subtitle">PARENT PORTAL</span>
        </div>
    </div>

    <ul class="nav-menu">
        <li>
            <a href="${pageContext.request.contextPath}/parent/dashboard"
               class="nav-link ${activePage == 'dashboard' ? 'active' : ''}">
                <span class="material-symbols-rounded">dashboard</span>
                Bảng điều khiển
            </a>
        </li>

        <li>
            <a href="${pageContext.request.contextPath}/parent/classes"
               class="nav-link ${activePage == 'classes' ? 'active' : ''}">
                <span class="material-symbols-rounded">menu_book</span>
                Lớp của con
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/parent/absence/list"
               class="nav-link ${activePage == 'absence-list' ? 'active' : ''}">
                <span class="material-symbols-rounded">fact_check</span>
                Xin nghỉ học
            </a>
            </a>
        </li>

        <li>
            <a href="${pageContext.request.contextPath}/payment/parent"
               class="nav-link ${activePage == 'payments' ? 'active' : ''}">
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
