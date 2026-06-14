<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="activePage" value="dashboard" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Dashboard Phụ huynh | TCMS</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0" />

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/parent-dashboard.css">
</head>

<body>

<jsp:include page="common/sidebar.jsp" />

<main class="main-content">
    <jsp:include page="common/header.jsp" />

    <div class="dashboard-body">

        <div class="parent-home-page">

            <section class="parent-welcome">
                <div>
                    <c:set var="displayTitle" value="Phụ huynh" />

                    <c:if test="${not empty currentUser and not empty currentUser.username}">
                        <c:set var="displayTitle" value="${currentUser.username}" />
                    </c:if>

                    <h1>Xin chào, <c:out value="${displayTitle}" /></h1>
                    <p>Cập nhật mới nhất về hành trình học tập của các con hôm nay.</p>
                </div>
            </section>

            <section class="parent-overview-grid">

                <div class="parent-overview-card">
                    <div class="overview-icon icon-blue">
                        <span class="material-symbols-rounded">school</span>
                    </div>
                    <p class="overview-label">Tổng số lớp của con</p>
                    <h3>${empty stats.totalClasses ? 0 : stats.totalClasses}</h3>
                </div>

                <div class="parent-overview-card">
                    <div class="overview-icon icon-orange">
                        <span class="material-symbols-rounded">event_available</span>
                    </div>
                    <p class="overview-label">Buổi học hôm nay</p>
                    <h3>${empty stats.todaySessions ? 0 : stats.todaySessions}</h3>
                </div>

                <div class="parent-overview-card">
                    <div class="overview-icon icon-green">
                        <span class="material-symbols-rounded">rate_review</span>
                    </div>
                    <p class="overview-label">Feedback mới</p>
                    <h3>${empty stats.latestFeedback ? 0 : stats.latestFeedback}</h3>
                </div>

                <div class="parent-overview-card">
                    <div class="overview-icon icon-purple">
                        <span class="material-symbols-rounded">payments</span>
                    </div>
                    <p class="overview-label">Thanh toán đang chờ</p>
                    <h3>${empty stats.pendingPayments ? 0 : stats.pendingPayments}</h3>
                </div>

                <div class="parent-overview-card">
                    <div class="overview-icon icon-red">
                        <span class="material-symbols-rounded">event_busy</span>
                    </div>
                    <p class="overview-label">Yêu cầu xin nghỉ</p>
                    <h3>${empty stats.absenceRequests ? 0 : stats.absenceRequests}</h3>
                </div>

            </section>

            <section class="parent-main-grid">

                <div class="parent-left-column">

                    <section class="parent-section">
                        <div class="parent-section-header">
                            <h2>
                                <span class="material-symbols-rounded">groups</span>
                                Danh sách con
                            </h2>

                            <a href="${pageContext.request.contextPath}/parent/classes">
                                Xem tất cả
                            </a>
                        </div>

                        <div class="children-grid">
                            <c:choose>
                                <c:when test="${not empty stats.children}">
                                    <c:forEach var="child" items="${stats.children}">
                                        <div class="child-card">
                                            <div class="child-avatar">
                                                <div class="avatar-img-wrapper">
                                                    <c:choose>
                                                        <c:when test="${not empty child.avatar}">
                                                            <img src="${pageContext.request.contextPath}${child.avatar}" alt="${child.fullName}">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="material-symbols-rounded">face</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <span class="online-dot"></span>
                                            </div>


                                            <div class="child-info">
                                                <h3><c:out value="${child.fullName}" /></h3>
                                                <p>Lớp: <c:out value="${empty child.grade ? 'Chưa cập nhật' : child.grade}" /></p>

                                                <div class="child-tags">
                                                    <span>Học sinh</span>
                                                    <span>TCMS</span>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="empty-state">
                                        <p>Chưa có thông tin con.</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                    </section>

                    <section class="parent-section">
                        <div class="section-header">
                            <h2>Lớp học hôm nay</h2>
                            <a href="${pageContext.request.contextPath}/parent/classes">Xem chi tiết</a>
                        </div>

                        <div class="content-card">
                            <c:choose>
                                <c:when test="${not empty todaySessions}">
                                    <c:forEach var="s" items="${todaySessions}">
                                        <div class="session-row">
                                            <div class="session-icon">
                                                <span class="material-symbols-rounded">schedule</span>
                                            </div>

                                            <div class="session-info">
                                                <h3>
                                                    <c:out value="${empty s.classEntity.className ? 'Lớp học' : s.classEntity.className}" />
                                                </h3>
                                                <p>
                                                    Học sinh:
                                                    <c:set var="childNames" value="" />
                                                    <c:forEach var="e" items="${stats.enrollments}">
                                                        <c:if test="${e.classEntity.classId == s.classEntity.classId}">
                                                            <c:set var="childNames" value="${childNames}${empty childNames ? '' : ', '}${e.student.fullName}" />
                                                        </c:if>
                                                    </c:forEach>
                                                    <c:choose>
                                                        <c:when test="${not empty childNames}">
                                                            <strong><c:out value="${childNames}" /></strong>
                                                        </c:when>
                                                        <c:otherwise>Con của bạn</c:otherwise>
                                                    </c:choose>
                                                </p>


                                            </div>

                                            <div class="session-time">
                                                <strong><c:out value="${s.startTime}" /></strong>
                                                <span>Kết thúc: <c:out value="${s.endTime}" /></span>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>

                                <c:otherwise>
                                    <div class="empty-card">
                                        <span class="material-symbols-rounded">event_available</span>
                                        <p>Hôm nay các con không có buổi học nào.</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </section>


                </div>

                <aside class="parent-right-column">

                    <section class="parent-section side-section">
                        <div class="parent-section-header">
                            <h2>
                                <span class="material-symbols-rounded">chat_bubble</span>
                                Feedback gần nhất
                            </h2>
                        </div>

                        <div class="mini-card feedback-mini-card">
                            <div class="mini-card-header">
                                <div class="mini-icon">
                                    <span class="material-symbols-rounded">face</span>
                                </div>

                                <div>
                                    <h3>Feedback mới</h3>
                                    <p>${empty stats.latestFeedback ? 0 : stats.latestFeedback} phản hồi gần đây</p>
                                </div>
                            </div>

                            <div class="quote-box">
                                “Theo dõi các nhận xét mới nhất của gia sư về quá trình học tập của con.”
                            </div>

                            <div class="mini-actions">
                                <a href="${pageContext.request.contextPath}/parent/classes">Chi tiết</a>
                            </div>
                        </div>
                    </section>

                    <section class="parent-section side-section">
                        <div class="parent-section-header">
                            <h2>
                                <span class="material-symbols-rounded">payments</span>
                                Thanh toán
                            </h2>
                        </div>

                        <div class="payment-summary-card">
                            <div class="payment-title-row">
                                <div>
                                    <h3>Thanh toán đang chờ</h3>
                                    <p>${empty stats.pendingPayments ? 0 : stats.pendingPayments} yêu cầu cần xử lý</p>
                                </div>

                                <span class="payment-status">CHƯA THANH TOÁN</span>
                            </div>

                            <div class="payment-amount-row">
                                <span>Số yêu cầu:</span>
                                <strong>${empty stats.pendingPayments ? 0 : stats.pendingPayments}</strong>
                            </div>

                            <a href="${pageContext.request.contextPath}/payment/parent"
                               class="pay-now-btn">
                                <span class="material-symbols-rounded">credit_card</span>
                                Thanh toán ngay
                            </a>
                        </div>
                    </section>

                    <section class="parent-section side-section">
                        <div class="parent-section-header">
                            <h2>
                                <span class="material-symbols-rounded">do_not_disturb_on</span>
                                Yêu cầu xin nghỉ
                            </h2>
                        </div>

                        <div class="absence-mini-card">
                            <div class="absence-date">
                                <span>YÊU</span>
                                <strong>CẦU</strong>
                            </div>

                            <div class="absence-info">
                                <h3>Đơn xin nghỉ</h3>
                                <p>${empty stats.absenceRequests ? 0 : stats.absenceRequests} yêu cầu đã gửi</p>
                            </div>

                            <span class="absence-badge">ĐÃ GỬI</span>
                        </div>


                    </section>

                </aside>

            </section>

        </div>

    </div>
</main>

</body>
</html>
