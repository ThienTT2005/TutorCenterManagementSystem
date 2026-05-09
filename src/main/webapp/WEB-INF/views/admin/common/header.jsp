<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<c:set var="adminUser" value="${sessionScope.currentUser}" />
<c:set var="displayName" value="${not empty adminUser and not empty adminUser.username ? adminUser.username : 'admin'}" />
<c:set var="avatarUrl" value="${pageContext.request.contextPath}/images/default-avatar.png" />

<%-- Admin dashboard có thể truyền recentNotifications, còn header parent dùng notifications --%>
<c:choose>
    <c:when test="${not empty notifications}">
        <c:set var="adminNotifications" value="${notifications}" />
    </c:when>
    <c:when test="${not empty recentNotifications}">
        <c:set var="adminNotifications" value="${recentNotifications}" />
    </c:when>
    <c:otherwise>
        <c:set var="adminNotifications" value="${null}" />
    </c:otherwise>
</c:choose>

<%-- Nếu backend chưa truyền unreadCount thì tự đếm từ danh sách thông báo --%>
<c:set var="adminUnreadCount" value="${not empty unreadCount ? unreadCount : 0}" />

<c:if test="${empty unreadCount and not empty adminNotifications}">
    <c:set var="adminUnreadCount" value="0" />
    <c:forEach var="notiCount" items="${adminNotifications}">
        <c:if test="${notiCount.isRead ne true}">
            <c:set var="adminUnreadCount" value="${adminUnreadCount + 1}" />
        </c:if>
    </c:forEach>
</c:if>

