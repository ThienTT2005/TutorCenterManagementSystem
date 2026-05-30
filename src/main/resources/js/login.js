document.addEventListener('DOMContentLoaded', function () {
    const togglePassword = document.querySelector('#togglePassword');
    const passwordInput = document.querySelector('#password');
    const eyeIcon = document.querySelector('#eyeIcon');

    const usernameInput = document.getElementById('username');
    const errorAlert = document.getElementById('errorAlert');
    const errorText = errorAlert ? errorAlert.querySelector('p') : null;

    const forgotLink = document.querySelector('.forgot-link');
    const contactBtn = document.getElementById('contactBtn');

    window.showLoginError = function (message) {
        if (!errorAlert || !errorText) return;
        errorText.textContent = message;
        errorAlert.classList.remove('hidden');
    };

    window.hideLoginError = function () {
        if (!errorAlert) return;
        errorAlert.classList.add('hidden');
    };

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

    if (forgotLink) {
        forgotLink.addEventListener('click', function (event) {
            event.preventDefault();
            window.showLoginError('Liên hệ hotline 0123.456.789 để được hỗ trợ.');
        });
    }

    if (contactBtn) {
        contactBtn.addEventListener('click', function () {
            const hotline = '0123.456.789';

            window.showLoginError('Liên hệ hotline ' + hotline + ' để được hỗ trợ.');

            this.textContent = 'Hotline: ' + hotline;
            this.classList.add('active');

            this.style.animation = 'none';
            this.offsetHeight;
            this.style.animation = 'pulse 0.4s ease-in-out';
        });
    }

    if (usernameInput) {
        usernameInput.addEventListener('input', window.hideLoginError);
    }

    if (passwordInput) {
        passwordInput.addEventListener('input', window.hideLoginError);
    }
});