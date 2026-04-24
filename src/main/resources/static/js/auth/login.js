document.addEventListener('DOMContentLoaded', function () {
    const togglePassword = document.querySelector('#togglePassword');
    const passwordInput = document.querySelector('#password');
    const eyeIcon = document.querySelector('#eyeIcon');

    const loginForm = document.getElementById('loginForm');
    const usernameInput = document.getElementById('username');
    const submitBtn = document.getElementById('submitBtn');
    const btnText = document.getElementById('btnText');
    const btnLoader = document.getElementById('btnLoader');

    const errorAlert = document.getElementById('errorAlert');
    const errorText = errorAlert ? errorAlert.querySelector('p') : null;

    const forgotLink = document.querySelector('.forgot-link');
    const contactBtn = document.getElementById('contactBtn');

    function showError(message) {
        if (!errorAlert || !errorText) return;
        errorText.textContent = message;
        errorAlert.classList.remove('hidden');
    }

    function hideError() {
        if (!errorAlert) return;
        errorAlert.classList.add('hidden');
    }

    // Hiện / ẩn mật khẩu
    if (togglePassword && passwordInput && eyeIcon) {
        togglePassword.addEventListener('click', function () {
            const type = passwordInput.getAttribute('type') === 'password'
                ? 'text'
                : 'password';

            passwordInput.setAttribute('type', type);
            eyeIcon.textContent = type === 'password'
                ? 'visibility'
                : 'visibility_off';

            togglePassword.setAttribute(
                'aria-label',
                type === 'password' ? 'Hiện mật khẩu' : 'Ẩn mật khẩu'
            );
        });
    }

    // Kiểm tra form trước khi gửi backend
    if (loginForm && submitBtn && btnText && btnLoader) {
        loginForm.addEventListener('submit', function (event) {
            const username = usernameInput.value.trim();
            const password = passwordInput.value.trim();

            hideError();

            if (username === '' || password === '') {
                event.preventDefault();
                showError('Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu.');
                return;
            }

            submitBtn.disabled = true;
            btnText.classList.add('hidden');
            btnLoader.classList.remove('hidden');
        });
    }

    // Bấm quên mật khẩu
    if (forgotLink) {
        forgotLink.addEventListener('click', function (event) {
            event.preventDefault();

            showError(
                'Liên hệ hotline 0123.456.789 để được hỗ trợ.'
            );
        });
    }

    // Bấm nút liên hệ
    if (contactBtn) {
        contactBtn.addEventListener('click', function () {
            const hotline = '0123.456.789';

            showError('Liên hệ hotline ' + hotline + ' để được hỗ trợ.');

            this.textContent = 'Hotline: ' + hotline;
            this.classList.add('active');

            this.style.animation = 'none';
            this.offsetHeight;
            this.style.animation = 'pulse 0.4s ease-in-out';
        });
    }

    // Khi nhập lại thì ẩn lỗi
    if (usernameInput) {
        usernameInput.addEventListener('input', hideError);
    }

    if (passwordInput) {
        passwordInput.addEventListener('input', hideError);
    }
});