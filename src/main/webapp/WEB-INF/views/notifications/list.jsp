<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="activePage" value="notifications" scope="request" />
<c:set var="currentUser" value="${sessionScope.currentUser}" />
<c:set var="role" value="${sessionScope.role}" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông báo của tôi | TCMS</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0" />
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/core-dashboard.css">
    <style>
        .notification-page {
            max-width: 900px;
            margin: 0 auto;
            width: 100%;
        }

        .noti-card {
            background: var(--bg-white);
            border-radius: var(--radius-xl);
            border: 1px solid var(--border-color);
            box-shadow: var(--shadow-sm);
            overflow: hidden;
        }

        .noti-page-header {
            padding: 24px 32px;
            border-bottom: 1px solid var(--border-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .noti-page-header h2 {
            font-size: 20px;
            font-weight: 800;
        }

        .noti-page-actions {
            display: flex;
            gap: 12px;
        }

        .btn-outline {
            padding: 8px 16px;
            border-radius: var(--radius-md);
            border: 1px solid var(--border-color);
            background: white;
            color: var(--text-dark);
            font-size: 13px;
            font-weight: 700;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.2s;
            text-decoration: none;
        }

        .btn-outline:hover {
            background: var(--bg-page);
            border-color: var(--text-muted);
        }

        .noti-full-list {
            display: flex;
            flex-direction: column;
        }

        .noti-full-item {
            padding: 24px 32px;
            border-bottom: 1px solid var(--bg-page);
            display: flex;
            gap: 20px;
            transition: background 0.2s;
            cursor: pointer;
            text-decoration: none;
            color: inherit;
        }

        .noti-full-item:hover {
            background: #f8fafc;
        }

        .noti-full-item.unread {
            background: #f0f7ff;
            border-left: 4px solid var(--primary);
        }

        .noti-icon-box {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            background: var(--bg-page);
            color: var(--text-muted);
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .unread .noti-icon-box {
            background: white;
            color: var(--primary);
            box-shadow: 0 4px 6px -1px rgba(0, 87, 191, 0.1);
        }

        .noti-content-box {
            flex: 1;
        }

        .noti-content-box h3 {
            font-size: 16px;
            font-weight: 700;
            margin-bottom: 6px;
            color: var(--text-dark);
        }

        .noti-content-box p {
            font-size: 14px;
            color: var(--text-muted);
            line-height: 1.6;
            margin-bottom: 12px;
        }

        .noti-meta {
            display: flex;
            align-items: center;
            gap: 16px;
            font-size: 12px;
            color: #94a3b8;
        }

        .noti-tag {
            padding: 2px 8px;
            border-radius: 4px;
            background: #f1f5f9;
            color: #475569;
            font-weight: 700;
            text-transform: uppercase;
        }

        .unread .noti-tag {
            background: var(--primary-light);
            color: var(--primary);
        }

        @media (max-width: 600px) {
            .noti-page-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 16px;
                padding: 20px;
            }
            .noti-full-item {
                padding: 20px;
                gap: 12px;
            }
            .noti-icon-box {
                width: 40px;
                height: 40px;
            }
        }
    </style>
</head>
<body>

<c:choose>
    <c:when test="${role == 'TUTOR'}">
        <jsp:include page="../tutor/common/sidebar.jsp"/>
    </c:when>

    <c:when test="${role == 'STUDENT'}">
        <jsp:include page="../student/common/sidebar.jsp"/>
    </c:when>

    <c:when test="${role == 'PARENT'}">
        <jsp:include page="../parent/common/sidebar.jsp"/>
    </c:when>

    <c:when test="${role == 'ADMIN'}">
        <jsp:include page="../admin/common/sidebar.jsp"/>
    </c:when>
</c:choose>

<main class="main-content">

    <c:choose>
        <c:when test="${role == 'TUTOR'}">
            <jsp:include page="../tutor/common/header.jsp"/>
        </c:when>

        <c:when test="${role == 'STUDENT'}">
            <jsp:include page="../student/common/header.jsp"/>
        </c:when>

        <c:when test="${role == 'PARENT'}">
            <jsp:include page="../parent/common/header.jsp"/>
        </c:when>

        <c:when test="${role == 'ADMIN'}">
            <jsp:include page="../admin/common/header.jsp"/>
        </c:when>
    </c:choose>

    <div class="dashboard-body">
            <div class="notification-page">
                <div class="noti-card">
                    <div class="noti-page-header">
                        <h2>Thông báo của tôi</h2>
                        <div class="noti-page-actions">
                            <form action="${pageContext.request.contextPath}/notifications/read-all" method="post" style="display: inline;">
                                <button type="submit" class="btn-outline">
                                    <span class="material-symbols-rounded">done_all</span>
                                    Đánh dấu tất cả đã đọc
                                </button>
                            </form>
                        </div>
                    </div>

                    <div class="noti-full-list">
                        <c:choose>
                            <c:when test="${not empty notifications}">
                                <c:forEach var="noti" items="${notifications}">
                                    <div class="noti-full-item ${!noti.isRead ? 'unread' : ''}" 
                                         onclick="markAsReadAndNavigate('${noti.notificationId}', '${noti.referenceTable}', '${noti.referenceId}')">
                                        <div class="noti-icon-box">
                                            <span class="material-symbols-rounded">
                                                <c:choose>
                                                    <c:when test="${noti.type == 'ATTENDANCE'}">event_available</c:when>
                                                    <c:when test="${noti.type == 'HOMEWORK'}">assignment</c:when>
                                                    <c:when test="${noti.type == 'FEEDBACK'}">chat</c:when>
                                                    <c:when test="${noti.type == 'PAYMENT'}">payments</c:when>
                                                    <c:when test="${noti.type == 'SCHEDULE'}">calendar_month</c:when>
                                                    <c:otherwise>notifications</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </div>
                                        <div class="noti-content-box">
                                            <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 4px;">
                                                <h3>${noti.title}</h3>
                                                <span class="noti-tag">${noti.type}</span>
                                            </div>
                                            <p>${noti.content}</p>
                                            <div class="noti-meta">
                                                <span class="noti-time">
                                                    <span class="material-symbols-rounded" style="font-size: 14px; vertical-align: middle; margin-top: -2px;">schedule</span>
                                                    ${noti.createdAt}
                                                </span>
                                                <c:if test="${noti.isRead}">
                                                    <span class="read-status">
                                                        <span class="material-symbols-rounded" style="font-size: 14px; vertical-align: middle; margin-top: -2px; color: var(--success);">check_circle</span>
                                                        Đã đọc
                                                    </span>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="noti-empty">
                                    <span class="material-symbols-rounded" style="font-size: 64px;">notifications_off</span>
                                    <p>Bạn không có thông báo nào.</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script>
        function markAsReadAndNavigate(id, table, refId) {
            // Gửi request đánh dấu đã đọc qua AJAX
            fetch(`${pageContext.request.contextPath}/notifications/${id}/read`, {
                method: 'POST'
            }).then(() => {
                // Điều hướng dựa trên reference
                let url = '#';
                if (table === 'teaching_sessions') url = `${pageContext.request.contextPath}/tutor/sessions/detail/${refId}`;
                else if (table === 'absence_requests') url = `${pageContext.request.contextPath}/admin/absence/pending`;
                else if (table === 'payments') url = `${pageContext.request.contextPath}/admin/payments/list`;
                else if (table === 'homework_submissions') url = `${pageContext.request.contextPath}/tutor/homework/submissions/${refId}`;
                
                window.location.href = url !== '#' ? url : window.location.href;
            });
        }
    </script>
</body>
</html>
