<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách tài khoản | TCMS Admin</title>

    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0" />

    <link rel="stylesheet" href="<c:url value='/css/core-dashboard.css' />">

    <style>
        .role-badge {
            padding: 6px 12px;
            border-radius: 999px;
            font-size: 11px;
            font-weight: 800;
            text-transform: uppercase;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            width: fit-content;
        }

        .role-admin {
            background: #f1f5f9;
            color: #475569;
        }

        .role-tutor {
            background: #e0f2fe;
            color: #0369a1;
        }

        .role-parent {
            background: #f3e8ff;
            color: #7e22ce;
        }

        .role-student {
            background: #ecfeff;
            color: #0891b2;
        }

        .status-pill {
            padding: 6px 12px;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 700;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            width: fit-content;
        }

        .status-pill.active {
            background: #dcfce7;
            color: #16a34a;
        }

        .status-pill.blocked {
            background: #fee2e2;
            color: #dc2626;
        }

        .status-dot {
            width: 7px;
            height: 7px;
            border-radius: 50%;
            background: currentColor;
        }

        .account-table-header,
        .account-table-row {
            display: grid;
            grid-template-columns: 0.6fr 2fr 1.6fr 1.3fr 1.3fr 1.6fr;
            align-items: center;
        }

        .account-table-row {
            padding: 18px 24px;
            border-bottom: 1px solid #f1f5f9;
            background: #fff;
        }

        .account-table-row:hover {
            background: var(--bg-page);
        }

        .user-cell {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .user-initials {
            width: 38px;
            height: 38px;
            border-radius: 50%;
            background: #e0f2fe;
            color: #0369a1;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 900;
            text-transform: uppercase;
        }

        .user-detail h4 {
            margin: 0;
            font-size: 14px;
            font-weight: 800;
            color: var(--text-dark);
        }

        .user-detail span {
            display: block;
            margin-top: 3px;
            font-size: 12px;
            color: var(--text-muted);
            font-weight: 600;
        }

        .summary-note {
            padding: 18px 24px;
            background: #fff;
            border-top: 1px solid #f1f5f9;
            color: var(--text-muted);
            font-size: 13px;
            font-weight: 500;
        }

        .empty-state {
            padding: 70px 20px;
            text-align: center;
            color: var(--text-muted);
            background: #fff;
        }

        .empty-state .material-symbols-rounded {
            font-size: 60px;
            opacity: 0.35;
            margin-bottom: 12px;
        }

        .empty-state h4 {
            font-size: 20px;
            margin-bottom: 8px;
            color: var(--text-dark);
        }

        @media (max-width: 1100px) {
            .account-table-header,
            .account-table-row {
                grid-template-columns: 0.5fr 2fr 1.2fr 1.2fr;
            }

            .hide-md {
                display: none;
            }
        }

        @media (max-width: 760px) {
            .account-table-header {
                display: none;
            }

            .account-table-row {
                grid-template-columns: 1fr;
                gap: 12px;
                padding: 18px;
            }

            .hide-md {
                display: block;
            }
        }
    </style>
</head>

<body>

<c:set var="activePage" value="accounts" scope="request" />

<jsp:include page="../common/sidebar.jsp" />

<main class="main-content">
    <jsp:include page="../common/header.jsp" />

    <div class="dashboard-body">

        <div class="page-header">
            <div class="page-title">
                <h2>Danh sách tài khoản</h2>
                <p>Quản lý các tài khoản người dùng trong hệ thống.</p>
            </div>

            <a href="${pageContext.request.contextPath}/admin/users/create"
               class="btn-primary"
               style="text-decoration: none;">
                <span class="material-symbols-rounded">person_add</span>
                Tạo tài khoản
            </a>
        </div>

        <%-- Thống kê tự tính từ biến users, không cần controller truyền thêm stats --%>
        <c:set var="totalUsers" value="${empty users ? 0 : fn:length(users)}" />
        <c:set var="adminCount" value="0" />
        <c:set var="tutorCount" value="0" />
        <c:set var="parentCount" value="0" />
        <c:set var="studentCount" value="0" />

        <c:if test="${not empty users}">
            <c:forEach items="${users}" var="u">
                <c:choose>
                    <c:when test="${not empty u.role and u.role.roleName == 'ADMIN'}">
                        <c:set var="adminCount" value="${adminCount + 1}" />
                    </c:when>
                    <c:when test="${not empty u.role and u.role.roleName == 'TUTOR'}">
                        <c:set var="tutorCount" value="${tutorCount + 1}" />
                    </c:when>
                    <c:when test="${not empty u.role and u.role.roleName == 'PARENT'}">
                        <c:set var="parentCount" value="${parentCount + 1}" />
                    </c:when>
                    <c:when test="${not empty u.role and u.role.roleName == 'STUDENT'}">
                        <c:set var="studentCount" value="${studentCount + 1}" />
                    </c:when>
                </c:choose>
            </c:forEach>
        </c:if>

        <section class="stats-grid">
            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-icon blue">
                        <span class="material-symbols-rounded">groups</span>
                    </div>
                </div>
                <div class="stat-title">Tổng tài khoản</div>
                <div class="stat-value">${totalUsers}</div>
            </div>

            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-icon blue">
                        <span class="material-symbols-rounded">person_celebrate</span>
                    </div>
                </div>
                <div class="stat-title">Gia sư</div>
                <div class="stat-value">${tutorCount}</div>
            </div>

            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-icon purple">
                        <span class="material-symbols-rounded">family_restroom</span>
                    </div>
                </div>
                <div class="stat-title">Phụ huynh</div>
                <div class="stat-value">${parentCount}</div>
            </div>

            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-icon purple">
                        <span class="material-symbols-rounded">face</span>
                    </div>
                </div>
                <div class="stat-title">Học sinh</div>
                <div class="stat-value">${studentCount}</div>
            </div>
        </section>
        <form action="${pageContext.request.contextPath}/admin/users"
              method="GET"
              class="filters-toolbar">

            <div class="filter-group" style="flex: 1.5;">
                <div class="filter-input">
                    <span class="material-symbols-rounded" style="color: var(--text-muted);">search</span>
                    <input type="text"
                           name="username"
                           value="${param.username}"
                           placeholder="Tìm theo username...">
                </div>
            </div>

            <div class="filter-group">
                <div class="filter-input">
                    <select name="role">
                        <option value="">Tất cả vai trò</option>
                        <option value="ADMIN" ${param.role == 'ADMIN' ? 'selected' : ''}>Admin</option>
                        <option value="TUTOR" ${param.role == 'TUTOR' ? 'selected' : ''}>Gia sư</option>
                        <option value="PARENT" ${param.role == 'PARENT' ? 'selected' : ''}>Phụ huynh</option>
                        <option value="STUDENT" ${param.role == 'STUDENT' ? 'selected' : ''}>Học sinh</option>
                    </select>
                </div>
            </div>

            <div class="filter-group">
                <div class="filter-input">
                    <select name="status">
                        <option value="">Tất cả trạng thái</option>
                        <option value="true" ${param.status == 'true' ? 'selected' : ''}>Active</option>
                        <option value="false" ${param.status == 'false' ? 'selected' : ''}>Blocked</option>
                    </select>
                </div>
            </div>

            <button type="submit"
                    class="icon-btn"
                    style="background: var(--bg-page); border: 1px solid var(--border-color); width: 44px; height: 44px;"
                    title="Lọc">
                <span class="material-symbols-rounded">filter_list</span>
            </button>

            <a href="${pageContext.request.contextPath}/admin/users"
               style="color: var(--primary); font-size: 13px; font-weight: 700; text-decoration: none;">
                Xóa lọc
            </a>
        </form>
        <div class="card">
            <div class="table-container">

                <div class="table-header account-table-header">
                    <div class="th">STT</div>
                    <div class="th">NGƯỜI DÙNG</div>
                    <div class="th">USERNAME / ID</div>
                    <div class="th">VAI TRÒ</div>
                    <div class="th">TRẠNG THÁI</div>
                    <div class="th hide-md">THAO TÁC</div>
                </div>

                <c:choose>
                    <c:when test="${not empty users}">
                        <c:forEach items="${users}" var="user" varStatus="stt">

                            <c:set var="roleName" value="${not empty user.role ? user.role.roleName : ''}" />

                            <div class="account-table-row">

                                <div style="color: var(--text-muted); font-weight: 700;">
                                        ${stt.index + 1}
                                </div>

                                <div class="user-cell">
                                    <div class="user-initials">
                                        <c:choose>
                                            <c:when test="${not empty user.username}">
                                                ${fn:substring(user.username, 0, 1)}
                                            </c:when>
                                            <c:otherwise>?</c:otherwise>
                                        </c:choose>
                                    </div>

                                    <div class="user-detail">
                                        <h4>
                                            <c:out value="${empty user.username ? 'Chưa cập nhật' : user.username}" />
                                        </h4>
                                        <span>Tài khoản hệ thống</span>
                                    </div>
                                </div>

                                <div style="display: flex; flex-direction: column; gap: 4px;">
                                    <span style="font-size: 13px; font-weight: 800; color: var(--text-dark);">
                                        @<c:out value="${empty user.username ? 'unknown' : user.username}" />
                                    </span>
                                    <span style="font-size: 12px; color: var(--text-muted); font-weight: 600;">
                                        ID: #<c:out value="${user.userId}" />
                                    </span>
                                </div>

                                <div>
                                    <c:choose>
                                        <c:when test="${roleName == 'ADMIN'}">
                                            <span class="role-badge role-admin">Quản trị</span>
                                        </c:when>
                                        <c:when test="${roleName == 'TUTOR'}">
                                            <span class="role-badge role-tutor">Gia sư</span>
                                        </c:when>
                                        <c:when test="${roleName == 'PARENT'}">
                                            <span class="role-badge role-parent">Phụ huynh</span>
                                        </c:when>
                                        <c:when test="${roleName == 'STUDENT'}">
                                            <span class="role-badge role-student">Học sinh</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="role-badge role-admin">Chưa xác định</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <div>
                                    <c:choose>
                                        <c:when test="${user.status == true}">
                                            <span class="status-pill active">
                                                <span class="status-dot"></span>
                                                Active
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-pill blocked">
                                                <span class="status-dot"></span>
                                                Blocked
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <div class="actions-cell">
                                    <a class="action-btn"
                                       href="${pageContext.request.contextPath}/admin/users/${user.userId}/detail"
                                       title="Xem chi tiết">
                                        <span class="material-symbols-rounded">visibility</span>
                                    </a>
                                </div>

                            </div>
                        </c:forEach>
                    </c:when>

                    <c:otherwise>
                        <div class="empty-state">
                            <span class="material-symbols-rounded">person_off</span>
                            <h4>Chưa có tài khoản nào</h4>
                            <p>Hãy tạo tài khoản đầu tiên cho hệ thống.</p>
                        </div>
                    </c:otherwise>
                </c:choose>

                <div class="summary-note">
                    Tổng cộng <strong>${totalUsers}</strong> tài khoản.
                </div>

            </div>
        </div>

    </div>
</main>

</body>
</html>
