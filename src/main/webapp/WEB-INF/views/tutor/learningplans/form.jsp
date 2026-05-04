<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="activePage" value="classes" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Kế hoạch bài học | TCMS Tutor</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/tutor-dashboard.css">

    <style>
        .learning-plan-page {
            padding: 2rem;
        }

        .plan-hero {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 24px;
            padding: 1.75rem;
            box-shadow: 0 8px 24px rgba(15, 23, 42, 0.05);
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .hero-badges {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            margin-bottom: 12px;
        }

        .badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 11px;
            border-radius: 999px;
            font-size: 11px;
            font-weight: 900;
            white-space: nowrap;
        }

        .badge.blue {
            background: #eff6ff;
            color: #0057bf;
        }

        .badge.green {
            background: #dcfce7;
            color: #16a34a;
        }

        .badge.orange {
            background: #fff7ed;
            color: #ea580c;
        }

        .badge.gray {
            background: #f1f5f9;
            color: #64748b;
        }

        .plan-hero h1 {
            font-size: 28px;
            line-height: 1.25;
            font-weight: 900;
            color: #0f172a;
            margin-bottom: 10px;
        }

        .hero-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 16px;
            color: #64748b;
            font-size: 14px;
            font-weight: 600;
        }

        .hero-meta span {
            display: inline-flex;
            align-items: center;
            gap: 7px;
        }

        .btn-back {
            min-height: 42px;
            padding: 0 18px;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
            background: #ffffff;
            color: #0f172a;
            font-size: 14px;
            font-weight: 800;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            white-space: nowrap;
            transition: all .2s ease;
        }

        .btn-back:hover {
            background: #eff6ff;
            color: #0057bf;
            border-color: #0057bf;
        }

        .plan-grid {
            display: grid;
            grid-template-columns: minmax(0, 1.8fr) 360px;
            gap: 1.5rem;
            align-items: start;
        }

        .form-card,
        .side-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 22px;
            box-shadow: 0 8px 24px rgba(15, 23, 42, 0.05);
        }

        .form-card {
            padding: 1.5rem;
        }

        .side-column {
            display: flex;
            flex-direction: column;
            gap: 1rem;
            position: sticky;
            top: 86px;
        }

        .side-card {
            padding: 1.35rem;
        }

        .form-header {
            margin-bottom: 1.25rem;
        }

        .form-header h2,
        .side-card h3 {
            font-size: 18px;
            font-weight: 900;
            color: #0f172a;
            margin-bottom: 6px;
        }

        .form-header p {
            color: #64748b;
            font-size: 13px;
            line-height: 1.6;
        }

        .error-alert {
            background: #fee2e2;
            color: #dc2626;
            border-radius: 14px;
            padding: 13px 15px;
            font-size: 13px;
            font-weight: 700;
            display: flex;
            align-items: flex-start;
            gap: 9px;
            margin-bottom: 1rem;
        }

        .warning-alert {
            background: #fff7ed;
            color: #ea580c;
            border-radius: 14px;
            padding: 13px 15px;
            font-size: 13px;
            font-weight: 700;
            display: flex;
            align-items: flex-start;
            gap: 9px;
            margin-bottom: 1rem;
        }

        .plan-form {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .form-group label {
            color: #0f172a;
            font-size: 13px;
            font-weight: 850;
        }

        .required {
            color: #dc2626;
        }

        .form-control {
            height: 46px;
            border: 1px solid #dbe3ef;
            border-radius: 12px;
            padding: 0 14px;
            outline: none;
            color: #0f172a;
            background: #ffffff;
            font-size: 14px;
            transition: all .2s ease;
        }

        .form-textarea {
            min-height: 130px;
            border: 1px solid #dbe3ef;
            border-radius: 12px;
            padding: 12px 14px;
            outline: none;
            resize: vertical;
            color: #0f172a;
            background: #ffffff;
            font-size: 14px;
            line-height: 1.55;
            transition: all .2s ease;
        }

        .form-textarea.large {
            min-height: 190px;
        }

        .form-control:focus,
        .form-textarea:focus {
            border-color: #0057bf;
            box-shadow: 0 0 0 4px rgba(0, 87, 191, 0.08);
        }

        .hint {
            color: #64748b;
            font-size: 12px;
            line-height: 1.5;
        }

        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 12px;
            margin-top: 1rem;
            padding-top: 1.25rem;
            border-top: 1px solid #f1f5f9;
        }

        .btn-soft,
        .btn-submit {
            min-height: 44px;
            padding: 0 18px;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 900;
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
            color: #0f172a;
            border: 1px solid #e2e8f0;
        }

        .btn-soft:hover {
            background: #eff6ff;
            color: #0057bf;
            border-color: #0057bf;
        }

        .btn-submit {
            background: #0057bf;
            color: #ffffff;
            border: 0;
            box-shadow: 0 8px 18px rgba(0, 87, 191, 0.18);
        }

        .btn-submit:hover {
            background: #004da8;
            transform: translateY(-1px);
        }

        .info-list {
            display: flex;
            flex-direction: column;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            gap: 12px;
            padding: 12px 0;
            border-bottom: 1px solid #f1f5f9;
            font-size: 13px;
        }

        .info-row:last-child {
            border-bottom: 0;
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

        .guide-list {
            display: flex;
            flex-direction: column;
            gap: 12px;
            color: #475569;
            font-size: 13px;
            line-height: 1.55;
        }

        .guide-item {
            display: flex;
            gap: 10px;
            align-items: flex-start;
        }

        .guide-item i {
            color: #0057bf;
            margin-top: 3px;
        }

        @media (max-width: 1100px) {
            .plan-grid {
                grid-template-columns: 1fr;
            }

            .side-column {
                position: static;
            }
        }

        @media (max-width: 760px) {
            .learning-plan-page {
                padding: 1rem;
            }

            .plan-hero,
            .form-actions {
                flex-direction: column;
            }

            .btn-soft,
            .btn-submit {
                width: 100%;
            }
        }
        .plan-preview-card {
            background: #ffffff;
        }

        .preview-section {
            padding: 12px 0;
            border-bottom: 1px solid #f1f5f9;
        }

        .preview-section:last-child {
            border-bottom: 0;
        }

        .preview-section span {
            display: block;
            color: #64748b;
            font-size: 12px;
            font-weight: 800;
            margin-bottom: 6px;
            text-transform: uppercase;
        }

        .preview-section strong {
            display: block;
            color: #0f172a;
            font-size: 15px;
            font-weight: 900;
            line-height: 1.5;
        }

        .preview-section p {
            color: #475569;
            font-size: 13px;
            line-height: 1.65;
            white-space: pre-line;
        }

        .empty-plan {
            background: #fff7ed;
            border-color: #fed7aa;
        }

        .empty-plan h3 {
            color: #ea580c;
        }

        .empty-plan p {
            color: #9a3412;
            font-size: 13px;
            line-height: 1.6;
        }
    </style>
</head>

<body>

<jsp:include page="../common/sidebar.jsp" />

<div class="main-content">
    <jsp:include page="../common/header.jsp" />

    <main class="learning-plan-page">

        <!-- HEADER -->
        <section class="plan-hero">
            <div>
                <div class="hero-badges">
                    <span class="badge blue">
                        <i class="fa-solid fa-book-open"></i>
                        <c:choose>
                            <c:when test="${not empty sessionItem.classEntity}">
                                <c:out value="${sessionItem.classEntity.className}" />
                            </c:when>
                            <c:otherwise>Lớp học</c:otherwise>
                        </c:choose>
                    </span>

                    <span class="badge gray">
                        <i class="fa-solid fa-circle-info"></i>
                        <c:out value="${empty sessionItem.status ? 'Chưa cập nhật' : sessionItem.status}" />
                    </span>
                </div>

                <h1>Kế hoạch bài học</h1>

                <div class="hero-meta">
                    <span>
                        <i class="fa-regular fa-calendar"></i>
                        <c:out value="${empty sessionItem.sessionDate ? 'Chưa có ngày' : sessionItem.sessionDate}" />
                    </span>

                    <span>
                        <i class="fa-regular fa-clock"></i>
                        <c:out value="${empty sessionItem.startTime ? '--:--' : sessionItem.startTime}" />
                        -
                        <c:out value="${empty sessionItem.endTime ? '--:--' : sessionItem.endTime}" />
                    </span>

                    <span>
                        <i class="fa-solid fa-hashtag"></i>
                        Buổi học #<c:out value="${sessionItem.sessionId}" />
                    </span>
                </div>
            </div>

            <c:choose>
                <c:when test="${not empty sessionItem.classEntity}">
                    <a href="${pageContext.request.contextPath}/tutor/classes/${sessionItem.classEntity.classId}"
                       class="btn-back">
                        <i class="fa-solid fa-arrow-left"></i>
                        Quay lại lớp học
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/tutor/classes"
                       class="btn-back">
                        <i class="fa-solid fa-arrow-left"></i>
                        Quay lại lớp học
                    </a>
                </c:otherwise>
            </c:choose>
        </section>

        <section class="plan-grid">

            <!-- LEFT: FORM -->
            <div class="form-card">
                <div class="form-header">
                    <h2>Soạn kế hoạch cho buổi học</h2>
                    <p>
                        Điền tiêu đề bài học, mục tiêu cần đạt và nội dung chi tiết.
                        Hệ thống chỉ cho phép tạo hoặc cập nhật giáo án trước khi buổi học bắt đầu.
                    </p>
                </div>

                <c:if test="${not empty error}">
                    <div class="error-alert">
                        <i class="fa-solid fa-circle-exclamation"></i>
                        <span><c:out value="${error}" /></span>
                    </div>
                </c:if>


                <form class="plan-form"
                      action="${pageContext.request.contextPath}/tutor/sessions/${sessionItem.sessionId}/learning-plan"
                      method="post"
                      id="learningPlanForm">

                    <input type="hidden" name="sessionId" value="${sessionItem.sessionId}" />

                    <div class="form-group">
                        <label for="title">
                            Tiêu đề bài học <span class="required">*</span>
                        </label>

                        <input type="text"
                               id="title"
                               name="title"
                               class="form-control"
                               value="${request.title}"
                               placeholder="Ví dụ: Hàm số bậc hai và đồ thị"
                               required>

                        <div class="hint">
                            Tên bài học không được để trống.
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="objectives">
                            Mục tiêu buổi học <span class="required">*</span>
                        </label>

                        <textarea id="objectives"
                                  name="objectives"
                                  class="form-textarea"
                                  placeholder="Ví dụ: Học sinh hiểu khái niệm, biết vẽ đồ thị, giải được bài tập cơ bản..."
                                  required>${request.objectives}</textarea>

                        <div class="hint">
                            Nêu rõ học sinh cần đạt được gì sau buổi học.
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="content">
                            Nội dung chi tiết <span class="required">*</span>
                        </label>

                        <textarea id="content"
                                  name="content"
                                  class="form-textarea large"
                                  placeholder="Nhập nội dung giảng dạy, các bước triển khai bài học, phần luyện tập, tài liệu cần chuẩn bị..."
                                  required>${request.content}</textarea>

                        <div class="hint">
                            Nội dung bài học không được để trống.
                        </div>
                    </div>

                    <div class="form-actions">
                        <c:choose>
                            <c:when test="${not empty sessionItem.classEntity}">
                                <a href="${pageContext.request.contextPath}/tutor/classes/${sessionItem.classEntity.classId}"
                                   class="btn-soft">
                                    <i class="fa-solid fa-arrow-left"></i>
                                    Quay lại lớp
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/tutor/classes"
                                   class="btn-soft">
                                    <i class="fa-solid fa-arrow-left"></i>
                                    Quay lại lớp
                                </a>
                            </c:otherwise>
                        </c:choose>

                        <button type="submit" class="btn-submit">
                            <i class="fa-solid fa-floppy-disk"></i>
                            Lưu kế hoạch
                        </button>
                    </div>
                </form>
            </div>

            <!-- RIGHT: SESSION INFO -->
            <aside class="side-column">

                <div class="side-card">
                    <h3>Thông tin buổi học</h3>

                    <div class="info-list">
                        <div class="info-row">
                            <span>Lớp</span>
                            <strong>
                                <c:choose>
                                    <c:when test="${not empty sessionItem.classEntity}">
                                        <c:out value="${sessionItem.classEntity.className}" />
                                    </c:when>
                                    <c:otherwise>---</c:otherwise>
                                </c:choose>
                            </strong>
                        </div>

                        <div class="info-row">
                            <span>Môn học</span>
                            <strong>
                                <c:choose>
                                    <c:when test="${not empty sessionItem.classEntity}">
                                        <c:out value="${empty sessionItem.classEntity.subject ? '---' : sessionItem.classEntity.subject}" />
                                    </c:when>
                                    <c:otherwise>---</c:otherwise>
                                </c:choose>
                            </strong>
                        </div>

                        <div class="info-row">
                            <span>Khối</span>
                            <strong>
                                <c:choose>
                                    <c:when test="${not empty sessionItem.classEntity}">
                                        <c:out value="${empty sessionItem.classEntity.grade ? '---' : sessionItem.classEntity.grade}" />
                                    </c:when>
                                    <c:otherwise>---</c:otherwise>
                                </c:choose>
                            </strong>
                        </div>

                        <div class="info-row">
                            <span>Ngày học</span>
                            <strong>
                                <c:out value="${empty sessionItem.sessionDate ? '---' : sessionItem.sessionDate}" />
                            </strong>
                        </div>

                        <div class="info-row">
                            <span>Thời gian</span>
                            <strong>
                                <c:out value="${empty sessionItem.startTime ? '--:--' : sessionItem.startTime}" />
                                -
                                <c:out value="${empty sessionItem.endTime ? '--:--' : sessionItem.endTime}" />
                            </strong>
                        </div>


                        <div class="info-row">
                            <span>Trạng thái</span>
                            <strong>
                                <c:out value="${empty sessionItem.status ? '---' : sessionItem.status}" />
                            </strong>
                        </div>
                    </div>
                </div>

                <div class="side-card">
                    <h3>Lưu ý</h3>

                    <div class="guide-list">
                        <div class="guide-item">
                            <i class="fa-solid fa-circle-check"></i>
                            <div>
                                Tiêu đề bài học, mục tiêu và nội dung chi tiết đều bắt buộc nhập.
                            </div>
                        </div>

                        <div class="guide-item">
                            <i class="fa-solid fa-clock"></i>
                            <div>
                                Chỉ cho phép lưu trước thời điểm bắt đầu buổi học.
                            </div>
                        </div>

                        <div class="guide-item">
                            <i class="fa-solid fa-rotate"></i>
                            <div>
                                Nếu buổi học đã có giáo án, lưu lại sẽ cập nhật nội dung cũ.
                            </div>
                        </div>

                        <div class="guide-item">
                            <i class="fa-solid fa-shield-halved"></i>
                            <div>
                                Gia sư chỉ được tạo kế hoạch cho buổi học thuộc lớp mình phụ trách.
                            </div>
                        </div>
                    </div>
                </div>

            </aside>
        </section>

    </main>
</div>

<script>
    document.getElementById('learningPlanForm').addEventListener('submit', function (event) {
        const title = document.getElementById('title').value.trim();
        const objectives = document.getElementById('objectives').value.trim();
        const content = document.getElementById('content').value.trim();

        if (!title) {
            event.preventDefault();
            alert('Tên bài học không được để trống.');
            return;
        }

        if (!objectives) {
            event.preventDefault();
            alert('Mục tiêu buổi học không được để trống.');
            return;
        }

        if (!content) {
            event.preventDefault();
            alert('Nội dung bài học không được để trống.');
        }
    });
</script>

</body>
</html>
