<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đổi mật khẩu | TCMS</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/core-dashboard.css">
    <style>
        body {
            background-color: var(--bg-body, #f4f6f8);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            font-family: 'Inter', sans-serif;
        }
        
        .form-container {
            width: 100%;
            max-width: 500px;
            margin: 2rem;
            background: white;
            padding: 2.5rem;
            border-radius: var(--radius-xl, 16px);
            border: 1px solid var(--border-color, #e2e8f0);
            box-shadow: var(--shadow-md, 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1));
        }
        
        .form-header {
            text-align: center;
            margin-bottom: 2.5rem;
        }
        
        .form-header .icon-box {
            width: 60px;
            height: 60px;
            background: var(--primary-light, #eff6ff);
            color: var(--primary, #3b82f6);
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
            color: var(--text-dark, #1e293b);
            margin: 0;
        }
        
        .form-header p {
            font-size: 14px;
            color: var(--text-muted, #64748b);
            margin-top: 8px;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-group label {
            display: block;
            font-size: 12px;
            font-weight: 700;
            color: var(--text-dark, #1e293b);
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
            color: var(--text-muted, #64748b);
            font-size: 14px;
        }
        
        .form-input {
            width: 100%;
            padding: 12px 16px 12px 45px;
            background: var(--bg-page, #f8fafc);
            border: 1px solid var(--border-color, #e2e8f0);
            border-radius: var(--radius-md, 8px);
            font-size: 14px;
            font-weight: 500;
            transition: all 0.2s ease;
            outline: none;
            box-sizing: border-box;
        }
        
        .form-input:focus {
            border-color: var(--primary, #3b82f6);
            background: white;
            box-shadow: 0 0 0 4px var(--primary-light, #eff6ff);
        }
        
        .submit-btn {
            width: 100%;
            margin-top: 1rem;
            background: var(--primary, #3b82f6);
            color: white;
            border: none;
            padding: 12px;
            border-radius: var(--radius-md, 8px);
            font-weight: 600;
            font-size: 15px;
            cursor: pointer;
            transition: background 0.2s;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
        }
        
        .submit-btn:hover {
            background: #2563eb;
        }
        
        .alert {
            padding: 12px 16px;
            border-radius: var(--radius-md, 8px);
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 1.5rem;
            display: none;
            align-items: center;
            gap: 10px;
        }
        
        .alert-success {
            background: var(--success-light, #dcfce7);
            color: var(--success, #16a34a);
            border: 1px solid rgba(22, 163, 74, 0.2);
        }
        
        .alert-error {
            background: var(--danger-light, #fee2e2);
            color: var(--danger, #dc2626);
            border: 1px solid rgba(220, 38, 38, 0.2);
        }
    </style>
</head>
<body>
<%--khung chính --%>
    <div class="form-container">
        <div class="form-header">
            <div class="icon-box">
                <i class="fa-solid fa-lock-open"></i>
            </div>
            <h2>Đổi mật khẩu</h2>
            <p>Cập nhật mật khẩu mới để bảo mật tài khoản của bạn.</p>
        </div>
<%--        hiển thị thông báo lỗi hoặc thành công --%>
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

            <button type="submit" class="submit-btn">
                <i class="fa-solid fa-paper-plane"></i>
                Cập nhật mật khẩu
            </button>
            
            <div style="text-align: center; margin-top: 1.5rem;">
                <a href="javascript:history.back()" style="text-decoration: none; color: var(--text-muted, #64748b); font-size: 13px; font-weight: 600;">
                   <i class="fa-solid fa-arrow-left"></i> Quay lại
                </a>
            </div>
        </form>
    </div>

    <script>
        document.getElementById('changePasswordForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const currentPassword = document.getElementById('currentPassword').value;
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const submitBtn = document.querySelector('.submit-btn');
            
            // Basic validation
            if (newPassword !== confirmPassword) {
                showAlert('Mật khẩu xác nhận không khớp!', 'error');
                return;
            }
            
            if (newPassword === currentPassword) {
                showAlert('Mật khẩu mới phải khác mật khẩu hiện tại!', 'error');
                return;
            }

            submitBtn.disabled = true;
            submitBtn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Đang xử lý...';

            // Call API
            fetch('${pageContext.request.contextPath}/api/auth/change-password', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    currentPassword: currentPassword,
                    newPassword: newPassword
                })
            })
            .then(response => response.json().then(data => (
                {
                    status: response.status,
                    body: data
                })))
            .then(res => {
                if (res.status === 200 || (res.body.message && res.body.message.includes('thành công'))) {
                    showAlert(res.body.message || 'Đổi mật khẩu thành công!', 'success');
                } else {
                    showAlert(res.body.message || 'Có lỗi xảy ra!', 'error');
                    submitBtn.disabled = false;
                    submitBtn.innerHTML = '<i class="fa-solid fa-paper-plane"></i> Cập nhật mật khẩu';
                }
            })
            .catch(error => {
                showAlert('Không thể kết nối đến máy chủ!', 'error');
                submitBtn.disabled = false;
                submitBtn.innerHTML = '<i class="fa-solid fa-paper-plane"></i> Cập nhật mật khẩu';
            });
        });

        function showAlert(msg, type) {
            const alertBox = document.getElementById('alertMessage');
            alertBox.innerHTML = type === 'success' 
                ? '<i class="fa-solid fa-circle-check"></i> ' + msg
                : '<i class="fa-solid fa-circle-exclamation"></i> ' + msg;
            alertBox.className = 'alert ' + (type === 'success' ? 'alert-success' : 'alert-error');
            alertBox.style.display = 'flex';
        }
    </script>
</body>
</html>