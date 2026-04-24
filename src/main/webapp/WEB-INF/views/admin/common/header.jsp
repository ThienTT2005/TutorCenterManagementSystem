<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header class="top-header">
    <div class="search-bar">
        <span class="material-symbols-rounded">search</span>
        <input type="text" placeholder="Tìm kiếm nhanh...">
    </div>
    
    <div class="header-actions">
        <button class="icon-btn">
            <span class="material-symbols-rounded">notifications</span>
            <span class="badge"></span>
        </button>

        <!-- User Dropdown Integration -->
        <div class="user-dropdown" id="adminUserDropdown">
            <button type="button" class="user-toggle" id="adminUserToggle">
                <img class="header-avatar" 
                     src="${pageContext.request.contextPath}/${empty loggedInUser.avatar || loggedInUser.avatar == 'avatar-default.png' || loggedInUser.avatar == 'default-avatar.png' ? 'images/default-avatar.png' : (loggedInUser.avatar.startsWith('assets/') ? loggedInUser.avatar : 'uploads/'.concat(loggedInUser.avatar))}"
                     alt="${empty loggedInUser.fullName ? 'Admin' : loggedInUser.fullName}"
                     onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/images/default-avatar.png'">
                
                <div class="user-meta">
                    <strong>${empty loggedInUser.fullName ? 'Quản trị viên' : loggedInUser.fullName}</strong>
                    <span>${empty loggedInUser.roleName ? 'ADMIN' : loggedInUser.roleName}</span>
                </div>
                <i class="fa-solid fa-chevron-down"></i>
            </button>

            <div class="user-menu" id="adminUserMenu">
                <div class="user-menu-header">
                    <strong>${empty loggedInUser.fullName ? 'Quản trị viên' : loggedInUser.fullName}</strong>
                    <span>${empty loggedInUser.roleName ? 'ADMIN' : loggedInUser.roleName}</span>
                </div>

                <a href="${pageContext.request.contextPath}/admin/profile">
                    <i class="fa-solid fa-user"></i>
                    <span>Thông tin cá nhân</span>
                </a>

                <a href="${pageContext.request.contextPath}/profile/change-password">
                    <i class="fa-solid fa-key"></i>
                    <span>Đổi mật khẩu</span>
                </a>

                <div class="menu-divider"></div>

                <a href="${pageContext.request.contextPath}/logout" class="logout-link">
                    <i class="fa-solid fa-right-from-bracket"></i>
                    <span>Đăng xuất</span>
                </a>
            </div>
        </div>
    </div>
</header>

<!-- FontAwesome for the dropdown icons as requested -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const toggle = document.getElementById('adminUserToggle');
        const menu = document.getElementById('adminUserMenu');
        
        if (toggle && menu) {
            toggle.addEventListener('click', function(e) {
                e.stopPropagation();
                menu.classList.toggle('active');
                toggle.classList.toggle('active');
            });

            document.addEventListener('click', function(e) {
                if (!menu.contains(e.target) && !toggle.contains(e.target)) {
                    menu.classList.remove('active');
                    toggle.classList.remove('active');
                }
            });
        }
    });
</script>
