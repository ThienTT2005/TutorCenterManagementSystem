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
