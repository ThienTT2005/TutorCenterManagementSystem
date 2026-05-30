<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đổi mật khẩu | TCMS</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0" />

    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap');

        :root {
            --primary: #0057bf;
            --primary-hover: #004da8;
            --primary-light: #eff6ff;
            --danger: #dc2626;
            --danger-light: #fee2e2;
            --success: #16a34a;
            --success-light: #dcfce7;
            --bg-page: #f7f9fb;
            --bg-white: #ffffff;
            --text-dark: #0f172a;
            --text-muted: #64748b;
            --border-color: #e2e8f0;
            --radius-md: 12px;
            --radius-lg: 16px;
            --radius-xl: 24px;
            --shadow-md: 0 10px 30px rgba(15, 23, 42, 0.08);
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Inter', sans-serif;
        }

        body {
            min-height: 100vh;
            background:
                    radial-gradient(circle at top left, rgba(0, 87, 191, 0.12), transparent 36%),
                    linear-gradient(135deg, #f8fbff 0%, #eef5ff 100%);
            color: var(--text-dark);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 24px;
        }

        .change-password-wrapper {
            width: 100%;
            max-width: 1080px;
            display: grid;
            grid-template-columns: 1fr 460px;
            background: var(--bg-white);
            border-radius: 32px;
            box-shadow: var(--shadow-md);
            overflow: hidden;
            border: 1px solid rgba(226, 232, 240, 0.8);
        }

        .info-panel {
            background: linear-gradient(160deg, #0057bf 0%, #0f3f83 100%);
            color: white;
            padding: 56px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            min-height: 620px;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .brand-icon {
            width: 46px;
            height: 46px;
            border-radius: 14px;
            background: rgba(255, 255, 255, 0.16);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .brand-icon .material-symbols-rounded {
            font-size: 28px;
        }

        .brand-text strong {
            display: block;
            font-size: 22px;
            font-weight: 800;
            line-height: 1;
        }

        .brand-text span {
            display: block;
            margin-top: 5px;
            font-size: 12px;
            font-weight: 700;
            opacity: 0.75;
            letter-spacing: 0.6px;
        }

        .info-content h1 {
            font-size: 36px;
            line-height: 1.2;
            font-weight: 800;
            margin-bottom: 16px;
        }

        .info-content p {
            color: rgba(255, 255, 255, 0.78);
            font-size: 15px;
            line-height: 1.7;
            max-width: 420px;
        }

        .security-list {
            display: grid;
            gap: 14px;
            margin-top: 32px;
        }

        .security-item {
            display: flex;
            align-items: center;
            gap: 12px;
            color: rgba(255, 255, 255, 0.88);
            font-size: 14px;
            font-weight: 600;
        }

        .security-item .material-symbols-rounded {
            width: 34px;
            height: 34px;
            border-radius: 999px;
            background: rgba(255, 255, 255, 0.14);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 19px;
        }

        .info-footer {
            color: rgba(255, 255, 255, 0.62);
            font-size: 12px;
        }

        .form-panel {
            padding: 56px 44px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .form-header {
            margin-bottom: 28px;
        }

        .form-header .icon-box {
            width: 54px;
            height: 54px;
            border-radius: 18px;
            background: var(--primary-light);
            color: var(--primary);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 18px;
        }

        .form-header .icon-box .material-symbols-rounded {
            font-size: 30px;
        }

        .form-header h2 {
            font-size: 28px;
            font-weight: 800;
            margin-bottom: 8px;
            color: var(--text-dark);
        }

        .form-header p {
            color: var(--text-muted);
            font-size: 14px;
            line-height: 1.6;
        }

        .alert {
            border-radius: var(--radius-md);
            padding: 13px 14px;
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 18px;
            display: flex;
            align-items: flex-start;
            gap: 10px;
            line-height: 1.5;
        }

        .alert-error {
            background: var(--danger-light);
            color: var(--danger);
        }

        .alert-success {
            background: var(--success-light);
            color: var(--success);
        }

        .alert .material-symbols-rounded {
            font-size: 20px;
            line-height: 1.2;
        }

        .form-group {
            margin-bottom: 18px;
        }

        .form-group label {
            display: block;
            font-size: 13px;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 8px;
        }

        .password-field {
            height: 48px;
            border: 1px solid var(--border-color);
            border-radius: var(--radius-md);
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 0 14px;
            background: #fff;
            transition: all 0.2s ease;
        }

        .password-field:focus-within {
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(0, 87, 191, 0.08);
        }

        .password-field .material-symbols-rounded {
            color: var(--text-muted);
            font-size: 21px;
        }

        .password-field input {
            width: 100%;
            border: none;
            outline: none;
            font-size: 14px;
            color: var(--text-dark);
            background: transparent;
        }

        .toggle-password {
            border: none;
            background: transparent;
            color: var(--text-muted);
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 0;
        }

        .hint {
            margin-top: 8px;
            font-size: 12px;
            color: var(--text-muted);
            line-height: 1.5;
        }

        .submit-btn {
            width: 100%;
            height: 50px;
            border: none;
            border-radius: var(--radius-md);
            background: var(--primary);
            color: white;
            font-weight: 800;
            font-size: 14px;
            cursor: pointer;
            margin-top: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            transition: all 0.2s ease;
            box-shadow: 0 10px 20px rgba(0, 87, 191, 0.2);
        }

        .submit-btn:hover {
            background: var(--primary-hover);
            transform: translateY(-1px);
        }

        .back-link {
            margin-top: 20px;
            text-align: center;
            font-size: 13px;
            color: var(--text-muted);
        }

        .back-link a {
            color: var(--primary);
            font-weight: 800;
            text-decoration: none;
        }

        .back-link a:hover {
            text-decoration: underline;
        }

        @media (max-width: 900px) {
            .change-password-wrapper {
                grid-template-columns: 1fr;
                max-width: 520px;
            }

            .info-panel {
                min-height: auto;
                padding: 32px;
                gap: 32px;
            }

            .info-content h1 {
                font-size: 28px;
            }

            .form-panel {
                padding: 36px 28px;
            }
        }

        @media (max-width: 520px) {
            body {
                padding: 12px;
            }

            .change-password-wrapper {
                border-radius: 22px;
            }

            .info-panel {
                padding: 28px 22px;
            }

            .form-panel {
                padding: 30px 22px;
            }

            .form-header h2 {
                font-size: 24px;
            }
        }
    </style>
</head>

<body>

<div class="change-password-wrapper">

    <section class="info-panel">
        <div class="brand">
            <div class="brand-icon">
                <span class="material-symbols-rounded">school</span>
            </div>
            <div class="brand-text">
                <strong>TCMS</strong>
                <span>TUTOR CENTER MANAGEMENT</span>
            </div>
        </div>

        <div class="info-content">
            <h1>Bảo vệ tài khoản của bạn</h1>
            <p>
                Đổi mật khẩu định kỳ giúp tăng cường bảo mật và hạn chế rủi ro truy cập trái phép vào hệ thống.
            </p>

            <div class="security-list">
                <div class="security-item">
                    <span class="material-symbols-rounded">verified_user</span>
                    Sử dụng mật khẩu mạnh, khó đoán
                </div>

                <div class="security-item">
                    <span class="material-symbols-rounded">lock_reset</span>
                    Không dùng lại mật khẩu cũ
                </div>

                <div class="security-item">
                    <span class="material-symbols-rounded">password</span>
                    Nên kết hợp chữ hoa, chữ thường và số
                </div>
            </div>
        </div>

        <div class="info-footer">
            © TCMS Security Center
        </div>
    </section>

    <section class="form-panel">
        <div class="form-header">
            <div class="icon-box">
                <span class="material-symbols-rounded">lock_reset</span>
            </div>
            <h2>Đổi mật khẩu</h2>
            <p>Nhập mật khẩu hiện tại và mật khẩu mới để cập nhật thông tin bảo mật.</p>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-error">
                <span class="material-symbols-rounded">error</span>
                <span><c:out value="${error}" /></span>
            </div>
        </c:if>

        <c:if test="${not empty success}">
            <div class="alert alert-success">
                <span class="material-symbols-rounded">check_circle</span>
                <span><c:out value="${success}" /></span>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/change-password" method="post" id="changePasswordForm">

            <div class="form-group">
                <label for="oldPassword">Mật khẩu hiện tại</label>
                <div class="password-field">
                    <span class="material-symbols-rounded">lock</span>
                    <input type="password"
                           id="oldPassword"
                           name="oldPassword"
                           placeholder="Nhập mật khẩu hiện tại"
                           required>
                    <button type="button" class="toggle-password" data-target="oldPassword">
                        <span class="material-symbols-rounded">visibility</span>
                    </button>
                </div>
            </div>

            <div class="form-group">
                <label for="newPassword">Mật khẩu mới</label>
                <div class="password-field">
                    <span class="material-symbols-rounded">encrypted</span>
                    <input type="password"
                           id="newPassword"
                           name="newPassword"
                           placeholder="Nhập mật khẩu mới"
                           minlength="6"
                           required>
                    <button type="button" class="toggle-password" data-target="newPassword">
                        <span class="material-symbols-rounded">visibility</span>
                    </button>
                </div>
                <div class="hint">Mật khẩu mới nên có ít nhất 6 ký tự.</div>
            </div>

            <div class="form-group">
                <label for="confirmPassword">Nhập lại mật khẩu mới</label>
                <div class="password-field">
                    <span class="material-symbols-rounded">done_all</span>
                    <input type="password"
                           id="confirmPassword"
                           name="confirmPassword"
                           placeholder="Nhập lại mật khẩu mới"
                           minlength="6"
                           required>
                    <button type="button" class="toggle-password" data-target="confirmPassword">
                        <span class="material-symbols-rounded">visibility</span>
                    </button>
                </div>
            </div>

            <button type="submit" class="submit-btn">
                <span class="material-symbols-rounded">save</span>
                Cập nhật mật khẩu
            </button>
        </form>

        <div class="back-link">
            <a href="${pageContext.request.contextPath}/login">Quay lại đăng nhập</a>
        </div>
    </section>

</div>

<script>
    document.querySelectorAll('.toggle-password').forEach(function (button) {
        button.addEventListener('click', function () {
            const targetId = this.getAttribute('data-target');
            const input = document.getElementById(targetId);
            const icon = this.querySelector('.material-symbols-rounded');

            if (!input) return;

            if (input.type === 'password') {
                input.type = 'text';
                icon.textContent = 'visibility_off';
            } else {
                input.type = 'password';
                icon.textContent = 'visibility';
            }
        });
    });

    document.getElementById('changePasswordForm').addEventListener('submit', function (event) {
        const newPassword = document.getElementById('newPassword').value;
        const confirmPassword = document.getElementById('confirmPassword').value;

        if (newPassword !== confirmPassword) {
            event.preventDefault();
            alert('Mật khẩu mới và nhập lại mật khẩu mới không khớp.');
        }
    });
</script>

</body>
</html>
