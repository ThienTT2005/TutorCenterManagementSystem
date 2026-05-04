<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="activePage" value="feedback" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Feedback buổi học | TCMS Tutor</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/tutor-dashboard.css">

    <style>
        .feedback-page {
            padding: 2rem;
        }

        .feedback-hero {
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

        .badge.red {
            background: #fee2e2;
            color: #dc2626;
        }

        .badge.gray {
            background: #f1f5f9;
            color: #64748b;
        }

        .feedback-hero h1 {
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

        .feedback-grid {
            display: grid;
            grid-template-columns: minmax(0, 1.8fr) 360px;
            gap: 1.5rem;
            align-items: start;
        }

        .panel-card,
        .side-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 22px;
            box-shadow: 0 8px 24px rgba(15, 23, 42, 0.05);
        }

        .panel-card {
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

        .panel-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 1rem;
            margin-bottom: 1.25rem;
        }

        .panel-header h2,
        .side-card h3 {
            font-size: 18px;
            font-weight: 900;
            color: #0f172a;
        }

        .panel-header p {
            margin-top: 5px;
            color: #64748b;
            font-size: 13px;
            line-height: 1.5;
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

        .feedback-form {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .student-feedback-card {
            border: 1px solid #e2e8f0;
            border-radius: 18px;
            padding: 1.15rem;
            background: #ffffff;
            transition: all .2s ease;
        }

        .student-feedback-card:hover {
            box-shadow: 0 8px 18px rgba(15, 23, 42, 0.06);
            transform: translateY(-1px);
        }

        .student-feedback-top {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .student-info {
            display: flex;
            align-items: center;
            gap: 10px;
            min-width: 0;
        }

        .avatar {
            width: 42px;
            height: 42px;
            border-radius: 999px;
            background: #eff6ff;
            color: #0057bf;
            font-size: 14px;
            font-weight: 900;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            text-transform: uppercase;
        }

        .student-name {
            color: #0f172a;
            font-size: 15px;
            font-weight: 900;
        }

        .student-sub {
            margin-top: 3px;
            color: #94a3b8;
            font-size: 12px;
            font-weight: 600;
        }

        .form-row {
            display: grid;
            grid-template-columns: 220px 1fr;
            gap: 1rem;
            align-items: start;
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

        .rating-select {
            height: 44px;
            border: 1px solid #dbe3ef;
            border-radius: 12px;
            padding: 0 12px;
            outline: none;
            color: #0f172a;
            background: #ffffff;
            font-size: 14px;
            transition: all .2s ease;
        }

        .comment-textarea {
            min-height: 92px;
            border: 1px solid #dbe3ef;
            border-radius: 12px;
            padding: 12px 14px;
            outline: none;
            resize: vertical;
            color: #0f172a;
            background: #ffffff;
            font-size: 14px;
            line-height: 1.5;
            transition: all .2s ease;
        }

        .rating-select:focus,
        .comment-textarea:focus {
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

        .old-feedback-list {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .old-feedback-item {
            border: 1px solid #e2e8f0;
            border-radius: 14px;
            padding: 12px;
            background: #f8fafc;
        }

        .old-feedback-top {
            display: flex;
            justify-content: space-between;
            gap: 10px;
            margin-bottom: 6px;
        }

        .old-feedback-top strong {
            color: #0f172a;
            font-size: 13px;
            font-weight: 900;
        }

        .old-feedback-top span {
            color: #0057bf;
            font-size: 12px;
            font-weight: 900;
        }

        .old-feedback-item p {
            color: #475569;
            font-size: 13px;
            line-height: 1.5;
        }

        .empty-card {
            text-align: center;
            color: #64748b;
            font-size: 14px;
            padding: 2rem !important;
        }

        @media (max-width: 1100px) {
            .feedback-grid {
                grid-template-columns: 1fr;
            }

            .side-column {
                position: static;
            }
        }

        @media (max-width: 760px) {
            .feedback-page {
                padding: 1rem;
            }

            .feedback-hero,
            .student-feedback-top,
            .form-actions {
                flex-direction: column;
            }

            .form-row {
                grid-template-columns: 1fr;
            }

            .btn-soft,
            .btn-submit {
                width: 100%;
            }
        }
    </style>
</head>

<body>

<jsp:include page="../common/sidebar.jsp" />

<div class="main-content">
    <jsp:include page="../common/header.jsp" />

    <main class="feedback-page">

        <!-- HEADER -->
        <section class="feedback-hero">
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

                    <c:choose>
                        <c:when test="${sessionItem.status == 'COMPLETED'}">
                            <span class="badge green">
                                <i class="fa-solid fa-circle-check"></i>
                                Đã hoàn thành
                            </span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge orange">
                                <i class="fa-solid fa-triangle-exclamation"></i>
                                <c:out value="${empty sessionItem.status ? 'Chưa cập nhật' : sessionItem.status}" />
                            </span>
                        </c:otherwise>
                    </c:choose>
                </div>

                <h1>Feedback buổi học</h1>

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
                        <i class="fa-solid fa-user-group"></i>
                        ${empty enrollments ? 0 : fn:length(enrollments)} học sinh
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

        <section class="feedback-grid">

            <!-- LEFT: FORM -->
            <div class="panel-card">
                <div class="panel-header">
                    <div>
                        <h2>Nhận xét học sinh</h2>
                        <p>
                            Nhập nhận xét và chọn đánh giá cho từng học sinh.
                            Học sinh nào không nhập comment sẽ không được tạo feedback.
                        </p>
                    </div>
                </div>

                <c:if test="${not empty error}">
                    <div class="error-alert">
                        <i class="fa-solid fa-circle-exclamation"></i>
                        <span><c:out value="${error}" /></span>
                    </div>
                </c:if>

                <c:if test="${sessionItem.status != 'COMPLETED'}">
                    <div class="warning-alert">
                        <i class="fa-solid fa-triangle-exclamation"></i>
                        <span>
                            Theo backend hiện tại, chỉ được gửi feedback sau khi buổi học đã hoàn thành.
                        </span>
                    </div>
                </c:if>

                <form class="feedback-form"
                      action="${pageContext.request.contextPath}/tutor/sessions/${sessionItem.sessionId}/feedback"
                      method="post"
                      id="feedbackForm">

                    <input type="hidden" name="sessionId" value="${sessionItem.sessionId}" />

                    <c:choose>
                        <c:when test="${not empty enrollments}">
                            <c:forEach var="e" items="${enrollments}">
                                <c:if test="${not empty e.student}">
                                    <div class="student-feedback-card">
                                        <div class="student-feedback-top">
                                            <div class="student-info">
                                                <div class="avatar">
                                                    <c:choose>
                                                        <c:when test="${not empty e.student.fullName}">
                                                            ${fn:substring(e.student.fullName, 0, 1)}
                                                        </c:when>
                                                        <c:otherwise>?</c:otherwise>
                                                    </c:choose>
                                                </div>

                                                <div>
                                                    <div class="student-name">
                                                        <c:out value="${empty e.student.fullName ? 'Học sinh' : e.student.fullName}" />
                                                    </div>
                                                    <div class="student-sub">
                                                        ID:
                                                        <c:out value="${e.student.studentId}" />
                                                        <c:if test="${not empty e.student.grade}">
                                                            • Khối <c:out value="${e.student.grade}" />
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </div>

                                            <span class="badge gray">
                                                <i class="fa-solid fa-user-graduate"></i>
                                                Học sinh
                                            </span>
                                        </div>

                                        <div class="form-row">
                                            <div class="form-group">
                                                <label for="rating-${e.student.studentId}">
                                                    Đánh giá
                                                </label>

                                                <select id="rating-${e.student.studentId}"
                                                        name="ratings[${e.student.studentId}]"
                                                        class="rating-select">
                                                    <option value="">-- Chọn đánh giá --</option>
                                                    <option value="Xuất_sắc">Xuất sắc</option>
                                                    <option value="Giỏi">Giỏi</option>
                                                    <option value="Khá">Khá</option>
                                                    <option value="Trung_bình">Trung bình</option>
                                                    <option value="Yếu">Yếu</option>
                                                </select>

                                                <div class="hint">
                                                    Bắt buộc chọn nếu có nhập nhận xét.
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="comment-${e.student.studentId}">
                                                    Nhận xét
                                                </label>

                                                <textarea id="comment-${e.student.studentId}"
                                                          name="comments[${e.student.studentId}]"
                                                          class="comment-textarea"
                                                          placeholder="Nhập nhận xét về thái độ học tập, mức độ hiểu bài, bài tập cần cải thiện..."></textarea>

                                                <div class="hint">
                                                    Nếu để trống, hệ thống sẽ bỏ qua feedback của học sinh này.
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </c:when>

                        <c:otherwise>
                            <div class="empty-card">
                                Chưa có học sinh trong lớp này.
                            </div>
                        </c:otherwise>
                    </c:choose>

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
                            <i class="fa-solid fa-paper-plane"></i>
                            Gửi feedback
                        </button>
                    </div>
                </form>
            </div>

            <!-- RIGHT -->
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
                            <span>Chủ đề</span>
                            <strong>
                                <c:out value="${empty sessionItem.topic ? 'Chưa cập nhật' : sessionItem.topic}" />
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
                    <h3>Quy định feedback</h3>

                    <div class="guide-list">
                        <div class="guide-item">
                            <i class="fa-solid fa-circle-check"></i>
                            <div>
                                Chỉ được gửi feedback sau khi buổi học đã hoàn thành.
                            </div>
                        </div>

                        <div class="guide-item">
                            <i class="fa-solid fa-circle-check"></i>
                            <div>
                                Nếu nhập nhận xét cho học sinh thì bắt buộc phải chọn đánh giá.
                            </div>
                        </div>

                        <div class="guide-item">
                            <i class="fa-solid fa-clock"></i>
                            <div>
                                Feedback gửi muộn sau hạn có thể bị ghi nhận phạt theo quy định hệ thống.
                            </div>
                        </div>

                        <div class="guide-item">
                            <i class="fa-solid fa-shield-halved"></i>
                            <div>
                                Feedback gửi xong sẽ ở trạng thái chờ admin duyệt.
                            </div>
                        </div>
                    </div>
                </div>

                <div class="side-card">
                    <h3>Feedback đã gửi</h3>

                    <c:choose>
                        <c:when test="${not empty feedbacks}">
                            <div class="old-feedback-list">
                                <c:forEach var="fb" items="${feedbacks}">
                                    <div class="old-feedback-item">
                                        <div class="old-feedback-top">
                                            <strong>
                                                <c:choose>
                                                    <c:when test="${not empty fb.student}">
                                                        <c:out value="${empty fb.student.fullName ? 'Học sinh' : fb.student.fullName}" />
                                                    </c:when>
                                                    <c:otherwise>Học sinh</c:otherwise>
                                                </c:choose>
                                            </strong>

                                            <span>
                                                <c:out value="${empty fb.status ? 'PENDING' : fb.status}" />
                                            </span>
                                        </div>

                                        <div style="margin-bottom: 6px;">
                                            <span class="badge blue">
                                                <c:out value="${empty fb.rating ? 'Chưa đánh giá' : fb.rating}" />
                                            </span>
                                        </div>

                                        <p>
                                            <c:out value="${empty fb.comment ? 'Không có nội dung nhận xét.' : fb.comment}" />
                                        </p>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>

                        <c:otherwise>
                            <div class="empty-card">
                                Chưa có feedback nào đã gửi cho buổi học này.
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

            </aside>
        </section>

    </main>
</div>

<script>
    document.getElementById('feedbackForm').addEventListener('submit', function (event) {
        const cards = document.querySelectorAll('.student-feedback-card');
        let hasAnyComment = false;
        let invalidStudentName = '';

        cards.forEach(function (card) {
            const comment = card.querySelector('textarea');
            const rating = card.querySelector('select');
            const nameEl = card.querySelector('.student-name');

            const commentValue = comment ? comment.value.trim() : '';
            const ratingValue = rating ? rating.value.trim() : '';

            if (commentValue.length > 0) {
                hasAnyComment = true;

                if (!ratingValue) {
                    invalidStudentName = nameEl ? nameEl.textContent.trim() : 'học sinh';
                }
            }
        });

        if (invalidStudentName) {
            event.preventDefault();
            alert('Vui lòng chọn đánh giá cho ' + invalidStudentName + '.');
            return;
        }

        if (!hasAnyComment) {
            event.preventDefault();
            alert('Vui lòng nhập feedback cho ít nhất một học sinh.');
        }
    });
</script>

</body>
</html>
