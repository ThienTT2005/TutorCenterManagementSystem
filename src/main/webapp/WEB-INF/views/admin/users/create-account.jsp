<%@ page language="java" contentType="text/html; charset=UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
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

                    <form id="registrationForm" action="${pageContext.request.contextPath}/admin/users/create" method="POST">
                        <div class="registration-grid" style="grid-template-columns: 1fr; max-width: 600px; margin: 0 auto;">

                            <!-- Account Info -->
                            <div class="form-card" id="accountCard">
                                <h3><i class="fa-solid fa-lock"></i> Thông tin tài khoản</h3>

                                <c:if test="${not empty error}">
                                    <div class="status-banner error" style="display: flex; margin-bottom: 20px;">
                                        <i class="fa-solid fa-triangle-exclamation"></i>
                                        ${error}
                                    </div>
                                </c:if>

                                <div class="form-group">
                                    <label>Tên đăng nhập</label>
                                    <input type="text" name="username" id="usernameInput" class="form-input"
                                        placeholder="username123" value="${request.username}" required>
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
                                        <option value="" disabled ${empty request.role ? 'selected' : ''}>Chọn vai trò...</option>
                                        <option value="TUTOR" ${request.role == 'TUTOR' ? 'selected' : ''}>Gia sư</option>
                                        <option value="PARENT" ${request.role == 'PARENT' ? 'selected' : ''}>Phụ huynh</option>
                                        <option value="STUDENT" ${request.role == 'STUDENT' ? 'selected' : ''}>Học sinh</option>
                                        <option value="ADMIN" ${request.role == 'ADMIN' ? 'selected' : ''}>Quản trị viên</option>
                                    </select>
                                    <small id="roleError" class="error-message"></small>
                                </div>

                                <button type="submit" id="btnSubmit" class="btn-primary btn-submit"
                                    style="width: 100%; margin-top: 1rem;">
                                    Tạo tài khoản <i class="fa-solid fa-arrow-right" style="margin-left: 8px;"></i>
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </main>

            <script>
                const registrationForm = document.getElementById('registrationForm');
                const passwordInput = document.getElementById('password');
                const confirmPasswordInput = document.getElementById('confirmPassword');

                function setFieldError(id, message) {
                    const input = document.getElementById(id);
                    const errorEl = document.getElementById(id + 'Error');

                    if (input) input.classList.add('error');
                    if (errorEl) {
                        errorEl.textContent = message;
                        errorEl.classList.add('active');
                    }
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

                registrationForm.addEventListener('submit', function (e) {
                    clearAllErrors();
                    let hasError = false;

                    const password = passwordInput.value;
                    const confirmPassword = confirmPasswordInput.value;

                    if (password !== confirmPassword) {
                        setFieldError('confirmPassword', 'Mật khẩu xác nhận không khớp');
                        hasError = true;
                    }

                    if (hasError) {
                        e.preventDefault();
                    }
                });
            </script>
        </body>

        </html>
