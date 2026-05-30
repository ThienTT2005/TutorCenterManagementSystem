<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="activePage" value="homework" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết bài nộp | TCMS Tutor</title>
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

                                <div style="height: 1rem;"></div>

                                <%
                                    try {
                                        com.tcms.homework.entity.HomeworkSubmission sub = (com.tcms.homework.entity.HomeworkSubmission) request.getAttribute("submission");
                                        if (sub != null && sub.getAnswers() != null) {
                                            com.fasterxml.jackson.databind.ObjectMapper mapper = new com.fasterxml.jackson.databind.ObjectMapper();
                                            java.util.Map<String, String> answersMap = mapper.readValue(sub.getAnswers(), 
                                                new com.fasterxml.jackson.core.type.TypeReference<java.util.Map<String, String>>() {});
                                            request.setAttribute("answersMap", answersMap);
                                        }
                                    } catch (Exception e) {
                                        // Silent catch for parse errors
                                    }
                                %>

                                <div class="quiz-container">
                                    <c:choose>
                                        <c:when test="${not empty submission.homework.questions}">
                                            <c:forEach var="q" items="${submission.homework.questions}" varStatus="vs">
                                                <c:set var="qKey" value="q_${q.questionId}" />
                                                <c:set var="studentAns" value="${answersMap[qKey]}" />
                                                <c:set var="correctAns" value="${q.correctAnswer}" />
                                                
                                                <div class="quiz-item">
                                                    <div class="quiz-question">
                                                        <span class="q-num">Câu ${vs.count}:</span>
                                                        <span><c:out value="${q.questionText}" /></span>
                                                    </div>
                                                    <div class="quiz-options">
                                                        <c:forEach var="opt" items="${['A', 'B', 'C', 'D']}">
                                                            <c:set var="optText" value="${opt == 'A' ? q.optionA : (opt == 'B' ? q.optionB : (opt == 'C' ? q.optionC : q.optionD))}" />
                                                            <c:set var="isCorrect" value="${opt == correctAns}" />
                                                            <c:set var="isStudent" value="${opt == studentAns}" />
                                                            
                                                            <div class="quiz-option ${isCorrect ? 'correct' : (isStudent ? 'wrong' : '')}">
                                                                <span class="option-label">${opt}</span>
                                                                <span><c:out value="${optText}" /></span>
                                                                
                                                                <c:if test="${isCorrect}">
                                                                    <i class="fa-solid fa-circle-check" style="margin-left: auto;"></i>
                                                                </c:if>
                                                                <c:if test="${isStudent && !isCorrect}">
                                                                    <i class="fa-solid fa-circle-xmark" style="margin-left: auto;"></i>
                                                                </c:if>
                                                            </div>
                                                        </c:forEach>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="empty-text">Bài tập này chưa có câu hỏi trắc nghiệm nào.</div>
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
