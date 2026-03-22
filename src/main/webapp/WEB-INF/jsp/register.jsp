<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>Đăng ký | Academic Atelier</title>
    <link href="assets/css/style.css" rel="stylesheet" />
</head>

<body>
    <!-- TopNavBar -->
    <header class="header">
        <div class="header-container">
            <a href="${pageContext.request.contextPath}/" class="logo">Academic Atelier</a>
            <nav class="nav-menu">
                <a class="nav-link" href="${pageContext.request.contextPath}/">Trang chủ</a>
                <a class="nav-link" href="#">Phụ huynh</a>
                <a class="nav-link" href="#">Gia sư</a>
                <a class="nav-link" href="#">Khóa học</a>
                <a class="nav-link" href="#">Tin tức</a>
            </nav>
            <div class="header-actions">
                <a href="${pageContext.request.contextPath}/login" class="btn btn-text">Đăng nhập</a>
                <a href="${pageContext.request.contextPath}/register" class="btn btn-primary">Đăng ký</a>
            </div>
        </div>
    </header>

    <!-- Main Content: Register Section -->
    <main class="login-main">
        <!-- Background Decoration -->
        <div class="register-bg-shapes">
            <div class="register-shape-1"></div>
            <div class="register-shape-2"></div>
        </div>
        
        <div class="login-grid">
            <!-- Left Side: Editorial Content -->
            <div class="register-editorial">
                <span class="section-subtitle">Chào mừng bạn</span>
                <h1 class="register-title">Tham gia cộng đồng Academic Atelier</h1>
                <p class="register-desc">
                    Nơi tri thức được vun đắp và tương lai được kiến tạo. Hãy chọn vai trò của bạn để bắt đầu hành trình.
                </p>
                <div class="register-info-box">
                    <div class="register-info-icon">
                        <span class="material-symbols-outlined">verified</span>
                    </div>
                    <div>
                        <p class="register-info-title">Chứng nhận uy tín</p>
                        <p class="register-info-desc">Hơn 5000+ gia sư được kiểm định.</p>
                    </div>
                </div>
            </div>
            
            <!-- Right Side: Registration Form -->
            <div class="register-form-box">
                <div class="register-ribbon"></div>
                
                <form class="login-form">
                    <!-- Role Selection -->
                    <div class="form-group">
                        <label class="form-label" style="text-transform: uppercase;">Tôi là...</label>
                        <div class="role-grid" style="grid-template-columns: repeat(2, 1fr); margin-top: 0.5rem;">
                            <button class="role-btn active" type="button">
                                <span class="material-symbols-outlined">family_restroom</span>
                                <span>Phụ huynh/Học sinh</span>
                            </button>
                            <button class="role-btn" type="button">
                                <span class="material-symbols-outlined">school</span>
                                <span>Gia sư</span>
                            </button>
                        </div>
                    </div>
                    
                    <!-- Fields -->
                    <div class="form-group">
                        <label class="form-label">Họ tên</label>
                        <input class="input-field" placeholder="Nguyễn Văn A" type="text" />
                    </div>
                    
                    <div class="grid-2-cols" style="margin-bottom: 1.5rem;">
                        <div>
                            <label class="form-label">Email</label>
                            <input class="input-field" placeholder="example@gmail.com" type="email" />
                        </div>
                        <div>
                            <label class="form-label">Số điện thoại</label>
                            <input class="input-field" placeholder="0901 234 567" type="tel" />
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Mật khẩu</label>
                        <input class="input-field" placeholder="••••••••" type="password" />
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Xác nhận mật khẩu</label>
                        <input class="input-field" placeholder="••••••••" type="password" />
                    </div>
                    
                    <div class="form-checkbox-row">
                        <input type="checkbox" id="terms" />
                        <label class="form-checkbox-text" for="terms">
                            Bằng cách đăng ký, tôi đồng ý với <a href="#">Điều khoản dịch vụ</a> và <a href="#">Chính sách bảo mật</a> của Academic Atelier.
                        </label>
                    </div>
                    
                    <button class="btn-login" style="margin-top: 1rem;" type="submit">Đăng ký thành viên</button>
                    
                    <div class="login-footer-text">
                        Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập</a>
                    </div>
                </form>
            </div>
        </div>
    </main>

    <!-- Section 6: Footer (Shared Component) -->
    <footer class="footer">
        <div class="footer-grid">
            <!-- Brand & Info -->
            <div>
                <span class="footer-brand">Academic Atelier</span>
                <p class="footer-desc">
                    Hệ thống quản lý và kết nối gia sư hàng đầu, mang đến giải pháp giáo dục toàn diện cho gia đình Việt.
                </p>
                <div class="social-links">
                    <a class="social-link" href="#">
                        <span class="material-symbols-outlined text-lg">public</span>
                    </a>
                    <a class="social-link" href="#">
                        <span class="material-symbols-outlined text-lg">mail</span>
                    </a>
                    <a class="social-link" href="#">
                        <span class="material-symbols-outlined text-lg">call</span>
                    </a>
                </div>
            </div>
            <!-- Links -->
            <div class="footer-links-container">
                <div>
                    <h4 class="footer-title">Thông tin</h4>
                    <ul class="footer-links">
                        <li><a class="footer-link" href="#">Về chúng tôi</a></li>
                        <li><a class="footer-link" href="#">Liên hệ</a></li>
                        <li><a class="footer-link" href="#">Hỗ trợ</a></li>
                    </ul>
                </div>
                <div>
                    <h4 class="footer-title">Hỗ trợ</h4>
                    <ul class="footer-links">
                        <li><a class="footer-link" href="#">FAQ</a></li>
                        <li><a class="footer-link" href="#">Chính sách bảo mật</a></li>
                        <li><a class="footer-link" href="#">Điều khoản sử dụng</a></li>
                    </ul>
                </div>
            </div>
            <!-- Newsletter -->
            <div>
                <h4 class="footer-title">Kết nối</h4>
                <p class="newsletter-desc">Đăng ký nhận để cập nhật những kiến thức giáo dục mới nhất.</p>
                <form class="newsletter-form">
                    <input class="newsletter-input" placeholder="Email của bạn" type="email" />
                    <button class="btn-send">
                        <span class="material-symbols-outlined">send</span>
                    </button>
                </form>
            </div>
        </div>
        <div class="footer-bottom">
            <p class="copyright">© 2024 Academic Atelier. Nâng tầm tri thức Việt.</p>
            <div class="footer-bottom-links">
                <a class="footer-bottom-link" href="#">Facebook</a>
                <a class="footer-bottom-link" href="#">LinkedIn</a>
                <a class="footer-bottom-link" href="#">YouTube</a>
            </div>
        </div>
    </footer>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const roleBtns = document.querySelectorAll('.role-btn');
            roleBtns.forEach(btn => {
                btn.addEventListener('click', () => {
                    roleBtns.forEach(b => b.classList.remove('active'));
                    btn.classList.add('active');
                });
            });
        });
    </script>
</body>
</html>
