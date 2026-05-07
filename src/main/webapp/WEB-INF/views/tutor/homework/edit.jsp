<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="activePage" value="homework" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa bài tập | TCMS Tutor</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0"/>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/tutor-dashboard.css">

    <style>
        .create-homework-page {
            padding: 2rem;
        }

        .homework-hero {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 24px;
            padding: 1.75rem;
            box-shadow: 0 8px 24px rgba(15, 23, 42, 0.05);
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .hero-badges {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            margin-bottom: 12px;
        }

        .badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 11px;
            border-radius: 999px;
            font-size: 11px;
            font-weight: 900;
            white-space: nowrap;
        }

        .badge.blue {
            background: #eff6ff;
            color: #0057bf;
        }

        .badge.gray {
            background: #f1f5f9;
            color: #64748b;
        }

        .homework-hero h1 {
            font-size: 28px;
            line-height: 1.25;
            font-weight: 900;
            color: #0f172a;
            margin-bottom: 10px;
        }

        .hero-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 16px;
            color: #64748b;
            font-size: 14px;
            font-weight: 600;
        }

        .hero-meta span {
            display: inline-flex;
            align-items: center;
            gap: 7px;
        }

        .btn-soft,
        .btn-primary,
        .btn-danger-soft {
            min-height: 42px;
            padding: 0 18px;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 850;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            text-decoration: none;
            cursor: pointer;
            transition: all .2s ease;
        }

        .btn-soft {
            background: #ffffff;
            color: #0f172a;
            border: 1px solid #e2e8f0;
        }

        .btn-soft:hover {
            background: #eff6ff;
            color: #0057bf;
            border-color: #0057bf;
        }

        .btn-primary {
            background: #0057bf;
            color: #ffffff;
            border: 1px solid #0057bf;
            box-shadow: 0 8px 18px rgba(0, 87, 191, 0.18);
        }

        .btn-primary:hover {
            background: #004da8;
        }

        .btn-danger-soft {
            background: #fff1f2;
            color: #dc2626;
            border: 1px solid #fecdd3;
        }

        .btn-danger-soft:hover {
            background: #ffe4e6;
        }

        .create-layout {
            display: grid;
            grid-template-columns: minmax(0, 1.8fr) 360px;
            gap: 1.5rem;
            align-items: start;
        }

        .form-card,
        .side-card,
        .question-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 22px;
            box-shadow: 0 8px 24px rgba(15, 23, 42, 0.05);
        }

        .form-card {
            padding: 1.5rem;
        }

        .form-header {
            margin-bottom: 1.25rem;
        }

        .form-header h2,
        .side-card h3 {
            font-size: 18px;
            font-weight: 900;
            color: #0f172a;
            margin-bottom: 6px;
        }

        .form-header p {
            color: #64748b;
            font-size: 13px;
            line-height: 1.6;
        }

        .error-alert {
            background: #fee2e2;
            color: #dc2626;
            border-radius: 14px;
            padding: 13px 15px;
            font-size: 13px;
            font-weight: 700;
            display: flex;
            gap: 9px;
            margin-bottom: 1rem;
        }

        .homework-form {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 1rem;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .form-group.full {
            grid-column: 1 / -1;
        }

        .form-group label {
            color: #0f172a;
            font-size: 13px;
            font-weight: 850;
        }

        .required {
            color: #dc2626;
        }

        .form-control,
        .form-select {
            height: 46px;
            border: 1px solid #dbe3ef;
            border-radius: 12px;
            padding: 0 14px;
            outline: none;
            color: #0f172a;
            background: #ffffff;
            font-size: 14px;
            transition: all .2s ease;
        }

        .form-textarea {
            min-height: 130px;
            border: 1px solid #dbe3ef;
            border-radius: 12px;
            padding: 12px 14px;
            outline: none;
            resize: vertical;
            color: #0f172a;
            background: #ffffff;
            font-size: 14px;
            line-height: 1.55;
            transition: all .2s ease;
        }

        .form-control:focus,
        .form-select:focus,
        .form-textarea:focus {
            border-color: #0057bf;
            box-shadow: 0 0 0 4px rgba(0, 87, 191, 0.08);
        }

        .hint {
            color: #64748b;
            font-size: 12px;
            line-height: 1.5;
        }

        .question-section {
            margin-top: 1rem;
            padding-top: 1.25rem;
            border-top: 1px solid #f1f5f9;
        }

        .question-section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .question-section-header h3 {
            color: #0f172a;
            font-size: 17px;
            font-weight: 900;
        }

        .question-card {
            padding: 1.25rem;
            margin-bottom: 1rem;
        }

        .question-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .question-title {
            font-size: 15px;
            font-weight: 900;
            color: #0f172a;
        }

        .option-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 1rem;
        }

        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 12px;
            margin-top: 1rem;
            padding-top: 1.25rem;
            border-top: 1px solid #f1f5f9;
        }

        .side-column {
            display: flex;
            flex-direction: column;
            gap: 1rem;
            position: sticky;
            top: 86px;
        }

        .side-card {
            padding: 1.35rem;
        }

        .info-list {
            display: flex;
            flex-direction: column;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            gap: 12px;
            padding: 12px 0;
            border-bottom: 1px solid #f1f5f9;
            font-size: 13px;
        }

        .info-row:last-child {
            border-bottom: 0;
        }

        .info-row span {
            color: #64748b;
            font-weight: 700;
        }

        .info-row strong {
            color: #0f172a;
            font-weight: 900;
            text-align: right;
        }

        .guide-list {
            display: flex;
            flex-direction: column;
            gap: 12px;
            color: #475569;
            font-size: 13px;
            line-height: 1.55;
        }

        .guide-item {
            display: flex;
            gap: 10px;
            align-items: flex-start;
        }

        .guide-item i {
            color: #0057bf;
            margin-top: 3px;
        }

        @media (max-width: 1100px) {
            .create-layout {
                grid-template-columns: 1fr;
            }

            .side-column {
                position: static;
            }
        }

        @media (max-width: 760px) {
            .create-homework-page {
                padding: 1rem;
            }

            .homework-hero,
            .form-actions,
            .question-section-header {
                flex-direction: column;
                align-items: stretch;
            }

            .form-grid,
            .option-grid {
                grid-template-columns: 1fr;
            }

            .btn-soft,
            .btn-primary,
            .btn-danger-soft {
                width: 100%;
            }
        }
    </style>
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

                <h1>Chỉnh sửa bài tập</h1>

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
                      action="${pageContext.request.contextPath}/tutor/homework/${homework.homeworkId}/edit"
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
                            Lưu thay đổi
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
