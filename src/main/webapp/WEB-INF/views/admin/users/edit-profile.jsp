<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="activePage" value="accounts" scope="request" />

<c:set var="roleName" value="${empty user.role ? '' : user.role.roleName}" />

<c:set var="displayName" value="Người dùng TCMS" />
<c:set var="displayCode" value="USER-${user.userId}" />
<c:set var="displayAvatar" value="${pageContext.request.contextPath}/images/default-avatar.png" />

<c:if test="${not empty request.fullName}">
    <c:set var="displayName" value="${request.fullName}" />
</c:if>

<c:if test="${not empty request.avatar}">
    <c:choose>
        <c:when test="${fn:startsWith(request.avatar, 'http')}">
            <c:set var="displayAvatar" value="${request.avatar}" />
        </c:when>
        <c:when test="${fn:startsWith(request.avatar, '/uploads/')}">
            <c:set var="displayAvatar" value="${pageContext.request.contextPath}${request.avatar}" />
        </c:when>
        <c:otherwise>
            <c:set var="displayAvatar" value="${pageContext.request.contextPath}/uploads/${request.avatar}" />
        </c:otherwise>
    </c:choose>
</c:if>

<c:choose>
    <c:when test="${roleName == 'TUTOR'}">
        <c:set var="displayCode" value="Gia sư" />
    </c:when>
    <c:when test="${roleName == 'STUDENT'}">
        <c:set var="displayCode" value="Học sinh" />
    </c:when>
    <c:when test="${roleName == 'PARENT'}">
        <c:set var="displayCode" value="Phụ huynh" />
    </c:when>
