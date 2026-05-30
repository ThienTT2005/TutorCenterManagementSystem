<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập | TCMS</title>

    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth/login.css">
</head>
<body>
<div class="login-page">

    <!-- Left Panel -->
    <section class="login-left">
        <div class="left-content">
            <div class="brand">
                <div class="brand-logo">
                    <span class="material-symbols-outlined">school</span>
                </div>
                <div class="brand-text">
                    <h2>TCMS</h2>
                    <p>Tutor Center Management System</p>
                </div>
            </div>

            <div class="hero-text">
                <h1>
                    Quản lý dễ dàng
                    <span>Hiệu quả vượt trội</span>
                </h1>
                <p>
                    Kết nối Trung tâm - Gia sư - Phụ huynh. Theo dõi tiến độ, quản lý lớp học
                    và thanh toán minh bạch trong một hệ thống duy nhất.
                </p>
            </div>

            <div class="feature-grid">
                <div class="feature-card">
                    <div class="feature-icon">
                        <span class="material-symbols-outlined">groups</span>
                    </div>
                    <span>Phân quyền linh hoạt</span>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">
                        <span class="material-symbols-outlined">trending_up</span>
                    </div>
                    <span>Theo dõi học tập</span>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">
                        <span class="material-symbols-outlined">account_balance_wallet</span>
                    </div>
                    <span>Quản lý thanh toán</span>
                </div>
            </div>


        </div>
    </section>

    <!-- Right Panel -->
    <main class="login-right">
        <div class="mobile-brand">
            <div class="brand-logo">
                <span class="material-symbols-outlined">school</span>
            </div>
            <h2>TCMS</h2>
            <p>Đăng nhập để tiếp tục</p>
        </div>

        <div class="login-card">
            <h2>Đăng nhập hệ thống</h2>

            <!-- lỗi backend -->
            <%
                String errorAttr = (String) request.getAttribute("error");
                String errorParam = request.getParameter("error");
                boolean hasError = (errorAttr != null) || (errorParam != null);
                String errorMessage = "Sai tài khoản hoặc mật khẩu";
                if (errorAttr != null && !errorAttr.trim().isEmpty()) {
                    errorMessage = errorAttr;
                } else if (errorParam != null && !errorParam.trim().isEmpty()) {
                    errorMessage = errorParam;
                }
            %>
            <div id="errorAlert" class="error-alert <%= hasError ? "" : "hidden" %>">
                <span class="material-symbols-outlined">error</span>
                <p><%= errorMessage %></p>
            </div>

            <form id="loginForm" action="${pageContext.request.contextPath}/login" method="post">
                <div class="form-group">
                    <label for="username">Tên đăng nhập</label>
                    <div class="input-wrap">
                        <span class="material-symbols-outlined input-icon">person</span>
                        <input
                                type="text"
                                id="username"
                                name="username"
                                placeholder="Nhập username"
                                autocomplete="username"
                                required>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label-row">
                        <label for="password">Mật khẩu</label>
                        <a href="javascript:void(0)" id="forgotPasswordLink" class="forgot-link">
                            Quên mật khẩu?
                        </a>
                    </div>

                    <div class="input-wrap">
                        <span class="material-symbols-outlined input-icon">lock</span>
                        <input
                                type="password"
                                id="password"
                                name="password"
                                placeholder="••••••••"
                                autocomplete="current-password"
                                required>
                        <button type="button" id="togglePassword" class="toggle-password" aria-label="Hiện mật khẩu">
                            <span class="material-symbols-outlined" id="eyeIcon">visibility</span>
                        </button>
                    </div>
                    <div id="forgotPasswordNotice" class="forgot-password-notice hidden">
                        <span class="material-symbols-outlined">support_agent</span>
                        <p>
                            Vui lòng liên hệ hotline:
                            <strong>0000000000</strong>
                            để được tư vấn và hỗ trợ lấy lại mật khẩu.
                        </p>
                    </div>
                </div>

                <div class="remember-row">
                    <label class="remember-me">
                        <input type="checkbox" id="rememberMe">
                        <span>Nhớ tài khoản</span>
                    </label>
                </div>

                <button type="submit" id="submitBtn" class="login-btn">
                    <span id="btnText">Đăng nhập</span>
                    <span id="btnLoader" class="loader hidden"></span>
                </button>
            </form>

            <div class="request-account">
                <p>Bạn chưa có tài khoản?</p>
                <button type="button" id="contactBtn" class="secondary-btn">Liên hệ để được tư vấn thêm </button>
            </div>
        </div>

        <footer class="login-footer">
            <p>© 2024 TCMS. All rights reserved.</p>
            <div class="footer-links">
                <a href="#">Bảo mật</a>
                <a href="#">Điều khoản</a>
                <a href="#">Trợ giúp</a>
            </div>
        </footer>
    </main>
</div>

    <script>
        const contextPath = "${pageContext.request.contextPath}";
        const loginForm = document.getElementById('loginForm');
        const usernameInput = document.getElementById('username');
        const passwordInput = document.getElementById('password');
        const togglePassword = document.getElementById('togglePassword');
        const eyeIcon = document.getElementById('eyeIcon');
        const rememberMe = document.getElementById('rememberMe');
        const errorAlert = document.getElementById('errorAlert');

        // 1. Show/Hide Password Logic
        if (togglePassword) {
            togglePassword.addEventListener('click', function () {
                const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
                passwordInput.setAttribute('type', type);
                eyeIcon.textContent = type === 'password' ? 'visibility' : 'visibility_off';
            });
        }

        // 2. Forgot Password → Show Hotline Notice
        const forgotPasswordLink = document.getElementById('forgotPasswordLink');
        const forgotPasswordNotice = document.getElementById('forgotPasswordNotice');
        if (forgotPasswordLink && forgotPasswordNotice) {
            forgotPasswordLink.addEventListener('click', function (e) {
                e.preventDefault();
                const isHidden = forgotPasswordNotice.classList.contains('hidden');
                if (isHidden) {
                    forgotPasswordNotice.classList.remove('hidden');
                } else {
                    forgotPasswordNotice.classList.add('hidden');
                }
            });
        }

        // 2. Load Saved Credentials from LocalStorage
        window.addEventListener('DOMContentLoaded', () => {
            const savedUsername = localStorage.getItem('tcms_username');
            const savedPassword = localStorage.getItem('tcms_password');
            
            if (savedUsername && savedPassword) {
                usernameInput.value = savedUsername;
                passwordInput.value = savedPassword;
                rememberMe.checked = true;
            }
        });

        // 3. Handle Form Submit (Validation & Save Credentials)
        loginForm.addEventListener('submit', function (event) {
            const username = usernameInput.value.trim();
            const password = passwordInput.value.trim();

            if (errorAlert) {
                errorAlert.classList.add('hidden');
            }

            // Save or remove credentials based on checkbox
            if (rememberMe.checked) {
                localStorage.setItem('tcms_username', username);
                localStorage.setItem('tcms_password', password);
            } else {
                localStorage.removeItem('tcms_username');
                localStorage.removeItem('tcms_password');
            }

            if (username === '' || password === '') {
                event.preventDefault();
                if (errorAlert) {
                    errorAlert.classList.remove('hidden');
                    errorAlert.querySelector('p').textContent = 'Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu.';
                }
                return;
            }
            
            // Show loader if exists
            const btnText = document.getElementById('btnText');
            const btnLoader = document.getElementById('btnLoader');
            if (btnText && btnLoader) {
                btnText.classList.add('hidden');
                btnLoader.classList.remove('hidden');
            }
        });
    </script>

</body>
</html>
