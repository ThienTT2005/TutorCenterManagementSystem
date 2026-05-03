<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa tài khoản | TCMS Admin</title>

    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <link rel="stylesheet" href="<c:url value='/css/core-dashboard.css' />">

    <style>
        .edit-container {
            width: 100%;
            padding: 2.5rem;
            box-sizing: border-box;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            border-bottom: 2px solid #f1f5f9;
            padding-bottom: 1.5rem;
        }

        .page-header h1 {
            font-size: 30px;
            font-weight: 900;
            color: #0f172a;
            margin: 0 0 8px;
        }

        .page-header p {
            color: #64748b;
            font-size: 15px;
            margin: 0;
        }

        .btn-back {
            background: #f1f5f9;
            color: #475569;
            padding: 12px 20px;
            border-radius: 12px;
            text-decoration: none;
            font-weight: 800;
        }

        .edit-grid {
            display: grid;
            grid-template-columns: 420px 1fr;
            gap: 2rem;
            align-items: start;
        }

        .form-card {
            background: white;
            border-radius: 24px;
            padding: 2rem;
            border: 1px solid #e2e8f0;
            box-shadow: 0 10px 25px rgba(15, 23, 42, 0.05);
        }

        .form-card h3 {
            font-size: 17px;
            font-weight: 900;
            color: #0369a1;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 10px;
            text-transform: uppercase;
        }

        .form-group {
            margin-bottom: 1.4rem;
        }

        .form-group label {
            display: block;
            font-size: 12px;
            font-weight: 800;
            color: #64748b;
            text-transform: uppercase;
            margin-bottom: 8px;
        }

        .form-input,
        .form-select,
        .form-textarea {
            width: 100%;
            padding: 14px 16px;
            background: #f8fafc;
            border: 1.5px solid #e2e8f0;
            border-radius: 12px;
            font-size: 15px;
            font-weight: 600;
            outline: none;
            box-sizing: border-box;
        }

        .form-input:focus,
        .form-select:focus,
        .form-textarea:focus {
            border-color: #0284c7;
            background: white;
            box-shadow: 0 0 0 4px #e0f2fe;
        }

        .form-input.error,
        .form-select.error {
            border-color: #ef4444 !important;
            background: #fef2f2 !important;
        }

        .error-message {
            color: #ef4444;
            font-size: 12px;
            font-weight: 700;
            margin-top: 6px;
            display: none;
        }

        .error-message.active {
            display: block;
        }

        .profile-grid-fields {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.3rem 1.6rem;
        }

        .full-width {
            grid-column: span 2;
        }

        .avatar-upload-box {
            background: #f1f5f9;
            border: 2px dashed #cbd5e1;
            border-radius: 20px;
            padding: 2rem;
            text-align: center;
            margin-bottom: 2rem;
        }

        .avatar-preview {
            width: 120px;
            height: 120px;
            border-radius: 28px;
            background: white;
            margin: 0 auto 1rem;
            overflow: hidden;
            box-shadow: 0 8px 20px rgba(15, 23, 42, 0.12);
        }

        .avatar-preview img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .btn-upload {
            background: #0284c7;
            color: white;
            padding: 10px 24px;
            border-radius: 12px;
            border: none;
            font-weight: 800;
            cursor: pointer;
        }

        .status-banner {
            margin-top: 1rem;
            padding: 1rem 1.3rem;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 700;
            display: none;
            align-items: center;
            gap: 10px;
        }

        .status-banner.success {
            display: flex;
            background: #f0fdf4;
            color: #15803d;
            border: 1px solid #bbf7d0;
        }

        .status-banner.error {
            display: flex;
            background: #fef2f2;
            color: #b91c1c;
            border: 1px solid #fecaca;
        }

        .footer-actions {
            margin-top: 2rem;
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
        }

        .btn-password {
            background: #e0f2fe;
            color: #0284c7;
            border: none;
            padding: 13px 22px;
            border-radius: 14px;
            font-weight: 900;
            cursor: pointer;
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            margin-top: 10px;
            transition: all 0.2s;
        }

        .btn-password:hover {
            background: #0284c7;
            color: white;
        }

        .btn-submit {
            background: #0284c7;
            color: white;
            border: none;
            padding: 13px 32px;
            border-radius: 14px;
            font-weight: 900;
            cursor: pointer;
        }

        @media (max-width: 1100px) {
            .edit-grid {
                grid-template-columns: 1fr;
            }

            .profile-grid-fields {
                grid-template-columns: 1fr;
            }

            .full-width {
                grid-column: span 1;
            }
        }
    </style>
