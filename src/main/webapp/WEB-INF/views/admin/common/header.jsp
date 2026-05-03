<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="adminUser" value="${sessionScope.currentUser}" />
<c:set var="displayName" value="${not empty adminUser and not empty adminUser.username ? adminUser.username : 'Admin'}" />
<c:set var="avatarUrl" value="${pageContext.request.contextPath}/images/default-avatar.png" />

<header class="top-header">
    <div class="search-bar">
        <span class="material-symbols-rounded">search</span>
        <input type="text" placeholder="Tìm kiếm nhanh...">
    </div>

    <div class="header-tools">
        <!-- Notification Dropdown -->
        <div class="notification-dropdown">
            <button type="button" class="tool-icon" id="bellToggle">
                <span class="material-symbols-rounded">notifications</span>
                <c:if test="${not empty unreadCount and unreadCount > 0}">
                    <span class="badge">${unreadCount}</span>
                </c:if>
            </button>

            <div class="notification-menu" id="notificationMenu">
                <div class="noti-header">
                    <strong>Thông báo</strong>
                    <a href="${pageContext.request.contextPath}/notifications">Xem tất cả</a>
                </div>

                <div class="noti-list">
                    <c:choose>
                        <c:when test="${not empty notifications}">
                            <c:forEach var="noti" items="${notifications}">
                                <div class="noti-item ${!noti.isRead ? 'unread' : ''}">
                                    <h4><c:out value="${empty noti.title ? 'Thông báo' : noti.title}" /></h4>
                                    <p><c:out value="${empty noti.content ? '' : noti.content}" /></p>
                                    <span class="noti-time"><c:out value="${noti.createdAt}" /></span>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="noti-empty">
                                <span class="material-symbols-rounded">notifications_off</span>
                                <p>Không có thông báo mới</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <!-- User Dropdown -->
        <div class="user-dropdown">
            <button type="button" class="user-toggle" id="userToggle">
                <img class="header-avatar"
                     src="${avatarUrl}"
                     alt="Admin"
                     onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/images/default-avatar.png'">

                <div class="user-meta">
                    <strong><c:out value="${displayName}"/></strong>
                    <span>ADMIN</span>
                </div>
                <span class="material-symbols-rounded">expand_more</span>
            </button>

            <div class="user-menu" id="userMenu">
                <div class="user-menu-header">
                    <strong><c:out value="${displayName}"/></strong>
                    <span>Hệ thống quản trị</span>
                </div>

                <a href="${pageContext.request.contextPath}/change-password">
                    <span class="material-symbols-rounded">key</span>
                    <span>Đổi mật khẩu</span>
                </a>

                <div class="menu-divider"></div>

                <a href="${pageContext.request.contextPath}/logout" class="logout-link">
                    <span class="material-symbols-rounded">logout</span>
                    <span>Đăng xuất</span>
                </a>
            </div>
        </div>
    </div>
</header>

<script>
    (function () {
        const userToggle = document.getElementById('userToggle');
        const userMenu = document.getElementById('userMenu');
        const bellToggle = document.getElementById('bellToggle');
        const notificationMenu = document.getElementById('notificationMenu');

        function closeAllMenus() {
            if (notificationMenu) notificationMenu.classList.remove('active');
            if (userMenu) userMenu.classList.remove('active');
            if (userToggle) userToggle.classList.remove('active');
        }

        if (bellToggle && notificationMenu) {
            bellToggle.addEventListener('click', function (e) {
                e.preventDefault();
                e.stopPropagation();
                const isActive = notificationMenu.classList.contains('active');
                closeAllMenus();
                if (!isActive) {
                    notificationMenu.classList.add('active');
                }
            });
        }

        if (userToggle && userMenu) {
            userToggle.addEventListener('click', function (e) {
                e.preventDefault();
                e.stopPropagation();
                const isActive = userMenu.classList.contains('active');
                closeAllMenus();
                if (!isActive) {
                    userMenu.classList.add('active');
                    userToggle.classList.add('active');
                }
            });
        }

        [notificationMenu, userMenu].forEach(menu => {
            if (menu) {
                menu.addEventListener('click', e => e.stopPropagation());
            }
        });

        document.addEventListener('click', closeAllMenus);
    })();
</script>
