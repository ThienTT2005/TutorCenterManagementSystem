<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết feedback</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student-feedback-detail.css">

    <!-- Font Awesome nếu project bạn đã dùng sẵn -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0"/>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/student-dashboard.css">
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            background: #f4f7fb;
            font-family: Arial, Helvetica, sans-serif;
            color: #1f2937;
        }

        .feedback-detail-page {
            position: relative;
            min-height: 100vh;
            padding: 18px 28px 40px;
        }

        /* Back */
        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            color: #64748b;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            margin-bottom: 22px;
        }

        .back-link:hover {
            color: #2563eb;
        }

        /* Status */
        .page-status {
            position: absolute;
            top: 12px;
            right: 28px;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 78px;
            height: 26px;
            padding: 0 14px;
            border-radius: 999px;
            font-size: 11px;
            font-weight: 800;
            letter-spacing: 0.6px;
        }

        .status-badge.approved {
            background: #dcfce7;
            color: #15803d;
            border: 1px solid #86efac;
        }

        .status-badge.pending {
            background: #fef3c7;
            color: #92400e;
            border: 1px solid #fde68a;
        }

        .status-badge.rejected {
            background: #fee2e2;
            color: #b91c1c;
            border: 1px solid #fecaca;
        }

        /* Layout */
        .content-layout {
            display: grid;
            grid-template-columns: minmax(0, 760px) 368px;
            gap: 32px;
            align-items: start;
        }

        /* Main Card */
        .main-card {
            min-height: 560px;
            background: #ffffff;
            border: 1px solid #cbd5e1;
            border-radius: 16px;
            padding: 40px;
        }

        .lesson-header {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 24px;
            margin-bottom: 34px;
        }

        .section-label {
            margin: 0 0 8px;
            color: #1d4ed8;
            font-size: 11px;
            font-weight: 800;
            letter-spacing: 1.1px;
            text-transform: uppercase;
        }

        .lesson-header h1 {
            margin: 0;
            font-size: 26px;
            line-height: 1.2;
            color: #111827;
            font-weight: 800;
        }

        .lesson-icon {
            width: 42px;
            height: 42px;
            border-radius: 14px;
            background: #dbeafe;
            color: #2563eb;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
        }

        /* Info grid */
        .lesson-info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 24px 46px;
            max-width: 560px;
        }

        .info-item {
            display: flex;
            align-items: center;
            gap: 13px;
        }

        .info-icon {
            width: 34px;
            height: 34px;
            border-radius: 10px;
            background: #e8eef7;
            color: #3b5f8f;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 15px;
            flex-shrink: 0;
        }

        .info-label {
            display: block;
            margin-bottom: 3px;
            color: #94a3b8;
            font-size: 10px;
            font-weight: 800;
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }

        .info-item strong {
            display: block;
            color: #111827;
            font-size: 13px;
            line-height: 1.3;
            font-weight: 700;
        }

        .divider {
            width: 100%;
            height: 1px;
            background: #e5e7eb;
            margin: 34px 0 26px;
        }

        /* Feedback */
        .feedback-section h2 {
            margin: 0 0 16px;
            display: flex;
            align-items: center;
            gap: 8px;
            color: #111827;
            font-size: 14px;
            font-weight: 800;
            text-transform: uppercase;
        }

        .feedback-section h2 i {
            color: #374151;
            font-size: 13px;
        }

        .feedback-box {
            max-width: 680px;
            background: #f1f3f6;
            border-radius: 14px;
            padding: 24px 28px;
        }

        .rating-row {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 16px;
        }

        .stars {
            display: inline-flex;
            align-items: center;
            gap: 2px;
            color: #f59e0b;
            font-size: 18px;
        }

        .rating-text {
            color: #111827;
            font-size: 13px;
            font-weight: 800;
        }

        .feedback-comment {
            margin: 0;
            color: #1f2937;
            font-size: 15px;
            line-height: 1.75;
            font-style: italic;
        }

        /* Reject box */
        .reject-reason {
            margin-top: 18px;
            padding: 16px 18px;
            border-radius: 12px;
            background: #fef2f2;
            border: 1px solid #fecaca;
            color: #991b1b;
        }

        .reject-reason p {
            margin: 8px 0 0;
            line-height: 1.6;
        }

        /* Tutor card */
        .tutor-card {
            background: #ffffff;
            border: 1px solid #cbd5e1;
            border-radius: 16px;
            padding: 30px 32px;
        }

        .tutor-card .section-label {
            color: #1e3a8a;
            margin-bottom: 18px;
        }

        .tutor-profile {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .tutor-avatar {
            width: 58px;
            height: 58px;
            border-radius: 50%;
            overflow: hidden;
            border: 1px solid #cbd5e1;
            flex-shrink: 0;
        }

        .tutor-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .tutor-info h3 {
            margin: 0 0 4px;
            font-size: 15px;
            color: #111827;
            font-weight: 800;
        }

        .tutor-info p {
            margin: 0;
            color: #64748b;
            font-size: 12px;
            line-height: 1.4;
        }

        /* Empty */
        .empty-card {
            max-width: 760px;
            background: #ffffff;
            border: 1px solid #fed7aa;
            color: #9a3412;
            border-radius: 14px;
            padding: 24px;
            font-size: 15px;
        }

        /* Responsive */
        @media (max-width: 1024px) {
            .content-layout {
                grid-template-columns: 1fr;
            }

            .tutor-card {
                max-width: 760px;
            }
        }

        @media (max-width: 768px) {
            .feedback-detail-page {
                padding: 18px;
            }

            .page-status {
                position: static;
                margin-bottom: 16px;
            }

            .main-card {
                padding: 26px 22px;
            }

            .lesson-info-grid {
                grid-template-columns: 1fr;
                gap: 18px;
            }

            .lesson-header h1 {
                font-size: 22px;
            }

            .feedback-box {
                padding: 20px;
            }
        }
    </style>
</head>

<body>

<jsp:include page="../common/sidebar.jsp" />

<div class="main-content">
    <jsp:include page="../common/header.jsp" />
<div class="feedback-detail-page">

    <!-- Back -->
    <a href="javascript:void(0)"
       onclick="history.back();"
       class="back-link">
        <i class="fa-solid fa-arrow-left"></i>
        Back
    </a>

    <!-- Status badge -->
    <c:if test="${not empty feedback}">
        <div class="page-status">
            <c:choose>
                <c:when test="${feedback.status == 'APPROVED'}">
                    <span class="status-badge approved">ĐÃ DUYỆT</span>
                </c:when>
                <c:when test="${feedback.status == 'PENDING'}">
                    <span class="status-badge pending">CHỜ DUYỆT</span>
                </c:when>
                <c:when test="${feedback.status == 'REJECTED'}">
                    <span class="status-badge rejected">BỊ TỪ CHỐI</span>
                </c:when>
                <c:otherwise>
                    <span class="status-badge">${feedback.status}</span>
                </c:otherwise>
            </c:choose>
        </div>
    </c:if>

    <c:choose>
        <c:when test="${empty feedback}">
            <div class="empty-card">
                Không tìm thấy feedback cho buổi học này.
            </div>
        </c:when>

        <c:otherwise>

            <div class="content-layout">

                <!-- LEFT MAIN CARD -->
                <div class="main-card">

                    <!-- Header lesson -->
                    <div class="lesson-header">
                        <div>
                            <p class="section-label">TOÁN HỌC</p>

                            <h1>
                                <c:choose>
                                    <c:when test="${not empty feedback.session.topic}">
                                        ${feedback.session.topic}
                                    </c:when>
                                    <c:otherwise>
                                        Tên lớp học
                                    </c:otherwise>
                                </c:choose>
                            </h1>
                        </div>

                        <div class="lesson-icon">
                            <i class="fa-solid fa-sigma"></i>
                        </div>
                    </div>

                    <!-- Lesson meta -->
                    <div class="lesson-info-grid">

                        <div class="info-item">
                            <div class="info-icon">
                                <i class="fa-regular fa-calendar"></i>
                            </div>

                            <div>
                                <span class="info-label">DATE</span>
                                <strong>${feedback.session.sessionDate}</strong>
                            </div>
                        </div>

                        <div class="info-item">
                            <div class="info-icon">
                                <i class="fa-regular fa-folder"></i>
                            </div>

                            <div>
                                <span class="info-label">CLASS</span>
                                <strong>${feedback.session.classEntity.className}</strong>
                            </div>
                        </div>

                        <div class="info-item">
                            <div class="info-icon">
                                <i class="fa-solid fa-graduation-cap"></i>
                            </div>

                            <div>
                                <span class="info-label">SUBJECT</span>
                                <strong>${feedback.session.classEntity.subject}</strong>
                            </div>
                        </div>

                        <div class="info-item">
                            <div class="info-icon">
                                <i class="fa-regular fa-clock"></i>
                            </div>

                            <div>
                                <span class="info-label">DURATION</span>
                                <strong>
                                        ${feedback.session.startTime} - ${feedback.session.endTime}
                                </strong>
                            </div>
                        </div>

                    </div>

                    <div class="divider"></div>

                    <!-- Tutor feedback -->
                    <div class="feedback-section">

                        <h2>
                            <i class="fa-regular fa-comment-dots"></i>
                            TUTOR FEEDBACK
                        </h2>

                        <div class="feedback-box">

                            <div class="rating-row">
                                <span class="stars">
                                    <i class="fa-solid fa-star"></i>
                                    <i class="fa-solid fa-star"></i>
                                    <i class="fa-solid fa-star"></i>
                                    <i class="fa-solid fa-star"></i>
                                    <i class="fa-solid fa-star"></i>
                                </span>

                                <strong class="rating-text">
                                    <c:choose>
                                        <c:when test="${not empty feedback.rating}">
                                            ${feedback.rating}
                                        </c:when>
                                        <c:otherwise>
                                            Chưa có đánh giá
                                        </c:otherwise>
                                    </c:choose>
                                </strong>
                            </div>

                            <p class="feedback-comment">
                                “${feedback.comment}”
                            </p>

                        </div>

                        <c:if test="${feedback.status == 'REJECTED'}">
                            <div class="reject-reason">
                                <strong>Lý do từ chối:</strong>
                                <p>${feedback.rejectedReason}</p>
                            </div>
                        </c:if>

                    </div>

                </div>

                <!-- RIGHT SIDEBAR CARD -->
                <aside class="tutor-card">

                    <p class="section-label">ASSIGNED TUTOR</p>

                    <div class="tutor-profile">

                        <div class="tutor-avatar">
                            <c:choose>
                                <c:when test="${not empty feedback.session.classEntity.tutor.avatar}">
                                    <img src="${pageContext.request.contextPath}/uploads/${feedback.session.classEntity.tutor.avatar}"
                                         alt="Tutor avatar">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/images/default-avatar.png"
                                         alt="Default avatar">
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="tutor-info">
                            <h3>${feedback.session.classEntity.tutor.fullName}</h3>

                            <p>
                                <c:choose>
                                    <c:when test="${not empty feedback.session.classEntity.subject}">
                                        ${feedback.session.classEntity.subject} Tutor
                                    </c:when>
                                    <c:otherwise>
                                        Tutor
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>

                    </div>

                </aside>

            </div>

        </c:otherwise>
    </c:choose>

</div>
</div>
</body>
</html>