</head>

<body>

<c:set var="activePage" value="accounts" scope="request"/>

<jsp:include page="../common/sidebar.jsp"/>

<main class="main-content">
    <jsp:include page="../common/header.jsp"/>

    <div class="edit-container">

        <div class="page-header">
            <div>
                <h1>Chỉnh sửa tài khoản</h1>
                <p>Cập nhật thông tin tài khoản và hồ sơ người dùng.</p>
            </div>

            <a class="btn-back"
               href="${pageContext.request.contextPath}/admin/users/${user.id}/detail">
                ← Quay lại chi tiết
            </a>
        </div>

        <form id="editForm">
            <div class="edit-grid">

                <!-- LEFT -->
                <div class="form-card">
                    <h3><i class="fa-solid fa-lock"></i> Thông tin tài khoản</h3>

                    <div class="form-group">
                        <label>Tên đăng nhập</label>
                        <input type="text"
                               name="username"
                               id="usernameInput"
                               class="form-input"
                               value="${user.username}"
                               required>
                        <small id="usernameError" class="error-message"></small>
                    </div>

                    <div class="form-group">
                        <label>Vai trò</label>
                        <input type="text"
                               class="form-input"
                               value="${user.roleName}"
                               readonly>
                    </div>

                    <div class="form-group">
                        <label>Trạng thái</label>
                        <select name="status" id="statusInput" class="form-select">
                            <option value="true" ${user.status ? 'selected' : ''}>Đang hoạt động</option>
                            <option value="false" ${!user.status ? 'selected' : ''}>Đã khóa</option>
                        </select>
                    </div>

                    <div id="passwordArea" style="display: none; background: #f0f9ff; padding: 15px; border-radius: 12px; margin-top: 15px; border: 1px solid #bae6fd;">
                        <label style="display: block; font-size: 11px; font-weight: 800; color: #0369a1; text-transform: uppercase; margin-bottom: 8px;">Nhập mật khẩu mới</label>
                        <div style="display: flex; gap: 8px;">
                            <input type="password" id="newPasswordInput" class="form-input" style="background: white;" placeholder="Tối thiểu 6 ký tự">
                            <button type="button" class="btn-submit" style="padding: 10px 15px; height: 46px; white-space: nowrap;" onclick="submitUpdatePassword()">Cập nhật</button>
                        </div>
                        <small id="passError" class="error-message"></small>
                    </div>

                    <button type="button" class="btn-password" id="btnShowPass" onclick="togglePasswordArea()">
                        <i class="fa-solid fa-key"></i>
                        Đổi mật khẩu
                    </button>
                </div>

                <!-- RIGHT -->
                <div class="form-card">
                    <h3><i class="fa-solid fa-user-pen"></i> Thông tin hồ sơ</h3>

                    <c:if test="${user.roleName != 'ADMIN'}">
                        <div class="avatar-upload-box">
                            <div class="avatar-preview">
                                <c:choose>
                                    <c:when test="${not empty user.avatar and user.avatar != 'default-avatar.png'}">
                                        <img src="${pageContext.request.contextPath}/uploads/${user.avatar}"
                                             id="avatarPreviewImg"
                                             onerror="this.src='${pageContext.request.contextPath}/images/default-avatar.png'">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/images/default-avatar.png"
                                             id="avatarPreviewImg">
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <strong>Ảnh đại diện</strong>
                            <p style="font-size: 12px; color: #64748b;">Ảnh sẽ được lưu trong thư mục uploads</p>

                            <input type="hidden"
                                   name="avatar"
                                   id="avatarInput"
                                   value="${empty user.avatar ? 'default-avatar.png' : user.avatar}">

                            <input type="file"
                                   id="realAvatarInput"
                                   style="display: none;"
                                   accept="image/*">

                            <button type="button"
                                    class="btn-upload"
                                    onclick="document.getElementById('realAvatarInput').click()">
                                Tải ảnh lên
                            </button>
                        </div>
                    </c:if>

                    <div class="profile-grid-fields">

                        <c:if test="${user.roleName != 'ADMIN'}">
                            <div class="form-group">
                                <label>Họ tên</label>
                                <input type="text"
                                       name="fullName"
                                       class="form-input profile-field"
                                       value="${user.fullName}">
                            </div>
                        </c:if>

                        <c:if test="${user.roleName == 'TUTOR' || user.roleName == 'PARENT'}">
                            <div class="form-group">
                                <label>Số điện thoại</label>
                                <input type="text"
                                       name="phone"
                                       id="phoneInput"
                                       class="form-input profile-field"
                                       value="${user.phone}">
                                <small class="error-message"></small>
                            </div>

                            <div class="form-group">
                                <label>Email</label>
                                <input type="email"
                                       name="email"
                                       id="emailInput"
                                       class="form-input profile-field"
                                       value="${user.email}">
                                <small class="error-message"></small>
                            </div>
                        </c:if>

                        <c:if test="${user.roleName != 'ADMIN'}">
                            <div class="form-group">
                                <label>Ngày sinh</label>
                                <input type="date"
                                       name="dob"
                                       class="form-input"
                                       value="${user.dob}">
                            </div>

                            <div class="form-group">
                                <label>Giới tính</label>
                                <select name="gender" class="form-select">
                                    <option value="Nam" ${user.gender == 'Nam' ? 'selected' : ''}>Nam</option>
                                    <option value="Nữ" ${user.gender == 'Nữ' ? 'selected' : ''}>Nữ</option>
                                    <option value="Khác" ${user.gender == 'Khác' ? 'selected' : ''}>Khác</option>
                                </select>
                            </div>
                        </c:if>

                        <c:if test="${user.roleName == 'TUTOR' || user.roleName == 'PARENT'}">
                            <div class="form-group full-width">
                                <label>Địa chỉ</label>
                                <input type="text"
                                       name="address"
                                       class="form-input"
                                       value="${user.address}">
                            </div>
                        </c:if>

                        <c:if test="${user.roleName == 'TUTOR'}">
                            <div class="form-group">
                                <label>Trường học</label>
                                <input type="text"
                                       name="school"
                                       class="form-input"
                                       value="${user.school}">
                            </div>

                            <div class="form-group">
                                <label>Chuyên ngành</label>
                                <input type="text"
                                       name="major"
                                       class="form-input"
                                       value="${user.major}">
                            </div>

                            <div class="form-group full-width">
                                <label>Mô tả</label>
                                <textarea name="description"
                                          class="form-textarea"
                                          rows="4">${user.description}</textarea>
                            </div>
                        </c:if>

                        <c:if test="${user.roleName == 'STUDENT'}">
                            <div class="form-group full-width">
                                <label>Phụ huynh</label>
                                <select name="parentId" id="parentSelect" class="form-select profile-field">
                                    <option value="">-- Chọn phụ huynh --</option>
                                </select>
                                <small class="error-message"></small>
                            </div>

                            <div class="form-group">
                                <label>Trường học</label>
                                <input type="text"
                                       name="school"
                                       class="form-input"
                                       value="${user.school}">
                            </div>

                            <div class="form-group">
                                <label>Lớp</label>
                                <input type="text"
                                       name="grade"
                                       class="form-input"
                                       value="${user.grade}">
                            </div>

                            <div class="form-group full-width">
                                <label>Địa chỉ</label>
                                <input type="text"
                                       name="address"
                                       class="form-input"
                                       value="${user.address}">
                            </div>
                        </c:if>

                    </div>

                    <div id="formStatus" class="status-banner"></div>

                    <div class="footer-actions">
                        <a class="btn-back"
                           href="${pageContext.request.contextPath}/admin/users/${user.id}/detail">
                            Hủy
                        </a>

                        <button type="submit" class="btn-submit" id="btnSubmit">
                            Lưu thay đổi
                        </button>
                    </div>
                </div>
            </div>
        </form>

    </div>
