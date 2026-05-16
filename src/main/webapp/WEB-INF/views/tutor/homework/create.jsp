<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="activePage" value="homework" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tạo bài tập | TCMS Tutor</title>
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

    <main class="create-homework-page">

        <!-- HEADER -->
        <section class="homework-hero">
            <div>
                <div class="hero-badges">
                    <span class="badge blue">
                        <i class="fa-solid fa-book-open"></i>
                        <c:choose>
                            <c:when test="${not empty sessionItem and not empty sessionItem.classEntity}">
                                <c:out value="${sessionItem.classEntity.className}" />
                            </c:when>
                            <c:otherwise>Buổi học</c:otherwise>
                        </c:choose>
                    </span>

                    <span class="badge gray">
                        <i class="fa-solid fa-circle-info"></i>
                        <c:out value="${empty sessionItem.status ? 'Chưa cập nhật' : sessionItem.status}" />
                    </span>
                </div>

                <h1>Tạo bài tập mới</h1>

                <div class="hero-meta">
                    <span>
                        <i class="fa-solid fa-hashtag"></i>
                        Buổi học #<c:out value="${request.sessionId}" />
                    </span>

                    <c:if test="${not empty sessionItem}">
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
                    </c:if>
                </div>
            </div>

            <a href="${pageContext.request.contextPath}/tutor/homework/session/${request.sessionId}"
               class="btn-soft">
                <i class="fa-solid fa-arrow-left"></i>
                Quay lại bài tập
            </a>
        </section>

        <section class="create-layout">

            <!-- LEFT: FORM -->
            <div class="form-card">
                <div class="form-header">
                    <h2>Thông tin bài tập</h2>
                    <p>
                        Chọn loại bài tập. Nếu là trắc nghiệm, hãy thêm danh sách câu hỏi và đáp án đúng.
                    </p>
                </div>

                <c:if test="${not empty error}">
                    <div class="error-alert">
                        <i class="fa-solid fa-circle-exclamation"></i>
                        <span><c:out value="${error}" /></span>
                    </div>
                </c:if>

                <form class="homework-form"
                      action="${pageContext.request.contextPath}/tutor/homework/create"
                      method="post"
                      id="homeworkForm">

                    <input type="hidden" name="sessionId" value="${request.sessionId}" />

                    <div class="form-grid">
                        <div class="form-group full">
                            <label for="title">
                                Tiêu đề bài tập <span class="required">*</span>
                            </label>
                            <input type="text"
                                   id="title"
                                   name="title"
                                   class="form-control"
                                   value="${request.title}"
                                   placeholder="Ví dụ: Bài tập về nhà buổi 1"
                                   required>
                        </div>

                        <div class="form-group">
                            <label for="type">
                                Loại bài tập <span class="required">*</span>
                            </label>

                            <select id="type" name="type" class="form-select" required>
                                <option value="">-- Chọn loại bài tập --</option>
                                <option value="MULTIPLE_CHOICE"
                                ${request.type == 'MULTIPLE_CHOICE' ? 'selected' : ''}>
                                    Trắc nghiệm
                                </option>
                                <option value="ESSAY"
                                ${request.type == 'ESSAY' ? 'selected' : ''}>
                                    Tự luận
                                </option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="deadline">
                                Hạn chót <span class="required">*</span>
                            </label>

                            <input type="date"
                                   id="deadline"
                                   name="deadline"
                                   class="form-control"
                                   value="${request.deadline}"
                                   required>
                        </div>

                        <div class="form-group full">
                            <label for="content">
                                Nội dung / Yêu cầu bài tập <span class="required">*</span>
                            </label>

                            <textarea id="content"
                                      name="content"
                                      class="form-textarea"
                                      placeholder="Nhập yêu cầu bài tập, hướng dẫn làm bài, nội dung đề bài tổng quát..."
                                      required>${request.content}</textarea>
                        </div>

                        <div class="form-group full">
                            <label for="attachmentUrl">
                                Link tài liệu / Tệp đính kèm
                            </label>

                            <input type="text"
                                   id="attachmentUrl"
                                   name="attachmentUrl"
                                   class="form-control"
                                   value="${request.attachmentUrl}"
                                   placeholder="Ví dụ: https://drive.google.com/...">

                            <div class="hint">
                                Chỉ nhập link tài liệu. Không dùng upload file nếu backend chưa xử lý MultipartFile.
                            </div>
                        </div>
                    </div>

                    <!-- MULTIPLE CHOICE QUESTIONS -->
                    <div class="question-section" id="questionSection" style="display:none;">
                        <div class="question-section-header">
                            <div>
                                <h3>Câu hỏi trắc nghiệm</h3>
                                <p class="hint">
                                    Mỗi câu hỏi cần đủ 4 lựa chọn và một đáp án đúng.
                                </p>
                            </div>

                            <button type="button" class="btn-primary" onclick="addQuestion()">
                                <i class="fa-solid fa-plus"></i>
                                Thêm câu hỏi
                            </button>
                        </div>

                        <div id="questionList"></div>
                    </div>

                    <div class="form-actions">
                        <a href="${pageContext.request.contextPath}/tutor/homework/session/${request.sessionId}"
                           class="btn-soft">
                            <i class="fa-solid fa-arrow-left"></i>
                            Quay lại
                        </a>

                        <button type="submit" class="btn-primary">
                            <i class="fa-solid fa-floppy-disk"></i>
                            Tạo bài tập
                        </button>
                    </div>
                </form>
            </div>

            <!-- RIGHT: INFO -->
            <aside class="side-column">
                <div class="side-card">
                    <h3>Thông tin buổi học</h3>

                    <div class="info-list">
                        <div class="info-row">
                            <span>Mã buổi học</span>
                            <strong>#<c:out value="${request.sessionId}" /></strong>
                        </div>

                        <c:if test="${not empty sessionItem}">
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
                        </c:if>
                    </div>
                </div>

                <div class="side-card">
                    <h3>Hướng dẫn</h3>

                    <div class="guide-list">
                        <div class="guide-item">
                            <i class="fa-solid fa-circle-check"></i>
                            <div>
                                Với bài tự luận, chỉ cần nhập nội dung và link tài liệu nếu có.
                            </div>
                        </div>

                        <div class="guide-item">
                            <i class="fa-solid fa-circle-check"></i>
                            <div>
                                Với bài trắc nghiệm, cần thêm ít nhất một câu hỏi.
                            </div>
                        </div>

                        <div class="guide-item">
                            <i class="fa-solid fa-circle-check"></i>
                            <div>
                                Mỗi câu hỏi trắc nghiệm cần đủ A, B, C, D và đáp án đúng.
                            </div>
                        </div>

                        <div class="guide-item">
                            <i class="fa-solid fa-code"></i>
                            <div>
                                Tên input câu hỏi phải là dạng
                                <strong>questions[0].questionText</strong>,
                                không dùng <strong>questions[]</strong>.
                            </div>
                        </div>
                    </div>
                </div>
            </aside>

        </section>

    </main>
