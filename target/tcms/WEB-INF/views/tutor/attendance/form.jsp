<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="activePage" value="classes" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Điểm danh buổi học | TCMS Tutor</title>
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

    <main class="attendance-page">

        <!-- HEADER -->
        <section class="attendance-hero">
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

                <h1>Điểm danh buổi học</h1>

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
                        ${empty attendanceList ? 0 : fn:length(attendanceList)} học sinh
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

        <section class="attendance-grid">

            <!-- LEFT: ATTENDANCE LIST -->
            <div class="panel-card">
                <div class="panel-header">
                    <h2>Danh sách điểm danh học sinh</h2>
                </div>

                <c:if test="${not empty error}">
                    <div class="error-alert">
                        <i class="fa-solid fa-circle-exclamation"></i>
                        <span><c:out value="${error}" /></span>
                    </div>
                </c:if>

                <div class="attendance-table-wrap">
                    <table class="attendance-table">
                        <thead>
                        <tr>
                            <th>Học sinh</th>
                            <th>Trạng thái</th>
                            <th>Check-in</th>
                            <th>Check-out</th>
                            <th>Hợp lệ</th>
                            <th>Ghi chú</th>
                        </tr>
                        </thead>

                        <tbody>
                        <c:choose>
                            <c:when test="${not empty attendanceList}">
                                <c:forEach var="a" items="${attendanceList}">
                                    <tr>
                                        <td>
                                            <div class="student-cell">
                                                <div class="avatar">
                                                    <c:choose>
                                                        <c:when test="${not empty a.student and not empty a.student.fullName}">
                                                            ${fn:substring(a.student.fullName, 0, 1)}
                                                        </c:when>
                                                        <c:otherwise>?</c:otherwise>
                                                    </c:choose>
                                                </div>

                                                <div>
                                                    <div class="student-name">
                                                        <c:out value="${not empty a.student and not empty a.student.fullName ? a.student.fullName : 'Học sinh'}" />
                                                    </div>

                                                    <div class="student-sub">
                                                        <c:choose>
                                                            <c:when test="${not empty a.student and not empty a.student.grade}">
                                                                Khối <c:out value="${a.student.grade}" />
                                                            </c:when>
                                                            <c:otherwise>Chưa cập nhật khối</c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>

                                        <td>
                                            <c:choose>
                                                <c:when test="${a.status == 'ATTENDED'}">
                                                    <span class="status-pill status-attended">Có mặt</span>
                                                </c:when>

                                                <c:when test="${a.status == 'ABSENT_EXCUSED'}">
                                                    <span class="status-pill status-excused">Vắng có phép</span>
                                                </c:when>

                                                <c:when test="${a.status == 'ABSENT_UNEXCUSED'}">
                                                    <span class="status-pill status-absent">Vắng không phép</span>
                                                </c:when>

                                                <c:otherwise>
                                                    <span class="status-pill status-unknown">
                                                        <c:out value="${empty a.status ? 'Chưa cập nhật' : a.status}" />
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>

                                        <td>
                                            <c:out value="${empty a.checkinTime ? '---' : a.checkinTime}" />
                                        </td>

                                        <td>
                                            <c:out value="${empty a.checkoutTime ? '---' : a.checkoutTime}" />
                                        </td>

                                        <td>
                                            <c:choose>
                                                <c:when test="${a.isValid == true}">
                                                    <span class="valid-pill valid">
                                                        <i class="fa-solid fa-circle-check"></i>
                                                        Hợp lệ
                                                    </span>
                                                </c:when>

                                                <c:when test="${a.isValid == false}">
                                                    <span class="valid-pill invalid">
                                                        <i class="fa-solid fa-circle-xmark"></i>
                                                        Không hợp lệ
                                                    </span>
                                                </c:when>

                                                <c:otherwise>
                                                    <span class="valid-pill pending">
                                                        <i class="fa-solid fa-clock"></i>
                                                        Chưa chốt
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>

                                        <td>
                                            <c:out value="${empty a.note ? '---' : a.note}" />
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>

                            <c:otherwise>
                                <tr>
                                    <td colspan="6" class="empty-card">
                                        Chưa có dữ liệu điểm danh. Gia sư cần check-in để hệ thống tạo điểm danh cho học sinh.
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- RIGHT: ACTIONS -->
            <aside class="side-column">

                <div class="action-card">
                    <h3>Nhập mã điểm danh</h3>

                    <div class="code-form">
                        <div class="form-group">
                            <label for="attendanceCode">Mã điểm danh</label>
                            <input type="text"
                                   id="attendanceCode"
                                   name="attendanceCode"
                                   class="code-input"
                                   placeholder="Nhập mã điểm danh của buổi học"
                                   autocomplete="off">
                            <div class="hint">
                                Mã này sẽ được dùng để xác thực quyền check-in và check-out cho buổi học.
                            </div>
                        </div>

                        <div class="action-buttons">
                            <form action="${pageContext.request.contextPath}/tutor/sessions/${sessionItem.sessionId}/attendance/checkin"
                                  method="post"
                                  onsubmit="return copyAttendanceCodeToForm(this);">
                                <input type="hidden" name="attendanceCode">
                                <button type="submit" class="btn-action btn-checkin">
                                    <i class="fa-solid fa-right-to-bracket"></i>
                                    Check-in bắt đầu buổi học
                                </button>
                            </form>

                            <form action="${pageContext.request.contextPath}/tutor/sessions/${sessionItem.sessionId}/attendance/checkout"
                                  method="post"
                                  onsubmit="return copyAttendanceCodeToForm(this);">
                                <input type="hidden" name="attendanceCode">
                                <button type="submit" class="btn-action btn-checkout">
                                    <i class="fa-solid fa-right-from-bracket"></i>
                                    Check-out kết thúc buổi học
                                </button>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="info-card">
                    <h3>Thông tin buổi học</h3>

                    <div class="session-info-list">
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

                <div class="info-card">
                    <h3>Luồng xử lý</h3>

                    <div class="flow-list">
                        <div class="flow-item">
                            <i class="fa-solid fa-shield-halved"></i>
                            <div>
                                Hệ thống kiểm tra quyền gia sư và mã điểm danh trước khi cho phép thao tác.
                            </div>
                        </div>

                        <div class="flow-item">
                            <i class="fa-solid fa-clock"></i>
                            <div>
                                Check-in sẽ chuyển buổi học sang trạng thái đang diễn ra và tạo điểm danh cho học sinh.
                            </div>
                        </div>

                        <div class="flow-item">
                            <i class="fa-solid fa-check-double"></i>
                            <div>
                                Check-out sẽ chốt buổi học, cập nhật trạng thái hoàn thành và tính hợp lệ của buổi học.
                            </div>
                        </div>
                    </div>
                </div>

            </aside>
        </section>

    </main>
</div>

<script>
    function copyAttendanceCodeToForm(form) {
        const codeInput = document.getElementById('attendanceCode');
        const codeValue = codeInput ? codeInput.value.trim() : '';

        if (!codeValue) {
            alert('Vui lòng nhập mã điểm danh.');
            return false;
        }

        const hiddenInput = form.querySelector('input[name="attendanceCode"]');
        if (hiddenInput) {
            hiddenInput.value = codeValue;
        }

        return true;
    }
</script>

</body>
</html>
