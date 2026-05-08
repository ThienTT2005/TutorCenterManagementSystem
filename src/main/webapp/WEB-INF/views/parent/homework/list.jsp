<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="activePage" value="homework" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh sách bài tập | TCMS Parent</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0"/>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/student-dashboard.css">

    <style>
        .homework-list-page {
            padding: 2rem;
            background: #f8fafc;
            min-height: 100vh;
        }

        .page-header {
            margin-bottom: 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .page-title h1 {
            font-size: 28px;
            font-weight: 900;
            color: #0f172a;
            margin: 0 0 8px;
        }

        .page-title p {
            color: #64748b;
            font-size: 14px;
            font-weight: 700;
        }

        .homework-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 1.5rem;
        }

        .homework-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 24px;
            padding: 1.5rem;
            box-shadow: 0 8px 24px rgba(15, 23, 42, 0.04);
            transition: all 0.3s ease;
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .homework-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(15, 23, 42, 0.08);
            border-color: #0057bf;
        }

        .card-top {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
        }

        .type-badge {
            padding: 6px 12px;
            border-radius: 999px;
            font-size: 11px;
            font-weight: 900;
            background: #eff6ff;
            color: #0057bf;
            text-transform: uppercase;
        }

        .homework-title {
            font-size: 18px;
            font-weight: 900;
            color: #0f172a;
            margin: 10px 0 5px;
            line-height: 1.4;
        }

        .homework-meta {
            display: flex;
            flex-direction: column;
            gap: 8px;
            color: #64748b;
            font-size: 13px;
            font-weight: 700;
        }

        .meta-item {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .meta-item i {
            color: #94a3b8;
            width: 16px;
        }

        .deadline-highlight {
            color: #dc2626;
            background: #fee2e2;
            padding: 4px 8px;
            border-radius: 8px;
            font-size: 12px;
        }

        .card-actions {
            margin-top: 0.5rem;
            padding-top: 1rem;
            border-top: 1px solid #f1f5f9;
        }

        .btn-view {
            width: 100%;
            height: 44px;
            background: #0057bf;
            color: #ffffff;
            border-radius: 14px;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            font-size: 14px;
            font-weight: 900;
            transition: all 0.2s ease;
        }

        .btn-view:hover {
            background: #004da8;
            transform: translateY(-2px);
            box-shadow: 0 8px 16px rgba(0, 87, 191, 0.15);
        }

        .empty-state {
            grid-column: 1 / -1;
            padding: 4rem 2rem;
            text-align: center;
            background: #ffffff;
            border: 2px dashed #e2e8f0;
            border-radius: 24px;
            color: #64748b;
        }

        .empty-state i {
            font-size: 48px;
            margin-bottom: 1rem;
            color: #cbd5e1;
        }

        .btn-back-header {
            padding: 10px 20px;
            border-radius: 12px;
            background: #ffffff;
            color: #0f172a;
            border: 1px solid #e2e8f0;
            text-decoration: none;
            font-weight: 800;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .btn-back-header:hover {
            background: #f8fafc;
            border-color: #cbd5e1;
        }
    </style>
</head>
<body>

<jsp:include page="../common/sidebar.jsp" />

<div class="main-content">
    <jsp:include page="../common/header.jsp" />

    <main class="homework-list-page">
        <div class="page-header">
            <div class="page-title">
                <h1>Danh sách bài tập</h1>
                <p>Tổng cộng ${fn:length(homeworks)} bài tập cho buổi học này</p>
            </div>
            <a href="javascript:history.back()" class="btn-back-header">
                <i class="fa-solid fa-arrow-left"></i>
                Quay lại
            </a>
        </div>

        <div class="homework-grid">
            <c:choose>
                <c:when test="${not empty homeworks}">
                    <c:forEach var="h" items="${homeworks}">
                        <div class="homework-card">
                            <div class="card-top">
                                <span class="type-badge">
                                    <c:out value="${empty h.type ? 'Bài tập' : h.type}" />
                                </span>
                            </div>

                            <h3 class="homework-title"><c:out value="${h.title}" /></h3>

                            <div class="homework-meta">
                                <div class="meta-item">
                                    <i class="fa-regular fa-calendar"></i>
                                    Hạn nộp: <span class="deadline-highlight"><c:out value="${h.deadline}" /></span>
                                </div>
                                <div class="meta-item">
                                    <i class="fa-solid fa-book"></i>
                                    Môn: <c:out value="${h.session.classEntity.subject}" />
                                </div>
                                <div class="meta-item">
                                    <i class="fa-solid fa-hashtag"></i>
                                    ID: #<c:out value="${h.homeworkId}" />
                                </div>
                            </div>

                            <div class="card-actions">
                                <a href="${pageContext.request.contextPath}/parent/homework/detail/${h.homeworkId}?studentId=${studentId}"
                                   class="btn-view">
                                    <i class="fa-solid fa-eye"></i>
                                    Xem chi tiết
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <i class="fa-solid fa-folder-open"></i>
                        <h3>Chưa có bài tập nào</h3>
                        <p>Buổi học này hiện chưa được giao bài tập.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>
</div>

</body>
</html>