</c:choose>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa hồ sơ người dùng | TCMS Admin</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap">

    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0"/>

    <link rel="stylesheet" href="<c:url value='/css/core-dashboard.css' />">

    <style>
        :root {
            --primary: #0057bf;
            --primary-hover: #004da8;
            --primary-light: #eff6ff;
            --bg-page: #f7fbff;
            --bg-white: #ffffff;
            --text-dark: #0f172a;
            --text-muted: #64748b;
            --border: #dbe3ef;
            --soft-border: #edf2f7;
            --green: #16a34a;
            --green-light: #dcfce7;
            --danger: #dc2626;
            --danger-light: #fee2e2;
            --purple: #7c3aed;
            --purple-light: #f3e8ff;
            --sidebar-width: 260px;
        }

        * {
            box-sizing: border-box;
            font-family: 'Inter', Arial, sans-serif;
        }

        body {
            margin: 0;
            background: var(--bg-page);
            color: var(--text-dark);
        }

        .main-content {
            margin-left: var(--sidebar-width);
            width: calc(100% - var(--sidebar-width));
            min-height: 100vh;
            background: var(--bg-page);
        }

        .profile-page {
            padding: 24px 32px 48px;
            min-height: calc(100vh - 70px);
        }

        .profile-topbar {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 18px;
            margin-bottom: 24px;
        }

        .page-title h1 {
            margin: 0 0 6px;
            color: #173b73;
            font-size: 25px;
            font-weight: 900;
            line-height: 1.2;
        }

        .page-title p {
            margin: 0;
            color: var(--text-muted);
            font-size: 13px;
            font-weight: 500;
        }

        .top-actions {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .btn {
            min-height: 38px;
            padding: 0 18px;
            border-radius: 10px;
            border: 1px solid transparent;
            font-size: 13px;
            font-weight: 800;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            text-decoration: none;
            cursor: pointer;
            transition: .18s ease;
        }

        .btn-primary {
            background: var(--primary);
            color: #ffffff;
            box-shadow: 0 8px 18px rgba(0, 87, 191, .2);
        }

        .btn-primary:hover {
            background: var(--primary-hover);
        }

        .btn-outline {
            background: #ffffff;
            color: #334155;
            border-color: #cbd5e1;
        }

        .btn-outline:hover {
            background: #f8fafc;
        }

        .profile-layout {
            display: grid;
            grid-template-columns: 290px minmax(0, 1fr);
            gap: 28px;
            align-items: start;
            max-width: 1120px;
        }

        .left-column,
        .right-column {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .profile-card,
        .account-card,
        .info-card {
            background: #ffffff;
            border: 1px solid var(--border);
            border-radius: 14px;
            box-shadow: 0 10px 24px rgba(15, 23, 42, .04);
            overflow: hidden;
        }

        .profile-card {
            text-align: center;
            padding: 24px 22px 22px;
            position: relative;
        }

        .profile-card::before {
            content: "";
            position: absolute;
            inset: 0 0 auto 0;
            height: 96px;
            background: linear-gradient(90deg, #f0f8ff, #e9fbff);
        }

        .avatar-wrap {
            position: relative;
            width: 110px;
            height: 110px;
            margin: 0 auto 14px;
            z-index: 1;
        }

        .avatar-img,
        .avatar-placeholder {
            width: 110px;
            height: 110px;
            border-radius: 20px;
            border: 4px solid #ffffff;
            box-shadow: 0 12px 26px rgba(15, 23, 42, .12);
            object-fit: cover;
            background: #dbeafe;
        }

        .avatar-placeholder {
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary);
            font-size: 38px;
        }

        .avatar-status {
            position: absolute;
            right: -2px;
            bottom: 6px;
            width: 24px;
            height: 24px;
            border-radius: 999px;
            background: #22c55e;
            border: 4px solid #ffffff;
        }

        .profile-name {
            margin: 0;
            color: #173b73;
            font-size: 20px;
            font-weight: 900;
            line-height: 1.25;
            position: relative;
            z-index: 1;
        }

        .profile-code {
            margin: 4px 0 10px;
            color: var(--primary);
            font-size: 13px;
            font-weight: 800;
            position: relative;
            z-index: 1;
        }

        .active-badge,
        .inactive-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-height: 26px;
            padding: 0 13px;
            border-radius: 999px;
            font-size: 11px;
            font-weight: 900;
            position: relative;
            z-index: 1;
        }

        .active-badge {
            background: var(--green-light);
            color: var(--green);
        }

        .inactive-badge {
            background: var(--danger-light);
            color: var(--danger);
        }

        .account-card {
            padding: 18px 20px;
        }

        .small-card-title {
            display: flex;
            align-items: center;
            gap: 8px;
            margin: 0 0 18px;
            color: #173b73;
            font-size: 15px;
            font-weight: 900;
        }

        .small-card-title i,
        .small-card-title .material-symbols-rounded {
            color: var(--primary);
            font-size: 17px;
        }

        .account-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 14px;
            margin-bottom: 18px;
            color: var(--text-muted);
            font-size: 13px;
        }

        .account-row strong {
            color: #173b73;
            font-size: 13px;
            font-weight: 900;
            text-align: right;
        }

        .role-pill {
            padding: 4px 8px;
            border-radius: 6px;
            background: var(--primary-light);
            color: var(--primary);
            font-size: 10px;
            font-weight: 900;
            text-transform: uppercase;
        }

        .password-btn {
            width: 100%;
            min-height: 42px;
            border-radius: 10px;
            border: none;
            background: #f1f5f9;
            color: #334155;
            font-size: 13px;
            font-weight: 800;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            text-decoration: none;
            cursor: pointer;
        }

        .password-btn:hover {
            background: #e2e8f0;
        }

        .password-btn.disabled,
        .password-btn:disabled {
            opacity: .7;
            cursor: not-allowed;
        }

        .info-card-header {
            min-height: 62px;
            padding: 0 24px;
            border-bottom: 1px solid var(--border);
            background: #f1f3f5;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .info-card-header h2 {
            margin: 0;
            color: #173b73;
            font-size: 16px;
            font-weight: 900;
        }

        .info-card-header i,
        .info-card-header .material-symbols-rounded {
            color: var(--primary);
            font-size: 18px;
        }

        .info-card-body {
            padding: 26px 28px;
        }

        .edit-form {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 22px 26px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .form-group.full {
            grid-column: 1 / -1;
        }

        .form-group label {
            color: #0f172a;
            font-size: 11px;
            font-weight: 900;
            text-transform: uppercase;
        }

        .form-control {
            width: 100%;
            min-height: 38px;
            border: 1px solid #94a3b8;
            border-radius: 8px;
            background: #ffffff;
            color: #0f172a;
            font-size: 13px;
            font-weight: 600;
            padding: 0 12px;
            outline: none;
        }

        .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(0, 87, 191, .1);
        }

        textarea.form-control {
            min-height: 112px;
            padding: 12px;
            resize: vertical;
            line-height: 1.5;
        }

        .error-box {
            margin-bottom: 16px;
            padding: 14px 16px;
            border-radius: 12px;
            background: #fee2e2;
            color: #b91c1c;
            border: 1px solid #fecaca;
            font-size: 13px;
            font-weight: 800;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .hint-text {
            margin-top: 8px;
            color: #94a3b8;
            font-size: 11px;
            font-weight: 600;
            line-height: 1.5;
        }

        @media (max-width: 1050px) {
            .profile-layout {
                grid-template-columns: 1fr;
            }

            .left-column {
                max-width: 320px;
            }
        }

        @media (max-width: 760px) {
            .main-content {
                margin-left: 0;
                width: 100%;
            }

            .profile-page {
                padding: 18px;
            }

            .profile-topbar {
                flex-direction: column;
            }

            .top-actions {
                width: 100%;
                flex-direction: column;
            }

            .top-actions .btn {
                width: 100%;
            }

            .edit-form {
                grid-template-columns: 1fr;
            }
        }
        .breadcrumb {
            font-size: 12px;
            color: #94a3b8;
            margin-bottom: 8px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .breadcrumb a {
            color: #94a3b8;
            text-decoration: none;
            font-weight: 700;
        }

        .breadcrumb a:hover {
            color: #2563eb;
            text-decoration: underline;
        }

        .breadcrumb span {
            color: #2563eb;
            font-weight: 800;
        }

        .breadcrumb .separator {
            color: #cbd5e1;
            font-weight: 700;
        }
    </style>
</head>

<body>

<jsp:include page="../common/sidebar.jsp" />

<main class="main-content">
    <jsp:include page="../common/header.jsp" />

    <section class="profile-page">

        <div class="breadcrumb">
            <a href="${pageContext.request.contextPath}/admin/dashboard">Hệ thống</a>
            <span class="separator">/</span>

            <a href="${pageContext.request.contextPath}/admin/users">Danh sách tài khoản</a>
            <span class="separator">/</span>

            <a href="${pageContext.request.contextPath}/admin/users/${user.userId}">Chi tiết hồ sơ</a>
            <span class="separator">/</span>

            <span>Chỉnh sửa hồ sơ</span>
        </div>

        <c:if test="${not empty error}">
            <div class="error-box">
                <i class="fa-solid fa-circle-exclamation"></i>
                <c:out value="${error}" />
            </div>
        </c:if>

        <div class="profile-topbar">
            <div class="page-title">
                <h1>Chỉnh sửa hồ sơ người dùng</h1>
                <p>Cập nhật thông tin cá nhân theo vai trò tài khoản.</p>
            </div>

            <div class="top-actions">
                <a href="${pageContext.request.contextPath}/admin/users/${user.userId}"
                   class="btn btn-outline">
                    <i class="fa-solid fa-arrow-left"></i>
                    Quay lại chi tiết user
                </a>

                <button type="submit"
                        form="adminEditProfileForm"
                        class="btn btn-primary">
                    <i class="fa-regular fa-floppy-disk"></i>
                    Lưu thay đổi
                </button>
            </div>
        </div>

        <div class="profile-layout">

            <aside class="left-column">

                <div class="profile-card">
                    <div class="avatar-wrap">
                        <img src="${displayAvatar}"
                             class="avatar-img"
                             alt="Avatar"
                             onerror="this.src='${pageContext.request.contextPath}/images/default-avatar.png'">

                        <span class="avatar-status"></span>
                    </div>

                    <h2 class="profile-name">
                        <c:out value="${displayName}" />
                    </h2>

                    <p class="profile-code">
                        <c:out value="${displayCode}" />
                    </p>

                    <c:choose>
                        <c:when test="${user.status == true}">
                            <span class="active-badge">Đang hoạt động</span>
                        </c:when>
                        <c:otherwise>
                            <span class="inactive-badge">Đã khóa</span>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="account-card">
                    <h3 class="small-card-title">
                        <i class="fa-regular fa-circle-user"></i>
                        Thông tin tài khoản
                    </h3>

                    <div class="account-row">
                        <span>Tên đăng nhập</span>
                        <strong>
                            <c:out value="${user.username}" />
                        </strong>
                    </div>

                    <div class="account-row">
                        <span>Vai trò</span>
                        <strong>
                            <span class="role-pill">
                                <c:out value="${roleName}" />
                            </span>
                        </strong>
                    </div>

                    <div class="account-row">
                        <span>Trạng thái</span>
                        <strong>
                            <c:choose>
                                <c:when test="${user.status == true}">Đang hoạt động</c:when>
                                <c:otherwise>Đã khóa</c:otherwise>
                            </c:choose>
                        </strong>
                    </div>

                    <div class="account-row">
                        <span>Ngày tạo</span>
                        <strong>
                            <c:choose>
                                <c:when test="${not empty user.createdAt}">
                                    <c:out value="${user.createdAt}" />
                                </c:when>
                                <c:otherwise>Chưa cập nhật</c:otherwise>
                            </c:choose>
                        </strong>
                    </div>
                </div>

                <div class="account-card">
                    <h3 class="small-card-title">
                        <i class="fa-solid fa-key"></i>
                        Đổi mật khẩu
                    </h3>

                    <form action="${pageContext.request.contextPath}/admin/users/${user.userId}/change-password"
                          method="post">

                        <div class="form-group">
                            <label>Mật khẩu mới</label>
                            <input class="form-control"
                                   type="password"
                                   name="newPassword"
                                   placeholder="Nhập mật khẩu mới"
                                   minlength="6"
                                   required>
                        </div>

                        <button type="submit"
                                class="password-btn"
                                style="margin-top: 12px;">
                            <i class="fa-solid fa-rotate-left"></i>
                            Cập nhật mật khẩu
                        </button>

                        <p class="hint-text">
                            Admin chỉ cần nhập mật khẩu mới. Không cần nhập mật khẩu cũ.
                        </p>
                    </form>
                </div>

            </aside>

            <section class="right-column">

                <div class="info-card">
                    <div class="info-card-header">
                        <i class="fa-regular fa-user"></i>
                        <h2>Thông tin hồ sơ cá nhân</h2>
                    </div>

                    <div class="info-card-body">
                        <form id="adminEditProfileForm"
                              action="${pageContext.request.contextPath}/admin/users/${user.userId}/edit-profile"
                              method="post"
                              class="edit-form">

                            <input type="hidden"
                                   name="avatar"
                                   value="${request.avatar}">

                            <div class="form-group">
                                <label>Họ và tên</label>
                                <input class="form-control"
                                       type="text"
                                       name="fullName"
                                       value="${request.fullName}"
                                       required>
                            </div>

                            <c:if test="${roleName == 'TUTOR' or roleName == 'PARENT'}">
                                <div class="form-group">
                                    <label>Số điện thoại</label>
                                    <input class="form-control"
                                           type="text"
                                           name="phone"
                                           value="${request.phone}"
                                           placeholder="Ví dụ: 0901234567">
                                </div>

                                <div class="form-group">
                                    <label>Email</label>
                                    <input class="form-control"
                                           type="email"
                                           name="email"
                                           value="${request.email}">
                                </div>
                            </c:if>

                            <c:if test="${roleName == 'STUDENT'}">
                                <div class="form-group">
                                    <label>Tài khoản đăng nhập</label>
                                    <input class="form-control"
                                           type="text"
                                           value="${user.username}"
                                           readonly>
                                </div>
                            </c:if>

                            <div class="form-group">
                                <label>Ngày sinh</label>
                                <input class="form-control"
                                       type="date"
                                       name="dob"
                                       value="${request.dob}">
                            </div>

                            <div class="form-group">
                                <label>Giới tính</label>
                                <select class="form-control" name="gender">
                                    <option value="">Chọn giới tính</option>
                                    <option value="Nam" ${request.gender == 'Nam' ? 'selected' : ''}>Nam</option>
                                    <option value="Nữ" ${request.gender == 'Nữ' ? 'selected' : ''}>Nữ</option>
                                    <option value="Khác" ${request.gender == 'Khác' ? 'selected' : ''}>Khác</option>
                                </select>
                            </div>

                            <div class="form-group full">
                                <label>Địa chỉ</label>
                                <input class="form-control"
                                       type="text"
                                       name="address"
                                       value="${request.address}">
                            </div>

                            <c:if test="${roleName == 'TUTOR'}">
                                <div class="form-group">
                                    <label>Trường đại học</label>
                                    <input class="form-control"
                                           type="text"
                                           name="school"
                                           value="${request.school}">
                                </div>

                                <div class="form-group">
                                    <label>Chuyên ngành</label>
                                    <input class="form-control"
                                           type="text"
                                           name="major"
                                           value="${request.major}">
                                </div>

                                <div class="form-group full">
                                    <label>Mô tả / kinh nghiệm</label>
                                    <textarea class="form-control"
                                              name="description"><c:out value="${request.description}" /></textarea>
                                </div>
                            </c:if>

                            <c:if test="${roleName == 'STUDENT'}">
                                <div class="form-group">
                                    <label>Trường học</label>
                                    <input class="form-control"
                                           type="text"
                                           name="school"
                                           value="${request.school}">
                                </div>

                                <div class="form-group">
                                    <label>Lớp</label>
                                    <input class="form-control"
                                           type="text"
                                           name="grade"
                                           value="${request.grade}">
                                </div>

                                <div class="form-group full">
                                    <label>Phụ huynh liên kết</label>
                                    <select class="form-control"
                                            name="parentId"
                                            required>
                                        <option value="">Chọn phụ huynh</option>

                                        <c:forEach var="p" items="${parents}">
                                            <option value="${p.parentId}"
                                                ${request.parentId == p.parentId ? 'selected' : ''}>
                                                <c:out value="${p.fullName}" />
                                                <c:if test="${not empty p.phone}">
                                                    - <c:out value="${p.phone}" />
                                                </c:if>
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </c:if>

                        </form>
                    </div>
                </div>

            </section>

        </div>

    </section>
</main>

</body>
</html>