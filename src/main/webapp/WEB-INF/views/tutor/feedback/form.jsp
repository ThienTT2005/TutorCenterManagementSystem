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
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0"/>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/tutor-dashboard.css">

    
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
                                                    <option value="Xuất sắc">Xuất sắc</option>
                                                    <option value="Giỏi">Giỏi</option>
                                                    <option value="Khá">Khá</option>
                                                    <option value="Trung bình">Trung bình</option>
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
