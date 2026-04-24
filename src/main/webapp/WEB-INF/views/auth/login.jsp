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
                        <a href="${pageContext.request.contextPath}/forgot-password" class="forgot-link">Quên mật khẩu?</a>
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

    <script src="${pageContext.request.contextPath}/js/auth/login.js"></script>
</body>
</html>