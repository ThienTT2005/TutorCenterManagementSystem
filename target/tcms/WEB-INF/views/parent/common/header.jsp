<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="currentUser" value="${sessionScope.currentUser}" />

<c:set var="rawAvatar" value="" />
<c:set var="displayName" value="${not empty currentUser ? currentUser.username : 'Phụ huynh'}" />

<c:choose>
    <c:when test="${not empty currentUser.parent}">
        <c:set var="rawAvatar" value="${currentUser.parent.avatar}" />
        <c:set var="displayName" value="${empty currentUser.parent.fullName ? currentUser.username : currentUser.parent.fullName}" />
    </c:when>

    <c:otherwise>
        <c:set var="displayName" value="${not empty currentUser.username ? currentUser.username : 'Phụ huynh'}" />
    </c:otherwise>
</c:choose>

<c:set var="avatarUrl" value="${pageContext.request.contextPath}/images/default-avatar.png" />

<c:if test="${not empty rawAvatar}">
    <c:choose>
        <c:when test="${fn:startsWith(rawAvatar, 'http')}">
            <c:set var="avatarUrl" value="${rawAvatar}" />
        </c:when>

        <c:when test="${fn:startsWith(rawAvatar, '/uploads/')}">
            <c:set var="avatarUrl" value="${pageContext.request.contextPath}${rawAvatar}" />
        </c:when>

        <c:when test="${fn:startsWith(rawAvatar, 'uploads/')}">
            <c:set var="avatarUrl" value="${pageContext.request.contextPath}/${rawAvatar}" />
        </c:when>

        <c:otherwise>
            <c:set var="avatarUrl" value="${pageContext.request.contextPath}/${rawAvatar}" />
        </c:otherwise>
    </c:choose>
</c:if>

<header class="top-header">
    <form class="search-wrapper"
          action="${pageContext.request.contextPath}/parent/classes"
          method="get">
        <i class="fa-solid fa-magnifying-glass"></i>
        <input name="keyword"
               placeholder="Tìm kiếm lớp học của con..."
               value="${param.keyword}">
    </form>

    <div class="header-tools">

        <!-- NOTIFICATION -->
        <div class="notification-dropdown">
            <button type="button" class="tool-icon" id="bellToggle" title="Thông báo">
                <i class="fa-regular fa-bell"></i>
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
                                <div class="noti-item ${noti.isRead == false ? 'unread' : ''}"
                                     onclick="handleParentNotiClick('${noti.notificationId}',
                                             '${noti.referenceTable}',
                                             '${noti.referenceId}',
                                             '${noti.type}',
                                             this)">

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
                    <span>Phụ huynh</span>
                </div>

                <i class="fa-solid fa-chevron-down"></i>
            </button>

            <div class="user-menu" id="userMenu">
                <div class="user-menu-header">
                    <strong><c:out value="${displayName}" /></strong>
                    <span>PARENT</span>
                </div>

                <div class="menu-divider"></div>

                <a href="${pageContext.request.contextPath}/profile">
                    <i class="fa-solid fa-user"></i>
                    Thông tin cá nhân
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
                if (!isActive) notificationMenu.classList.add('active');
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

    function handleParentNotiClick(id, table, refId, type, element) {

        fetch(
            '${pageContext.request.contextPath}/notifications/' + id + '/read',
            {
                method: 'POST'
            }
        ).finally(() => {

            // remove unread
            if (element) {

                element.classList.remove('unread');

                const badge =
                    document.querySelector('.badge');

                if (badge) {

                    let count =
                        parseInt(badge.innerText);

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

            window.location.href =
                getParentNotificationUrl(table, refId, type);
        });
    }

    function getParentNotificationUrl(table, refId, type) {

        table = (table || '').toLowerCase();
        type = (type || '').toUpperCase();

        // PAYMENT
        if (
            type === 'PAYMENT' ||
            table === 'payments' ||
            table === 'payment'
        ) {
            return '${pageContext.request.contextPath}/payment/parent';
        }

        // FEEDBACK
        if (
            type === 'FEEDBACK' ||
            table === 'feedback' ||
            table === 'feedbacks'
        ) {
            return '${pageContext.request.contextPath}/parent/classes';
        }

        // HOMEWORK
        if (
            type === 'HOMEWORK' ||
            table === 'homework' ||
            table === 'homeworks'
        ) {
            return '${pageContext.request.contextPath}/parent/classes';
        }

        // ATTENDANCE
        if (
            type === 'ATTENDANCE' ||
            table === 'attendance' ||
            table === 'absence_requests'
        ) {
            return '${pageContext.request.contextPath}/parent/absence/list';
        }

        // SCHEDULE
        if (
            type === 'SCHEDULE' ||
            table === 'schedules' ||
            table === 'teaching_sessions'
        ) {
            return '${pageContext.request.contextPath}/parent/classes';
        }

        return '${pageContext.request.contextPath}/notifications';
    }
</script>
