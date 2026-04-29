document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("createAccountForm");

    const usernameInput = document.getElementById("username");
    const passwordInput = document.getElementById("password");
    const confirmPasswordInput = document.getElementById("confirmPassword");
    const roleSelect = document.getElementById("role");

    const formStatus = document.getElementById("formStatus");

    function showError(input, errorId, message) {
        input.classList.add("error");
        const errorEl = document.getElementById(errorId);
        if (errorEl) {
            errorEl.textContent = message;
            errorEl.classList.add("active");
        }
    }

    function clearErrors() {
        document.querySelectorAll(".form-input, .form-select").forEach(el => {
            el.classList.remove("error");
        });

        document.querySelectorAll(".error-message").forEach(el => {
            el.textContent = "";
            el.classList.remove("active");
        });

        formStatus.className = "status-banner";
        formStatus.textContent = "";
        formStatus.style.display = "none";
    }

    function showStatus(type, message) {
        formStatus.className = "status-banner " + type;
        formStatus.textContent = message;
        formStatus.style.display = "flex";
    }

    form.addEventListener("submit", async function (e) {
        e.preventDefault();
        clearErrors();

        const username = usernameInput.value.trim();
        const password = passwordInput.value.trim();
        const confirmPassword = confirmPasswordInput.value.trim();
        const role = roleSelect.value;

        let hasError = false;

        if (!username) {
            showError(usernameInput, "usernameError", "Vui lòng nhập tên đăng nhập");
            hasError = true;
        }

        if (!password) {
            showError(passwordInput, "passwordError", "Vui lòng nhập mật khẩu");
            hasError = true;
        }

        if (!confirmPassword) {
            showError(confirmPasswordInput, "confirmPasswordError", "Vui lòng xác nhận mật khẩu");
            hasError = true;
        } else if (password !== confirmPassword) {
            showError(confirmPasswordInput, "confirmPasswordError", "Mật khẩu xác nhận không khớp");
            hasError = true;
        }

        if (!role) {
            showError(roleSelect, "roleError", "Vui lòng chọn vai trò");
            hasError = true;
        }

        if (hasError) return;

        try {
            showStatus("success", "Đang tạo tài khoản...");

            const response = await fetch(contextPath + "/admin/users/create-account", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({
                    username: username,
                    password: password,
                    role: role
                })
            });

            const data = await response.json();

            if (!response.ok) {
                showStatus("error", data.message || "Tạo tài khoản thất bại");
                return;
            }

            showStatus("success", "Tạo tài khoản thành công. Đang chuyển sang tạo hồ sơ...");

            setTimeout(function () {
                window.location.href =
                    contextPath + "/admin/users/create-profile?userId=" + data.userId + "&role=" + data.role;
            }, 800);

        } catch (error) {
            console.error(error);
            showStatus("error", "Không thể kết nối tới server");
        }
    });
});