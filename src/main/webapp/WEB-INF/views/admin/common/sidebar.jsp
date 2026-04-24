<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<aside class="sidebar">
    <div class="brand">
        <div class="brand-icon">
            <span class="material-symbols-rounded">school</span>
        </div>
        <div class="brand-text">
            <span class="brand-title">TCMS Admin</span>
            <span class="brand-subtitle">MANAGEMENT PORTAL</span>
        </div>
    </div>

    <ul class="nav-menu">
        <li>
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link ${activePage == 'dashboard' ? 'active' : ''}">
                <span class="material-symbols-rounded">dashboard</span>
                Bảng điều khiển
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/accounts" class="nav-link ${activePage == 'accounts' ? 'active' : ''}">
                <span class="material-symbols-rounded">manage_accounts</span>
                Tài khoản
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/parents" class="nav-link ${activePage == 'parents' ? 'active' : ''}">
                <span class="material-symbols-rounded">family_restroom</span>
                Phụ huynh
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/students" class="nav-link ${activePage == 'students' ? 'active' : ''}">
                <span class="material-symbols-rounded">face</span>
                Học sinh
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/tutors" class="nav-link ${activePage == 'tutors' ? 'active' : ''}">
                <span class="material-symbols-rounded">person_celebrate</span>
                Gia sư
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/classes" class="nav-link ${activePage == 'classes' ? 'active' : ''}">
                <span class="material-symbols-rounded">menu_book</span>
                Lớp học
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/payments" class="nav-link ${activePage == 'payments' ? 'active' : ''}">
                <span class="material-symbols-rounded">payments</span>
                Thanh toán
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/reports" class="nav-link ${activePage == 'reports' ? 'active' : ''}">
                <span class="material-symbols-rounded">bar_chart</span>
                Báo cáo
            </a>
        </li>
    </ul>

    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/logout" class="nav-link" style="color: var(--danger);">
            <span class="material-symbols-rounded">logout</span>
            Đăng xuất
        </a>
    </div>
</aside>
