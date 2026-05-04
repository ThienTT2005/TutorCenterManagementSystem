<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="activePage" value="homework" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết bài nộp | TCMS Tutor</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/tutor-dashboard.css">

    <style>
        .submission-detail-page {
            padding: 2rem;
            background: #f8fafc;
            min-height: 100vh;
        }

        .page-top {
            margin-bottom: 1.5rem;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: #0057bf;
            font-size: 13px;
            font-weight: 800;
            text-decoration: none;
            margin-bottom: 12px;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        .page-title-row {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 1rem;
        }

        .page-title h1 {
            font-size: 28px;
            font-weight: 900;
            color: #0f172a;
            margin-bottom: 6px;
        }

        .page-title p {
            color: #64748b;
            font-size: 14px;
            font-weight: 600;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 7px 12px;
            border-radius: 999px;
            font-size: 11px;
            font-weight: 900;
            text-transform: uppercase;
        }

        .status-graded {
            background: #dcfce7;
            color: #16a34a;
            border: 1px solid #bbf7d0;
        }

        .status-submitted {
            background: #fff7ed;
            color: #ea580c;
            border: 1px solid #fed7aa;
        }

        .status-other {
            background: #f1f5f9;
            color: #64748b;
            border: 1px solid #e2e8f0;
        }

        .detail-layout {
            display: grid;
            grid-template-columns: minmax(0, 1fr) 330px;
            gap: 1.5rem;
            align-items: start;
        }

        .left-column,
        .right-column {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 22px;
            box-shadow: 0 8px 24px rgba(15, 23, 42, 0.05);
        }

        .card-body {
            padding: 1.5rem;
        }

        .card-title {
            display: flex;
            align-items: center;
            gap: 10px;
            color: #0f172a;
            font-size: 18px;
            font-weight: 900;
            margin-bottom: 1rem;
        }

        .card-title i {
            color: #0057bf;
        }

        .homework-info-grid {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 12px;
        }

        .info-box {
            background: #f8fafc;
            border-radius: 16px;
            padding: 14px 16px;
        }

        .info-box span {
            display: block;
            color: #64748b;
            font-size: 12px;
            font-weight: 800;
            margin-bottom: 6px;
        }

        .info-box strong {
            display: block;
            color: #0f172a;
            font-size: 15px;
            font-weight: 900;
            line-height: 1.4;
        }

        .student-card {
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .student-avatar {
            width: 54px;
            height: 54px;
            border-radius: 999px;
            background: #eff6ff;
            color: #0057bf;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 900;
            font-size: 16px;
            flex-shrink: 0;
            text-transform: uppercase;
        }

        .student-main strong {
            display: block;
            color: #0f172a;
            font-size: 17px;
            font-weight: 900;
            margin-bottom: 4px;
        }

        .student-main span {
            display: block;
            color: #64748b;
            font-size: 13px;
            font-weight: 600;
        }

        .answer-block {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 18px;
            padding: 1rem;
        }

        .answer-block h3 {
            color: #0f172a;
            font-size: 15px;
            font-weight: 900;
            margin-bottom: 10px;
        }

        .answer-text {
            color: #334155;
            font-size: 14px;
            line-height: 1.7;
            white-space: pre-line;
        }

        .answer-json {
            background: #0f172a;
            color: #e2e8f0;
            border-radius: 14px;
            padding: 1rem;
            font-size: 13px;
            line-height: 1.6;
            overflow-x: auto;
            white-space: pre-wrap;
            word-break: break-word;
        }

        .attachment-box {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 1rem;
            background: #eff6ff;
            border: 1px solid #bfdbfe;
            border-radius: 16px;
            padding: 1rem;
        }

        .attachment-box div strong {
            display: block;
            color: #0f172a;
            font-size: 14px;
            font-weight: 900;
            margin-bottom: 4px;
        }

        .attachment-box div span {
            color: #64748b;
            font-size: 12px;
            font-weight: 700;
        }

        .attachment-link {
            min-height: 38px;
            border-radius: 12px;
            background: #0057bf;
            color: #ffffff;
            padding: 0 14px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            font-size: 13px;
            font-weight: 900;
            white-space: nowrap;
        }

        .attachment-link:hover {
            background: #004da8;
        }

        .score-card {
            background: linear-gradient(135deg, #0057bf, #3b82f6);
            color: #ffffff;
            border-radius: 22px;
            padding: 1.5rem;
            min-height: 150px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            box-shadow: 0 12px 26px rgba(0, 87, 191, 0.2);
        }

        .score-card span {
            font-size: 12px;
            font-weight: 900;
            text-transform: uppercase;
            opacity: .9;
            margin-bottom: 8px;
        }

        .score-card strong {
            font-size: 46px;
            font-weight: 900;
            line-height: 1;
        }

        .score-card small {
            font-size: 16px;
            font-weight: 800;
            opacity: .85;
        }

        .side-info-list {
            display: flex;
            flex-direction: column;
        }

        .side-info-row {
            display: flex;
            justify-content: space-between;
            gap: 12px;
            padding: 12px 0;
            border-bottom: 1px solid #f1f5f9;
            font-size: 13px;
        }

        .side-info-row:last-child {
            border-bottom: 0;
        }

        .side-info-row span {
            color: #64748b;
            font-weight: 700;
        }

        .side-info-row strong {
            color: #0f172a;
            font-weight: 900;
            text-align: right;
            line-height: 1.4;
        }

        .grade-form {
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
            font-weight: 900;
        }

        .form-control {
            height: 44px;
            border: 1px solid #dbe3ef;
            border-radius: 12px;
            padding: 0 14px;
            outline: none;
            color: #0f172a;
            font-size: 14px;
            transition: all .2s ease;
        }

        .form-textarea {
            min-height: 120px;
            border: 1px solid #dbe3ef;
            border-radius: 12px;
            padding: 12px 14px;
            outline: none;
            resize: vertical;
            color: #0f172a;
            font-size: 14px;
            line-height: 1.6;
            transition: all .2s ease;
        }

        .form-control:focus,
        .form-textarea:focus {
            border-color: #0057bf;
            box-shadow: 0 0 0 4px rgba(0, 87, 191, 0.08);
        }

        .btn-submit {
            min-height: 44px;
            border: 0;
            border-radius: 12px;
            background: #0057bf;
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

        .btn-submit:hover {
            background: #004da8;
            transform: translateY(-1px);
        }

        .hint {
            color: #64748b;
            font-size: 12px;
            line-height: 1.5;
        }

        .mc-note {
            background: #eff6ff;
            color: #0057bf;
            border: 1px solid #bfdbfe;
            border-radius: 14px;
            padding: 12px 14px;
            font-size: 13px;
            font-weight: 700;
            line-height: 1.6;
        }

        .essay-note {
            background: #fff7ed;
            color: #c2410c;
            border: 1px solid #fed7aa;
            border-radius: 14px;
            padding: 12px 14px;
            font-size: 13px;
            font-weight: 700;
            line-height: 1.6;
        }

        .empty-text {
            color: #94a3b8;
            font-size: 14px;
            font-style: italic;
            font-weight: 700;
        }

        @media (max-width: 1150px) {
            .detail-layout {
                grid-template-columns: 1fr;
            }

            .homework-info-grid {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }
        }

        @media (max-width: 700px) {
            .submission-detail-page {
                padding: 1rem;
            }

            .page-title-row,
            .attachment-box {
                flex-direction: column;
                align-items: flex-start;
            }

            .homework-info-grid {
                grid-template-columns: 1fr;
            }

            .score-card strong {
                font-size: 38px;
            }
        }
    </style>
</head>

<body>

<jsp:include page="../common/sidebar.jsp" />

<div class="main-content">
    <jsp:include page="../common/header.jsp" />

    <main class="submission-detail-page">

        <div class="page-top">
            <c:choose>
                <c:when test="${not empty submission.homework}">
                    <a class="back-link"
                       href="${pageContext.request.contextPath}/tutor/homework/submissions/homework/${submission.homework.homeworkId}">
                        <i class="fa-solid fa-arrow-left"></i>
                        Quay lại danh sách bài nộp
                    </a>
                </c:when>
                <c:otherwise>
                    <a class="back-link"
                       href="${pageContext.request.contextPath}/tutor/classes">
                        <i class="fa-solid fa-arrow-left"></i>
                        Quay lại
                    </a>
                </c:otherwise>
            </c:choose>

            <div class="page-title-row">
                <div class="page-title">
                    <h1>
                        Chi tiết bài nộp
                        <c:if test="${not empty submission.homework and not empty submission.homework.type}">
                            -
                            <c:choose>
                                <c:when test="${submission.homework.type == 'MULTIPLE_CHOICE'}">Trắc nghiệm</c:when>
                                <c:when test="${submission.homework.type == 'ESSAY'}">Tự luận</c:when>
                                <c:otherwise><c:out value="${submission.homework.type}" /></c:otherwise>
                            </c:choose>
                        </c:if>
                    </h1>

                    <p>
                        <c:choose>
                            <c:when test="${not empty submission.homework and not empty submission.homework.title}">
                                <c:out value="${submission.homework.title}" />
                            </c:when>
                            <c:otherwise>Bài tập</c:otherwise>
                        </c:choose>
                    </p>
                </div>

                <c:choose>
                    <c:when test="${submission.status == 'GRADED'}">
                        <span class="status-badge status-graded">GRADED</span>
                    </c:when>
                    <c:when test="${submission.status == 'SUBMITTED'}">
                        <span class="status-badge status-submitted">SUBMITTED</span>
                    </c:when>
                    <c:otherwise>
                        <span class="status-badge status-other">
                            <c:out value="${empty submission.status ? 'UNKNOWN' : submission.status}" />
                        </span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <section class="detail-layout">

            <div class="left-column">

                <!-- THÔNG TIN BÀI TẬP -->
                <div class="card">
                    <div class="card-body">
                        <h2 class="card-title">
                            <i class="fa-solid fa-book-open"></i>
                            Thông tin bài tập
                        </h2>

                        <div class="homework-info-grid">
                            <div class="info-box">
                                <span>Tên bài tập</span>
                                <strong>
                                    <c:choose>
                                        <c:when test="${not empty submission.homework and not empty submission.homework.title}">
                                            <c:out value="${submission.homework.title}" />
                                        </c:when>
                                        <c:otherwise>---</c:otherwise>
                                    </c:choose>
                                </strong>
                            </div>

                            <div class="info-box">
                                <span>Loại bài</span>
                                <strong>
                                    <c:choose>
                                        <c:when test="${not empty submission.homework and submission.homework.type == 'MULTIPLE_CHOICE'}">
                                            Trắc nghiệm
                                        </c:when>
                                        <c:when test="${not empty submission.homework and submission.homework.type == 'ESSAY'}">
                                            Tự luận
                                        </c:when>
                                        <c:when test="${not empty submission.homework}">
                                            <c:out value="${submission.homework.type}" />
                                        </c:when>
                                        <c:otherwise>---</c:otherwise>
                                    </c:choose>
                                </strong>
                            </div>

                            <div class="info-box">
                                <span>Hạn chót</span>
                                <strong>
                                    <c:choose>
                                        <c:when test="${not empty submission.homework and not empty submission.homework.deadline}">
                                            <c:out value="${submission.homework.deadline}" />
                                        </c:when>
                                        <c:otherwise>Chưa cập nhật</c:otherwise>
                                    </c:choose>
                                </strong>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- THÔNG TIN HỌC SINH -->
                <div class="card">
                    <div class="card-body">
                        <h2 class="card-title">
                            <i class="fa-solid fa-user-graduate"></i>
                            Thông tin học sinh
                        </h2>

                        <div class="student-card">
                            <div class="student-avatar">
                                <c:choose>
                                    <c:when test="${not empty submission.student and not empty submission.student.fullName}">
                                        ${fn:substring(submission.student.fullName, 0, 2)}
                                    </c:when>
                                    <c:otherwise>HS</c:otherwise>
                                </c:choose>
                            </div>

                            <div class="student-main">
                                <strong>
                                    <c:choose>
                                        <c:when test="${not empty submission.student and not empty submission.student.fullName}">
                                            <c:out value="${submission.student.fullName}" />
                                        </c:when>
                                        <c:otherwise>Học sinh</c:otherwise>
                                    </c:choose>
                                </strong>

                                <span>
                                    <c:choose>
                                        <c:when test="${not empty submission.student and not empty submission.student.school}">
                                            Trường: <c:out value="${submission.student.school}" />
                                        </c:when>
                                        <c:otherwise>Chưa cập nhật trường</c:otherwise>
                                    </c:choose>
                                </span>

                                <span>
                                    <c:choose>
                                        <c:when test="${not empty submission.student and not empty submission.student.grade}">
                                            Khối: <c:out value="${submission.student.grade}" />
                                        </c:when>
                                        <c:otherwise>Chưa cập nhật khối</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- NỘI DUNG BÀI LÀM -->
                <div class="card">
                    <div class="card-body">
                        <h2 class="card-title">
                            <i class="fa-solid fa-file-lines"></i>
                            Nội dung bài làm
                        </h2>

                        <c:choose>
                            <c:when test="${not empty submission.homework and submission.homework.type == 'MULTIPLE_CHOICE'}">
                                <div class="mc-note">
                                    Đây là bài trắc nghiệm. Backend hiện lưu câu trả lời trong trường <strong>answers</strong>.
                                    Nếu muốn hiển thị từng câu hỏi giống hình mẫu, controller cần truyền thêm danh sách câu hỏi và map đáp án đã parse.
                                </div>

                                <div style="height: 1rem;"></div>

                                <div class="answer-block">
                                    <h3>Đáp án học sinh đã nộp</h3>

                                    <c:choose>
                                        <c:when test="${not empty submission.answers}">
                                            <pre class="answer-json"><c:out value="${submission.answers}" /></pre>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="empty-text">Chưa có dữ liệu đáp án.</div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </c:when>

                            <c:otherwise>
                                <div class="essay-note">
                                    Đây là bài tự luận. Gia sư xem nội dung bài làm hoặc tệp đính kèm, sau đó nhập điểm và nhận xét ở khung chấm bài.
                                </div>

                                <div style="height: 1rem;"></div>

                                <div class="answer-block">
                                    <h3>Nội dung học sinh nộp</h3>

                                    <c:choose>
                                        <c:when test="${not empty submission.answers}">
                                            <div class="answer-text">
                                                <c:out value="${submission.answers}" />
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="empty-text">Học sinh chưa nhập nội dung văn bản.</div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </c:otherwise>
                        </c:choose>

                        <c:if test="${not empty submission.attachmentUrl}">
                            <div style="height: 1rem;"></div>

                            <div class="attachment-box">
                                <div>
                                    <strong>Tệp / Link bài làm</strong>
                                    <span>Học sinh có gửi tệp hoặc đường dẫn bài làm.</span>
                                </div>

                                <a class="attachment-link"
                                   href="${submission.attachmentUrl}"
                                   target="_blank">
                                    Mở bài làm
                                    <i class="fa-solid fa-arrow-up-right-from-square"></i>
                                </a>
                            </div>
                        </c:if>
                    </div>
                </div>

            </div>

            <aside class="right-column">

                <!-- ĐIỂM -->
                <div class="score-card">
                    <span>Điểm số hiện tại</span>

                    <c:choose>
                        <c:when test="${not empty submission.score}">
                            <div>
                                <strong><c:out value="${submission.score}" /></strong>
                                <small>/10</small>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div>
                                <strong>--</strong>
                                <small>/10</small>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- THÔNG TIN BÀI NỘP -->
                <div class="card">
                    <div class="card-body">
                        <h2 class="card-title">
                            <i class="fa-solid fa-circle-info"></i>
                            Thông tin bài nộp
                        </h2>

                        <div class="side-info-list">
                            <div class="side-info-row">
                                <span>Mã bài nộp</span>
                                <strong>#<c:out value="${submission.submissionId}" /></strong>
                            </div>

                            <div class="side-info-row">
                                <span>Học sinh</span>
                                <strong>
                                    <c:out value="${not empty submission.student and not empty submission.student.fullName ? submission.student.fullName : 'Học sinh'}" />
                                </strong>
                            </div>

                            <div class="side-info-row">
                                <span>Thời gian nộp</span>
                                <strong>
                                    <c:out value="${empty submission.submittedAt ? 'Chưa cập nhật' : submission.submittedAt}" />
                                </strong>
                            </div>

                            <div class="side-info-row">
                                <span>Trạng thái</span>
                                <strong>
                                    <c:out value="${empty submission.status ? '---' : submission.status}" />
                                </strong>
                            </div>

                            <div class="side-info-row">
                                <span>Thời gian chấm</span>
                                <strong>
                                    <c:out value="${empty submission.gradedAt ? 'Chưa chấm' : submission.gradedAt}" />
                                </strong>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- CHẤM BÀI -->
                <div class="card">
                    <div class="card-body">
                        <h2 class="card-title">
                            <i class="fa-solid fa-pen-to-square"></i>
                            <c:choose>
                                <c:when test="${submission.status == 'GRADED'}">
                                    Cập nhật chấm bài
                                </c:when>
                                <c:otherwise>
                                    Chấm bài
                                </c:otherwise>
                            </c:choose>
                        </h2>

                        <form class="grade-form"
                              action="${pageContext.request.contextPath}/tutor/homework/submissions/grade"
                              method="post">

                            <input type="hidden"
                                   name="submissionId"
                                   value="${submission.submissionId}" />

                            <div class="form-group">
                                <label for="score">Điểm số</label>
                                <input type="number"
                                       id="score"
                                       name="score"
                                       class="form-control"
                                       min="0"
                                       max="10"
                                       step="0.1"
                                       value="${submission.score}"
                                       placeholder="Nhập điểm từ 0 đến 10"
                                       required>
                                <div class="hint">Điểm hợp lệ từ 0 đến 10.</div>
                            </div>

                            <div class="form-group">
                                <label for="feedback">Nhận xét</label>
                                <textarea id="feedback"
                                          name="feedback"
                                          class="form-textarea"
                                          placeholder="Nhập nhận xét cho học sinh..."
                                          required>${submission.teacherFeedback}</textarea>
                            </div>

                            <button type="submit" class="btn-submit">
                                <i class="fa-solid fa-floppy-disk"></i>
                                <c:choose>
                                    <c:when test="${submission.status == 'GRADED'}">
                                        Cập nhật điểm
                                    </c:when>
                                    <c:otherwise>
                                        Lưu chấm bài
                                    </c:otherwise>
                                </c:choose>
                            </button>
                        </form>
                    </div>
                </div>

            </aside>

        </section>

    </main>
</div>

</body>
</html>
