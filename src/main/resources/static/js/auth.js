$(document).ready(function () {
    $("#loginForm").on("submit", function (e) {
        e.preventDefault();

        const username = $("#username").val().trim();
        const password = $("#password").val().trim();

        $("#loginError").addClass("d-none").text("");

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
                $("#loginError").removeClass("d-none").text(message);
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