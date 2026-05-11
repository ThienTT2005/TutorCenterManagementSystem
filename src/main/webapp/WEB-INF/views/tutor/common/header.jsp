<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="currentUser" value="${sessionScope.currentUser}" />

<c:set var="rawAvatar" value="" />
<c:set var="displayName" value="${not empty currentUser ? currentUser.username : 'Gia sư'}" />

<c:choose>
    <c:when test="${not empty currentUser.tutor}">
        <c:set var="rawAvatar" value="${currentUser.tutor.avatar}" />
        <c:set var="displayName" value="${currentUser.tutor.fullName}" />
    </c:when>
    <c:otherwise>
        <c:set var="displayName" value="${not empty currentUser.username ? currentUser.username : 'Gia sư'}" />
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
          action="${pageContext.request.contextPath}/tutor/search"
          method="get">
        <i class="fa-solid fa-magnifying-glass"></i>
        <input name="keyword"
               placeholder="Tìm kiếm học sinh..."
               value="${param.keyword}">
    </form>

    <div class="header-tools">

        <div class="notification-dropdown">
            <button type="button"
                    class="tool-icon"
                    id="tutorBellToggle"
                    title="Thông báo">
                <i class="fa-regular fa-bell"></i>

                <c:if test="${not empty unreadCount and unreadCount > 0}">
                    <span class="badge">
                        <c:out value="${unreadCount}" />
                    </span>
                </c:if>
            </button>

            <div class="notification-menu" id="tutorNotificationMenu">
                <div class="noti-header">
                    <strong>Thông báo</strong>
                    <a href="${pageContext.request.contextPath}/notifications">
                        Xem tất cả
                    </a>
                </div>

                <div class="noti-list">
                    <c:choose>
                        <c:when test="${not empty notifications}">
                            <c:forEach var="noti" items="${notifications}">
                                <div class="noti-item ${noti.isRead == false ? 'unread' : ''}"
                                     onclick="handleTutorNotiClick('${noti.notificationId}',
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
                                    <span class="noti-time">
                                        <c:out value="${empty noti.createdAt ? '' : noti.createdAt}" />
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

        <a href="#"
           class="tool-icon"
           title="Trợ giúp">
            <i class="fa-regular fa-circle-question"></i>
        </a>

        <div class="user-dropdown">
            <button type="button"
                    class="user-toggle"
                    id="tutorUserToggle">
                <img src="${avatarUrl}"
                     class="header-avatar"
                     alt="Avatar"
                     onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/images/default-avatar.png'">

                <div class="user-meta">
                    <strong>
                        <c:out value="${displayName}" />
                    </strong>
                    <span>Gia sư</span>
                </div>

                <i class="fa-solid fa-chevron-down"></i>
            </button>

            <div class="user-menu" id="tutorUserMenu">
                <div class="user-menu-header">
                    <strong>
                        <c:out value="${displayName}" />
                    </strong>
                    <span>TUTOR</span>
                </div>

                <div class="menu-divider"></div>

                <a href="${pageContext.request.contextPath}/profile">
                    <i class="fa-solid fa-user"></i>
                    Hồ sơ cá nhân
                </a>

                <a href="${pageContext.request.contextPath}/change-password">
                    <i class="fa-solid fa-key"></i>
                    Đổi mật khẩu
                </a>

                <div class="menu-divider"></div>

                <a href="${pageContext.request.contextPath}/logout"
                   class="logout-link">
                    <i class="fa-solid fa-arrow-right-from-bracket"></i>
                    Đăng xuất
                </a>
            </div>
        </div>

    </div>
</header>

<script>
    (function () {
        const userToggle = document.getElementById('tutorUserToggle');
        const userMenu = document.getElementById('tutorUserMenu');

        const bellToggle = document.getElementById('tutorBellToggle');
        const notificationMenu = document.getElementById('tutorNotificationMenu');

        function closeAllMenus() {
            if (notificationMenu) {
                notificationMenu.classList.remove('active');
            }

            if (userMenu) {
                userMenu.classList.remove('active');
            }

            if (userToggle) {
                userToggle.classList.remove('active');
            }
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

        if (notificationMenu) {
            notificationMenu.addEventListener('click', function (e) {
                e.stopPropagation();
            });
        }

        if (userMenu) {
            userMenu.addEventListener('click', function (e) {
                e.stopPropagation();
            });
        }

        document.addEventListener('click', closeAllMenus);
    })();

    function handleTutorNotiClick(id, table, refId, type, element) {

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

            window.location.href = getTutorNotificationUrl(table, refId, type);
        });
    }

    function getTutorNotificationUrl(table, refId, type) {

        table = table || '';
        type = type || '';

        if (type === 'PAYMENT' || table === 'payments') {
            return '${pageContext.request.contextPath}/payment/tutor';
        }

        if (type === 'HOMEWORK' || table === 'homeworks') {
            return '${pageContext.request.contextPath}/tutor/classes';
        }

        if (type === 'FEEDBACK' || table === 'feedbacks') {
            return '${pageContext.request.contextPath}/tutor/classes';
        }

        if (type === 'SCHEDULE' || table === 'teaching_sessions') {
            return '${pageContext.request.contextPath}/tutor/classes';
        }

        if (table === 'homework_submissions') {
            return '${pageContext.request.contextPath}/tutor/homework/submissions/' + refId;
        }

        return '${pageContext.request.contextPath}/notifications';
    }
</script>