<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="activePage" value="homework" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết bài tập | TCMS Parent</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0"/>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/core-dashboard.css">

    <style>
        :root {
            --primary: #0057bf;
            --primary-dark: #004da8;
            --bg-page: #f6f9fc;
            --card: #ffffff;
            --border: #e2e8f0;
            --soft-border: #eef2f7;
            --text-dark: #0f172a;
            --text-main: #334155;
            --text-muted: #64748b;
            --danger: #ef4444;
            --success: #22c55e;
            --blue-soft: #eff6ff;
            --green-soft: #dcfce7;
            --red-soft: #fee2e2;
            --orange-soft: #fff7ed;
        }

        .homework-detail-page {
            padding: 2rem;
            min-height: 100vh;
            background: var(--bg-page);
        }

        .breadcrumb {
            color: var(--text-muted);
            font-size: 13px;
            font-weight: 700;
            margin-bottom: 1rem;
        }

        .breadcrumb a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 800;
        }

        .top-card,
        .card,
        .side-card {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 22px;
            box-shadow: 0 8px 24px rgba(15, 23, 42, 0.04);
            overflow: hidden;
        }

        .top-card {
            padding: 1.6rem;
            margin-bottom: 1.5rem;
        }

        .top-card-inner {
            display: grid;
            grid-template-columns: minmax(0, 1fr) 230px;
            gap: 1.5rem;
            align-items: center;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            color: var(--text-muted);
            font-size: 13px;
            font-weight: 800;
            text-decoration: none;
            margin-bottom: 12px;
        }

        .back-link:hover {
            color: var(--primary);
        }

        .tag-row {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            margin-bottom: 10px;
        }

        .tag {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 10px;
            border-radius: 999px;
            font-size: 11px;
            font-weight: 900;
            white-space: nowrap;
        }

        .tag-blue {
            background: var(--blue-soft);
            color: var(--primary);
        }

        .tag-green {
            background: var(--green-soft);
            color: #16a34a;
        }

        .tag-red {
            background: var(--red-soft);
            color: var(--danger);
        }

        .tag-gray {
            background: #f1f5f9;
            color: var(--text-muted);
        }

        .top-card h1 {
            margin: 0;
            color: var(--text-dark);
            font-size: 30px;
            font-weight: 900;
            line-height: 1.25;
        }

        .deadline-box {
            border: 1px solid var(--border);
            border-radius: 18px;
            padding: 14px 16px;
            background: #ffffff;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .deadline-icon {
            width: 42px;
            height: 42px;
            border-radius: 12px;
            background: var(--red-soft);
            color: var(--danger);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .deadline-box span {
            display: block;
            color: var(--text-muted);
            font-size: 11px;
            font-weight: 900;
            text-transform: uppercase;
            margin-bottom: 4px;
        }

        .deadline-box strong {
            color: var(--danger);
            font-size: 13px;
            font-weight: 900;
        }

        .main-layout {
            display: grid;
            grid-template-columns: minmax(0, 1fr) 310px;
            gap: 1.5rem;
            align-items: start;
        }

        .left-stack,
        .right-stack {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .card-body {
            padding: 1.5rem;
        }

        .accent-blue {
            border-top: 5px solid var(--primary);
        }

        .accent-red {
            border-top: 5px solid var(--danger);
        }

        .card-title {
            margin: 0 0 1rem;
            color: var(--text-dark);
            font-size: 18px;
            font-weight: 900;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .title-icon {
            width: 34px;
            height: 34px;
            border-radius: 10px;
            background: var(--blue-soft);
            color: var(--primary);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .homework-content,
        .submitted-content,
        .feedback-box {
            background: #f8fafc;
            border: 1px solid var(--soft-border);
            border-radius: 16px;
            padding: 1rem;
            color: var(--text-main);
            font-size: 14px;
            font-weight: 600;
            line-height: 1.8;
            white-space: pre-line;
        }

        .attachment-link {
            margin-top: 1rem;
            min-height: 42px;
            padding: 0 14px;
            border-radius: 12px;
            background: var(--blue-soft);
            color: var(--primary);
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            font-size: 13px;
            font-weight: 900;
        }

        .review-question {
            background: #ffffff;
            border: 1px solid var(--border);
            border-radius: 18px;
            padding: 1.25rem;
            margin-bottom: 1rem;
        }

        .question-title {
            display: flex;
            align-items: flex-start;
            gap: 12px;
            margin-bottom: 1rem;
        }

        .question-number {
            width: 32px;
            height: 32px;
            border-radius: 10px;
            background: var(--primary);
            color: #ffffff;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            font-weight: 900;
            flex-shrink: 0;
        }

        .question-title h3 {
            margin: 0;
            color: var(--text-dark);
            font-size: 15px;
            font-weight: 900;
            line-height: 1.5;
        }

        .review-option {
            min-height: 42px;
            border: 1px solid var(--soft-border);
            border-radius: 12px;
            padding: 10px 12px;
            margin-top: 8px;
            display: flex;
            align-items: center;
            gap: 10px;
            color: var(--text-main);
            font-size: 13px;
            font-weight: 700;
        }

        .review-option.correct {
            border-color: var(--success);
            background: var(--green-soft);
            color: #166534;
        }

        .review-option.wrong {
            border-color: var(--danger);
            background: var(--red-soft);
            color: #991b1b;
        }

        .option-letter {
            width: 24px;
            height: 24px;
            border-radius: 999px;
            background: #f8fafc;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            color: var(--text-muted);
            font-size: 11px;
            font-weight: 900;
            flex-shrink: 0;
        }

        .ms-auto {
            margin-left: auto;
        }

        .status-hero {
            text-align: center;
            padding: 1.5rem 1rem;
        }

        .status-hero-icon {
            width: 70px;
            height: 70px;
            border-radius: 999px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            margin-bottom: 1rem;
        }

        .status-pending {
            border-top: 5px solid var(--danger);
        }

        .status-submitted,
        .status-graded {
            border-top: 5px solid var(--primary);
        }

        .status-pending .status-hero-icon {
            background: var(--red-soft);
            color: var(--danger);
        }

        .status-submitted .status-hero-icon,
        .status-graded .status-hero-icon {
            background: var(--blue-soft);
            color: var(--primary);
        }

        .status-hero h2 {
            margin: 0 0 6px;
            font-size: 22px;
            font-weight: 900;
        }

        .status-hero p {
            margin: 0;
            color: var(--text-muted);
            font-size: 13px;
            font-weight: 600;
            line-height: 1.5;
        }

        .status-list {
            padding: 0 1.5rem 1.5rem;
        }

        .status-row {
            display: flex;
            justify-content: space-between;
            gap: 1rem;
            padding: 12px 0;
            border-top: 1px solid var(--soft-border);
        }

        .status-row span {
            color: var(--text-muted);
            font-size: 12px;
            font-weight: 900;
            text-transform: uppercase;
        }

        .status-row strong {
            color: var(--text-dark);
            font-size: 13px;
            font-weight: 900;
            text-align: right;
        }

        .score-card {
            padding: 1.5rem;
            text-align: center;
        }

        .score-ring {
            width: 140px;
            height: 140px;
            border-radius: 999px;
            border: 8px solid var(--primary);
            margin: 0 auto 1rem;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            background: #ffffff;
        }

        .score-ring strong {
            color: var(--text-dark);
            font-size: 36px;
            font-weight: 900;
            line-height: 1;
        }

        .score-ring span {
            color: var(--text-muted);
            font-size: 13px;
            font-weight: 800;
        }

        .score-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 7px 12px;
            border-radius: 999px;
            background: var(--blue-soft);
            color: var(--primary);
            font-size: 12px;
            font-weight: 900;
        }

        .btn {
            min-height: 44px;
            padding: 0 18px;
            border-radius: 13px;
            border: 0;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            font-size: 14px;
            font-weight: 900;
            text-decoration: none;
            cursor: pointer;
            transition: all .2s ease;
        }

        .btn-primary {
            background: var(--primary);
            color: #ffffff;
        }

        .btn-primary:hover {
            background: var(--primary-dark);
        }

        @media (max-width: 1180px) {
            .main-layout,
            .top-card-inner {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 720px) {
            .homework-detail-page {
                padding: 1rem;
            }
        }
    </style>
</head>

<body>

<jsp:include page="../common/sidebar.jsp" />

<div class="main-content">
    <jsp:include page="../common/header.jsp" />

    <main class="homework-detail-page">

        <div class="breadcrumb">
            <a href="${pageContext.request.contextPath}/parent/classes">
                Lớp học của con
            </a>
            <span> › Chi tiết bài tập</span>
        </div>

        <section class="top-card">
            <div class="top-card-inner">
                <div>
                    <a href="javascript:history.back()" class="back-link">
                        <i class="fa-solid fa-arrow-left"></i>
                        Quay lại
                    </a>

                    <div class="tag-row">
                        <span class="tag tag-blue">
                            <c:out value="${empty homework.type ? 'BÀI TẬP' : homework.type}" />
                        </span>

                        <span class="tag tag-gray">
                            <c:choose>
                                <c:when test="${not empty homework.session and not empty homework.session.classEntity and not empty homework.session.classEntity.subject}">
                                    <c:out value="${homework.session.classEntity.subject}" />
                                </c:when>
                                <c:otherwise>Môn học</c:otherwise>
                            </c:choose>
                        </span>

                        <c:choose>
                            <c:when test="${empty submission}">
                                <span class="tag tag-red">
                                    <i class="fa-solid fa-circle-xmark"></i>
                                    Chưa nộp bài
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="tag tag-green">
                                    <i class="fa-solid fa-circle-check"></i>
                                    Đã nộp bài
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <h1>
                        <c:out value="${empty homework.title ? 'Tên bài tập' : homework.title}" />
                    </h1>
                </div>

                <div class="deadline-box">
                    <div class="deadline-icon">
                        <i class="fa-regular fa-clock"></i>
                    </div>
                    <div>
                        <span>Deadline</span>
                        <strong>
                            <c:out value="${empty homework.deadline ? 'Chưa cập nhật' : homework.deadline}" />
                        </strong>
                    </div>
                </div>
            </div>
        </section>

        <section class="main-layout">
            <div class="left-stack">

                <div class="card accent-blue">
                    <div class="card-body">
                        <h2 class="card-title">
                            <span class="title-icon">
                                <i class="fa-solid fa-file-lines"></i>
                            </span>
                            Đề bài
                        </h2>

                        <div class="homework-content">
                            <c:out value="${empty homework.content ? 'Chưa có nội dung đề bài.' : homework.content}" />
                        </div>

                        <c:if test="${not empty homework.attachmentUrl}">
                            <a href="${homework.attachmentUrl}" target="_blank" class="attachment-link">
                                <i class="fa-solid fa-paperclip"></i>
                                Mở tài liệu đính kèm
                            </a>
                        </c:if>
                    </div>
                </div>

                <c:if test="${homework.type == 'MULTIPLE_CHOICE'}">
                    <div class="card">
                        <div class="card-body">
                            <h2 class="card-title">
                                <span class="title-icon">
                                    <i class="fa-solid fa-list-check"></i>
                                </span>
                                Danh sách câu hỏi
                            </h2>

                            <c:choose>
                                <c:when test="${not empty questions}">
                                    <c:forEach var="q" items="${questions}" varStatus="loop">
                                        <c:set var="qKey" value="q_${q.questionId}" />
                                        <c:set var="sAns" value="${not empty studentAnswers ? studentAnswers[qKey] : ''}" />

                                        <div class="review-question">
                                            <div class="question-title">
                                                <span class="question-number">${loop.index + 1}</span>
                                                <h3>
                                                    <c:out value="${q.questionText}" />
                                                </h3>
                                            </div>

                                            <div class="review-option ${q.correctAnswer == 'A' ? 'correct' : ''} ${sAns == 'A' and q.correctAnswer != 'A' ? 'wrong' : ''}">
                                                <span class="option-letter">A</span>
                                                <c:out value="${q.optionA}" />
                                            </div>

                                            <div class="review-option ${q.correctAnswer == 'B' ? 'correct' : ''} ${sAns == 'B' and q.correctAnswer != 'B' ? 'wrong' : ''}">
                                                <span class="option-letter">B</span>
                                                <c:out value="${q.optionB}" />
                                            </div>

                                            <div class="review-option ${q.correctAnswer == 'C' ? 'correct' : ''} ${sAns == 'C' and q.correctAnswer != 'C' ? 'wrong' : ''}">
                                                <span class="option-letter">C</span>
                                                <c:out value="${q.optionC}" />
                                            </div>

                                            <div class="review-option ${q.correctAnswer == 'D' ? 'correct' : ''} ${sAns == 'D' and q.correctAnswer != 'D' ? 'wrong' : ''}">
                                                <span class="option-letter">D</span>
                                                <c:out value="${q.optionD}" />
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>

                                <c:otherwise>
                                    <div class="homework-content">
                                        Chưa có câu hỏi cho bài tập này.
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:if>

                <c:if test="${not empty submission}">
                    <div class="card">
                        <div class="card-body">
                            <h2 class="card-title">
                                <span class="title-icon">
                                    <i class="fa-solid fa-circle-check"></i>
                                </span>
                                Bài làm của con
                            </h2>

                            <div class="submitted-content">
                                <c:out value="${empty submission.answers ? 'Không có nội dung bài làm.' : submission.answers}" />
                            </div>

                            <c:if test="${not empty submission.attachmentUrl}">
                                <a href="${submission.attachmentUrl}" target="_blank" class="attachment-link">
                                    <i class="fa-solid fa-paperclip"></i>
                                    Xem file bài làm
                                </a>
                            </c:if>
                        </div>
                    </div>
                </c:if>

            </div>

            <aside class="right-stack">
                <c:choose>
                    <c:when test="${empty submission}">
                        <div class="side-card status-pending">
                            <div class="status-hero">
                                <div class="status-hero-icon">
                                    <i class="fa-solid fa-circle-xmark"></i>
                                </div>
                                <h2>Chưa nộp bài</h2>
                                <p>Học sinh chưa gửi bài làm cho bài tập này.</p>
                            </div>

                            <div class="status-list">
                                <div class="status-row">
                                    <span>Trạng thái</span>
                                    <strong>Chưa nộp</strong>
                                </div>
                                <div class="status-row">
                                    <span>Deadline</span>
                                    <strong>
                                        <c:out value="${empty homework.deadline ? 'Chưa cập nhật' : homework.deadline}" />
                                    </strong>
                                </div>
                                <div class="status-row">
                                    <span>Điểm</span>
                                    <strong>-- / 10</strong>
                                </div>
                            </div>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <div class="side-card status-graded">
                            <div class="score-card">
                                <div class="score-ring">
                                    <strong>
                                        <c:out value="${empty submission.score ? '--' : submission.score}" />
                                    </strong>
                                    <span>/ 10</span>
                                </div>

                                <span class="score-badge">
                                    <i class="fa-solid fa-circle-check"></i>
                                    <c:out value="${empty submission.status ? 'Đã nộp bài' : submission.status}" />
                                </span>

                                <div class="feedback-box" style="margin-top:1rem; text-align:left;">
                                    <strong>Nhận xét:</strong><br>
                                    <c:choose>
                                        <c:when test="${not empty submission.teacherFeedback}">
                                            <c:out value="${submission.teacherFeedback}" />
                                        </c:when>
                                        <c:otherwise>Chưa có nhận xét.</c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>

                <a href="javascript:history.back()" class="btn btn-primary">
                    <i class="fa-solid fa-arrow-left"></i>
                    Quay lại
                </a>
            </aside>
        </section>

    </main>
</div>

</body>
</html>