</main>

<script>
    const contextPath = '${pageContext.request.contextPath}';
    const userId = '${user.id}';
    const roleName = '${user.roleName}';
    const originalEmail = '${empty user.email ? "" : user.email}';
    const originalPhone = '${empty user.phone ? "" : user.phone}';
    const currentParentUserId = '${empty user.parentUserId ? "" : user.parentUserId}';

    const editForm = document.getElementById('editForm');
    const formStatus = document.getElementById('formStatus');
    const btnSubmit = document.getElementById('btnSubmit');

    function showStatus(message, type) {
        formStatus.className = 'status-banner ' + type;
        formStatus.innerHTML = message;
        formStatus.style.display = 'flex';
    }

    function clearAllErrors() {
        document.querySelectorAll('.form-input, .form-select').forEach(el => {
            el.classList.remove('error');
        });

        document.querySelectorAll('.error-message').forEach(el => {
            el.textContent = '';
            el.classList.remove('active');
        });
    }

    function showFieldError(field, message) {
        field.classList.add('error');

        let errorEl = field.parentElement.querySelector('.error-message');

        if (!errorEl) {
            errorEl = document.createElement('small');
            errorEl.className = 'error-message';
            field.parentElement.appendChild(errorEl);
        }

        errorEl.textContent = message;
        errorEl.classList.add('active');
    }

    async function loadParents() {
        if (roleName !== 'STUDENT') return;

        const parentSelect = document.getElementById('parentSelect');
        if (!parentSelect) return;

        try {
            const res = await fetch(contextPath + '/api/admin/users/parents');
            const parents = await res.json();

            parentSelect.innerHTML = '<option value="">-- Chọn phụ huynh --</option>';

            parents.forEach(p => {
                const opt = document.createElement('option');
                opt.value = p.id;
                opt.textContent = (p.fullName || 'Chưa cập nhật tên') + ' - ' + (p.phone || 'Chưa có SĐT');

                if (String(p.id) === String(currentParentUserId)) {
                    opt.selected = true;
                }

                parentSelect.appendChild(opt);
            });
        } catch (e) {
            console.error('Không thể tải danh sách phụ huynh', e);
        }
    }

    async function checkEmailPhoneExists() {
        let hasError = false;

        const emailInput = document.getElementById('emailInput');
        const phoneInput = document.getElementById('phoneInput');

        if (emailInput && emailInput.value.trim() && emailInput.value.trim() !== originalEmail) {
            const email = emailInput.value.trim();

            try {
                const res = await fetch(contextPath + '/api/admin/users/exists-email?email=' + encodeURIComponent(email));
                const exists = await res.json();

                if (exists === true) {
                    showFieldError(emailInput, 'Email đã tồn tại');
                    hasError = true;
                }
            } catch (e) {
                showFieldError(emailInput, 'Không thể kiểm tra email');
                hasError = true;
            }
        }

        if (phoneInput && phoneInput.value.trim() && phoneInput.value.trim() !== originalPhone) {
            const phone = phoneInput.value.trim();

            try {
                const res = await fetch(contextPath + '/api/admin/users/exists-phone?phone=' + encodeURIComponent(phone));
                const exists = await res.json();

                if (exists === true) {
                    showFieldError(phoneInput, 'Số điện thoại đã tồn tại');
                    hasError = true;
                }
            } catch (e) {
                showFieldError(phoneInput, 'Không thể kiểm tra số điện thoại');
                hasError = true;
            }
        }

        return hasError;
    }

    const realAvatarInput = document.getElementById('realAvatarInput');
    const avatarPreviewImg = document.getElementById('avatarPreviewImg');
    const avatarInput = document.getElementById('avatarInput');

    if (realAvatarInput) {
        realAvatarInput.addEventListener('change', async function (e) {
            const file = e.target.files[0];
            if (!file) return;

            const reader = new FileReader();
            reader.onload = function (e) {
                avatarPreviewImg.src = e.target.result;
            };
            reader.readAsDataURL(file);

            const formData = new FormData();
            formData.append('file', file);

            try {
                const res = await fetch(contextPath + '/api/admin/users/upload-avatar', {
                    method: 'POST',
                    body: formData
                });

                const data = await res.json();

                if (!res.ok) {
                    alert(data.message || 'Upload ảnh thất bại');
                    return;
                }

                avatarInput.value = data.fileName;
                avatarPreviewImg.src = contextPath + '/uploads/' + data.fileName;
            } catch (e) {
                alert('Không thể upload ảnh');
            }
        });
    }

    editForm.addEventListener('submit', async function (e) {
        e.preventDefault();
        clearAllErrors();

        btnSubmit.disabled = true;
        showStatus('<i class="fa-solid fa-circle-notch fa-spin"></i> Đang kiểm tra thông tin...', 'success');

        const existsError = await checkEmailPhoneExists();

        if (existsError) {
            btnSubmit.disabled = false;
            formStatus.style.display = 'none';
            return;
        }

        const data = {
            username: document.getElementById('usernameInput').value.trim(),
            role: roleName,
            status: document.getElementById('statusInput').value === 'true'
        };

        document.querySelectorAll('#editForm [name]').forEach(field => {
            if (field.name === 'username' || field.name === 'status') return;

            let value = field.value;

            if (value === null || value === undefined || value === '') return;

            if (field.name === 'parentId') {
                data[field.name] = parseInt(value, 10);
            } else {
                data[field.name] = value;
            }
        });

        showStatus('<i class="fa-solid fa-circle-notch fa-spin"></i> Đang lưu thay đổi...', 'success');

        fetch(contextPath + '/api/admin/users/' + userId, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        })
            .then(r => r.json().then(json => ({ok: r.ok, json})))
            .then(res => {
                if (res.ok) {
                    showStatus('<i class="fa-solid fa-check-circle"></i> Cập nhật thành công! Đang chuyển hướng...', 'success');

                    setTimeout(() => {
                        window.location.href = contextPath + '/admin/users/' + userId + '/detail';
                    }, 1200);
                } else {
                    showStatus('<i class="fa-solid fa-circle-exclamation"></i> ' + (res.json.message || 'Cập nhật thất bại'), 'error');
                    btnSubmit.disabled = false;
                }
            })
            .catch(() => {
                showStatus('<i class="fa-solid fa-wifi"></i> Lỗi kết nối hệ thống', 'error');
                btnSubmit.disabled = false;
            });
    });

    function togglePasswordArea() {
        const area = document.getElementById('passwordArea');
        const btn = document.getElementById('btnShowPass');
        if (area.style.display === 'none') {
            area.style.display = 'block';
            btn.innerHTML = '<i class="fa-solid fa-xmark"></i> Hủy đổi mật khẩu';
            btn.style.background = '#f1f5f9';
            btn.style.color = '#475569';
        } else {
            area.style.display = 'none';
            btn.innerHTML = '<i class="fa-solid fa-key"></i> Đổi mật khẩu';
            btn.style.background = '#e0f2fe';
            btn.style.color = '#0284c7';
        }
    }

    async function submitUpdatePassword() {
        const passInput = document.getElementById('newPasswordInput');
        const passError = document.getElementById('passError');
        const newPassword = passInput.value.trim();

        if (newPassword.length < 6) {
            passInput.classList.add('error');
            passError.textContent = 'Mật khẩu phải có ít nhất 6 ký tự';
            passError.classList.add('active');
            return;
        }

        try {
            const res = await fetch(contextPath + '/api/admin/users/' + userId + '/update-password', {
                method: 'PATCH',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ password: newPassword })
            });

            const data = await res.json();

            if (res.ok) {
                alert('Cập nhật mật khẩu thành công!');
                passInput.value = '';
                togglePasswordArea();
            } else {
                alert(data.message || 'Cập nhật thất bại');
            }
        } catch (e) {
            alert('Lỗi kết nối hệ thống');
        }
    }

    loadParents();
</script>

</body>
</html>
