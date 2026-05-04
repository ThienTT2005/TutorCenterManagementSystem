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
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/tutor-dashboard.css">

    <style>
        .attendance-page {
            padding: 2rem;
        }

        .attendance-hero {
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

        .attendance-hero h1 {
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

        .attendance-grid {
            display: grid;
            grid-template-columns: minmax(0, 1.7fr) 380px;
            gap: 1.5rem;
            align-items: start;
        }

        .panel-card,
        .action-card,
        .info-card {
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

        .panel-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1.25rem;
        }

        .panel-header h2 {
            font-size: 18px;
            font-weight: 900;
            color: #0f172a;
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

        .attendance-table-wrap {
            overflow-x: auto;
        }

        .attendance-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 820px;
        }

        .attendance-table th,
        .attendance-table td {
            padding: 14px 12px;
            border-bottom: 1px solid #f1f5f9;
            text-align: left;
            font-size: 13px;
            vertical-align: middle;
        }

        .attendance-table th {
            color: #64748b;
            font-size: 11px;
            text-transform: uppercase;
            font-weight: 900;
            letter-spacing: .3px;
        }

        .student-cell {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .avatar {
            width: 36px;
            height: 36px;
            border-radius: 999px;
            background: #eff6ff;
            color: #0057bf;
            font-size: 13px;
            font-weight: 900;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            text-transform: uppercase;
        }

        .student-name {
            font-weight: 850;
            color: #0f172a;
        }

        .student-sub {
            margin-top: 2px;
            font-size: 11px;
            color: #94a3b8;
            font-weight: 600;
        }

        .status-pill {
            display: inline-flex;
            padding: 5px 10px;
            border-radius: 999px;
            font-size: 11px;
            font-weight: 900;
            white-space: nowrap;
        }

        .status-attended {
            background: #dcfce7;
            color: #16a34a;
        }

        .status-absent {
            background: #fee2e2;
            color: #dc2626;
        }

        .status-excused {
            background: #eff6ff;
            color: #0057bf;
        }

        .status-unknown {
            background: #f1f5f9;
            color: #64748b;
        }

        .valid-pill {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            font-size: 12px;
            font-weight: 850;
        }

        .valid-pill.valid {
            color: #16a34a;
        }

        .valid-pill.invalid {
            color: #dc2626;
        }

        .valid-pill.pending {
            color: #64748b;
        }

        .action-card,
        .info-card {
            padding: 1.35rem;
        }

        .action-card h3,
        .info-card h3 {
            font-size: 17px;
            font-weight: 900;
            color: #0f172a;
            margin-bottom: 1rem;
        }

        .code-form {
            display: flex;
            flex-direction: column;
            gap: 12px;
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

        .code-input {
            height: 46px;
            border: 1px solid #dbe3ef;
            border-radius: 12px;
            padding: 0 14px;
            outline: none;
            font-size: 14px;
            color: #0f172a;
            transition: all .2s ease;
        }

        .code-input:focus {
            border-color: #0057bf;
            box-shadow: 0 0 0 4px rgba(0, 87, 191, 0.08);
        }

        .hint {
            color: #64748b;
            font-size: 12px;
            line-height: 1.5;
        }

        .action-buttons {
            display: grid;
            grid-template-columns: 1fr;
            gap: 10px;
        }

        .btn-action {
            min-height: 44px;
            border: 0;
            border-radius: 12px;
            color: #ffffff;
            font-size: 14px;
            font-weight: 900;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            transition: all .2s ease;
        }

        .btn-checkin {
            background: #0057bf;
            box-shadow: 0 8px 18px rgba(0, 87, 191, 0.18);
        }

        .btn-checkout {
            background: #193b68;
            box-shadow: 0 8px 18px rgba(25, 59, 104, 0.18);
        }

        .btn-action:hover {
            transform: translateY(-1px);
            filter: brightness(.97);
        }

        .session-info-list {
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

        .flow-list {
            display: flex;
            flex-direction: column;
            gap: 12px;
            color: #475569;
            font-size: 13px;
            line-height: 1.55;
        }

        .flow-item {
            display: flex;
            gap: 10px;
            align-items: flex-start;
        }

        .flow-item i {
            color: #0057bf;
            margin-top: 3px;
        }

        .empty-card {
            text-align: center;
            color: #64748b;
            font-size: 14px;
            padding: 2rem !important;
        }

        @media (max-width: 1100px) {
            .attendance-grid {
                grid-template-columns: 1fr;
            }

            .side-column {
                position: static;
            }
        }

        @media (max-width: 760px) {
            .attendance-page {
                padding: 1rem;
            }

            .attendance-hero {
                flex-direction: column;
            }
        }
    </style>
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
