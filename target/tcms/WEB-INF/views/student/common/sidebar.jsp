<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<aside class="sidebar">
    <div class="brand">
        <div class="brand-icon">
            <span class="material-symbols-rounded">school</span>
        </div>
        <div class="brand-text">
            <span class="brand-title">TCMS Student</span>
            <span class="brand-subtitle">STUDENT PORTAL</span>
        </div>
    </div>

    <ul class="nav-menu">
        <li>
            <a href="${pageContext.request.contextPath}/student/dashboard"
               class="nav-link ${activePage == 'dashboard' ? 'active' : ''}">
                <span class="material-symbols-rounded">dashboard</span>
                Bảng điều khiển
            </a>
        </li>

        <li>
            <a href="${pageContext.request.contextPath}/student/classes"
               class="nav-link ${activePage == 'classes' ? 'active' : ''}">
                <span class="material-symbols-rounded">menu_book</span>
                Lớp học của tôi
            </a>
        </li>

        <li>
            <a href="${pageContext.request.contextPath}/student/homework"
               class="nav-link ${activePage == 'homework' ? 'active' : ''}">
                <span class="material-symbols-rounded">assignment</span>
                Bài tập
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
