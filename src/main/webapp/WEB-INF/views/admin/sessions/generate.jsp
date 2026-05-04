<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="activePage" value="classes" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Sinh buổi học tự động | TCMS Admin</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0" />

    <link rel="stylesheet" href="<c:url value='/css/core-dashboard.css' />">

    <style>
        .generate-wrapper {
            display: grid;
            grid-template-columns: minmax(0, 1.5fr) 380px;
            gap: 24px;
            align-items: start;
        }

        .page-heading {
            margin-bottom: 24px;
        }

        .breadcrumb {
            font-size: 13px;
            color: #64748b;
            margin-bottom: 8px;
            font-weight: 600;
        }

        .breadcrumb span {
            color: #0057bf;
            font-weight: 800;
        }

        .page-heading h1 {
            margin: 0 0 8px;
            font-size: 26px;
            line-height: 34px;
            font-weight: 900;
            color: #0f172a;
        }

        .page-heading p {
            margin: 0;
            color: #64748b;
            font-size: 14px;
            line-height: 1.6;
        }

        .form-card,
        .class-card,
        .note-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 20px;
            box-shadow: 0 8px 24px rgba(15, 23, 42, 0.05);
        }

        .form-card {
            padding: 26px;
        }

        .class-card,
        .note-card {
            padding: 22px;
        }

        .section-title {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 22px;
        }

        .section-icon {
            width: 44px;
            height: 44px;
            border-radius: 14px;
            background: #eff6ff;
            color: #0057bf;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .section-title h2 {
            margin: 0;
            font-size: 18px;
            font-weight: 900;
            color: #0f172a;
        }

        .section-title p {
            margin: 3px 0 0;
            color: #64748b;
            font-size: 13px;
            line-height: 1.5;
        }

        .alert-error {
            margin-bottom: 18px;
            padding: 13px 15px;
            border-radius: 12px;
            background: #fee2e2;
            color: #dc2626;
            font-size: 13px;
            font-weight: 700;
            display: flex;
            align-items: flex-start;
            gap: 9px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 18px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .form-group label {
            font-size: 13px;
            font-weight: 800;
            color: #0f172a;
        }

        .required {
            color: #dc2626;
        }

        .form-control {
            width: 100%;
            height: 46px;
            border: 1px solid #dbe3ef;
            border-radius: 12px;
            padding: 0 14px;
            font-size: 14px;
            color: #0f172a;
            outline: none;
            background: #ffffff;
            transition: all .2s ease;
        }

        .form-control:focus {
            border-color: #0057bf;
            box-shadow: 0 0 0 4px rgba(0, 87, 191, 0.08);
        }

        .hint {
            color: #64748b;
            font-size: 12px;
            line-height: 1.5;
        }

        .preview-box {
            margin-top: 22px;
            padding: 16px;
            border-radius: 14px;
            background: #f8fafc;
            border: 1px dashed #cbd5e1;
        }

        .preview-title {
            display: flex;
            align-items: center;
            gap: 8px;
            color: #0f172a;
            font-size: 14px;
            font-weight: 900;
            margin-bottom: 8px;
        }

        .preview-box p {
            margin: 0;
            color: #64748b;
            font-size: 13px;
            line-height: 1.6;
        }

        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 12px;
            margin-top: 24px;
            padding-top: 20px;
            border-top: 1px solid #f1f5f9;
        }

        .btn-soft,
        .btn-primary {
            min-height: 44px;
            padding: 0 18px;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 850;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            text-decoration: none;
            cursor: pointer;
            transition: all .2s ease;
        }

        .btn-soft {
            background: #ffffff;
            color: #334155;
            border: 1px solid #e2e8f0;
        }

        .btn-soft:hover {
            background: #f8fafc;
            border-color: #cbd5e1;
        }

        .btn-primary {
            border: none;
            background: #0057bf;
            color: #ffffff;
            box-shadow: 0 8px 18px rgba(0, 87, 191, 0.18);
        }

        .btn-primary:hover {
            background: #004da8;
            transform: translateY(-1px);
        }

        .class-header {
            display: flex;
            gap: 14px;
            align-items: center;
            margin-bottom: 18px;
        }

        .class-icon {
            width: 50px;
            height: 50px;
            border-radius: 15px;
            background: #eff6ff;
            color: #0057bf;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .class-header h3 {
            margin: 0;
            font-size: 18px;
            font-weight: 900;
            color: #0f172a;
        }

        .class-header p {
            margin: 4px 0 0;
            color: #64748b;
            font-size: 13px;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            gap: 12px;
            padding: 13px 0;
            border-bottom: 1px solid #f1f5f9;
            font-size: 13px;
        }

        .info-row:last-child {
            border-bottom: none;
        }

        .info-row span {
            color: #64748b;
            font-weight: 700;
        }

        .info-row strong {
            color: #0f172a;
            font-weight: 900;
            text-align: right;
        }

        .status-pill {
            display: inline-flex;
            align-items: center;
            padding: 5px 10px;
            border-radius: 999px;
            font-size: 11px;
            font-weight: 900;
        }

        .status-pill.active {
            background: #dcfce7;
            color: #16a34a;
        }

        .status-pill.inactive {
            background: #fee2e2;
            color: #dc2626;
        }

        .right-column {
            display: flex;
            flex-direction: column;
            gap: 18px;
        }

        .note-list {
            display: flex;
            flex-direction: column;
            gap: 13px;
        }

        .note-item {
            display: flex;
            gap: 10px;
            align-items: flex-start;
            color: #475569;
            font-size: 13px;
            line-height: 1.6;
        }

        .note-item .material-symbols-rounded {
            color: #0057bf;
            font-size: 20px;
            margin-top: 1px;
        }

        @media (max-width: 1100px) {
            .generate-wrapper {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 700px) {
            .form-grid {
                grid-template-columns: 1fr;
            }

            .form-actions {
                flex-direction: column-reverse;
            }

            .btn-soft,
            .btn-primary {
                width: 100%;
            }
        }
    </style>
</head>

<body>

<jsp:include page="../common/sidebar.jsp" />

<main class="main-content">
    <jsp:include page="../common/header.jsp" />

    <div class="dashboard-body">

        <div class="page-heading">
            <div class="breadcrumb">
                Admin / Lớp học /
                <span>Sinh buổi học</span>
            </div>

            <h1>Sinh buổi học tự động</h1>
            <p>
                Chọn khoảng thời gian để hệ thống tự động tạo các buổi học cho lớp.
                Thứ học và giờ học sẽ được lấy từ lịch học hàng tuần đã cấu hình cho lớp.
            </p>
        </div>

        <section class="generate-wrapper">

            <!-- LEFT: FORM -->
            <div class="form-card">
                <div class="section-title">
                    <div class="section-icon">
                        <span class="material-symbols-rounded">auto_awesome</span>
                    </div>
                    <div>
                        <h2>Thiết lập khoảng thời gian</h2>
                        <p>Backend hiện tại nhận classId, startDate và endDate.</p>
                    </div>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert-error">
                        <span class="material-symbols-rounded">error</span>
                        <span><c:out value="${error}" /></span>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/admin/classes/${classItem.classId}/sessions/generate"
                      method="post"
                      id="generateSessionsForm">

                    <input type="hidden" name="classId" value="${classItem.classId}" />

                    <div class="form-grid">
                        <div class="form-group">
                            <label for="startDate">
                                Ngày bắt đầu <span class="required">*</span>
                            </label>

                            <input type="date"
                                   id="startDate"
                                   name="startDate"
                                   class="form-control"
                                   value="${request.startDate}"
                                   required>

                            <div class="hint">
                                Ngày đầu tiên hệ thống bắt đầu xét để tạo buổi học.
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="endDate">
                                Ngày kết thúc <span class="required">*</span>
                            </label>

                            <input type="date"
                                   id="endDate"
                                   name="endDate"
                                   class="form-control"
                                   value="${request.endDate}"
                                   required>

                            <div class="hint">
                                Hệ thống chỉ sinh các buổi học trong khoảng thời gian này.
                            </div>
                        </div>
                    </div>

                    <div class="preview-box">
                        <div class="preview-title">
                            <span class="material-symbols-rounded">info</span>
                            Cách hệ thống sinh buổi học
                        </div>
                        <p>
                            Form này chỉ gửi ngày bắt đầu và ngày kết thúc.
                            Service sẽ dùng lịch học hàng tuần của lớp để xác định các ngày học thực tế,
                            giờ bắt đầu và giờ kết thúc của từng buổi.
                        </p>
                    </div>

                    <div class="form-actions">
                        <a href="${pageContext.request.contextPath}/admin/classes/${classItem.classId}"
                           class="btn-soft">
                            <span class="material-symbols-rounded">arrow_back</span>
                            Quay lại lớp
                        </a>

                        <button type="submit" class="btn-primary">
                            <span class="material-symbols-rounded">auto_awesome</span>
                            Sinh buổi học
                        </button>
                    </div>
                </form>
            </div>

            <!-- RIGHT -->
            <aside class="right-column">

                <div class="class-card">
                    <div class="class-header">
                        <div class="class-icon">
                            <span class="material-symbols-rounded">menu_book</span>
                        </div>

                        <div>
                            <h3>
                                <c:out value="${empty classItem.className ? 'Lớp học' : classItem.className}" />
                            </h3>
                            <p>
                                Mã lớp: #<c:out value="${classItem.classId}" />
                            </p>
                        </div>
                    </div>

                    <div class="info-row">
                        <span>Môn học</span>
                        <strong>
                            <c:out value="${empty classItem.subject ? '---' : classItem.subject}" />
                        </strong>
                    </div>

                    <div class="info-row">
                        <span>Khối lớp</span>
                        <strong>
                            <c:out value="${empty classItem.grade ? '---' : classItem.grade}" />
                        </strong>
                    </div>

                    <div class="info-row">
                        <span>Gia sư</span>
                        <strong>
                            <c:choose>
                                <c:when test="${not empty classItem.tutor}">
                                    <c:out value="${empty classItem.tutor.fullName ? 'Chưa cập nhật' : classItem.tutor.fullName}" />
                                </c:when>
                                <c:otherwise>Chưa phân công</c:otherwise>
                            </c:choose>
                        </strong>
                    </div>

                    <div class="info-row">
                        <span>Học phí</span>
                        <strong>
                            <c:choose>
                                <c:when test="${not empty classItem.tuitionFeePerSession}">
                                    <fmt:formatNumber value="${classItem.tuitionFeePerSession}" type="number"/>đ / buổi
                                </c:when>
                                <c:otherwise>---</c:otherwise>
                            </c:choose>
                        </strong>
                    </div>

                    <div class="info-row">
                        <span>Số buổi yêu cầu</span>
                        <strong>
                            ${empty classItem.requiredSessions ? '---' : classItem.requiredSessions} buổi
                        </strong>
                    </div>

                    <div class="info-row">
                        <span>Trạng thái</span>
                        <strong>
                            <c:choose>
                                <c:when test="${classItem.status == true}">
                                    <span class="status-pill active">Đang hoạt động</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-pill inactive">Tạm dừng</span>
                                </c:otherwise>
                            </c:choose>
                        </strong>
                    </div>
                </div>

                <div class="note-card">
                    <div class="section-title" style="margin-bottom: 16px;">
                        <div class="section-icon">
                            <span class="material-symbols-rounded">tips_and_updates</span>
                        </div>
                        <div>
                            <h2>Lưu ý</h2>
                            <p>Trước khi sinh buổi học</p>
                        </div>
                    </div>

                    <div class="note-list">
                        <div class="note-item">
                            <span class="material-symbols-rounded">check_circle</span>
                            <div>
                                Lớp cần có lịch học hàng tuần trước khi sinh buổi học.
                            </div>
                        </div>

                        <div class="note-item">
                            <span class="material-symbols-rounded">check_circle</span>
                            <div>
                                Ngày kết thúc phải lớn hơn hoặc bằng ngày bắt đầu.
                            </div>
                        </div>

                        <div class="note-item">
                            <span class="material-symbols-rounded">check_circle</span>
                            <div>
                                Sau khi sinh thành công, hệ thống sẽ quay lại trang chi tiết lớp.
                            </div>
                        </div>

                        <div class="note-item">
                            <span class="material-symbols-rounded">info</span>
                            <div>
                                Nếu muốn nhập thứ học và giờ học trực tiếp ở màn này,
                                cần bổ sung thêm field vào <strong>GenerateSessionsRequest</strong>.
                            </div>
                        </div>
                    </div>
                </div>

            </aside>
        </section>

    </div>
</main>

<script>
    document.getElementById('generateSessionsForm').addEventListener('submit', function (event) {
        const startDate = document.getElementById('startDate').value;
        const endDate = document.getElementById('endDate').value;

        if (!startDate || !endDate) {
            event.preventDefault();
            alert('Vui lòng nhập đầy đủ ngày bắt đầu và ngày kết thúc.');
            return;
        }

        if (endDate < startDate) {
            event.preventDefault();
            alert('Ngày kết thúc phải lớn hơn hoặc bằng ngày bắt đầu.');
        }
    });
</script>

</body>
</html>
