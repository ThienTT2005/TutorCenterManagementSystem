<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="activePage" value="classes" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Lớp của tôi | TCMS Tutor</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/tutor-dashboard.css">
    
</head>

<body>
<jsp:include page="../common/sidebar.jsp" />

<div class="main-content">
    <jsp:include page="../common/header.jsp" />

    <main class="class-page">
        <div class="class-page-header">
            <div>
                <h1>Lớp của tôi</h1>
                <p>
                    Quản lý các lớp học bạn đang phụ trách
                    <strong id="totalClassText">(${fn:length(classes)} lớp)</strong>
                </p>
            </div>
        </div>

        <section class="class-filter-card">
            <div class="filter-search">
                <i class="fa-solid fa-magnifying-glass"></i>
                <input id="keywordFilter" type="text" placeholder="Tìm theo tên lớp / môn học">
            </div>

            <select id="subjectFilter">
                <option value="">Môn học (Tất cả)</option>
                <option value="toán">Toán</option>
                <option value="văn">Văn</option>
                <option value="anh">Anh văn</option>
                <option value="lý">Vật lý</option>
                <option value="hóa">Hóa học</option>
            </select>

            <select id="statusFilter">
                <option value="">Trạng thái</option>
                <option value="active">Đang hoạt động</option>
                <option value="inactive">Đã kết thúc</option>
            </select>

            <select id="gradeFilter">
                <option value="">Khối lớp</option>
                <option value="6">Khối 6</option>
                <option value="7">Khối 7</option>
                <option value="8">Khối 8</option>
                <option value="9">Khối 9</option>
                <option value="10">Khối 10</option>
                <option value="11">Khối 11</option>
                <option value="12">Khối 12</option>
            </select>
        </section>

        <section class="class-grid" id="classGrid">
            <c:choose>
                <c:when test="${not empty classes}">
                    <c:forEach var="c" items="${classes}">
                        <c:set var="subjectLower" value="${fn:toLowerCase(empty c.subject ? '' : c.subject)}" />
                        <c:set var="gradeValue" value="${empty c.grade ? '' : c.grade}" />
                        <c:set var="isActive" value="${c.status == true}" />

                        <article class="class-card"
                                 data-name="${fn:toLowerCase(c.className)}"
                                 data-subject="${subjectLower}"
                                 data-grade="${gradeValue}"
                                 data-status="${isActive ? 'active' : 'inactive'}">

                            <div class="class-card-accent ${isActive ? 'accent-blue' : 'accent-gray'}"></div>

                            <div class="class-card-top">
                                <div>
                                    <div class="class-tags">
                                        <span class="subject-tag">${empty c.subject ? 'Môn học' : c.subject}</span>
                                        <span class="grade-tag">Khối ${empty c.grade ? '-' : c.grade}</span>
                                    </div>

                                    <h2>${c.className}</h2>
                                </div>

                                <c:choose>
                                    <c:when test="${isActive}">
                                        <span class="status-badge active">Đang hoạt động</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-badge inactive">Đã kết thúc</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="class-meta-grid">

                                <div class="class-meta-item">
                                    <span class="material-symbols-rounded">payments</span>
                                    <div>
                                        <small>Học phí</small>
                                        <strong>
                                            <fmt:formatNumber value="${empty c.tuitionFeePerSession ? 0 : c.tuitionFeePerSession}" pattern="#,###"/>
                                            đ/buổi
                                        </strong>
                                    </div>
                                </div>
                            </div>



                            <div class="class-card-footer">

                                <a class="class-detail-link"
                                   href="${pageContext.request.contextPath}/tutor/classes/${c.classId}">
                                    Xem chi tiết
                                    <span class="material-symbols-rounded">chevron_right</span>
                                </a>
                            </div>
                        </article>
                    </c:forEach>
                </c:when>

                <c:otherwise>
                    <div class="empty-card">
                        Chưa có lớp học nào được phân công.
                    </div>
                </c:otherwise>
            </c:choose>
        </section>

        <section class="pagination-bar">
            <div class="pagination-info" id="paginationInfo"></div>
            <div class="pagination-controls" id="paginationControls"></div>
        </section>
    </main>
