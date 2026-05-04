<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="currentUser" value="${sessionScope.currentUser}" />
<c:set var="displayName" value="Gia sư" />
<c:set var="avatarUrl" value="${pageContext.request.contextPath}/images/default-avatar.png" />

<c:if test="${not empty currentUser and not empty currentUser.username}">
    <c:set var="displayName" value="${currentUser.username}" />
</c:if>

<header class="top-header">
    <form class="search-wrapper" action="${pageContext.request.contextPath}/tutor/search" method="get">
        <i class="fa-solid fa-magnifying-glass"></i>
        <input name="keyword" placeholder="Tìm kiếm học sinh..." value="${param.keyword}">
    </form>

    <div class="header-tools">
        <div class="notification-dropdown">

            <button type ="button" class="tool-icon" id="bellToggle">
                <i class="fa-regular fa-bell"></i>

                <!-- badge -->
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
                                <div class="noti-item ${!noti.isRead ? 'unread' : ''}" 
                                     style="cursor: pointer;"
                                     onclick="handleNotiClick('${noti.notificationId}', '${noti.referenceTable}', '${noti.referenceId}')">
                                    <h4>${noti.title}</h4>
                                    <p>${noti.content}</p>
                                    <span class="noti-time">${noti.createdAt}</span>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="noti-empty">
                                <i class="fa-regular fa-bell-slash"></i>
                                <p>Không có thông báo mới</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <a href="#" class="tool-icon">
            <i class="fa-regular fa-circle-question"></i>
        </a>

        <div class="user-dropdown">
            <button type="button" class="user-toggle" id="userToggle">
                <img src="${avatarUrl}" 
                     class="header-avatar" 
                     alt="Avatar"
                     onerror="this.src='${pageContext.request.contextPath}/images/default-avatar.png'">
                <div class="user-meta">
                    <strong><c:out value="${displayName}" /></strong>
                    <span>Gia sư</span>
                </div>
                <i class="fa-solid fa-chevron-down"></i>
            </button>

            <div class="user-menu" id="userMenu">
                <div class="user-menu-header">
                    <strong><c:out value="${displayName}" /></strong>
                    <span>TUTOR</span>
                </div>
                <div class="menu-divider"></div>
                <a href="${pageContext.request.contextPath}/profile">
                    <i class="fa-solid fa-user"></i> Hồ sơ cá nhân
                </a>
                <a href="${pageContext.request.contextPath}/change-password">
                    <i class="fa-solid fa-key"></i> Đổi mật khẩu
                </a>
                <div class="menu-divider"></div>
                <a href="${pageContext.request.contextPath}/logout" class="logout-link">
                    <i class="fa-solid fa-arrow-right-from-bracket"></i> Đăng xuất
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

        // Prevent closing when clicking inside menus
        [notificationMenu, userMenu].forEach(menu => {
            if (menu) {
                menu.addEventListener('click', e => e.stopPropagation());
            }
        });

        document.addEventListener('click', closeAllMenus);
    })();

    function handleNotiClick(id, table, refId) {
        fetch(`${pageContext.request.contextPath}/notifications/${id}/read`, {
            method: 'POST'
        }).then(() => {
            let url = '#';
            if (table === 'teaching_sessions') {
                url = `${pageContext.request.contextPath}/tutor/sessions/detail/${refId}`;
            } else if (table === 'homework_submissions') {
                url = `${pageContext.request.contextPath}/tutor/homework/submissions/${refId}`;
            } else if (table === 'notifications') {
                url = `${pageContext.request.contextPath}/notifications`;
            }
            
            if (url !== '#') {
                window.location.href = url;
            } else {
                window.location.reload();
            }
        }).catch(err => {
            console.error('Error marking notification as read:', err);
            window.location.reload();
        });
    }
</script>
