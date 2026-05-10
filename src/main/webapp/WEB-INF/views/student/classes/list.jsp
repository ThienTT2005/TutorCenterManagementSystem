<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="activePage" value="classes" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Lớp học của tôi | TCMS Student</title>
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
            --text-dark: #0f172a;
            --text-muted: #64748b;
        }

        .student-class-page {
            padding: 2rem;
            background: var(--bg-page);
            min-height: 100vh;
        }

        .page-header {
            margin-bottom: 2rem;
        }

        .page-header h1 {
            font-size: 32px;
            font-weight: 950;
            color: var(--text-dark);
            margin-bottom: 8px;
        }

        .page-header p {
            color: var(--text-muted);
            font-size: 15px;
            font-weight: 600;
        }

        .class-item {
            padding: 1.5rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;

            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 24px;

            transition: all 0.2s ease;
            margin-top: 20px;
        }

        .class-item {
            padding: 1.5rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid var(--border);
            transition: all 0.2s ease;
        }

        .class-item:last-child {
            border-bottom: none;
        }

        .class-item:hover {
            background: #f8fafc;
        }

        .class-main {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .class-tags {
            display: flex;
            gap: 8px;
        }

        .tag {
            padding: 4px 10px;
            border-radius: 8px;
            font-size: 11px;
            font-weight: 900;
            text-transform: uppercase;
        }

        .tag-subject { background: #eff6ff; color: var(--primary); }
        .tag-grade { background: #f3e8ff; color: #7e22ce; }

        .class-name {
            font-size: 20px;
            font-weight: 900;
            color: var(--text-dark);
            margin: 0;
        }

        .class-tutor {
            font-size: 14px;
            color: var(--text-muted);
            font-weight: 600;
        }

        .btn-action {
            height: 46px;
            padding: 0 20px;
            background: var(--primary);
            color: #ffffff;
            border-radius: 12px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 900;
            display: flex;
            align-items: center;
            gap: 10px;
            transition: all 0.2s ease;
        }

        .btn-action:hover {
            background: var(--primary-dark);
            transform: translateX(4px);
        }

        .empty-state {
            padding: 5rem 2rem;
            text-align: center;
            color: var(--text-muted);
        }

        .empty-state i {
            font-size: 48px;
            margin-bottom: 1.5rem;
            opacity: 0.5;
        }

        @media (max-width: 768px) {
            .class-item {
                flex-direction: column;
                align-items: flex-start;
                gap: 1.5rem;
                padding: 1.5rem;
            }
            .btn-action {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>

<body>

<jsp:include page="../common/sidebar.jsp" />

<div class="main-content">
    <jsp:include page="../common/header.jsp" />

    <main class="student-class-page">
        <header class="page-header">
            <h1>Lớp học của tôi</h1>
            <p>Danh sách các lớp học bạn đang theo học tại trung tâm</p>
        </header>

        <div class="class-list-card">
            <c:choose>
                <c:when test="${not empty enrollments}">
                    <c:forEach var="e" items="${enrollments}">
                        <c:set var="clazz" value="${e.classEntity}" />
                        <div class="class-item">
                            <div class="class-main">
                                <div class="class-tags">
                                    <span class="tag tag-subject">${clazz.subject}</span>
                                    <span class="tag tag-grade">Khối ${clazz.grade}</span>
                                </div>
                                <h2 class="class-name"><c:out value="${clazz.className}" /></h2>
                                <div class="class-tutor">
                                    <i class="fa-solid fa-chalkboard-user"></i>
                                    Gia sư: ${empty clazz.tutor ? 'Chưa phân công' : clazz.tutor.fullName}
                                </div>
                            </div>
                            <a href="${pageContext.request.contextPath}/student/classes/${clazz.classId}" class="btn-action">
                                Xem chi tiết lớp học
                                <i class="fa-solid fa-chevron-right"></i>
                            </a>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <i class="fa-solid fa-folder-open"></i>
                        <h3>Bạn chưa có lớp học nào</h3>
                        <p>Vui lòng liên hệ trung tâm để được xếp lớp.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>
</div>

</body>
</html>