</div>

<script>
    const PAGE_SIZE = 10;

    const keywordInput = document.getElementById('keywordFilter');
    const subjectFilter = document.getElementById('subjectFilter');
    const statusFilter = document.getElementById('statusFilter');
    const gradeFilter = document.getElementById('gradeFilter');

    const cards = Array.from(document.querySelectorAll('.class-card'));
    const paginationInfo = document.getElementById('paginationInfo');
    const paginationControls = document.getElementById('paginationControls');
    const totalClassText = document.getElementById('totalClassText');

    let currentPage = 1;
    let filteredCards = [...cards];

    function normalize(value) {
        return (value || '').toString().trim().toLowerCase();
    }

    function applyFilters() {
        const keyword = normalize(keywordInput.value);
        const subject = normalize(subjectFilter.value);
        const status = normalize(statusFilter.value);
        const grade = normalize(gradeFilter.value);
        const errorAlert = document.getElementById('errorAlert');

        filteredCards = cards.filter(card => {
            const cardName = normalize(card.dataset.name);
            const cardSubject = normalize(card.dataset.subject);
            const cardStatus = normalize(card.dataset.status);
            const cardGrade = normalize(card.dataset.grade);

            const matchKeyword =
                keyword === '' ||
                cardName.includes(keyword) ||
                cardSubject.includes(keyword);

            const matchSubject =
                subject === '' ||
                cardSubject.includes(subject);

            const matchStatus =
                status === '' ||
                cardStatus === status;

            const matchGrade =
                grade === '' ||
                cardGrade === grade;

            return matchKeyword && matchSubject && matchStatus && matchGrade;
        });

        currentPage = 1;
        renderPage();
    }

    function renderPage() {
        const total = filteredCards.length;
        const totalPages = Math.max(1, Math.ceil(total / PAGE_SIZE));

        if (currentPage > totalPages) {
            currentPage = totalPages;
        }

        cards.forEach(card => card.style.display = 'none');

        const start = (currentPage - 1) * PAGE_SIZE;
        const end = start + PAGE_SIZE;

        filteredCards.slice(start, end).forEach(card => {
            card.style.display = 'block';
        });

        totalClassText.textContent = '(' + total + ' lớp)';
        paginationInfo.textContent = total === 0
            ? 'Không tìm thấy lớp phù hợp'
            : 'Hiển thị ' + (start + 1) + ' - ' + Math.min(end, total) + ' trong ' + total + ' lớp';

        renderPagination(totalPages);
    }

    function renderPagination(totalPages) {
        paginationControls.innerHTML = '';

        const prevBtn = document.createElement('button');
        prevBtn.className = 'page-btn';
        prevBtn.textContent = '‹';
        prevBtn.disabled = currentPage === 1;
        prevBtn.onclick = () => {
            currentPage--;
            renderPage();
        };
        paginationControls.appendChild(prevBtn);

        for (let i = 1; i <= totalPages; i++) {
            const btn = document.createElement('button');
            btn.className = 'page-btn' + (i === currentPage ? ' active' : '');
            btn.textContent = i;
            btn.onclick = () => {
                currentPage = i;
                renderPage();
            };
            paginationControls.appendChild(btn);
        }

        const nextBtn = document.createElement('button');
        nextBtn.className = 'page-btn';
        nextBtn.textContent = '›';
        nextBtn.disabled = currentPage === totalPages;
        nextBtn.onclick = () => {
            currentPage++;
            renderPage();
        };
        paginationControls.appendChild(nextBtn);
    }

    keywordInput.addEventListener('input', applyFilters);
    subjectFilter.addEventListener('change', applyFilters);
    statusFilter.addEventListener('change', applyFilters);
    gradeFilter.addEventListener('change', applyFilters);
    const forgotPasswordLink = document.getElementById('forgotPasswordLink');
    const forgotPasswordNotice = document.getElementById('forgotPasswordNotice');

    if (forgotPasswordLink && forgotPasswordNotice) {
        forgotPasswordLink.addEventListener('click', function () {
            forgotPasswordNotice.classList.remove('hidden');
        });
    }

    renderPage();

</script>

</body>
</html>
