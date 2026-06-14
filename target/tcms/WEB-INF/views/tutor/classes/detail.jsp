<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="activePage" value="classes" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết lớp học | TCMS Tutor</title>
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

    <main class="class-detail-page">

        <!-- HEADER -->
        <section class="class-hero">

            <div class="class-hero-top">
                <div class="class-hero-main">
                    <div class="hero-badges">
                <span class="badge subject">
                    <i class="fa-solid fa-book-open"></i>
                    <c:out value="${empty classItem.subject ? 'Môn học' : classItem.subject}" />
                </span>

                        <span class="badge grade">
                    <i class="fa-solid fa-layer-group"></i>
                    Khối <c:out value="${empty classItem.grade ? '?' : classItem.grade}" />
                </span>

                        <c:choose>
                            <c:when test="${classItem.status == true}">
                        <span class="badge active">
                            <i class="fa-solid fa-circle-check"></i>
                            Đang hoạt động
                        </span>
                            </c:when>
                            <c:otherwise>
                        <span class="badge inactive">
                            <i class="fa-solid fa-circle-xmark"></i>
                            Đã kết thúc
                        </span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <h1>
                        <c:out value="${empty classItem.className ? 'Chi tiết lớp học' : classItem.className}" />
                    </h1>

                    <div class="hero-meta">
                <span>
                    <i class="fa-solid fa-users"></i>
                    ${empty enrollments ? 0 : fn:length(enrollments)} học sinh
                </span>

                        <span>
                    <i class="fa-solid fa-calendar-days"></i>
                    ${empty sessions ? 0 : fn:length(sessions)} buổi học đã tạo
                </span>

                        <span>
                    <i class="fa-solid fa-hashtag"></i>
                    Mã lớp #<c:out value="${classItem.classId}" />
                </span>
                    </div>

                    <p class="hero-desc">
                        <c:out value="${empty classItem.description ? 'Chưa có mô tả cho lớp học này.' : classItem.description}" />
                    </p>
                </div>

                <a href="${pageContext.request.contextPath}/tutor/classes" class="hero-back-btn">
                    <i class="fa-solid fa-arrow-left"></i>
                    Danh sách lớp
                </a>
            </div>

            <div class="quick-card quick-card-light">
                <h3>Thông tin nhanh</h3>

                <div class="quick-info-grid">
                    <div class="quick-info-box">
                        <span>Môn học</span>
                        <strong>
                            <c:out value="${empty classItem.subject ? '---' : classItem.subject}" />
                        </strong>
                    </div>

                    <div class="quick-info-box">
                        <span>Khối lớp</span>
                        <strong>
                            <c:out value="${empty classItem.grade ? '---' : classItem.grade}" />
                        </strong>
                    </div>

                    <div class="quick-info-box">
                        <span>Học phí</span>
                        <strong>
                            <fmt:formatNumber value="${empty classItem.tuitionFeePerSession ? 0 : classItem.tuitionFeePerSession}" pattern="#,###"/>đ/buổi
                        </strong>
                    </div>

                    <div class="quick-info-box">
                        <span>Số buổi yêu cầu</span>
                        <strong>${empty classItem.requiredSessions ? 0 : classItem.requiredSessions} buổi</strong>
                    </div>

                    <div class="quick-info-box">
                        <span>Trạng thái</span>
                        <strong class="${classItem.status ? 'text-success' : 'text-muted'}">
                            ${classItem.status ? 'Đang hoạt động' : 'Đã kết thúc'}
                        </strong>
                    </div>

                    <div class="quick-info-box">
                        <span>Số học sinh</span>
                        <strong>${empty enrollments ? 0 : fn:length(enrollments)} học sinh</strong>
                    </div>
                </div>
            </div>

        </section>
        <!-- STATS -->
        <section class="stats-grid-detail">
            <div class="mini-stat">
                <div class="mini-icon">
                    <i class="fa-solid fa-user-group"></i>
                </div>
                <div>
                    <div class="mini-label">Tổng học sinh</div>
                    <div class="mini-value">${empty enrollments ? 0 : fn:length(enrollments)}</div>
                </div>
            </div>

            <div class="mini-stat">
                <div class="mini-icon" style="background:#f3e8ff;color:#7e22ce;">
                    <i class="fa-solid fa-calendar-days"></i>
                </div>
                <div>
                    <div class="mini-label">Buổi học đã tạo</div>
                    <div class="mini-value">${empty sessions ? 0 : fn:length(sessions)}</div>
                </div>
            </div>

            <div class="mini-stat">
                <div class="mini-icon" style="background:#dcfce7;color:#16a34a;">
                    <i class="fa-solid fa-money-bill-wave"></i>
                </div>
                <div>
                    <div class="mini-label">Học phí / buổi</div>
                    <div class="mini-value" style="font-size:18px;">
                        <c:choose>
                            <c:when test="${not empty classItem.tuitionFeePerSession}">
                                <fmt:formatNumber value="${classItem.tuitionFeePerSession}" pattern="#,###" />đ
                            </c:when>
                            <c:otherwise>0đ</c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <div class="mini-stat">
                <div class="mini-icon" style="background:#fff7ed;color:#ea580c;">
                    <i class="fa-solid fa-list-check"></i>
                </div>
                <div>
                    <div class="mini-label">Số buổi yêu cầu</div>
                    <div class="mini-value">${empty classItem.requiredSessions ? 0 : classItem.requiredSessions}</div>
                </div>
            </div>
        </section>

        <!-- MAIN LAYOUT -->
        <section class="detail-layout">

            <!-- LEFT -->
            <div class="detail-left">

                    <section class="upcoming-section">
                        <h2>
                            <i class="fa-solid fa-calendar-plus"></i>
                            Buổi học gần nhất
                        </h2>

                        <div class="upcoming-grid">
                            <c:choose>
                                <c:when test="${not empty sessions}">
                                    <c:forEach var="s" items="${sessions}" begin="0" end="1">
                                        <div class="upcoming-card">
                                        <span class="badge subject">
                                            <c:out value="${empty s.sessionDate ? 'Chưa có ngày' : s.sessionDate}" />
                                        </span>

                                            <span class="badge gray">
                                            <c:out value="${empty s.status ? 'Chưa cập nhật' : s.status}" />
                                        </span>

                                            <h3>
                                                <c:out value="${empty s.topic ? (empty s.lessonName ? 'Chưa cập nhật chủ đề' : s.lessonName) : s.topic}" />
                                            </h3>

                                            <p>
                                                <i class="fa-regular fa-clock"></i>
                                                <c:out value="${empty s.startTime ? '--:--' : s.startTime}" />
                                                -
                                                <c:out value="${empty s.endTime ? '--:--' : s.endTime}" />
                                            </p>
                                        </div>
                                    </c:forEach>
                                </c:when>

                                <c:otherwise>
                                    <div class="empty-card" style="grid-column: 1 / -1;">
                                        Chưa có buổi học gần nhất.
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </section>

                    <!-- STUDENTS TABLE -->
                    <section class="detail-section-card">
                        <div class="detail-section-header">
                            <div>
                                <h2>
                                    Học sinh lớp
                                    <c:out value="${empty classItem.className ? '' : classItem.className}" />
                                </h2>
                                <p>Danh sách học sinh đang được đăng ký trong lớp học này.</p>
                            </div>

                            <span class="section-count-badge">
                                <i class="fa-solid fa-users"></i>
                                ${empty enrollments ? 0 : fn:length(enrollments)} học sinh
                            </span>
                        </div>

                        <div class="student-table-wrap">
                            <table class="student-table">
                                <thead>
                                <tr>
                                    <th>Học sinh</th>
                                    <th>Giới tính</th>
                                    <th>Trường</th>
                                    <th>Khối</th>
                                    <th>Trạng thái</th>
                                </tr>
                                </thead>

                                <tbody>
                                <c:choose>
                                    <c:when test="${not empty enrollments}">
                                        <c:forEach var="e" items="${enrollments}">
                                            <tr>
                                                <td>
                                                    <div class="student-info">
                                                        <div class="avatar">
                                                            <c:choose>
                                                                <c:when test="${not empty e.student and not empty e.student.fullName}">
                                                                    ${fn:substring(e.student.fullName, 0, 1)}
                                                                </c:when>
                                                                <c:otherwise>?</c:otherwise>
                                                            </c:choose>
                                                        </div>

                                                        <strong>
                                                            <c:out value="${not empty e.student and not empty e.student.fullName ? e.student.fullName : 'Học sinh'}" />
                                                        </strong>
                                                    </div>
                                                </td>

                                                <td>
                                                    <c:out value="${not empty e.student and not empty e.student.gender ? e.student.gender : 'Chưa cập nhật'}" />
                                                </td>

                                                <td>
                                                    <c:out value="${not empty e.student and not empty e.student.school ? e.student.school : 'Chưa cập nhật'}" />
                                                </td>

                                                <td>
                                                    <c:out value="${not empty e.student and not empty e.student.grade ? e.student.grade : 'Chưa cập nhật'}" />
                                                </td>

                                                <td>
                                                    <c:choose>
                                                        <c:when test="${e.status == true}">
                                                            <span class="student-status active">Đang học</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="student-status paused">Tạm dừng</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>

                                    <c:otherwise>
                                        <tr>
                                            <td colspan="5" class="empty-row">
                                                Chưa có học sinh trong lớp.
                                            </td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                <tr id="noSessionResult" style="display:none;">
                                    <td colspan="6" class="no-result-row">
                                        Không có buổi học nào trong ngày đã chọn.
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </section>

                    <!-- SESSIONS TABLE -->
                    <section class="detail-section-card">
                        <div class="detail-section-header">
                            <div>
                                <h2>Lịch học cụ thể</h2>
                                <p>Danh sách các buổi học đã được tạo cho lớp này.</p>
                            </div>

                            <span class="section-count-badge">
                                <i class="fa-solid fa-calendar-days"></i>
                                ${empty sessions ? 0 : fn:length(sessions)} buổi học
                            </span>
                        </div>
                        <div class="session-filter-bar">

                            <div class="filter-left">
                                <span class="filter-label">
                                    <i class="fa-solid fa-filter"></i>
                                    Lọc theo thứ:
                                </span>

                                <select id="weekdayFilter" class="weekday-filter">
                                    <option value="all">Tất cả</option>
                                    <option value="1">Thứ 2</option>
                                    <option value="2">Thứ 3</option>
                                    <option value="3">Thứ 4</option>
                                    <option value="4">Thứ 5</option>
                                    <option value="5">Thứ 6</option>
                                    <option value="6">Thứ 7</option>
                                    <option value="0">Chủ nhật</option>
                                </select>
                            </div>

                        </div>
                        <div class="session-table-wrap">
                            <table class="session-table">
                                <thead>
                                <tr>
                                    <th>Ngày học</th>
                                    <th>Thời gian</th>
                                    <th>Chủ đề</th>
                                    <th>Trạng thái</th>
                                    <th>Thao tác</th>
                                </tr>
                                </thead>

                                <tbody>
                                <c:choose>
                                    <c:when test="${not empty sessions}">
                                        <c:forEach var="s" items="${sessions}">
                                            <tr class="session-row"
                                                data-date="${s.sessionDate}">
                                                <td>
                                                    <span class="badge subject">
                                                        <i class="fa-regular fa-calendar"></i>
                                                        <c:out value="${empty s.sessionDate ? 'Chưa có ngày' : s.sessionDate}" />
                                                    </span>
                                                </td>

                                                <td>
                                                    <span class="session-code">
                                                        <i class="fa-regular fa-clock"></i>
                                                        <c:out value="${empty s.startTime ? '--:--' : s.startTime}" />
                                                        -
                                                        <c:out value="${empty s.endTime ? '--:--' : s.endTime}" />
                                                    </span>
                                                </td>

                                                <td>
                                                    <div class="session-topic-cell">
                                                        <strong>
                                                            <c:out value="${empty s.topic ? (empty s.lessonName ? 'Chưa cập nhật chủ đề' : s.lessonName) : s.topic}" />
                                                        </strong>
                                                        <span>
                                                            Buổi học #<c:out value="${s.sessionId}" />
                                                        </span>
                                                    </div>
                                                </td>

                                                <td>
                                                    <c:choose>
                                                        <c:when test="${s.status == 'COMPLETED'}">
                                                            <span class="badge active">
                                                                <i class="fa-solid fa-circle-check"></i>
                                                                Đã hoàn thành
                                                            </span>
                                                        </c:when>
                                                        <c:when test="${s.status == 'CANCELLED'}">
                                                            <span class="badge inactive">
                                                                <i class="fa-solid fa-circle-xmark"></i>
                                                                Đã hủy
                                                            </span>
                                                        </c:when>
                                                        <c:when test="${s.status == 'PLANNED'}">
                                                            <span class="badge orange">
                                                                <i class="fa-solid fa-clock"></i>
                                                                Sắp diễn ra
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge subject">
                                                                <i class="fa-solid fa-circle-info"></i>
                                                                <c:out value="${s.status}" />
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>

                                                </td>

                                                <td>
                                                    <div class="session-action-table">
                                                        <c:set var="sid" value="${s.sessionId}" />
                                                        <a class="session-action ${s.status == 'COMPLETED' ? 'green' : 'blue'}"
                                                           href="${pageContext.request.contextPath}/tutor/sessions/${s.sessionId}/attendance">
                                                            <i class="fa-solid fa-user-check"></i>
                                                            Điểm danh
                                                        </a>

                                                        <a class="session-action ${feedbackMap[sid] ? 'green' : 'disabled'}"
                                                           href="${pageContext.request.contextPath}/tutor/sessions/${s.sessionId}/feedback">
                                                            <i class="fa-solid fa-comment-dots"></i>
                                                            Feedback
                                                        </a>

                                                        <a class="session-action <c:choose><c:when test="${learningPlanMap[sid]}">purple</c:when><c:when test="${s.status == 'PLANNED'}">gray</c:when><c:otherwise>disabled</c:otherwise></c:choose>"
                                                           href="${pageContext.request.contextPath}/tutor/sessions/${s.sessionId}/learning-plan">
                                                            <i class="fa-solid fa-clipboard-list"></i>
                                                            Kế hoạch
                                                        </a>

                                                        <a class="session-action ${homeworkMap[sid] ? 'orange' : 'disabled'}"
                                                           href="${pageContext.request.contextPath}/tutor/homework/session/${s.sessionId}">
                                                            <i class="fa-solid fa-book-open-reader"></i>
                                                            Bài tập
                                                        </a>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>

                                    <c:otherwise>
                                        <tr>
                                            <td colspan="6" class="empty-row">
                                                Chưa có buổi học nào được tạo cho lớp này.
                                            </td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </section>

                </div>





                <!-- UPCOMING -->


            <!-- RIGHT SIDEBAR -->
            <aside class="detail-sidebar">


                <div class="quick-card">
                    <h3>Tiến độ tạo buổi học</h3>

                    <div class="progress-number">
                        <strong>${empty sessions ? 0 : fn:length(sessions)}</strong>
                        <span>/ ${empty classItem.requiredSessions ? 0 : classItem.requiredSessions} buổi đã tạo</span>
                    </div>

                    <div class="progress-bar">
                        <div style="width:
                        <c:choose>
                        <c:when test='${not empty classItem.requiredSessions and classItem.requiredSessions > 0 and not empty sessions}'>
                            ${fn:length(sessions) * 100 / classItem.requiredSessions}%
                        </c:when>
                        <c:otherwise>0%</c:otherwise>
                                </c:choose>">
                        </div>
                    </div>

                    <small>
                        Đây là tiến độ số buổi đã được tạo trên hệ thống, không phải số buổi đã hoàn thành.
                    </small>
                </div>

                <div class="quick-card">
                    <h3>Truy cập nhanh</h3>

                    <div class="quick-link-list">
                        <a href="${pageContext.request.contextPath}/tutor/classes" class="quick-link">
                            <i class="fa-solid fa-arrow-left"></i>
                            Lớp của tôi
                        </a>

                        <button type="button" class="quick-link" data-go-tab="sessions" style="border:0;cursor:pointer;width:100%;">
                            <i class="fa-solid fa-calendar-days"></i>
                            Xem lịch dạy
                        </button>

                        <button type="button" class="quick-link" data-go-tab="students" style="border:0;cursor:pointer;width:100%;">
                            <i class="fa-solid fa-users"></i>
                            Xem học sinh
                        </button>
                    </div>
                </div>

            </aside>
        </section>

    </main>
</div>
<script>
    const weekdayFilter = document.getElementById("weekdayFilter");
    const sessionRows = document.querySelectorAll(".session-row");
    const noResultRow = document.getElementById("noSessionResult");

    weekdayFilter.addEventListener("change", function () {

        const selected = this.value;
        let visibleCount = 0;

        sessionRows.forEach(row => {

            const dateStr = row.dataset.date;

            if (!dateStr) {
                row.style.display = "none";
                return;
            }

            const date = new Date(dateStr);
            const weekday = date.getDay();

            if (selected === "all" || weekday.toString() === selected) {
                row.style.display = "";
                visibleCount++;
            } else {
                row.style.display = "none";
            }
        });

        noResultRow.style.display = visibleCount === 0 ? "" : "none";
    });
</script>
</body>
</html>
