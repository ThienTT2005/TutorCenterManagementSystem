$(document).ready(function () {
    $("#loginForm").on("submit", function (e) {
        e.preventDefault();

        const username = $("#username").val().trim();
        const password = $("#password").val().trim();

        const submitBtn = $("#submitBtn");
        const btnText = $("#btnText");
        const btnLoader = $("#btnLoader");

        if (window.hideLoginError) {
            window.hideLoginError();
        }

        if (username === "" || password === "") {
            if (window.showLoginError) {
                window.showLoginError("Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu.");
            }
            return;
        }

        submitBtn.prop("disabled", true);
        btnText.addClass("hidden");
        btnLoader.removeClass("hidden");

        $.ajax({
            url: contextPath + "/api/auth/login",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify({
                username: username,
                password: password
            }),
            success: function (res) {
                localStorage.setItem("accessToken", res.accessToken);
                localStorage.setItem("refreshToken", res.refreshToken);
                localStorage.setItem("role", res.role);
                localStorage.setItem("user", JSON.stringify(res.user));

                redirectByRole(res.role);
            },
            error: function (xhr) {
                let message = "Đăng nhập thất bại";

                if (xhr.responseJSON && xhr.responseJSON.message) {
                    message = xhr.responseJSON.message;
                }

                if (window.showLoginError) {
                    window.showLoginError(message);
                }

                submitBtn.prop("disabled", false);
                btnText.removeClass("hidden");
                btnLoader.addClass("hidden");
            }
        });
    });
});

function redirectByRole(role) {
    if (role === "ADMIN") {
        window.location.href = contextPath + "/admin/dashboard";
    } else if (role === "TUTOR") {
        window.location.href = contextPath + "/tutor/dashboard";
    } else if (role === "PARENT") {
        window.location.href = contextPath + "/parent/dashboard";
    } else if (role === "STUDENT") {
        window.location.href = contextPath + "/student/dashboard";
    } else {
        window.location.href = contextPath + "/";
    }
}