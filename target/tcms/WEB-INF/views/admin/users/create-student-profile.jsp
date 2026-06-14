<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cập Nhật Hồ Sơ Học Sinh | TCMS Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link rel="stylesheet" href="<c:url value='/css/core-dashboard.css' />">
    <style>
        .profile-container { width: 100%; padding: 2.5rem; box-sizing: border-box; }
        .page-header { margin-bottom: 2.5rem; border-bottom: 2px solid #f1f5f9; padding-bottom: 1.5rem; }
        .form-card { background: white; border-radius: 24px; padding: 2.5rem; border: 1px solid var(--border-color); box-shadow: 0 10px 25px -5px rgba(0,0,0,0.05); max-width: 800px; margin: 0 auto; }
        .form-card h3 { font-size: 18px; font-weight: 800; margin-bottom: 2rem; color: var(--primary); text-transform: uppercase; letter-spacing: 1px; display: flex; align-items: center; gap: 12px; }
        .profile-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem 2rem; }
        .form-group { margin-bottom: 1.5rem; }
        .form-group label { display: block; font-size: 12px; font-weight: 800; color: #64748b; text-transform: uppercase; margin-bottom: 8px; }
        .form-input, .form-select { width: 100%; padding: 12px 16px; background: #f8fafc; border: 1.5px solid var(--border-color); border-radius: 12px; font-size: 15px; font-weight: 600; outline: none; transition: all 0.3s; box-sizing: border-box; }
        .form-input:focus { border-color: var(--primary); background: white; box-shadow: 0 0 0 4px var(--primary-light); }
        .full-width { grid-column: span 2; }
        .btn-submit { background: var(--primary); color: white; border: none; padding: 14px 40px; border-radius: 16px; font-size: 16px; font-weight: 800; cursor: pointer; box-shadow: 0 4px 15px rgba(2, 132, 199, 0.3); transition: all 0.2s; }
        .btn-submit:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(2, 132, 199, 0.4); }
        .status-banner.error { background: #fef2f2; color: #b91c1c; padding: 1rem; border-radius: 12px; margin-bottom: 1.5rem; display: flex; align-items: center; gap: 10px; font-weight: 600; border: 1px solid #fecaca; }
    </style>
</head>
<body>
    <c:set var="activePage" value="accounts" scope="request" />
    <jsp:include page="/WEB-INF/views/admin/common/sidebar.jsp" />
    <main class="main-content">
        <jsp:include page="/WEB-INF/views/admin/common/header.jsp" />
        <div class="profile-container">
            <div class="page-header">
                <h1>Hồ Sơ Học Sinh</h1>
                <p>Bước 2: Cập nhật thông tin chi tiết cho tài khoản mới.</p>
            </div>

            <form action="${pageContext.request.contextPath}/admin/users/${userId}/profile/student" method="POST" enctype="multipart/form-data">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                <div class="form-card">
                    <h3><i class="fa-solid fa-user-graduate"></i> Thông tin cá nhân</h3>
                    
                    <c:if test="${not empty error}">
                        <div class="status-banner error">
                            <i class="fa-solid fa-circle-exclamation"></i> ${error}
                        </div>
                    </c:if>

                    <div class="profile-grid">
                        <!-- Avatar Upload Section -->
                        <div class="form-group full-width" style="display: flex; flex-direction: column; align-items: center; justify-content: center; margin-bottom: 1rem; padding-bottom: 1rem; border-bottom: 1px dashed #e2e8f0;">
                            <div style="position: relative; width: 120px; height: 120px; border-radius: 50%; border: 3px dashed #cbd5e1; display: flex; align-items: center; justify-content: center; overflow: hidden; background: #f8fafc; cursor: pointer;" onclick="document.getElementById('avatarInput').click()">
                                <img id="avatarPreview" src="${pageContext.request.contextPath}/images/default-avatar.png" style="width: 100%; height: 100%; object-fit: cover; display: none;">
                                <i class="fa-solid fa-camera" id="cameraIcon" style="font-size: 2rem; color: #94a3b8;"></i>
                            </div>
                            <label for="avatarInput" style="margin-top: 1rem; cursor: pointer; color: var(--primary); font-weight: 700; font-size: 14px; text-transform: uppercase;">
                                <i class="fa-solid fa-cloud-arrow-up"></i> Tải ảnh đại diện lên
                            </label>
                            <input type="file" id="avatarInput" name="avatarFile" accept="image/png, image/jpeg, image/jpg" style="display: none;" onchange="previewAvatar(event)">
                            <span style="font-size: 11px; color: #94a3b8; margin-top: 4px;">Hỗ trợ JPG, PNG (Tối đa 2MB)</span>
                        </div>
                        <div class="form-group full-width">
                            <label>Phụ huynh giám hộ <span style="color:red">*</span></label>
                            <select name="parentId" class="form-select" required>
                                <option value="" disabled selected>Chọn phụ huynh...</option>
                                <c:forEach items="${parents}" var="parent">
                                    <option value="${parent.parentId}" ${request.parentId == parent.parentId ? 'selected' : ''}>
                                        ${parent.fullName} - ${parent.phone}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Họ và tên học sinh <span style="color:red">*</span></label>
                            <input type="text" name="fullName" class="form-input" placeholder="Nguyễn Văn C" value="${request.fullName}" required>
                        </div>
                        <div class="form-group">
                            <label>Ngày sinh</label>
                            <input type="date" name="dob" class="form-input" value="${request.dob}">
                        </div>
                        <div class="form-group">
                            <label>Giới tính</label>
                            <select name="gender" class="form-select">
                                <option value="Nam" ${request.gender == 'Nam' ? 'selected' : ''}>Nam</option>
                                <option value="Nữ" ${request.gender == 'Nữ' ? 'selected' : ''}>Nữ</option>
                                <option value="Khác" ${request.gender == 'Khác' ? 'selected' : ''}>Khác</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Trường học</label>
                            <input type="text" name="school" class="form-input" placeholder="VD: THPT Lê Hồng Phong" value="${request.school}">
                        </div>
                        <div class="form-group">
                            <label>Lớp</label>
                            <input type="text" name="grade" class="form-input" placeholder="VD: 10A1" value="${request.grade}">
                        </div>
                        <div class="form-group full-width">
                            <label>Địa chỉ</label>
                            <input type="text" name="address" class="form-input" placeholder="Nhập địa chỉ học sinh" value="${request.address}">
                        </div>
                    </div>

                    <div style="display: flex; justify-content: flex-end; margin-top: 2rem;">
                        <button type="submit" class="btn-submit">Hoàn tất hồ sơ</button>
                    </div>
                </div>
            </form>
        </div>
    </main>
    <script src="${pageContext.request.contextPath}/js/admin-profile.js"></script>
    <script>
        function previewAvatar(event) {
            const reader = new FileReader();
            reader.onload = function() {
                const output = document.getElementById('avatarPreview');
                const cameraIcon = document.getElementById('cameraIcon');
                output.src = reader.result;
                output.style.display = 'block';
                cameraIcon.style.display = 'none';
            }
            if(event.target.files[0]) {
                reader.readAsDataURL(event.target.files[0]);
            }
        }
    </script>
</body>
</html>
