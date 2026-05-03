<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đổi mật khẩu | TCMS Admin</title>
    <!-- Use Google Material Symbols Rounded for icons -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/core-dashboard.css">
    <style>
        .form-container {
            max-width: 500px;
            margin: 2rem auto;
            background: white;
            padding: 2.5rem;
            border-radius: var(--radius-xl);
            border: 1px solid var(--border-color);
            box-shadow: var(--shadow-md);
        }
        
        .form-header {
            text-align: center;
            margin-bottom: 2.5rem;
        }
        
        .form-header .icon-box {
            width: 60px;
            height: 60px;
            background: var(--primary-light);
            color: var(--primary);
            border-radius: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            margin: 0 auto 1rem;
        }
        
        .form-header h2 {
            font-size: 22px;
            font-weight: 800;
            color: var(--text-dark);
        }
        
        .form-header p {
            font-size: 14px;
            color: var(--text-muted);
            margin-top: 4px;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-group label {
            display: block;
            font-size: 12px;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 8px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .input-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }
        
        .input-wrapper i {
            position: absolute;
            left: 16px;
            color: var(--text-muted);
            font-size: 14px;
        }
        
        .form-input {
            width: 100%;
            padding: 12px 16px 12px 45px;
            background: var(--bg-page);
            border: 1px solid var(--border-color);
            border-radius: var(--radius-md);
            font-size: 14px;
            font-weight: 500;
            transition: all 0.2s ease;
            outline: none;
        }
        
        .form-input:focus {
            border-color: var(--primary);
            background: white;
            box-shadow: 0 0 0 4px var(--primary-light);
        }
        
        .pwd-toggle {
            position: absolute;
            right: 16px;
            background: none;
            border: none;
            color: var(--text-muted);
            cursor: pointer;
            padding: 0;
            display: flex;
            align-items: center;
        }
        
        .submit-btn {
            width: 100%;
            margin-top: 1rem;
        }
        
        .alert {
            padding: 12px 16px;
            border-radius: var(--radius-md);
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 1.5rem;
            display: none;
            align-items: center;
            gap: 10px;
        }
        
        .alert-success {
            background: var(--success-light);
            color: var(--success);
            border: 1px solid rgba(22, 163, 74, 0.2);
        }
        
        .alert-error {
            background: var(--danger-light);
            color: var(--danger);
            border: 1px solid rgba(220, 38, 38, 0.2);
        }
    </style>
</head>
<body>

    <c:set var="activePage" value="profile" scope="request" />

    <jsp:include page="../common/sidebar.jsp" />

    <main class="main-content">
        <jsp:include page="../common/header.jsp" />

        <div class="profile-container">
            <div class="form-container">
                <div class="form-header">
                    <div class="icon-box">
                        <i class="fa-solid fa-lock-open"></i>
                    </div>
                    <h2>Đổi mật khẩu</h2>
                    <p>Cập nhật mật khẩu mới để bảo mật tài khoản của bạn.</p>
                </div>

                <div id="alertMessage" class="alert"></div>

                <form id="changePasswordForm">
                    <div class="form-group">
                        <label>Mật khẩu hiện tại</label>
                        <div class="input-wrapper">
                            <i class="fa-solid fa-shield"></i>
                            <input type="password" id="currentPassword" class="form-input" placeholder="Nhập mật khẩu cũ" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Mật khẩu mới</label>
                        <div class="input-wrapper">
                            <i class="fa-solid fa-key"></i>
                            <input type="password" id="newPassword" class="form-input" placeholder="Tối thiểu 6 ký tự" required minlength="6">
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Xác nhận mật khẩu mới</label>
                        <div class="input-wrapper">
                            <i class="fa-solid fa-check-double"></i>
                            <input type="password" id="confirmPassword" class="form-input" placeholder="Nhập lại mật khẩu mới" required>
                        </div>
                    </div>

                    <button type="submit" class="btn-primary submit-btn">
                        <i class="fa-solid fa-paper-plane"></i>
                        Cập nhật mật khẩu
                    </button>
                    
                    <div style="text-align: center; margin-top: 1.5rem;">
                        <a href="${pageContext.request.contextPath}/admin/profile" style="text-decoration: none; color: var(--text-muted); font-size: 13px; font-weight: 600;">
                           Hủy bỏ và quay lại
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </main>

    <script>
        document.getElementById('changePasswordForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const currentPassword = document.getElementById('currentPassword').value;
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const alertBox = document.getElementById('alertMessage');
            
            // Basic validation
            if (newPassword !== confirmPassword) {
                showAlert('Mật khẩu xác nhận không khớp!', 'error');
                return;
            }
            
            if (newPassword === currentPassword) {
                showAlert('Mật khẩu mới phải khác mật khẩu hiện tại!', 'error');
                return;
            }

            // Call API
            fetch('${pageContext.request.contextPath}/api/admin/profile/change-password', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    currentPassword: currentPassword,
                    newPassword: newPassword
                })
            })
            .then(response => response.json())
            .then(data => {
                if (data.message && data.message.includes('thành công')) {
                    showAlert(data.message, 'success');
                    setTimeout(() => {
                        window.location.href = '${pageContext.request.contextPath}/logout';
                    }, 2000);
                } else {
                    showAlert(data.message || 'Có lỗi xảy ra!', 'error');
                }
            })
            .catch(error => {
                showAlert('Không thể kết nối đến máy chủ!', 'error');
            });
        });

        function showAlert(msg, type) {
            const alertBox = document.getElementById('alertMessage');
            alertBox.textContent = msg;
            alertBox.className = 'alert ' + (type === 'success' ? 'alert-success' : 'alert-error');
            alertBox.style.display = 'flex';
        }
    </script>
</body>
</html>