<header class="top-header">
    <div class="search-wrapper">
        <i class="fa-solid fa-magnifying-glass"></i>
        <input type="text" placeholder="Tìm kiếm nhanh...">
    </div>

    <div class="header-tools">

        <!-- NOTIFICATION -->
        <div class="notification-dropdown">
            <button type="button" class="tool-icon" id="bellToggle" title="Thông báo">
                <i class="fa-regular fa-bell"></i>

                <c:if test="${adminUnreadCount > 0}">
                    <span class="badge">
                        <c:choose>
                            <c:when test="${adminUnreadCount > 99}">99+</c:when>
                            <c:otherwise>${adminUnreadCount}</c:otherwise>
                        </c:choose>
                    </span>
                </c:if>
            </button>

            <div class="notification-menu" id="notificationMenu">
                <div class="noti-header">
                    <strong>Thông báo</strong>
                    <a href="${pageContext.request.contextPath}/notifications">Xem tất cả</a>
                </div>

                <div class="noti-list">
                    <c:choose>
                        <c:when test="${not empty adminNotifications}">
                            <c:forEach var="noti" items="${adminNotifications}">

                                <c:set var="notiUrl" value="${pageContext.request.contextPath}/notifications" />

                                <c:if test="${not empty noti.referenceTable}">
                                    <c:set var="refTable" value="${fn:toLowerCase(noti.referenceTable)}" />

                                    <c:choose>
                                        <c:when test="${refTable eq 'payments' or refTable eq 'payment'}">
                                            <c:set var="notiUrl" value="${pageContext.request.contextPath}/admin/payments/approve" />
                                        </c:when>

                                        <c:when test="${refTable eq 'classes' or refTable eq 'class'}">
                                            <c:set var="notiUrl" value="${pageContext.request.contextPath}/admin/classes" />
                                        </c:when>

                                        <c:when test="${refTable eq 'users' or refTable eq 'user'}">
                                            <c:set var="notiUrl" value="${pageContext.request.contextPath}/admin/users" />
                                        </c:when>

                                        <c:when test="${refTable eq 'schedules' or refTable eq 'schedule' or refTable eq 'sessions' or refTable eq 'teaching_sessions'}">
                                            <c:set var="notiUrl" value="${pageContext.request.contextPath}/admin/schedules" />
                                        </c:when>

                                        <c:when test="${refTable eq 'feedbacks' or refTable eq 'feedback'}">
                                            <c:set var="notiUrl" value="${pageContext.request.contextPath}/admin/feedbacks" />
                                        </c:when>

                                        <c:when test="${refTable eq 'homeworks' or refTable eq 'homework'}">
                                            <c:set var="notiUrl" value="${pageContext.request.contextPath}/admin/homeworks" />
                                        </c:when>

                                        <c:when test="${refTable eq 'absence_requests' or refTable eq 'absence'}">
                                            <c:set var="notiUrl" value="${pageContext.request.contextPath}/admin/absence-requests" />
                                        </c:when>
                                    </c:choose>
                                </c:if>

                                <div class="noti-item ${noti.isRead ne true ? 'unread' : ''}"
                                     onclick="handleAdminNotiClick('${noti.notificationId}',
                                             '${noti.referenceTable}',
                                             '${noti.referenceId}',
                                             '${noti.type}',
                                             this)">

                                    <h4>
                                        <c:out value="${empty noti.title ? 'Thông báo' : noti.title}" />
                                    </h4>

                                    <p>
                                        <c:out value="${empty noti.content ? '' : noti.content}" />
                                    </p>

                                    <c:if test="${not empty noti.createdAt}">
                                        <c:set var="createdAtText" value="${fn:replace(noti.createdAt, 'T', ' ')}" />
                                        <span class="noti-time">
                                                ${fn:substring(createdAtText, 0, 16)}
                                        </span>
                                    </c:if>
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

        <!-- HELP -->
        <a href="#" class="tool-icon" title="Trợ giúp">
            <i class="fa-regular fa-circle-question"></i>
        </a>

        <!-- USER DROPDOWN -->
        <div class="user-dropdown">
            <button type="button" class="user-toggle" id="userToggle">
                <img src="${avatarUrl}"
                     class="header-avatar"
                     alt="Avatar"
                     onerror="this.src='${pageContext.request.contextPath}/images/default-avatar.png'">

                <div class="user-meta">
                    <strong><c:out value="${displayName}" /></strong>
                    <span>ADMIN</span>
                </div>

                <i class="fa-solid fa-chevron-down"></i>
            </button>

            <div class="user-menu" id="userMenu">
                <div class="user-menu-header">
                    <strong><c:out value="${displayName}" /></strong>
                    <span>QUẢN TRỊ VIÊN</span>
                </div>

                <div class="menu-divider"></div>

                <a href="${pageContext.request.contextPath}/admin/profile">
                    <i class="fa-solid fa-user"></i>
                    Hồ sơ cá nhân
                </a>

                <a href="${pageContext.request.contextPath}/change-password">
                    <i class="fa-solid fa-key"></i>
                    Đổi mật khẩu
                </a>

                <div class="menu-divider"></div>

                <a href="${pageContext.request.contextPath}/logout" class="logout-link">
                    <i class="fa-solid fa-arrow-right-from-bracket"></i>
                    Đăng xuất
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

        [notificationMenu, userMenu].forEach(function (menu) {
            if (menu) {
                menu.addEventListener('click', function (e) {
                    e.stopPropagation();
                });
            }
        });

        document.addEventListener('click', closeAllMenus);
    })();
    function handleAdminNotiClick(id, table, refId, type, element) {
        fetch('${pageContext.request.contextPath}/notifications/' + id + '/read', {
            method: 'POST'
        }).finally(() => {
            if (element) {
                element.classList.remove('unread');

                const badge = document.querySelector('.badge');

                if (badge) {
                    let count = parseInt(badge.innerText);

                    if (!isNaN(count) && count > 0) {
                        count--;

                        if (count <= 0) {
                            badge.remove();
                        } else {
                            badge.innerText = count;
                        }
                    }
                }
            }
            window.location.href = getAdminNotificationUrl(table, refId, type);
        });
    }

    function getAdminNotificationUrl(table, refId, type) {
        table = table || '';
        type = type || '';

        if (type === 'PAYMENT' || table === 'payments') {
            return '${pageContext.request.contextPath}/payment/admin';
        }

        if (type === 'FEEDBACK' || table === 'feedback' || table === 'feedbacks') {
            return '${pageContext.request.contextPath}/admin/feedback/pending';
        }

        if (type === 'ATTENDANCE' || table === 'absence_requests') {
            return '${pageContext.request.contextPath}/admin/absence/pending';
        }

        if (table === 'classes') {
            return '${pageContext.request.contextPath}/admin/classes/' + refId;
        }

        if (table === 'teaching_sessions') {
            return '${pageContext.request.contextPath}/admin/classes';
        }

        return '${pageContext.request.contextPath}/notifications';
    }
</script>