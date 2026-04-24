<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark px-3">
    <a class="navbar-brand" href="#">TCMS</a>

    <div class="ms-auto d-flex align-items-center gap-3">
        <span class="text-white" id="currentUserName">Đang tải...</span>
        <button class="btn btn-outline-light btn-sm" id="btnLogout">Đăng xuất</button>
    </div>
</nav>

<script>
    const contextPath = "${pageContext.request.contextPath}";
</script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/common.js"></script>
<script>
    $(document).ready(function () {
        loadCurrentUser();

        $("#btnLogout").click(function () {
            logout();
        });
    });

    function loadCurrentUser() {
        $.ajax({
            url: contextPath + "/api/auth/me",
            type: "GET",
            headers: authHeaders(),
            success: function (res) {
                const fullName = res.fullName || (res.user && res.user.fullName) || res.username || "User";
                $("#currentUserName").text(fullName);
            },
            error: function () {
                $("#currentUserName").text("Chưa đăng nhập");
            }
        });
    }

    function logout() {
        $.ajax({
            url: contextPath + "/api/auth/logout",
            type: "POST",
            contentType: "application/json",
            headers: authHeaders(),
            data: JSON.stringify({
                refreshToken: getRefreshToken()
            }),
            complete: function () {
                clearAuthData();
                window.location.href = contextPath + "/auth/login";
            }
        });
    }
</script>