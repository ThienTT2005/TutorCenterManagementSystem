<%@ page language="java" contentType="text/html; charset=UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Tạo Tài Khoản Mới | TCMS Admin</title>
            <link rel="stylesheet"
                href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0" />
            <link rel="stylesheet"
                href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0" />
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
            <link rel="stylesheet" href="<c:url value='/css/core-dashboard.css' />">
            <style>
                .create-account-container {
                    width: 100%;
                    margin: 0;
                    padding: 2.5rem;
                    box-sizing: border-box;
                }

                .page-header {
                    margin-bottom: 2.5rem;
                    border-bottom: 2px solid #f1f5f9;
                    padding-bottom: 1.5rem;
                }

                .page-header h1 {
                    font-size: 32px;
                    font-weight: 900;
                    color: var(--text-dark);
                    margin-bottom: 8px;
                    letter-spacing: -0.5px;
                }

                .page-header p {
                    color: var(--text-muted);
                    font-size: 16px;
                    font-weight: 500;
                }

                .registration-grid {
                    display: grid;
                    grid-template-columns: 420px 1fr;
                    gap: 2.5rem;
                    align-items: start;
                }

                @media (max-width: 1200px) {
                    .registration-grid {
                        grid-template-columns: 1fr;
                    }

                    .create-account-container {
                        padding: 1.5rem;
                    }
                }

                .form-card {
                    background: white;
                    border-radius: 24px;
                    padding: 2.5rem;
                    border: 1px solid var(--border-color);
                    box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05), 0 8px 10px -6px rgba(0, 0, 0, 0.05);
                    width: 100%;
                }

                .form-card h3 {
                    font-size: 18px;
                    font-weight: 800;
                    margin-bottom: 2rem;
                    display: flex;
                    align-items: center;
                    gap: 12px;
                    color: var(--primary);
                    text-transform: uppercase;
                    letter-spacing: 1px;
                }

                .form-group {
                    margin-bottom: 1.75rem;
                }

                .form-group label {
                    display: block;
                    font-size: 12px;
                    font-weight: 800;
                    color: #64748b;
                    text-transform: uppercase;
                    letter-spacing: 1px;
                    margin-bottom: 10px;
                }

                .form-input,
                .form-select,
                .form-textarea {
                    width: 100%;
                    padding: 14px 18px;
                    background: #f8fafc;
                    border: 1.5px solid var(--border-color);
                    border-radius: 12px;
                    font-size: 15px;
                    font-weight: 600;
                    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                    outline: none;
                    color: var(--text-dark);
                    box-sizing: border-box;
                }

                .form-input:focus,
                .form-select:focus,
                .form-textarea:focus {
                    border-color: var(--primary);
                    background: white;
                    box-shadow: 0 0 0 4px var(--primary-light);
                    transform: translateY(-1px);
                }

                .form-input.error,
                .form-select.error {
                    border-color: #ef4444 !important;
                    background-color: #fef2f2 !important;
                }

                .error-message {
                    color: #ef4444;
                    font-size: 12px;
                    font-weight: 600;
                    margin-top: 6px;
                    display: none;
                }

                .error-message.active {
                    display: block;
                    animation: fadeIn 0.2s ease-in;
                }

                @keyframes fadeIn {
                    from {
                        opacity: 0;
                        transform: translateY(-5px);
                    }

                    to {
                        opacity: 1;
                        transform: translateY(0);
                    }
                }

                .profile-section {
                    display: none;
                }

                .profile-section.active {
                    display: block;
                    animation: slideUp 0.4s cubic-bezier(0.4, 0, 0.2, 1);
                }

                @keyframes slideUp {
                    from {
                        opacity: 0;
                        transform: translateY(20px);
                    }

                    to {
                        opacity: 1;
                        transform: translateY(0);
                    }
                }

                .profile-grid-fields {
                    display: grid;
                    grid-template-columns: 1fr 1fr;
                    gap: 1.5rem 2rem;
                }

                @media (max-width: 768px) {
                    .profile-grid-fields {
                        grid-template-columns: 1fr;
                    }
                }

                .full-width {
                    grid-column: span 2;
                }

                @media (max-width: 768px) {
                    .full-width {
                        grid-column: span 1;
                    }
                }

                .avatar-upload-box {
                    background: #f1f5f9;
                    border: 2px dashed #cbd5e1;
                    border-radius: 20px;
                    padding: 3rem;
                    text-align: center;
                    margin-bottom: 2.5rem;
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                    gap: 16px;
                    transition: all 0.3s;
                }

                .avatar-upload-box:hover {
                    border-color: var(--primary);
                    background: var(--primary-light);
                }

                .avatar-preview {
                    width: 120px;
                    height: 120px;
                    border-radius: 28px;
                    background: white;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    color: #94a3b8;
                    font-size: 48px;
                    box-shadow: var(--shadow-sm);
                    position: relative;
                }

                .avatar-preview::after {
                    content: '\e3c9';
                    font-family: 'Material Symbols Rounded';
                    position: absolute;
                    bottom: -5px;
                    right: -5px;
                    width: 32px;
                    height: 32px;
                    background: white;
                    border-radius: 50%;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 18px;
                    box-shadow: var(--shadow-md);
                    color: var(--primary);
                }

                .btn-upload {
                    background: var(--primary);
                    color: white;
                    padding: 10px 24px;
                    border-radius: 12px;
                    font-size: 14px;
                    font-weight: 700;
                    cursor: pointer;
                    border: none;
                    box-shadow: 0 4px 12px rgba(2, 132, 199, 0.2);
                    transition: all 0.2s;
                }

                .btn-upload:hover {
                    background: #0369a1;
                    transform: scale(1.05);
                }

                .role-badge {
                    background: #e0f2fe;
                    color: #0369a1;
                    padding: 6px 16px;
                    border-radius: 12px;
                    font-size: 12px;
                    font-weight: 800;
                    text-transform: uppercase;
                    letter-spacing: 1px;
                }

                .footer-actions {
                    margin-top: 3rem;
                    display: flex;
                    justify-content: flex-end;
                    gap: 1.5rem;
                    padding-bottom: 2rem;
                }

                .btn-cancel {
                    background: #f1f5f9;
                    color: #64748b;
                    border: none;
                    font-weight: 800;
                    padding: 14px 28px;
                    border-radius: 14px;
                    cursor: pointer;
                    transition: all 0.2s;
                }

                .btn-cancel:hover {
                    background: #e2e8f0;
                    color: var(--text-dark);
                }

                .btn-submit {
                    padding: 14px 40px;
                    font-size: 16px;
                    font-weight: 800;
                    border-radius: 16px;
                    box-shadow: 0 4px 15px rgba(2, 132, 199, 0.3);
                }

                .status-banner {
                    margin-top: 1rem;
                    padding: 1rem 1.5rem;
                    border-radius: 12px;
                    font-size: 14px;
                    font-weight: 600;
                    display: none;
                    align-items: center;
                    gap: 10px;
                    animation: slideIn 0.3s ease-out;
                }

                .status-banner.error {
                    display: flex;
                    background: #fef2f2;
                    color: #b91c1c;
                    border: 1px solid #fecaca;
                }

                .status-banner.success {
                    display: flex;
                    background: #f0fdf4;
                    color: #15803d;
                    border: 1px solid #bbf7d0;
                }

                @keyframes slideIn {
                    from {
                        opacity: 0;
                        transform: translateY(-10px);
                    }

                    to {
                        opacity: 1;
                        transform: translateY(0);
                    }
                }
            </style>
        </head>

        <body>

            <c:set var="activePage" value="accounts" scope="request" />

            <jsp:include page="../common/sidebar.jsp" />

            <main class="main-content">
                <jsp:include page="../common/header.jsp" />

                <div class="create-account-container">
                    <div class="page-header">
                        <h1>Tạo Tài Khoản Mới</h1>
                        <p>Vui lòng điền đầy đủ thông tin để cấp quyền truy cập hệ thống.</p>
                    </div>

                    <form id="registrationForm">
                        <div class="registration-grid">

                            <!-- Left: Account Info -->
                            <div class="form-card" id="accountCard">
                                <h3><i class="fa-solid fa-lock"></i> Thông tin tài khoản</h3>

                                <div class="form-group">
                                    <label>Tên đăng nhập</label>
                                    <input type="text" name="username" id="usernameInput" class="form-input"
                                        placeholder="username123" required>
                                    <small id="usernameError" class="error-message"></small>
                                </div>

                                <div class="form-group">
                                    <label>Mật khẩu</label>
                                    <input type="password" name="password" id="password" class="form-input"
                                        placeholder="••••••••" required>
                                    <small id="passwordError" class="error-message"></small>
                                </div>

                                <div class="form-group">
                                    <label>Xác nhận mật khẩu</label>
                                    <input type="password" name="confirmPassword" id="confirmPassword"
                                        class="form-input" placeholder="••••••••" required>
                                    <small id="confirmPasswordError" class="error-message"></small>
                                </div>

                                <div class="form-group">
                                    <label>Vai trò</label>
                                    <select name="role" id="roleSelect" class="form-select" required>
                                        <option value="" disabled selected>Chọn vai trò...</option>
                                        <option value="TUTOR">Gia sư</option>
                                        <option value="PARENT">Phụ huynh</option>
                                        <option value="STUDENT">Học sinh</option>
                                        <option value="ADMIN">Quản trị viên</option>
                                    </select>
                                    <small id="roleError" class="error-message"></small>
                                </div>

                                <button type="button" id="btnContinue" class="btn-primary"
                                    style="width: 100%; padding: 14px; border-radius: 12px; border: none; cursor: pointer; font-weight: 800;">
                                    Tiếp tục hồ sơ <i class="fa-solid fa-arrow-right" style="margin-left: 8px;"></i>
                                </button>
                            </div>

                            <!-- Right: Profile Info -->
                            <div class="form-card" id="profileCard"
                                style="opacity: 0.5; pointer-events: none; transition: all 0.4s ease;">
                                <div
                                    style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
                                    <h3 style="margin-bottom: 0;"><i class="fa-solid fa-user-plus"></i> Thông tin hồ sơ
                                    </h3>
                                    <span id="activeRoleBadge" class="role-badge" style="display: none;">TUTOR</span>
                                </div>

                                <div id="emptyProfileState"
                                    style="text-align: center; padding: 4rem 2rem; color: var(--text-muted);">
                                    <i class="fa-solid fa-user-astronaut"
                                        style="font-size: 48px; margin-bottom: 1rem; display: block;"></i>
                                    <p>Vui lòng ấn "Tiếp tục" sau khi điền thông tin tài khoản.</p>
                                </div>

                                <div id="tutorProfile" class="profile-section">
                                    <div class="avatar-upload-box">
                                        <div class="avatar-preview">
                                            <img src="${pageContext.request.contextPath}/images/default-avatar.png"
                                                style="width: 100%; height: 100%; object-fit: cover; border-radius: 28px;"
                                                class="avatar-preview-img">
                                        </div>
                                        <div>
                                            <strong style="display: block; font-size: 14px; margin-bottom: 4px;">Ảnh đại diện</strong>
                                            <span style="font-size: 12px; color: var(--text-muted);">Mặc định: default-avatar.png</span>
                                        </div>
                                        <input type="hidden" name="avatar" value="default-avatar.png" class="avatar-hidden-input">
                                        <input type="file" class="real-avatar-input" style="display: none;" accept="image/*">
                                        <button type="button" class="btn-upload" onclick="this.parentElement.querySelector('.real-avatar-input').click()">Tải ảnh lên</button>
                                    </div>

                                    <div class="profile-grid-fields">
                                        <div class="form-group">
                                            <label>Họ tên <span style="color: red;">*</span></label>
                                            <input type="text" name="fullName" class="form-input profile-field"
                                                placeholder="Nguyễn Văn A">
                                        </div>
                                        <div class="form-group">
                                            <label>Số điện thoại <span style="color: red;">*</span></label>
                                            <input type="text" name="phone" class="form-input profile-field"
                                                placeholder="0901 234 567">
                                        </div>
                                        <div class="form-group">
                                            <label>Email <span style="color: red;">*</span></label>
                                            <input type="email" name="email" class="form-input profile-field"
                                                placeholder="tutor@example.com">
                                        </div>
                                        <div class="form-group">
                                            <label>Ngày sinh</label>
                                            <input type="date" name="dob" class="form-input">
                                        </div>
                                        <div class="form-group">
                                            <label>Giới tính</label>
                                            <select name="gender" class="form-select">
                                                <option value="Nam">Nam</option>
                                                <option value="Nữ">Nữ</option>
                                                <option value="Khác">Khác</option>
                                            </select>
                                        </div>
                                        <div class="form-group full-width">
                                            <label>Địa chỉ</label>
                                            <input type="text" name="address" class="form-input"
                                                placeholder="123 Đường ABC, Quận X, TP. HCM">
                                        </div>
                                        <div class="form-group">
                                            <label>Trường học</label>
                                            <input type="text" name="school" class="form-input"
                                                placeholder="Đại học Sư Phạm">
                                        </div>
                                        <div class="form-group">
                                            <label>Ngành học</label>
                                            <input type="text" name="major" class="form-input"
                                                placeholder="Sư phạm Toán học">
                                        </div>
                                        <div class="form-group full-width">
                                            <label>Mô tả bản thân</label>
                                            <textarea name="description" class="form-textarea" rows="4"
                                                placeholder="Giới thiệu ngắn về kinh nghiệm giảng dạy..."></textarea>
                                        </div>
                                    </div>
                                </div>

                                <div id="parentProfile" class="profile-section">
                                    <div class="avatar-upload-box">
                                        <div class="avatar-preview">
                                            <img src="${pageContext.request.contextPath}/images/default-avatar.png"
                                                style="width: 100%; height: 100%; object-fit: cover; border-radius: 28px;"
                                                class="avatar-preview-img">
                                        </div>
                                        <div>
                                            <strong style="display: block; font-size: 14px; margin-bottom: 4px;">Ảnh đại diện</strong>
                                            <span style="font-size: 12px; color: var(--text-muted);">Ảnh sẽ được lưu vào thư mục uploads</span>
                                        </div>
                                        <input type="hidden" name="avatar" value="default-avatar.png" class="avatar-hidden-input">
                                        <input type="file" class="real-avatar-input" style="display: none;" accept="image/*">
                                        <button type="button" class="btn-upload" onclick="this.parentElement.querySelector('.real-avatar-input').click()">Tải ảnh lên</button>
                                    </div>
                                    <div class="profile-grid-fields">
                                        <div class="form-group">
                                            <label>Họ tên phụ huynh <span style="color: red;">*</span></label>
                                            <input type="text" name="fullName" class="form-input profile-field"
                                                placeholder="Nguyễn Văn B">
                                        </div>
                                        <div class="form-group">
                                            <label>Số điện thoại <span style="color: red;">*</span></label>
                                            <input type="text" name="phone" class="form-input profile-field"
                                                placeholder="0912 345 678">
                                        </div>
                                        <div class="form-group">
                                            <label>Email <span style="color: red;">*</span></label>
                                            <input type="email" name="email" class="form-input profile-field"
                                                placeholder="parent@example.com">
                                        </div>
                                        <div class="form-group">
                                            <label>Ngày sinh</label>
                                            <input type="date" name="dob" class="form-input">
                                        </div>
                                        <div class="form-group">
                                            <label>Giới tính</label>
                                            <select name="gender" class="form-select">
                                                <option value="Nam">Nam</option>
                                                <option value="Nữ">Nữ</option>
                                            </select>
                                        </div>
                                        <div class="form-group full-width">
                                            <label>Địa chỉ thường trú</label>
                                            <input type="text" name="address" class="form-input"
                                                placeholder="456 Đường XYZ, Quận Y, TP. HCM">
                                        </div>
                                    </div>
                                </div>

                                <div id="studentProfile" class="profile-section">
                                    <div class="avatar-upload-box">
                                        <div class="avatar-preview">
                                            <img src="${pageContext.request.contextPath}/images/default-avatar.png"
                                                style="width: 100%; height: 100%; object-fit: cover; border-radius: 28px;"
                                                class="avatar-preview-img">
                                        </div>
                                        <div>
                                            <strong style="display: block; font-size: 14px; margin-bottom: 4px;">Ảnh đại diện</strong>
                                            <span style="font-size: 12px; color: var(--text-muted);">Ảnh sẽ được lưu vào thư mục uploads</span>
                                        </div>
                                        <input type="hidden" name="avatar" value="default-avatar.png" class="avatar-hidden-input">
                                        <input type="file" class="real-avatar-input" style="display: none;" accept="image/*">
                                        <button type="button" class="btn-upload" onclick="this.parentElement.querySelector('.real-avatar-input').click()">Tải ảnh lên</button>
                                    </div>
                                    <div class="profile-grid-fields">
                                        <div class="form-group full-width">
                                            <label>Tìm phụ huynh giám hộ <span style="color: red;">*</span></label>
                                            <div style="position: relative; margin-bottom: 10px;">
                                                <input type="text" id="parentSearch" class="form-input"
                                                    placeholder="Nhập tên hoặc SĐT để tìm..."
                                                    style="padding-left: 40px;">
                                                <i class="fa-solid fa-search"
                                                    style="position: absolute; left: 15px; top: 50%; transform: translateY(-50%); color: #94a3b8;"></i>
                                            </div>
                                            <select name="parentId" id="parentSelect" class="form-select profile-field">
                                                <option value="">-- Danh sách phụ huynh --</option>
                                            </select>
                                            <small id="parentIdError" class="error-message"></small>
                                        </div>

                                        <div class="form-group full-width">
                                            <label>Họ tên học sinh <span style="color: red;">*</span></label>
                                            <input type="text" name="fullName" class="form-input profile-field"
                                                placeholder="Nguyễn Văn C">
                                            <small id="fullNameError" class="error-message"></small>
                                        </div>

                                        <div class="form-group">
                                            <label>Ngày sinh</label>
                                            <input type="date" name="dob" class="form-input">
                                        </div>

                                        <div class="form-group">
                                            <label>Giới tính</label>
                                            <select name="gender" class="form-select">
                                                <option value="Nam">Nam</option>
                                                <option value="Nữ">Nữ</option>
                                                <option value="Khác">Khác</option>
                                            </select>
                                        </div>

                                        <div class="form-group">
                                            <label>Trường học</label>
                                            <input type="text" name="school" class="form-input"
                                                placeholder="VD: THPT Lê Hồng Phong">
                                        </div>

                                        <div class="form-group">
                                            <label>Lớp</label>
                                            <input type="text" name="grade" class="form-input" placeholder="VD: 10A1">
                                        </div>

                                        <div class="form-group full-width">
                                            <label>Địa chỉ</label>
                                            <input type="text" name="address" class="form-input"
                                                placeholder="Nhập địa chỉ học sinh">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="footer-actions" id="submitActions"
                            style="opacity: 0; pointer-events: none; transition: all 0.4s ease;">
                            <div style="flex-grow: 1;">
                                <div id="formStatus" class="status-banner"></div>
                            </div>
                            <button type="button" class="btn-cancel" onclick="window.location.reload()">Làm lại</button>
                            <button type="submit" class="btn-submit btn-primary" id="btnSubmit">
                                Tạo hồ sơ
                            </button>
                        </div>
                    </form>
                </div>
            </main>

            <script>
                const roleSelect = document.getElementById('roleSelect');
                const usernameInput = document.getElementById('usernameInput');
                const btnContinue = document.getElementById('btnContinue');
                const profileCard = document.getElementById('profileCard');
                const submitActions = document.getElementById('submitActions');
                const registrationForm = document.getElementById('registrationForm');
                const emptyState = document.getElementById('emptyProfileState');
                const badge = document.getElementById('activeRoleBadge');

                const sections = {
                    'TUTOR': document.getElementById('tutorProfile'),
                    'PARENT': document.getElementById('parentProfile'),
                    'STUDENT': document.getElementById('studentProfile'),
                    'ADMIN': null
                };

                const parentSelect = document.getElementById('parentSelect');
                const parentSearch = document.getElementById('parentSearch');
                let allParents = [];

                async function loadParents() {
                    if (allParents.length > 0) return;
                    try {
                        const r = await fetch(`${pageContext.request.contextPath}/api/admin/users/parents`);
                        allParents = await r.json();
                        renderParents(allParents);
                    } catch (err) {
                        console.error("Failed to load parents", err);
                    }
                }

                function renderParents(list) {
                    parentSelect.innerHTML = '<option value="">-- Danh sách phụ huynh (' + list.length + ') --</option>';
                    list.forEach(p => {
                        const opt = document.createElement('option');
                        opt.value = p.id;
                        const name = p.fullName ? p.fullName : ('Chưa cập nhật tên (ID: ' + p.id + ')');
                        const phone = p.phone ? p.phone : 'Chưa có SĐT';
                        opt.textContent = name + ' - ' + phone;
                        parentSelect.appendChild(opt);
                    });
                }

                if (parentSearch) {
                    parentSearch.addEventListener('input', function (e) {
                        const term = e.target.value.toLowerCase();
                        const filtered = allParents.filter(p => {
                            const n = p.fullName ? p.fullName.toLowerCase() : '';
                            const ph = p.phone ? p.phone.toLowerCase() : '';
                            return n.includes(term) || ph.includes(term);
                        });
                        renderParents(filtered);
                    });

                    // Ngăn chặn nhấn Enter làm submit form khi đang tìm kiếm phụ huynh
                    parentSearch.addEventListener('keydown', function (e) {
                        if (e.key === 'Enter') {
                            e.preventDefault();
                        }
                    });
                }

                function setFieldError(id, message) {
                    const input = document.getElementById(id) || document.querySelector(`[name="${id}"]`);
                    const errorEl = document.getElementById(id + 'Error') || (input ? input.parentElement.querySelector('.error-message') : null);

                    if (input) input.classList.add('error');
                    if (errorEl) {
                        errorEl.textContent = message;
                        errorEl.classList.add('active');
                    }
                }

                function clearAllErrors() {
                    document.querySelectorAll('.form-input, .form-select, .profile-field').forEach(el => {
                        el.classList.remove('error');
                        el.style.borderColor = '';
                        el.style.backgroundColor = '';
                    });

                    document.querySelectorAll('.error-message, .field-error').forEach(el => {
                        el.textContent = '';
                        el.classList.remove('active');
                        if (el.classList.contains('field-error')) el.remove();
                    });
                }

                btnContinue.addEventListener('click', async function () {
                    clearAllErrors();

                    const username = usernameInput.value.trim();
                    const password = document.getElementById('password').value;
                    const confirmPassword = document.getElementById('confirmPassword').value;
                    const role = roleSelect.value;

                    let hasError = false;

                    if (!username) {
                        setFieldError('usernameInput', 'Vui lòng nhập tên đăng nhập');
                        hasError = true;
                    }
                    if (!password) {
                        setFieldError('password', 'Vui lòng nhập mật khẩu');
                        hasError = true;
                    }
                    if (!confirmPassword) {
                        setFieldError('confirmPassword', 'Vui lòng xác nhận mật khẩu');
                        hasError = true;
                    } else if (password !== confirmPassword) {
                        setFieldError('confirmPassword', 'Mật khẩu xác nhận không khớp');
                        hasError = true;
                    }
                    if (!role) {
                        setFieldError('roleSelect', 'Vui lòng chọn vai trò');
                        hasError = true;
                    }

                    if (hasError) return;


                    try {
                        btnContinue.disabled = true;
                        const originalText = btnContinue.innerHTML;
                        btnContinue.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Đang kiểm tra...';

                        const response = await fetch(`${pageContext.request.contextPath}/api/admin/users/exists/` + username);
                        if (!response.ok) throw new Error('System error');
                        const exists = await response.json();

                        if (exists === true) {
                            setFieldError('usernameInput', 'Username đã tồn tại, vui lòng chọn tên khác');
                            btnContinue.disabled = false;
                            btnContinue.innerHTML = originalText;
                            return;
                        }

                        revealProfile(role);
                    } catch (err) {
                        console.error(err);
                        setFieldError('usernameInput', 'Không thể kết nối với hệ thống. Vui lòng thử lại.');
                        btnContinue.disabled = false;
                        btnContinue.innerHTML = 'Tiếp tục hồ sơ <i class="fa-solid fa-arrow-right"></i>';
                    }
                });

                document.querySelectorAll('.real-avatar-input').forEach(input => {
                    input.addEventListener('change', async function(e) {
                        const file = e.target.files[0];
                        if (!file) return;

                        const box = this.closest('.avatar-upload-box');
                        const previewImg = box.querySelector('.avatar-preview-img');
                        const hiddenInput = box.querySelector('.avatar-hidden-input');
                        const uploadBtn = box.querySelector('.btn-upload');

                        // 1. Show local preview
                        const reader = new FileReader();
                        reader.onload = function(e) {
                            previewImg.src = e.target.result;
                        };
                        reader.readAsDataURL(file);

                        // 2. Upload to server
                        try {
                            uploadBtn.disabled = true;
                            uploadBtn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Đang tải...';

                            const formData = new FormData();
                            formData.append('file', file);

                            const response = await fetch(`${pageContext.request.contextPath}/api/admin/users/upload-avatar`, {
                                method: 'POST',
                                body: formData
                            });

                            if (!response.ok) throw new Error('Upload failed');

                            const resData = await response.json();
                            hiddenInput.value = resData.fileName; // Update hidden input with new filename
                            
                            // Update preview to use the official /uploads/ path
                            previewImg.src = `${pageContext.request.contextPath}/uploads/` + resData.fileName;

                            uploadBtn.innerHTML = '<i class="fa-solid fa-check"></i> Đã tải lên';
                            uploadBtn.style.background = '#10b981';
                        } catch (err) {
                            console.error(err);
                            alert("Không thể tải ảnh lên. Vui lòng thử lại.");
                            uploadBtn.innerHTML = 'Thử lại';
                            uploadBtn.style.background = '#ef4444';
                        } finally {
                            uploadBtn.disabled = false;
                        }
                    });
                });

                function revealProfile(role) {
                    profileCard.style.opacity = '1';
                    profileCard.style.pointerEvents = 'all';
                    submitActions.style.opacity = '1';
                    submitActions.style.pointerEvents = 'all';

                    usernameInput.readOnly = true;
                    document.getElementById('password').readOnly = true;
                    document.getElementById('confirmPassword').readOnly = true;
                    roleSelect.disabled = true;
                    btnContinue.disabled = true;
                    btnContinue.style.background = '#e2e8f0';
                    btnContinue.style.color = '#94a3b8';
                    btnContinue.innerHTML = '<i class="fa-solid fa-check"></i> Đã xác thực tài khoản';

                    Object.values(sections).forEach(s => s ? s.classList.remove('active') : null);
                    emptyState.style.display = 'none';

                    if (sections[role]) {
                        sections[role].classList.add('active');
                        badge.style.display = 'block';
                        badge.textContent = role;
                        if (role === 'STUDENT') loadParents();
                    } else if (role === 'ADMIN') {
                        badge.style.display = 'block';
                        badge.textContent = role;
                        emptyState.style.display = 'block';
                        emptyState.innerHTML = '<i class="fa-solid fa-user-shield" style="font-size: 48px; margin-bottom: 1rem; display: block;"></i><p>Tài khoản Admin không cần nhập hồ sơ chi tiết.</p>';
                    }
                }

                registrationForm.addEventListener('submit', async function (e) {
                    e.preventDefault();
                    clearAllErrors();

                    const activeRole = roleSelect.value;
                    const activeSection = sections[activeRole];
                    let hasError = false;

                    if (activeSection) {
                        const requiredFields = activeSection.querySelectorAll('.profile-field');
                        requiredFields.forEach(field => {
                            if (!field.value.trim()) {
                                field.classList.add('error');
                                let errorEl = field.parentElement.querySelector('.error-message');
                                if (!errorEl) {
                                    errorEl = document.createElement('small');
                                    errorEl.className = 'error-message active';
                                    field.parentElement.appendChild(errorEl);
                                }
                                errorEl.textContent = 'Trường này là bắt buộc';
                                errorEl.classList.add('active');
                                hasError = true;
                            }
                        });
                    }

                    if (hasError) return;

                    const formStatus = document.getElementById('formStatus');
                    const btnSubmit = document.getElementById('btnSubmit');

                    formStatus.className = 'status-banner';
                    formStatus.innerHTML = '<i class="fa-solid fa-circle-notch fa-spin"></i> Đang kiểm tra thông tin...';
                    formStatus.classList.add('success');
                    formStatus.style.display = 'flex';
                    btnSubmit.disabled = true;

                    const existsError = await checkEmailPhoneExists(activeSection);
                    if (existsError) {
                        btnSubmit.disabled = false;
                        formStatus.style.display = 'none';
                        return;
                    }

                    formStatus.innerHTML = '<i class="fa-solid fa-circle-notch fa-spin"></i> Đang xử lý tạo hồ sơ...';

                    const data = {
                        username: document.querySelector('[name="username"]').value.trim(),
                        password: document.querySelector('[name="password"]').value,
                        role: roleSelect.value,
                        avatar: activeSection ? (activeSection.querySelector('.avatar-hidden-input')?.value || 'default-avatar.png') : 'default-avatar.png'
                    };

                    if (activeSection) {
                        const activeFields = activeSection.querySelectorAll('[name]');
                        activeFields.forEach(field => {
                            const key = field.name;
                            let value = field.value;

                            if (value === null || value === undefined || value === '') return;

                            if (key === 'parentId') {
                                data[key] = parseInt(value, 10);
                            } else {
                                data[key] = value;
                            }
                        });
                    }

                    fetch('${pageContext.request.contextPath}/api/admin/users/create-account', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify(data)
                    })
                        .then(r => r.json().then(json => ({ ok: r.ok, json })))
                        .then(res => {
                            if (res.ok) {
                                formStatus.className = 'status-banner success';
                                formStatus.innerHTML = '<i class="fa-solid fa-check-circle"></i> Tài khoản và hồ sơ đã được tạo thành công! Đang chuyển hướng...';
                                setTimeout(() => {
                                    window.location.href = '${pageContext.request.contextPath}/admin/accounts';
                                }, 2000);
                            } else {
                                formStatus.className = 'status-banner error';
                                formStatus.innerHTML = '<i class="fa-solid fa-circle-exclamation"></i> ' + (res.json.message || 'Không thể tạo tài khoản');
                                btnSubmit.disabled = false;
                            }
                        })
                        .catch(err => {
                            formStatus.className = 'status-banner error';
                            formStatus.innerHTML = '<i class="fa-solid fa-wifi"></i> Lỗi kết nối hệ thống. Vui lòng kiểm tra lại.';
                            btnSubmit.disabled = false;
                        });
                });
                async function checkEmailPhoneExists(activeSection) {
                    if (!activeSection) return false;
                    let hasError = false;

                    const emailInput = activeSection.querySelector('[name="email"]');
                    const phoneInput = activeSection.querySelector('[name="phone"]');

                    if (emailInput && emailInput.value.trim()) {
                        const email = emailInput.value.trim();
                        try {
                            const res = await fetch(`${pageContext.request.contextPath}/api/admin/users/exists-email?email=` + encodeURIComponent(email));
                            const exists = await res.json();

                            if (exists === true) {
                                showFieldError(emailInput, 'Email đã tồn tại');
                                hasError = true;
                            }
                        } catch (e) {
                            console.error("Error checking email existence", e);
                        }
                    }

                    if (phoneInput && phoneInput.value.trim()) {
                        const phone = phoneInput.value.trim();
                        try {
                            const res = await fetch(`${pageContext.request.contextPath}/api/admin/users/exists-phone?phone=` + encodeURIComponent(phone));
                            const exists = await res.json();

                            if (exists === true) {
                                showFieldError(phoneInput, 'Số điện thoại đã tồn tại');
                                hasError = true;
                            }
                        } catch (e) {
                            console.error("Error checking phone existence", e);
                        }
                    }

                    return hasError;
                }

                function showFieldError(field, message) {
                    field.classList.add('error');

                    let errorEl = field.parentElement.querySelector('.error-message');

                    if (!errorEl) {
                        errorEl = document.createElement('small');
                        errorEl.className = 'error-message active';
                        field.parentElement.appendChild(errorEl);
                    }

                    errorEl.textContent = message;
                    errorEl.classList.add('active');
                }
            </script>
        </body>

        </html>