<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="activePage" value="homework" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết bài tập | TCMS Student</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0"/>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/student-dashboard.css">

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
            --muted-light: #94a3b8;
            --danger: #ef4444;
            --success: #22c55e;
            --warning: #f59e0b;
            --blue-soft: #eff6ff;
            --green-soft: #dcfce7;
            --red-soft: #fee2e2;
            --orange-soft: #fff7ed;
        }

        .material-symbols-rounded {
            font-family: 'Material Symbols Rounded' !important;
            font-weight: normal;
            font-style: normal;
            font-size: 22px;
            line-height: 1;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            white-space: nowrap;
            direction: ltr;
            -webkit-font-feature-settings: 'liga';
            -webkit-font-smoothing: antialiased;
            font-feature-settings: 'liga';
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

        .breadcrumb a:hover {
            text-decoration: underline;
        }

        .alert-error {
            background: #fef2f2;
            border: 1px solid #fecaca;
            color: #b91c1c;
            border-radius: 16px;
            padding: 14px 16px;
            margin-bottom: 1rem;
            font-size: 14px;
            font-weight: 800;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .top-card {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 24px;
            padding: 1.6rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 8px 24px rgba(15, 23, 42, 0.04);
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

        .tag-purple {
            background: #f3e8ff;
            color: #7e22ce;
        }

        .tag-orange {
            background: var(--orange-soft);
            color: #ea580c;
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
            letter-spacing: -0.4px;
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
            font-size: 18px;
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

        .card,
        .side-card {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 20px;
            box-shadow: 0 8px 24px rgba(15, 23, 42, 0.04);
            overflow: hidden;
        }

        .accent-blue {
            border-top: 5px solid var(--primary);
        }

        .accent-green {
            border-top: 5px solid var(--primary);
        }

        .accent-red {
            border-top: 5px solid var(--danger);
        }

        .card-body {
            padding: 1.5rem;
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

        .homework-content {
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

        .attachment-link:hover {
            background: #dbeafe;
        }

        .submission-header {
            display: flex;
            justify-content: space-between;
            gap: 1rem;
            align-items: center;
            margin-bottom: 1rem;
        }

        .autosave {
            color: var(--muted-light);
            font-size: 11px;
            font-weight: 700;
        }

        .form-group {
            margin-bottom: 1rem;
        }

        .form-label {
            display: block;
            color: var(--text-dark);
            font-size: 13px;
            font-weight: 900;
            margin-bottom: 8px;
        }

        .answer-textarea {
            width: 100%;
            min-height: 230px;
            resize: vertical;
            border: 1px solid var(--border);
            border-radius: 16px;
            padding: 14px 16px;
            font-size: 14px;
            font-family: inherit;
            color: var(--text-dark);
            outline: none;
            background: #ffffff;
        }

        .answer-textarea:focus,
        .attachment-input:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(0, 87, 191, 0.12);
        }

        .attachment-input {
            width: 100%;
            height: 46px;
            border: 1px solid var(--border);
            border-radius: 14px;
            padding: 0 14px;
            font-size: 14px;
            font-weight: 600;
            color: var(--text-dark);
            outline: none;
        }

        .form-hint {
            color: var(--text-muted);
            font-size: 12px;
            font-weight: 600;
            margin-top: 6px;
            line-height: 1.5;
        }

        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 1.25rem;
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
            transform: translateY(-1px);
        }

        .btn-dark {
            background: #0f172a;
            color: #ffffff;
        }

        .btn-dark:hover {
            background: #020617;
        }

        .btn-soft {
            background: #f1f5f9;
            color: var(--text-dark);
        }

        .btn-soft:hover {
            background: #e2e8f0;
            color: var(--primary);
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

        .status-pending .status-hero-icon {
            background: var(--red-soft);
            color: var(--danger);
        }

        .status-pending .status-hero h2 {
            color: var(--danger);
        }

        .status-submitted,
        .status-graded {
            border-top: 5px solid var(--primary);
        }

        .status-submitted .status-hero-icon,
        .status-graded .status-hero-icon {
            background: var(--blue-soft);
            color: var(--primary);
        }

        .status-submitted .status-hero h2,
        .status-graded .status-hero h2 {
            color: var(--primary);
        }

        .status-hero h2 {
            margin: 0 0 6px;
            color: var(--text-dark);
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

        .text-danger {
            color: var(--danger) !important;
        }

        .text-primary {
            color: var(--primary) !important;
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

        .feedback-box {
            margin-top: 1rem;
            background: #f8fafc;
            border: 1px solid var(--soft-border);
            border-radius: 16px;
            padding: 1rem;
            color: var(--text-main);
            font-size: 14px;
            font-weight: 600;
            line-height: 1.7;
            white-space: pre-line;
            text-align: left;
        }

        .submitted-content {
            color: var(--text-main);
            font-size: 14px;
            font-weight: 600;
            line-height: 1.8;
            white-space: pre-line;
        }

        .submitted-file {
            margin-top: 1rem;
            border: 1px solid var(--border);
            border-radius: 16px;
            padding: 14px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 1rem;
            background: #ffffff;
        }

        .submitted-file-left {
            display: flex;
            align-items: center;
            gap: 12px;
            min-width: 0;
        }

        .file-icon {
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

        .submitted-file strong {
            display: block;
            color: var(--text-dark);
            font-size: 13px;
            font-weight: 900;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .submitted-file span {
            color: var(--text-muted);
            font-size: 12px;
            font-weight: 600;
        }

        .file-actions {
            display: flex;
            gap: 10px;
        }

        .file-actions a {
            color: var(--primary);
            text-decoration: none;
        }

        .quiz-layout {
            display: grid;
            grid-template-columns: minmax(0, 1fr) 280px;
            gap: 1.5rem;
            align-items: start;
        }

        .quiz-question {
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

        .options-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 12px;
        }

        .option-box {
            position: relative;
        }

        .option-box input {
            position: absolute;
            opacity: 0;
            pointer-events: none;
        }

        .option-label {
            min-height: 48px;
            border: 1px solid var(--border);
            border-radius: 12px;
            padding: 12px 14px;
            display: flex;
            align-items: center;
            gap: 10px;
            color: var(--text-main);
            font-size: 13px;
            font-weight: 700;
            cursor: pointer;
            transition: all .2s ease;
            background: #ffffff;
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

        .option-box input:checked + .option-label {
            border-color: var(--primary);
            background: var(--blue-soft);
            color: var(--primary);
            box-shadow: 0 0 0 3px rgba(0, 87, 191, 0.10);
        }

        .option-box input:checked + .option-label .option-letter {
            background: var(--primary);
            color: #ffffff;
        }

        .quiz-side-card {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 20px;
            padding: 1.25rem;
            position: sticky;
            top: 90px;
        }

        .progress-card {
            margin-bottom: 1rem;
        }

        .progress-card h3 {
            margin: 0 0 10px;
            color: var(--text-dark);
            font-size: 14px;
            font-weight: 900;
        }

        .question-nav {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 8px;
        }

        .q-nav-btn {
            height: 34px;
            border-radius: 10px;
            border: 1px solid var(--border);
            background: #ffffff;
            color: var(--text-muted);
            font-size: 12px;
            font-weight: 900;
        }

        .q-nav-btn.answered {
            background: var(--blue-soft);
            color: var(--primary);
            border-color: #bfdbfe;
        }

        .guide-box {
            background: var(--blue-soft);
            color: var(--primary);
            border-radius: 14px;
            padding: 12px;
            font-size: 12px;
            font-weight: 700;
            line-height: 1.6;
            margin-bottom: 1rem;
        }

        .result-summary {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 20px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            display: grid;
            grid-template-columns: 140px repeat(4, minmax(0, 1fr));
            gap: 1rem;
            align-items: center;
        }

        .result-score {
            text-align: center;
        }

        .result-score strong {
            display: block;
            color: var(--text-dark);
            font-size: 34px;
            font-weight: 900;
        }

        .result-score span {
            color: var(--text-muted);
            font-size: 12px;
            font-weight: 800;
        }

        .result-stat {
            background: #f8fafc;
            border-radius: 14px;
            padding: 14px;
        }

        .result-stat span {
            display: block;
            color: var(--text-muted);
            font-size: 12px;
            font-weight: 800;
            margin-bottom: 6px;
        }

        .result-stat strong {
            color: var(--primary);
            font-size: 18px;
            font-weight: 900;
        }

        .review-question {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 18px;
            padding: 1.25rem;
            margin-bottom: 1rem;
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

        .ms-auto {
            margin-left: auto;
        }

        @media (max-width: 1180px) {
            .main-layout,
            .quiz-layout,
            .top-card-inner {
                grid-template-columns: 1fr;
            }

            .quiz-side-card {
                position: static;
            }

            .result-summary {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }
        }

        @media (max-width: 720px) {
            .homework-detail-page {
                padding: 1rem;
            }

            .options-grid {
                grid-template-columns: 1fr;
            }

            .result-summary {
                grid-template-columns: 1fr;
            }

            .form-actions {
                flex-direction: column;
            }

            .btn {
                width: 100%;
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
            <a href="${pageContext.request.contextPath}/student/homework">
                Bài tập của tôi
            </a>
            <span> › Chi tiết bài tập</span>
        </div>

        <c:if test="${not empty error}">
            <div class="alert-error">
                <i class="fa-solid fa-circle-exclamation"></i>
                <c:out value="${error}" />
            </div>
        </c:if>

        <section class="top-card">
            <div class="top-card-inner">
                <div>
                    <a href="${pageContext.request.contextPath}/student/homework" class="back-link">
                        <i class="fa-solid fa-arrow-left"></i>
                        Back to Homework List
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
                                    Chưa làm bài
                                </span>
                            </c:when>

                            <c:otherwise>
                                <span class="tag tag-blue">
                                    <i class="fa-solid fa-circle-check"></i>
                                    Đã làm bài
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <h1>
                        <c:out value="${empty homework.title ? 'Tên bài' : homework.title}" />
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

        <c:choose>

            <%-- MULTIPLE_CHOICE + ĐÃ CHẤM --%>
            <c:when test="${homework.type == 'MULTIPLE_CHOICE' and not empty submission and submission.status == 'GRADED'}">

                <section class="result-summary">
                    <div class="result-score">
                        <strong>
                            <c:out value="${empty submission.score ? '--' : submission.score}" />
                        </strong>
                        <span>/ 10.0</span>
                    </div>

                    <div class="result-stat">
                        <span>Tổng câu hỏi</span>
                        <strong>${empty questions ? '--' : fn:length(questions)}</strong>
                    </div>

                    <div class="result-stat">
                        <span>Trạng thái</span>
                        <strong>Đã làm bài</strong>
                    </div>

                    <div class="result-stat">
                        <span>Thời gian nộp</span>
                        <strong>
                            <c:out value="${empty submission.submittedAt ? '--' : submission.submittedAt}" />
                        </strong>
                    </div>

                    <div class="result-stat">
                        <span>Thời gian chấm</span>
                        <strong>
                            <c:out value="${empty submission.gradedAt ? '--' : submission.gradedAt}" />
                        </strong>
                    </div>
                </section>

                <section class="main-layout">
                    <div class="left-stack">
                        <div class="card">
                            <div class="card-body">
                                <h2 class="card-title">
                                    <span class="title-icon">
                                        <i class="fa-solid fa-list-check"></i>
                                    </span>
                                    Review câu hỏi
                                </h2>

                                <c:choose>
                                    <c:when test="${not empty questions}">
                                        <c:forEach var="q" items="${questions}" varStatus="loop">
                                            <c:set var="qKey" value="q_${q.questionId}" />
                                            <c:set var="sAns" value="${studentAnswers[qKey]}" />

                                            <div class="review-question">
                                                <div class="question-title">
                                                    <span class="question-number">${loop.index + 1}</span>
                                                    <h3>
                                                        <c:out value="${q.questionText}" />
                                                    </h3>
                                                </div>

                                                <div class="review-option ${sAns == 'A' ? (q.correctAnswer == 'A' ? 'correct' : 'wrong') : (q.correctAnswer == 'A' ? 'correct' : '')}">
                                                    <span class="option-letter">A</span>
                                                    <c:out value="${q.optionA}" />
                                                    <c:if test="${q.correctAnswer == 'A'}"><i class="fa-solid fa-check ms-auto"></i></c:if>
                                                    <c:if test="${sAns == 'A' and q.correctAnswer != 'A'}"><i class="fa-solid fa-xmark ms-auto"></i></c:if>
                                                </div>

                                                <div class="review-option ${sAns == 'B' ? (q.correctAnswer == 'B' ? 'correct' : 'wrong') : (q.correctAnswer == 'B' ? 'correct' : '')}">
                                                    <span class="option-letter">B</span>
                                                    <c:out value="${q.optionB}" />
                                                    <c:if test="${q.correctAnswer == 'B'}"><i class="fa-solid fa-check ms-auto"></i></c:if>
                                                    <c:if test="${sAns == 'B' and q.correctAnswer != 'B'}"><i class="fa-solid fa-xmark ms-auto"></i></c:if>
                                                </div>

                                                <div class="review-option ${sAns == 'C' ? (q.correctAnswer == 'C' ? 'correct' : 'wrong') : (q.correctAnswer == 'C' ? 'correct' : '')}">
                                                    <span class="option-letter">C</span>
                                                    <c:out value="${q.optionC}" />
                                                    <c:if test="${q.correctAnswer == 'C'}"><i class="fa-solid fa-check ms-auto"></i></c:if>
                                                    <c:if test="${sAns == 'C' and q.correctAnswer != 'C'}"><i class="fa-solid fa-xmark ms-auto"></i></c:if>
                                                </div>

                                                <div class="review-option ${sAns == 'D' ? (q.correctAnswer == 'D' ? 'correct' : 'wrong') : (q.correctAnswer == 'D' ? 'correct' : '')}">
                                                    <span class="option-letter">D</span>
                                                    <c:out value="${q.optionD}" />
                                                    <c:if test="${q.correctAnswer == 'D'}"><i class="fa-solid fa-check ms-auto"></i></c:if>
                                                    <c:if test="${sAns == 'D' and q.correctAnswer != 'D'}"><i class="fa-solid fa-xmark ms-auto"></i></c:if>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:when>

                                    <c:otherwise>
                                        <div class="homework-content">
                                            <c:out value="${empty submission.answers ? 'Không có đáp án.' : submission.answers}" />
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>

                    <aside class="right-stack">
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
                                    Đã làm bài
                                </span>
                            </div>
                        </div>

                        <a href="${pageContext.request.contextPath}/student/homework" class="btn btn-primary">
                            <i class="fa-solid fa-arrow-left"></i>
                            Quay lại danh sách
                        </a>
                    </aside>
                </section>
            </c:when>

            <%-- MULTIPLE_CHOICE + CHƯA NỘP --%>
            <c:when test="${homework.type == 'MULTIPLE_CHOICE' and empty submission}">

                <form id="quizForm"
                      action="${pageContext.request.contextPath}/student/homework/submit"
                      method="post">

                    <input type="hidden" name="homeworkId" value="${homework.homeworkId}">
                    <input type="hidden" name="answers" id="answersJson">
                    <input type="hidden" name="attachmentUrl" value="">

                    <section class="quiz-layout">
                        <div>
                            <c:choose>
                                <c:when test="${not empty questions}">
                                    <c:forEach var="q" items="${questions}" varStatus="loop">
                                        <div class="quiz-question" id="question-${loop.index + 1}">
                                            <div class="question-title">
                                                <span class="question-number">${loop.index + 1}</span>
                                                <h3>
                                                    Câu ${loop.index + 1}:
                                                    <c:out value="${q.questionText}" />
                                                </h3>
                                            </div>

                                            <div class="options-grid">
                                                <label class="option-box">
                                                    <input type="radio"
                                                           name="q_${q.questionId}"
                                                           value="A"
                                                           data-question-index="${loop.index + 1}">
                                                    <span class="option-label">
                                                        <span class="option-letter">A</span>
                                                        <c:out value="${q.optionA}" />
                                                    </span>
                                                </label>

                                                <label class="option-box">
                                                    <input type="radio"
                                                           name="q_${q.questionId}"
                                                           value="B"
                                                           data-question-index="${loop.index + 1}">
                                                    <span class="option-label">
                                                        <span class="option-letter">B</span>
                                                        <c:out value="${q.optionB}" />
                                                    </span>
                                                </label>

                                                <label class="option-box">
                                                    <input type="radio"
                                                           name="q_${q.questionId}"
                                                           value="C"
                                                           data-question-index="${loop.index + 1}">
                                                    <span class="option-label">
                                                        <span class="option-letter">C</span>
                                                        <c:out value="${q.optionC}" />
                                                    </span>
                                                </label>

                                                <label class="option-box">
                                                    <input type="radio"
                                                           name="q_${q.questionId}"
                                                           value="D"
                                                           data-question-index="${loop.index + 1}">
                                                    <span class="option-label">
                                                        <span class="option-letter">D</span>
                                                        <c:out value="${q.optionD}" />
                                                    </span>
                                                </label>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>

                                <c:otherwise>
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="homework-content" style="text-align: center; padding: 2rem;">
                                                <i class="fa-solid fa-triangle-exclamation"
                                                   style="font-size: 40px; color: var(--warning); margin-bottom: 1rem;"></i>
                                                <p>Bài trắc nghiệm này chưa có câu hỏi. Vui lòng liên hệ gia sư.</p>
                                            </div>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <aside class="quiz-side-card status-pending">
                            <div class="status-hero">
                                <div class="status-hero-icon">
                                    <i class="fa-solid fa-circle-xmark"></i>
                                </div>
                                <h2>Chưa làm bài</h2>
                                <p>Bạn chưa gửi bài làm.</p>
                            </div>

                            <div class="progress-card">
                                <h3>Tiến độ làm bài</h3>

                                <div class="question-nav">
                                    <c:choose>
                                        <c:when test="${not empty questions}">
                                            <c:forEach var="q" items="${questions}" varStatus="loop">
                                                <button type="button"
                                                        class="q-nav-btn"
                                                        id="nav-q-${loop.index + 1}">
                                                        ${loop.index + 1}
                                                </button>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <button type="button" class="q-nav-btn">1</button>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <div class="guide-box">
                                <strong>Hướng dẫn làm bài</strong><br>
                                Chọn một đáp án cho mỗi câu hỏi. Sau khi bấm nộp, hệ thống sẽ tự chấm điểm.
                            </div>

                            <button type="submit" class="btn btn-primary" style="width:100%;">
                                <i class="fa-solid fa-paper-plane"></i>
                                Nộp bài ngay
                            </button>
                        </aside>
                    </section>
                </form>
            </c:when>

            <%-- ESSAY + CHƯA NỘP --%>
            <c:when test="${empty submission}">

                <section class="main-layout">
                    <div class="left-stack">
                        <div class="card accent-red">
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

                        <div class="card">
                            <div class="card-body">
                                <div class="submission-header">
                                    <h2 class="card-title" style="margin-bottom:0;">
                                        <span class="title-icon">
                                            <i class="fa-solid fa-pen-to-square"></i>
                                        </span>
                                        Your Submission
                                    </h2>
                                </div>

                                <form action="${pageContext.request.contextPath}/student/homework/submit"
                                      method="post">

                                    <input type="hidden" name="homeworkId" value="${homework.homeworkId}">

                                    <div class="form-group">
                                        <label class="form-label" for="answers">
                                            Nội dung bài làm
                                        </label>

                                        <textarea id="answers"
                                                  name="answers"
                                                  class="answer-textarea"
                                                  placeholder="Bắt đầu viết bài luận của bạn tại đây..."
                                                  required></textarea>
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label" for="attachmentUrl">
                                            Link file bài làm
                                        </label>

                                        <input id="attachmentUrl"
                                               name="attachmentUrl"
                                               type="text"
                                               class="attachment-input"
                                               placeholder="https://drive.google.com/file/...">

                                        <div class="form-hint">
                                            Đảm bảo link có quyền truy cập để gia sư có thể xem bài làm.
                                        </div>
                                    </div>

                                    <div class="form-actions">
                                        <button type="button" class="btn btn-soft">
                                            Save Draft
                                        </button>

                                        <button type="submit" class="btn btn-primary">
                                            <i class="fa-solid fa-paper-plane"></i>
                                            Nộp bài
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <aside class="right-stack">
                        <div class="side-card status-pending">
                            <div class="status-hero">
                                <div class="status-hero-icon">
                                    <i class="fa-solid fa-circle-xmark"></i>
                                </div>
                                <h2>Chưa làm bài</h2>
                                <p>Bạn chưa gửi bài làm.</p>
                            </div>

                            <div class="status-list">
                                <div class="status-row">
                                    <span>Trạng thái</span>
                                    <strong class="text-danger">Chưa làm bài</strong>
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
                    </aside>
                </section>
            </c:when>

            <%-- ESSAY + ĐÃ NỘP CHỜ CHẤM --%>
            <c:when test="${not empty submission and submission.status == 'SUBMITTED'}">

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
                            </div>
                        </div>

                        <div class="card">
                            <div class="card-body">
                                <div class="submission-header">
                                    <h2 class="card-title" style="margin-bottom:0;">
                                        <span class="title-icon">
                                            <i class="fa-solid fa-circle-check"></i>
                                        </span>
                                        My Submission
                                    </h2>

                                    <span class="autosave">Locked for Review</span>
                                </div>

                                <div class="submitted-content">
                                    <c:out value="${empty submission.answers ? 'Không có nội dung bài làm.' : submission.answers}" />
                                </div>

                                <c:if test="${not empty submission.attachmentUrl}">
                                    <div class="submitted-file">
                                        <div class="submitted-file-left">
                                            <div class="file-icon">
                                                <i class="fa-solid fa-file-pdf"></i>
                                            </div>
                                            <div>
                                                <strong>
                                                    <c:out value="${submission.attachmentUrl}" />
                                                </strong>
                                                <span>Submitted file</span>
                                            </div>
                                        </div>

                                        <div class="file-actions">
                                            <a href="${submission.attachmentUrl}" target="_blank">
                                                <i class="fa-regular fa-eye"></i>
                                            </a>
                                            <a href="${submission.attachmentUrl}" target="_blank">
                                                <i class="fa-solid fa-download"></i>
                                            </a>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>

                    <aside class="right-stack">
                        <div class="side-card status-submitted">
                            <div class="status-hero">
                                <div class="status-hero-icon">
                                    <i class="fa-solid fa-circle-check"></i>
                                </div>
                                <h2>Đã làm bài</h2>
                                <p>Bài làm của bạn đã được gửi và đang chờ gia sư chấm.</p>
                            </div>

                            <div class="status-list">
                                <div class="status-row">
                                    <span>Submitted on</span>
                                    <strong>
                                        <c:out value="${empty submission.submittedAt ? '--' : submission.submittedAt}" />
                                    </strong>
                                </div>
                                <div class="status-row">
                                    <span>Score</span>
                                    <strong>Chưa có</strong>
                                </div>
                            </div>
                        </div>

                        <div class="side-card">
                            <div class="card-body">
                                <div class="guide-box" style="margin-bottom:0;">
                                    Sau khi gia sư chấm, điểm và nhận xét sẽ tự động hiển thị tại đây.
                                </div>
                            </div>
                        </div>

                        <a href="${pageContext.request.contextPath}/student/homework" class="btn btn-dark">
                            Quay lại danh sách bài tập
                        </a>
                    </aside>
                </section>
            </c:when>

            <%-- ESSAY + ĐÃ CHẤM --%>
            <c:otherwise>

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
                            </div>
                        </div>

                        <div class="card">
                            <div class="card-body">
                                <div class="submission-header">
                                    <h2 class="card-title" style="margin-bottom:0;">
                                        <span class="title-icon">
                                            <i class="fa-solid fa-circle-check"></i>
                                        </span>
                                        My Submission
                                    </h2>

                                    <span class="autosave">
                                        Submitted
                                        <c:out value="${empty submission.submittedAt ? '' : submission.submittedAt}" />
                                    </span>
                                </div>

                                <div class="submitted-content">
                                    <c:out value="${empty submission.answers ? 'Không có nội dung bài làm.' : submission.answers}" />
                                </div>

                                <c:if test="${not empty submission.attachmentUrl}">
                                    <div class="submitted-file">
                                        <div class="submitted-file-left">
                                            <div class="file-icon">
                                                <i class="fa-solid fa-file-pdf"></i>
                                            </div>
                                            <div>
                                                <strong>
                                                    <c:out value="${submission.attachmentUrl}" />
                                                </strong>
                                                <span>Submitted file</span>
                                            </div>
                                        </div>

                                        <div class="file-actions">
                                            <a href="${submission.attachmentUrl}" target="_blank">
                                                <i class="fa-regular fa-eye"></i>
                                            </a>
                                            <a href="${submission.attachmentUrl}" target="_blank">
                                                <i class="fa-solid fa-download"></i>
                                            </a>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>

                    <aside class="right-stack">
                        <div class="side-card status-graded">
                            <div class="score-card">
                                <h2 class="card-title" style="justify-content:center;">
                                    Final Grade
                                </h2>

                                <div class="score-ring">
                                    <strong>
                                        <c:out value="${empty submission.score ? '--' : submission.score}" />
                                    </strong>
                                    <span>/ 10</span>
                                </div>

                                <span class="score-badge">
                                    <i class="fa-solid fa-circle-check"></i>
                                    Đã làm bài
                                </span>

                                <div class="feedback-box">
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

                        <a href="${pageContext.request.contextPath}/student/homework" class="btn btn-primary">
                            <i class="fa-solid fa-arrow-left"></i>
                            Quay lại danh sách
                        </a>
                    </aside>
                </section>
            </c:otherwise>

        </c:choose>

    </main>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const quizForm = document.getElementById('quizForm');

        if (quizForm) {
            quizForm.addEventListener('submit', function (event) {
                const answersJsonInput = document.getElementById('answersJson');
                const manualQuizAnswers = document.getElementById('manualQuizAnswers');
                const selectedOptions = Array.from(quizForm.querySelectorAll('input[type="radio"]:checked'));

                if (manualQuizAnswers && manualQuizAnswers.value.trim() !== '') {
                    answersJsonInput.value = manualQuizAnswers.value.trim();
                    return;
                }

                const answers = {};

                selectedOptions.forEach(input => {
                    answers[input.name] = input.value;
                });

                if (Object.keys(answers).length === 0) {
                    event.preventDefault();
                    alert('Vui lòng chọn đáp án trước khi nộp bài.');
                    return;
                }

                answersJsonInput.value = JSON.stringify(answers);
            });

            const radios = Array.from(quizForm.querySelectorAll('input[type="radio"]'));

            radios.forEach(radio => {
                radio.addEventListener('change', function () {
                    const index = radio.dataset.questionIndex;
                    const nav = document.getElementById('nav-q-' + index);

                    if (nav) {
                        nav.classList.add('answered');
                    }
                });
            });
        }
    });
</script>

</body>
</html>