</div>

<script>
    let questionIndex = 0;

    const typeSelect = document.getElementById('type');
    const questionSection = document.getElementById('questionSection');
    const questionList = document.getElementById('questionList');
    const homeworkForm = document.getElementById('homeworkForm');

    function toggleQuestionSection() {
        if (typeSelect.value === 'MULTIPLE_CHOICE') {
            questionSection.style.display = 'block';

            if (questionList.children.length === 0) {
                addQuestion();
            }
        } else {
            questionSection.style.display = 'none';
        }
    }

    function addQuestion() {
        const index = questionIndex++;

        const card = document.createElement('div');
        card.className = 'question-card';

        card.innerHTML =
            '<div class="question-top">' +
            '<div class="question-title">Câu hỏi ' + (index + 1) + '</div>' +
            '<button type="button" class="btn-danger-soft" onclick="removeQuestion(this)">' +
            '<i class="fa-solid fa-trash"></i>' +
            'Xóa' +
            '</button>' +
            '</div>' +

            '<div class="form-group" style="margin-bottom: 1rem;">' +
            '<label>Nội dung câu hỏi <span class="required">*</span></label>' +
            '<textarea data-field="questionText" ' +
            'name="questions[' + index + '].questionText" ' +
            'class="form-textarea" ' +
            'placeholder="Nhập nội dung câu hỏi..."></textarea>' +
            '</div>' +

            '<div class="option-grid">' +
            '<div class="form-group">' +
            '<label>Lựa chọn A <span class="required">*</span></label>' +
            '<input data-field="optionA" ' +
            'type="text" ' +
            'name="questions[' + index + '].optionA" ' +
            'class="form-control">' +
            '</div>' +

            '<div class="form-group">' +
            '<label>Lựa chọn B <span class="required">*</span></label>' +
            '<input data-field="optionB" ' +
            'type="text" ' +
            'name="questions[' + index + '].optionB" ' +
            'class="form-control">' +
            '</div>' +

            '<div class="form-group">' +
            '<label>Lựa chọn C <span class="required">*</span></label>' +
            '<input data-field="optionC" ' +
            'type="text" ' +
            'name="questions[' + index + '].optionC" ' +
            'class="form-control">' +
            '</div>' +

            '<div class="form-group">' +
            '<label>Lựa chọn D <span class="required">*</span></label>' +
            '<input data-field="optionD" ' +
            'type="text" ' +
            'name="questions[' + index + '].optionD" ' +
            'class="form-control">' +
            '</div>' +

            '<div class="form-group">' +
            '<label>Đáp án đúng <span class="required">*</span></label>' +
            '<select data-field="correctAnswer" ' +
            'name="questions[' + index + '].correctAnswer" ' +
            'class="form-select">' +
            '<option value="">-- Chọn đáp án --</option>' +
            '<option value="A">A</option>' +
            '<option value="B">B</option>' +
            '<option value="C">C</option>' +
            '<option value="D">D</option>' +
            '</select>' +
            '</div>' +
            '</div>';

        questionList.appendChild(card);
        reindexQuestions();
    }

    function removeQuestion(button) {
        const card = button.closest('.question-card');

        if (card) {
            card.remove();
        }

        reindexQuestions();
    }

    function reindexQuestions() {
        const cards = document.querySelectorAll('.question-card');

        cards.forEach(function (card, index) {
            const title = card.querySelector('.question-title');

            if (title) {
                title.textContent = 'Câu hỏi ' + (index + 1);
            }

            const questionText = card.querySelector('[data-field="questionText"]');
            const optionA = card.querySelector('[data-field="optionA"]');
            const optionB = card.querySelector('[data-field="optionB"]');
            const optionC = card.querySelector('[data-field="optionC"]');
            const optionD = card.querySelector('[data-field="optionD"]');
            const correctAnswer = card.querySelector('[data-field="correctAnswer"]');

            if (questionText) questionText.name = 'questions[' + index + '].questionText';
            if (optionA) optionA.name = 'questions[' + index + '].optionA';
            if (optionB) optionB.name = 'questions[' + index + '].optionB';
            if (optionC) optionC.name = 'questions[' + index + '].optionC';
            if (optionD) optionD.name = 'questions[' + index + '].optionD';
            if (correctAnswer) correctAnswer.name = 'questions[' + index + '].correctAnswer';
        });

        questionIndex = cards.length;
    }

    typeSelect.addEventListener('change', function () {
        toggleQuestionSection();
    });

    homeworkForm.addEventListener('submit', function (event) {
        const title = document.getElementById('title').value.trim();
        const type = document.getElementById('type').value;
        const deadline = document.getElementById('deadline').value;
        const content = document.getElementById('content').value.trim();

        if (!title || !type || !deadline || !content) {
            event.preventDefault();
            alert('Vui lòng nhập đầy đủ tiêu đề, loại bài tập, deadline và nội dung.');
            return;
        }

        if (type === 'ESSAY') {
            questionList.innerHTML = '';
            return;
        }

        if (type === 'MULTIPLE_CHOICE') {
            reindexQuestions();

            const cards = document.querySelectorAll('.question-card');

            if (cards.length === 0) {
                event.preventDefault();
                alert('Bài trắc nghiệm cần ít nhất một câu hỏi.');
                return;
            }

            for (const card of cards) {
                const questionText = card.querySelector('[data-field="questionText"]').value.trim();
                const optionA = card.querySelector('[data-field="optionA"]').value.trim();
                const optionB = card.querySelector('[data-field="optionB"]').value.trim();
                const optionC = card.querySelector('[data-field="optionC"]').value.trim();
                const optionD = card.querySelector('[data-field="optionD"]').value.trim();
                const correctAnswer = card.querySelector('[data-field="correctAnswer"]').value;

                if (!questionText || !optionA || !optionB || !optionC || !optionD || !correctAnswer) {
                    event.preventDefault();
                    alert('Vui lòng nhập đầy đủ nội dung, 4 lựa chọn và đáp án đúng cho tất cả câu hỏi.');
                    return;
                }
            }
        }
    });

    toggleQuestionSection();
</script>

</body>
</html>
