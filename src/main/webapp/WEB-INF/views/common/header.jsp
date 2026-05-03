<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="adminUser" value="${sessionScope.currentUser}" />
<c:set var="displayName" value="${empty adminUser.username ? 'Admin' : adminUser.username}" />
<c:set var="avatarUrl" value="${pageContext.request.contextPath}/images/default-avatar.png" />

<header class="top-header">
    <form class="search-wrapper" action="${pageContext.request.contextPath}/admin/search" method="get">
        <span class="material-symbols-rounded">search</span>
        <input name="keyword" placeholder="Tìm kiếm nhanh..." value="${param.keyword}">
    </form>

    <div class="header-tools">

        <!-- NOTIFICATION DROPDOWN -->
        <div class="notification-dropdown">
            <button type="button" class="tool-icon" id="adminBellToggle" title="Thông báo">
                <span class="material-symbols-rounded">notifications</span>

                <c:if test="${not empty unreadCount and unreadCount > 0}">
                    <span class="badge">${unreadCount}</span>
                </c:if>
            </button>

            <div class="notification-menu" id="adminNotificationMenu">
                <div class="noti-header">
                    <strong>Thông báo</strong>
                    <a href="${pageContext.request.contextPath}/notifications">Xem tất cả</a>
                </div>

                <div class="noti-list">
                    <c:choose>
                        <c:when test="${not empty notifications}">
                            <c:forEach var="noti" items="${notifications}">
                                <div class="noti-item ${noti.isRead == false ? 'unread' : ''}">
                                    <h4><c:out value="${noti.title}" /></h4>
                                    <p><c:out value="${noti.content}" /></p>
                                    <span class="noti-time">
                                        <c:out value="${noti.createdAt}" />
                                    </span>
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

        <!-- HELP ICON -->
        <a href="#" class="tool-icon" title="Trợ giúp">
            <span class="material-symbols-rounded">help</span>
        </a>

        <!-- USER DROPDOWN -->
        <div class="user-dropdown">
            <button type="button" class="user-toggle" id="adminUserToggle">
                <img class="header-avatar"
                     src="${avatarUrl}"
                     alt="Admin"
                     onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/images/default-avatar.png'">

                <div class="user-meta">
                    <strong><c:out value="${displayName}" /></strong>
                    <span>ADMIN</span>
                </div>

                <span class="material-symbols-rounded">expand_more</span>
            </button>

            <div class="user-menu" id="adminUserMenu">
                <div class="user-menu-header">
                    <strong><c:out value="${displayName}" /></strong>
                    <span>Hệ thống quản trị</span>
                </div>

                <div class="menu-divider"></div>

                <a href="${pageContext.request.contextPath}/admin/profile">
                    <span class="material-symbols-rounded">person</span>
                    Thông tin cá nhân
                </a>

                <a href="${pageContext.request.contextPath}/change-password">
                    <span class="material-symbols-rounded">key</span>
                    Đổi mật khẩu
                </a>

                <div class="menu-divider"></div>

                <a href="${pageContext.request.contextPath}/logout" class="logout-link">
                    <span class="material-symbols-rounded">logout</span>
                    Đăng xuất
                </a>
            </div>
        </div>
    </div>
</header>

<script>
    (function () {
        const userToggle = document.getElementById('adminUserToggle');
        const userMenu = document.getElementById('adminUserMenu');

        const bellToggle = document.getElementById('adminBellToggle');
        const notificationMenu = document.getElementById('adminNotificationMenu');

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

        [notificationMenu, userMenu].forEach(function (menu) {
            if (menu) {
                menu.addEventListener('click', function (e) {
                    e.stopPropagation();
                });
            }
        });

        document.addEventListener('click', closeAllMenus);
    })();
</script>
