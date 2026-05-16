<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

            <c:set var="activePage" value="homework" scope="request" />

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <title>Bài tập buổi học | TCMS Tutor</title>
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

                    <main class="homework-page">

                        <section class="homework-hero">
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
                                        <c:out
                                            value="${empty sessionItem.status ? 'Chưa cập nhật' : sessionItem.status}" />
                                    </span>
                                </div>

                                <h1>Bài tập buổi học</h1>

                                <div class="hero-meta">
                                    <span>
                                        <i class="fa-regular fa-calendar"></i>
                                        <c:out
                                            value="${empty sessionItem.sessionDate ? 'Chưa có ngày' : sessionItem.sessionDate}" />
                                    </span>

                                    <span>
                                        <i class="fa-regular fa-clock"></i>
                                        <c:out
                                            value="${empty sessionItem.startTime ? '--:--' : sessionItem.startTime}" />
                                        -
                                        <c:out value="${empty sessionItem.endTime ? '--:--' : sessionItem.endTime}" />
                                    </span>

                                    <span>
                                        <i class="fa-solid fa-pen-to-square"></i>
                                        ${empty homeworks ? 0 : fn:length(homeworks)} bài tập
                                    </span>
                                </div>
                            </div>

                            <div class="hero-actions">
                                <c:choose>
                                    <c:when test="${not empty sessionItem.classEntity}">
                                        <a href="${pageContext.request.contextPath}/tutor/classes/${sessionItem.classEntity.classId}"
                                            class="btn-soft">
                                            <i class="fa-solid fa-arrow-left"></i>
                                            Quay lại lớp học
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/tutor/classes" class="btn-soft">
                                            <i class="fa-solid fa-arrow-left"></i>
                                            Quay lại lớp học
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                                <a href="${pageContext.request.contextPath}/tutor/homework/create?sessionId=${sessionItem.sessionId}"
                                   class="btn-primary">
                                    <i class="fa-solid fa-plus"></i>
                                    Tạo bài tập mới
                                </a>
                            </div>
                        </section>

                        <section class="stats-grid">
                            <div class="stat-mini">
                                <span>Tổng bài tập</span>
                                <strong>${empty homeworks ? 0 : fn:length(homeworks)}</strong>
                            </div>

                            <div class="stat-mini">
                                <span>Trắc nghiệm</span>
                                <strong>
                                    <c:set var="mcCount" value="0" />
                                    <c:forEach var="hw" items="${homeworks}">
                                        <c:if test="${hw.type == 'MULTIPLE_CHOICE'}">
                                            <c:set var="mcCount" value="${mcCount + 1}" />
                                        </c:if>
                                    </c:forEach>
                                    ${mcCount}
                                </strong>
                            </div>

                            <div class="stat-mini">
                                <span>Tự luận</span>
                                <strong>
                                    <c:set var="essayCount" value="0" />
                                    <c:forEach var="hw" items="${homeworks}">
                                        <c:if test="${hw.type == 'ESSAY'}">
                                            <c:set var="essayCount" value="${essayCount + 1}" />
                                        </c:if>
                                    </c:forEach>
                                    ${essayCount}
                                </strong>
                            </div>

                            <div class="stat-mini">
                                <span>Buổi học</span>
                                <strong>#
                                    <c:out value="${sessionItem.sessionId}" />
                                </strong>
                            </div>
                        </section>

                        <section class="homework-layout">

                            <div class="panel-card">
                                <div class="panel-header">
                                    <div>
                                        <h2>Danh sách bài tập</h2>
                                        <p>Các bài tập đã tạo cho buổi học này.</p>
                                    </div>
                                </div>



                                <c:choose>
                                    <c:when test="${not empty homeworks}">
                                        <div class="homework-list">
                                            <c:forEach var="hw" items="${homeworks}">
                                                <article class="homework-card">
                                                    <div class="homework-top">
                                                        <div>
                                                            <h3 class="homework-title">
                                                                <c:out
                                                                    value="${empty hw.title ? 'Bài tập' : hw.title}" />
                                                            </h3>

                                                            <div class="hero-badges">
                                                                <c:choose>
                                                                    <c:when test="${hw.type == 'MULTIPLE_CHOICE'}">
                                                                        <span class="badge purple">
                                                                            <i class="fa-solid fa-list-check"></i>
                                                                            Trắc nghiệm
                                                                        </span>
                                                                    </c:when>
                                                                    <c:when test="${hw.type == 'ESSAY'}">
                                                                        <span class="badge orange">
                                                                            <i class="fa-solid fa-file-lines"></i>
                                                                            Tự luận
                                                                        </span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="badge gray">
                                                                            <c:out
                                                                                value="${empty hw.type ? 'Chưa rõ loại' : hw.type}" />
                                                                        </span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <p class="homework-content">
                                                        <c:out
                                                            value="${empty hw.content ? 'Chưa có nội dung mô tả.' : hw.content}" />
                                                    </p>

                                                    <div class="homework-meta">
                                                        <div class="meta-box">
                                                            <span>Deadline</span>
                                                            <strong>
                                                                <c:out
                                                                    value="${empty hw.deadline ? 'Chưa cập nhật' : hw.deadline}" />
                                                            </strong>
                                                        </div>

                                                        <div class="meta-box">
                                                            <span>Câu hỏi</span>
                                                            <strong>
                                                                <c:choose>
                                                                    <c:when test="${hw.type == 'ESSAY'}">1</c:when>
                                                                    <c:when test="${hw.type == 'MULTIPLE_CHOICE'}">
                                                                        <c:choose>
                                                                            <c:when test="${not empty questionCountMap}">
                                                                                ${empty questionCountMap[hw.homeworkId] ? 0 : questionCountMap[hw.homeworkId]}
                                                                            </c:when>
                                                                            <c:otherwise>0</c:otherwise>
                                                                        </c:choose>
                                                                    </c:when>
                                                                    <c:otherwise>---</c:otherwise>
                                                                </c:choose>
                                                            </strong>
                                                        </div>

                                                        <div class="meta-box">
                                                            <span>Bài nộp</span>
                                                            <strong>
                                                                <c:choose>
                                                                    <c:when test="${not empty submissionCountMap}">
                                                                        ${empty submissionCountMap[hw.homeworkId] ? 0 :
                                                                        submissionCountMap[hw.homeworkId]}
                                                                    </c:when>
                                                                    <c:otherwise>0</c:otherwise>
                                                                </c:choose>
                                                            </strong>
                                                        </div>
                                                    </div>

                                                    <c:if test="${not empty hw.attachmentUrl}">
                                                        <div class="meta-box" style="margin-bottom: 1rem;">
                                                            <span>Tệp / Link đính kèm</span>
                                                            <a href="${hw.attachmentUrl}" target="_blank">
                                                                <i class="fa-solid fa-paperclip"></i>
                                                                Mở tài liệu
                                                            </a>
                                                        </div>
                                                    </c:if>

                                                    <div class="homework-actions">
                                                        <a href="${pageContext.request.contextPath}/tutor/homework/${hw.homeworkId}/edit"
                                                           class="btn-soft">
                                                            <i class="fa-solid fa-pen-to-square"></i>
                                                            Sửa bài tập
                                                        </a>

                                                        <a href="${pageContext.request.contextPath}/tutor/homework/submissions/homework/${hw.homeworkId}"
                                                           class="btn-soft">
                                                            <i class="fa-solid fa-users-viewfinder"></i>
                                                            Xem bài nộp
                                                        </a>
                                                    </div>
                                                </article>
                                            </c:forEach>
                                        </div>
                                    </c:when>

                                    <c:otherwise>
                                        <div class="empty-card">
                                            <i class="fa-regular fa-folder-open"></i>
                                            <h3>Chưa có bài tập</h3>
                                            <p>Hãy tạo bài tập đầu tiên cho buổi học này.</p>
                                            <a href="${pageContext.request.contextPath}/tutor/homework/create?sessionId=${sessionItem.sessionId}"
                                                class="btn-primary">
                                                <i class="fa-solid fa-plus"></i>
                                                Tạo bài tập mới
                                            </a>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>

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
                                                <c:out
                                                    value="${empty sessionItem.sessionDate ? '---' : sessionItem.sessionDate}" />
                                            </strong>
                                        </div>

                                        <div class="info-row">
                                            <span>Thời gian</span>
                                            <strong>
                                                <c:out
                                                    value="${empty sessionItem.startTime ? '--:--' : sessionItem.startTime}" />
                                                -
                                                <c:out
                                                    value="${empty sessionItem.endTime ? '--:--' : sessionItem.endTime}" />
                                            </strong>
                                        </div>

                                        <div class="info-row">
                                            <span>Chủ đề</span>
                                            <strong>
                                                <c:out
                                                    value="${empty sessionItem.topic ? 'Chưa cập nhật' : sessionItem.topic}" />
                                            </strong>
                                        </div>

                                        <div class="info-row">
                                            <span>Trạng thái</span>
                                            <strong>
                                                <c:out
                                                    value="${empty sessionItem.status ? '---' : sessionItem.status}" />
                                            </strong>
                                        </div>
                                    </div>
                                </div>

                                <div class="side-card">
                                    <h3>Thao tác nhanh</h3>

                                    <div class="quick-link-list">
                                        <a href="${pageContext.request.contextPath}/tutor/homework/create?sessionId=${sessionItem.sessionId}"
                                            class="quick-link">
                                            <i class="fa-solid fa-plus"></i>
                                            Tạo bài tập mới
                                        </a>

                                        <c:if test="${not empty sessionItem.classEntity}">
                                            <a href="${pageContext.request.contextPath}/tutor/classes/${sessionItem.classEntity.classId}"
                                                class="quick-link">
                                                <i class="fa-solid fa-arrow-left"></i>
                                                Quay lại chi tiết lớp
                                            </a>
                                        </c:if>

                                        <a href="${pageContext.request.contextPath}/tutor/sessions/${sessionItem.sessionId}/learning-plan"
                                            class="quick-link">
                                            <i class="fa-solid fa-clipboard-list"></i>
                                            Xem kế hoạch bài học
                                        </a>
                                    </div>
                                </div>
                            </aside>

                        </section>
                    </main>
                </div>

            </body>

            </html>