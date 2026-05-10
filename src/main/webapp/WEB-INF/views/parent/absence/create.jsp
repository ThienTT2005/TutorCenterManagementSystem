<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="activePage" value="absence-create" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Form xin nghỉ</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0"/>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/parent-dashboard.css">

    <style>
        .absence-create-page {
            min-height: 100vh;
            background: var(--bg-page, #f7f9fb);
            padding: 24px 32px 40px;
            color: var(--text-dark, #0f172a);
        }

        .breadcrumb {
            display: flex;
            align-items: center;
            gap: 7px;
            margin-bottom: 8px;
            color: var(--text-muted, #64748b);
            font-size: 13px;
            font-weight: 600;
        }

        .breadcrumb a {
            color: var(--text-muted, #64748b);
            text-decoration: none;
        }

        .breadcrumb a:hover {
            color: var(--primary, #0057bf);
        }

        .breadcrumb .current {
            color: var(--primary, #0057bf);
            font-weight: 800;
        }

        .page-heading {
            margin-bottom: 24px;
        }

        .page-heading h1 {
            margin: 0 0 6px;
            color: var(--text-dark, #0f172a);
            font-size: 30px;
            line-height: 1.2;
            font-weight: 900;
        }

        .page-heading p {
            margin: 0;
            color: var(--text-muted, #64748b);
            font-size: 14px;
            font-weight: 500;
        }

        .absence-layout {
            display: grid;
            grid-template-columns: minmax(0, 560px) 300px;
            gap: 24px;
            align-items: start;
        }

        .absence-form-card {
            background: var(--bg-white, #ffffff);
            border: 1px solid var(--border-color, #e2e8f0);
            border-radius: 18px;
            padding: 32px;
            box-shadow: 0 16px 34px rgba(15, 23, 42, 0.06);
            position: relative;
            overflow: hidden;
        }

        .absence-form-card::before {
            content: "";
            position: absolute;
            top: -90px;
            right: -80px;
            width: 190px;
            height: 190px;
            border-radius: 50%;
            background: #f0f6ff;
            pointer-events: none;
        }

        .absence-form {
            position: relative;
            z-index: 1;
        }

        .error-box {
            margin-bottom: 18px;
            padding: 13px 15px;
            border-radius: 12px;
            background: var(--danger-light, #fee2e2);
            border: 1px solid #fecaca;
            color: var(--danger, #dc2626);
            font-size: 13px;
            font-weight: 700;
            line-height: 1.5;
        }

        .form-group {
            margin-bottom: 22px;
        }

        .form-label {
            display: flex;
            align-items: center;
            gap: 7px;
            margin-bottom: 8px;
            color: var(--text-dark, #0f172a);
            font-size: 13px;
            font-weight: 900;
        }

        .form-label i,
        .form-label .material-symbols-rounded {
            color: var(--primary, #0057bf);
            font-size: 16px;
        }

        .select-like,
        .readonly-field {
            min-height: 46px;
            width: 100%;
            border: 1px solid #cbd5e1;
            border-radius: 10px;
            background: #f8fafc;
            color: var(--text-dark, #0f172a);
            font-size: 14px;
            font-weight: 600;
            padding: 0 14px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 10px;
        }

        .select-like span,
        .readonly-field span {
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
        }

        .select-like i,
        .readonly-field i {
            color: var(--text-muted, #64748b);
            font-size: 14px;
            flex-shrink: 0;
        }

        .session-row-wrap {
            display: grid;
            grid-template-columns: minmax(0, 1fr) 230px;
            gap: 12px;
        }

        .session-note {
            min-height: 46px;
            border-radius: 10px;
            background: #eef4ff;
            color: #3860a8;
            font-size: 11px;
            line-height: 1.45;
            font-weight: 600;
            display: flex;
            align-items: center;
            padding: 0 14px;
        }

        .reason-textarea {
            width: 100%;
            min-height: 150px;
            border: 1px solid #cbd5e1;
            border-radius: 12px;
            background: #f8fafc;
            color: var(--text-dark, #0f172a);
            font-size: 14px;
            font-weight: 500;
            line-height: 1.6;
            padding: 16px;
            resize: vertical;
            outline: none;
            font-family: inherit;
        }

        .reason-textarea::placeholder {
            color: #94a3b8;
        }

        .reason-textarea:focus,
        .select-like:focus-within,
        .readonly-field:focus-within {
            border-color: var(--primary, #0057bf);
            box-shadow: 0 0 0 4px rgba(0, 87, 191, 0.1);
            background: #ffffff;
        }

        .submit-btn {
            width: 100%;
            height: 52px;
            border: none;
            border-radius: 12px;
            background: var(--primary, #0057bf);
            color: #ffffff;
            font-size: 15px;
            font-weight: 900;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 14px;
            box-shadow: 0 10px 20px rgba(0, 87, 191, 0.22);
            transition: var(--transition, all .2s ease);
        }

        .submit-btn:hover {
            background: var(--primary-hover, #004da8);
            transform: translateY(-2px);
        }

        .submit-btn i {
            font-size: 14px;
        }

        .form-footnote {
            margin-top: 14px;
            color: #94a3b8;
            text-align: center;
            font-size: 11px;
            font-weight: 600;
        }

        .side-panel {
            display: flex;
            flex-direction: column;
            gap: 18px;
        }

        .rule-card {
            background: #e2e8ec;
            border: 1px solid #d5dde5;
            border-radius: 18px;
            padding: 24px;
            color: var(--text-dark, #0f172a);
        }

        .rule-header {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 14px;
        }

        .rule-icon {
            width: 34px;
            height: 34px;
            border-radius: 50%;
            background: #bfe3ee;
            color: #0084a8;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .rule-header h3 {
            margin: 0;
            font-size: 15px;
            font-weight: 900;
        }

        .rule-list {
            margin: 0;
            padding-left: 18px;
            color: #334155;
            font-size: 12px;
            line-height: 1.7;
            font-weight: 600;
        }

        .rule-list li {
            margin-bottom: 8px;
        }

        .rule-list li::marker {
            color: var(--primary, #0057bf);
        }

        .support-card {
            background: #005fd8;
            border-radius: 18px;
            padding: 24px;
            color: #ffffff;
            box-shadow: 0 14px 28px rgba(0, 95, 216, 0.22);
        }

        .support-card h3 {
            margin: 0 0 10px;
            font-size: 17px;
            font-weight: 900;
        }

        .support-card p {
            margin: 0 0 18px;
            color: rgba(255, 255, 255, .86);
            font-size: 13px;
            line-height: 1.5;
            font-weight: 500;
        }

        .support-phone {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            color: #ffffff;
            font-size: 14px;
            font-weight: 900;
        }

        @media (max-width: 1050px) {
            .absence-layout {
                grid-template-columns: 1fr;
            }

            .side-panel {
                max-width: 560px;
            }
        }

        @media (max-width: 700px) {
            .absence-create-page {
                padding: 18px;
            }

            .absence-form-card {
                padding: 22px;
            }

            .session-row-wrap {
                grid-template-columns: 1fr;
            }

            .page-heading h1 {
                font-size: 25px;
            }
        }
    </style>
</head>

<body class="theme-blue">

<jsp:include page="../common/sidebar.jsp" />

<div class="main-content">
    <jsp:include page="../common/header.jsp" />

    <main class="absence-create-page">

        <div class="breadcrumb">
            <a href="${pageContext.request.contextPath}/parent/dashboard">Trang chủ</a>
            <span>›</span>
            <a href="${pageContext.request.contextPath}/parent/classes">Lớp học</a>
            <span>›</span>
            <span class="current">Tạo mới</span>
        </div>

        <div class="page-heading">
            <h1>Form xin nghỉ</h1>
            <p>Vui lòng cung cấp thông tin chi tiết để chúng tôi hỗ trợ học sinh tốt nhất.</p>
        </div>

        <section class="absence-layout">

            <div class="absence-form-card">

                <c:if test="${not empty error}">
                    <div class="error-box">
                        <i class="fa-solid fa-circle-exclamation"></i>
                        <c:out value="${error}" />
                    </div>
                </c:if>

                <form class="absence-form"
                      action="${pageContext.request.contextPath}/parent/absence/create"
                      method="post">

                    <c:choose>
                        <c:when test="${not empty selectedSession and not empty selectedStudent}">
                            <%-- THÔNG TIN ĐÃ CÓ SẴN (Từ trang chi tiết lớp học) --%>
                            <div class="form-group">
                                <label class="form-label">
                                    <i class="fa-regular fa-user"></i>
                                    Học sinh
                                </label>
                                <div class="readonly-field">
                                    <span><strong><c:out value="${selectedStudent.fullName}" /></strong></span>
                                    <i class="fa-solid fa-check-circle" style="color: #16a34a;"></i>
                                </div>
                                <input type="hidden" name="studentId" value="${selectedStudent.studentId}">
                            </div>

                            <div class="form-group">
                                <label class="form-label">
                                    <i class="fa-solid fa-graduation-cap"></i>
                                    Lớp học
                                </label>
                                <div class="readonly-field">
                                    <span>
                                        #<c:out value="${selectedSession.classEntity.classId}" /> - 
                                        <strong><c:out value="${selectedSession.classEntity.className}" /></strong>
                                    </span>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="form-label">
                                    <i class="fa-regular fa-calendar-check"></i>
                                    Buổi học xin nghỉ
                                </label>
                                <div class="readonly-field">
                                    <span>
                                        <c:out value="${selectedSession.sessionDate}" /> 
                                        (<c:out value="${selectedSession.startTime}" /> - <c:out value="${selectedSession.endTime}" />)
                                    </span>
                                    <i class="fa-regular fa-clock"></i>
                                </div>
                                <input type="hidden" name="sessionId" value="${selectedSession.sessionId}">
                            </div>
                        </c:when>

                        <c:otherwise>
                            <%-- CHẾ ĐỘ CHỌN THỦ CÔNG --%>
                            <div class="form-group">
                                <label class="form-label" for="studentSelect">
                                    <i class="fa-regular fa-user"></i>
                                    Chọn học sinh
                                </label>
                                <select id="studentSelect" name="studentId" class="select-like" style="appearance: auto;" required>
                                    <option value="">-- Chọn con --</option>
                                    <c:forEach var="c" items="${children}">
                                        <option value="${c.studentId}" ${request.studentId == c.studentId ? 'selected' : ''}>
                                            <c:out value="${c.fullName}" />
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="form-group">
                                <label class="form-label" for="classSelect">
                                    <i class="fa-solid fa-graduation-cap"></i>
                                    Chọn lớp học
                                </label>
                                <select id="classSelect" class="select-like" style="appearance: auto;" required>
                                    <option value="">-- Chọn lớp học --</option>
                                    <c:forEach var="e" items="${enrollments}">
                                        <option value="${e.classEntity.classId}" 
                                                data-student="${e.student.studentId}">
                                            <c:out value="${e.classEntity.className}" />
                                        </option>
                                    </c:forEach>
                                </select>

                            </div>

                            <div class="form-group">

                                <label class="form-label" for="sessionSelect">
                                    <i class="fa-regular fa-calendar"></i>
                                    Chọn buổi học (trong 7 ngày tới)
                                </label>
                                <select id="sessionSelect" name="sessionId" class="select-like" style="appearance: auto;" required>
                                    <option value="">-- Chọn buổi học --</option>
                                    <c:forEach var="s" items="${upcomingSessions}">
                                        <%-- Tập hợp tất cả studentId của các con trong lớp này --%>
                                        <c:set var="studentIds" value="" />
                                        <c:set var="displayNames" value="" />
                                        <c:forEach var="e" items="${enrollments}">
                                            <c:if test="${e.classEntity.classId == s.classEntity.classId}">
                                                <c:set var="studentIds" value="${studentIds}${empty studentIds ? '' : ','}${e.student.studentId}" />
                                                <c:set var="displayNames" value="${displayNames}${empty displayNames ? '' : ', '}${e.student.fullName}" />
                                            </c:if>
                                        </c:forEach>
                                        
                                        <option value="${s.sessionId}" 
                                                data-students="${studentIds}"
                                                data-class="${s.classEntity.classId}"
                                                ${request.sessionId == s.sessionId ? 'selected' : ''}>
                                            <c:out value="${s.sessionDate}" /> (${s.startTime})
                                        </option>

                                    </c:forEach>
                                </select>

                                <div class="session-note" style="margin-top: 10px;">
                                    Lưu ý: Chỉ hiển thị các buổi học trong vòng 7 ngày tới.
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>


                    <div class="form-group">
                        <label for="reason" class="form-label">
                            <i class="fa-solid fa-paragraph"></i>
                            Lý do nghỉ
                        </label>

                        <textarea id="reason"
                                  name="reason"
                                  class="reason-textarea"
                                  placeholder="Vui lòng ghi rõ lý do để giáo viên có thể hỗ trợ con học bù hoặc gửi bài tập..."
                                  required><c:out value="${request.reason}" /></textarea>
                    </div>

                    <button type="submit" class="submit-btn">
                        Gửi đơn xin nghỉ
                        <i class="fa-regular fa-paper-plane"></i>
                    </button>

                    <p class="form-footnote">
                        Thông báo sẽ được gửi trực tiếp đến bộ trung tâm và gia sư phụ trách
                    </p>

                </form>
            </div>

            <aside class="side-panel">

                <div class="rule-card">
                    <div class="rule-header">
                        <span class="rule-icon">
                            <i class="fa-solid fa-info"></i>
                        </span>
                        <h3>Quy định nghỉ học</h3>
                    </div>

                    <ul class="rule-list">
                        <li>Xin nghỉ trước ít nhất 4 tiếng để được sắp xếp học bù miễn phí.</li>
                        <li>Các buổi nghỉ có lý do chính đáng sẽ được bảo lưu học phí.</li>
                        <li>Hỗ trợ gửi tài liệu học tập qua cổng thông tin này.</li>
                    </ul>
                </div>

                <div class="support-card">
                    <h3>Cần hỗ trợ gấp?</h3>
                    <p>
                        Liên hệ trực tiếp với bộ phận chăm sóc khách hàng của TCMS.
                    </p>

                    <div class="support-phone">
                        <i class="fa-solid fa-phone"></i>
                        1900 1234
                    </div>
                </div>

            </aside>

        </section>
    </main>
</div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const studentSelect = document.getElementById('studentSelect');
            const classSelect = document.getElementById('classSelect');
            const sessionSelect = document.getElementById('sessionSelect');
            
            if (studentSelect && classSelect && sessionSelect) {
                // Lưu lại tất cả các option ban đầu (trừ option mặc định)
                const allClassOptions = Array.from(classSelect.options).slice(1);
                const allSessionOptions = Array.from(sessionSelect.options).slice(1);
                
                // Hàm xóa sạch các option cũ
                function clearSelect(select) {
                    while (select.options.length > 1) {
                        select.remove(1);
                    }
                }

                // Xóa dữ liệu lúc mới load trang nếu chưa chọn học sinh
                if (!studentSelect.value) {
                    clearSelect(classSelect);
                    clearSelect(sessionSelect);
                }
                
                // Khi chọn học sinh -> Lọc lớp học
                studentSelect.addEventListener('change', function() {
                    const selectedStudentId = this.value;
                    
                    clearSelect(classSelect);
                    clearSelect(sessionSelect);
                    
                    if (selectedStudentId) {
                        const filteredClasses = allClassOptions.filter(opt => opt.getAttribute('data-student') == selectedStudentId);
                        filteredClasses.forEach(opt => {
                            // Clone để tránh lỗi tham chiếu khi add/remove nhiều lần
                            const newOpt = opt.cloneNode(true);
                            classSelect.add(newOpt);
                        });
                    }
                });
                
                // Khi chọn lớp học -> Lọc buổi học
                classSelect.addEventListener('change', function() {
                    const selectedClassId = this.value;
                    const selectedStudentId = studentSelect.value;
                    
                    clearSelect(sessionSelect);
                    
                    if (selectedClassId && selectedStudentId) {
                        const filteredSessions = allSessionOptions.filter(opt => {
                            const isCorrectClass = opt.getAttribute('data-class') == selectedClassId;
                            const studentIds = opt.getAttribute('data-students').split(',');
                            return isCorrectClass && studentIds.includes(selectedStudentId);
                        });
                        filteredSessions.forEach(opt => {
                            const newOpt = opt.cloneNode(true);
                            sessionSelect.add(newOpt);
                        });
                    }
                });
            }
        });
    </script>

</body>
</html>
