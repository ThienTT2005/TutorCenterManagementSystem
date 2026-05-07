<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="activePage" value="absence" scope="request" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Duyệt đơn xin nghỉ | TCMS Admin</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0"/>

    <link rel="stylesheet" href="<c:url value='/css/core-dashboard.css' />">

    <style>
        .absence-page {
            padding: 2.5rem;
            background: #f8fafc;
            min-height: calc(100vh - 70px);
        }

        .page-header {
            margin-bottom: 2rem;
        }

        .page-header h1 {
            margin: 0;
            font-size: 1.875rem;
            font-weight: 800;
            color: #0f172a;
            letter-spacing: -0.03em;
        }

        .page-header p {
            margin: 0.5rem 0 0;
            color: #64748b;
            font-size: 0.95rem;
            font-weight: 500;
        }

        .summary-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .summary-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 1.25rem;
            padding: 1.5rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            box-shadow: 0 8px 20px rgba(15, 23, 42, 0.05);
        }

        .card-icon {
            width: 52px;
            height: 52px;
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .card-icon .material-symbols-rounded {
            font-size: 28px;
        }

        .icon-pending {
            background: #fff7ed;
            color: #ea580c;
        }

        .icon-approved {
            background: #f0fdf4;
            color: #16a34a;
        }

        .card-info h3 {
            margin: 0;
            color: #64748b;
            font-size: 0.875rem;
            font-weight: 700;
        }

        .card-info .count {
            margin-top: 0.25rem;
            color: #0f172a;
            font-size: 1.75rem;
            font-weight: 800;
        }

        .filters-toolbar {
            background: #ffffff;
            padding: 1rem;
            border-radius: 1rem;
            border: 1px solid #e2e8f0;
            display: flex;
            gap: 1rem;
            align-items: center;
            margin-bottom: 1.5rem;
            box-shadow: 0 4px 10px rgba(15, 23, 42, 0.04);
        }

        .filter-group {
            display: flex;
            align-items: center;
        }

        .filter-input {
            height: 44px;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            background: #f8fafc;
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 0 14px;
            width: 100%;
        }

        .filter-input:focus-within {
            border-color: #0057bf;
            background: #ffffff;
            box-shadow: 0 0 0 4px rgba(0, 87, 191, 0.08);
        }

        .filter-input input,
        .filter-input select {
            border: none;
            outline: none;
            background: transparent;
            width: 100%;
            font-size: 14px;
            color: #334155;
            font-weight: 600;
            font-family: inherit;
        }

        .filter-input select {
            min-width: 150px;
            cursor: pointer;
        }

        .icon-btn {
            border-radius: 12px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .icon-btn:hover {
            background: #e2e8f0 !important;
        }

        .clear-filter-link {
            color: var(--primary);
            font-size: 13px;
            font-weight: 700;
            text-decoration: none;
            white-space: nowrap;
        }

        .clear-filter-link:hover {
            text-decoration: underline;
        }

        .absence-table-card {
            background: #ffffff;
            border-radius: 1.5rem;
            border: 1px solid #e2e8f0;
            box-shadow: 0 10px 25px rgba(15, 23, 42, 0.05);
            overflow: hidden;
        }

        .absence-table-card .table-header {
            padding: 1.5rem;
            border-bottom: 1px solid #f1f5f9;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .absence-table-card .table-header h2 {
            margin: 0;
            color: #0f172a;
            font-size: 1.125rem;
            font-weight: 800;
        }

        .table-responsive {
            width: 100%;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background: #f8fafc;
            color: #64748b;
            font-size: 0.75rem;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            padding: 1rem 1.5rem;
            text-align: left;
            border-bottom: 1px solid #e2e8f0;
        }

        td {
            padding: 1.25rem 1.5rem;
            border-bottom: 1px solid #f1f5f9;
            vertical-align: middle;
        }

        .absence-row:hover {
            background: #f8fafc;
        }

        .student-info {
            display: flex;
            align-items: center;
            gap: 0.875rem;
        }

        .student-avatar {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            background: #e0f2fe;
            color: #0369a1;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.875rem;
            font-weight: 800;
            flex-shrink: 0;
        }

        .student-details h4 {
            margin: 0;
            color: #0f172a;
            font-size: 0.9rem;
            font-weight: 800;
        }

        .student-details p {
            margin: 0.25rem 0 0;
            color: #64748b;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .session-badge {
            display: inline-flex;
            align-items: center;
            padding: 0.5rem 0.75rem;
            border-radius: 999px;
            background: #eff6ff;
            color: #2563eb;
            font-size: 0.8rem;
            font-weight: 700;
        }

        .reason-box {
            max-width: 420px;
            color: #475569;
            font-size: 0.875rem;
            line-height: 1.5;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .action-group {
            display: flex;
            align-items: center;
            gap: 0.625rem;
        }

        .btn {
            min-height: 38px;
            padding: 0 1rem;
            border-radius: 10px;
            border: none;
            font-size: 0.8125rem;
            font-weight: 800;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 0.375rem;
            transition: all 0.2s ease;
        }

        .btn-approve {
            background: #dcfce7;
            color: #166534;
        }

        .btn-approve:hover {
            background: #bbf7d0;
        }

        .btn-reject-modal {
            background: #fee2e2;
            color: #991b1b;
        }

        .btn-reject-modal:hover {
            background: #fecaca;
        }

        .btn-ghost {
            background: #f1f5f9;
            color: #64748b;
        }

        .empty-state {
            padding: 4rem 2rem;
            text-align: center;
            color: #94a3b8;
        }

        .empty-state .material-symbols-rounded {
            font-size: 56px;
            color: #16a34a;
            opacity: 0.7;
        }

        .empty-state h3 {
            margin: 1rem 0 0.5rem;
            color: #334155;
            font-size: 1.125rem;
            font-weight: 800;
        }

        .empty-state p {
            margin: 0;
            color: #64748b;
            font-size: 0.9rem;
        }

        .table-footer {
            padding: 1rem 1.5rem;
            border-top: 1px solid #f1f5f9;
            color: #64748b;
            font-size: 0.825rem;
            font-weight: 700;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #ffffff;
        }

        .modal {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(15, 23, 42, 0.45);
            backdrop-filter: blur(4px);
            z-index: 9999;
            align-items: center;
            justify-content: center;
            padding: 1rem;
        }

        .modal.active {
            display: flex;
        }

        .modal-content {
            width: 100%;
            max-width: 480px;
            background: #ffffff;
            border-radius: 1.5rem;
            padding: 1.75rem;
            box-shadow: 0 25px 60px rgba(15, 23, 42, 0.25);
        }

        .modal-header h3 {
            margin: 0;
            color: #0f172a;
            font-size: 1.25rem;
            font-weight: 800;
        }

        .form-group {
            margin-top: 1.25rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: #334155;
            font-size: 0.825rem;
            font-weight: 800;
        }

        .form-control {
            width: 100%;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 0.875rem 1rem;
            outline: none;
            resize: vertical;
            font-family: inherit;
            font-size: 0.9rem;
        }

        .form-control:focus {
            border-color: #0057bf;
            box-shadow: 0 0 0 4px rgba(0, 87, 191, 0.08);
        }

        .modal-footer {
            display: flex;
            justify-content: flex-end;
            gap: 0.75rem;
            margin-top: 1.25rem;
        }

        @media (max-width: 1024px) {
            .absence-page {
                padding: 1.5rem;
            }

            .summary-grid {
                grid-template-columns: 1fr;
            }

            .filters-toolbar {
                flex-direction: column;
                align-items: stretch;
            }

            .action-group {
                flex-direction: column;
                align-items: flex-start;
            }
        }
    </style>
</head>


</head>
<body>

<jsp:include page="../common/sidebar.jsp" />

<div class="main-content">
    <jsp:include page="../common/header.jsp" />

    <div style="padding: 2.5rem;">
        <header class="page-header">
            <h1>Duyệt đơn xin nghỉ</h1>
            <p>Quản lý và phê duyệt các yêu cầu nghỉ học từ học sinh & phụ huynh.</p>
        </header>

        <div class="summary-grid">
            <div class="summary-card">
                <div class="card-icon icon-pending">
                    <span class="material-symbols-rounded">pending_actions</span>
                </div>
                <div class="card-info">
                    <h3>Chờ xử lý</h3>
                    <div class="count">${fn:length(requests)}</div>
                </div>
            </div>
            <div class="summary-card">
                <div class="card-icon icon-approved">
                    <span class="material-symbols-rounded">check_circle</span>
                </div>
                <div class="card-info">
                    <h3>Hệ thống ổn định</h3>
                    <div class="count">100%</div>
                </div>
            </div>
        </div>

        <form action="${pageContext.request.contextPath}/admin/absence"
              method="GET"
              class="filters-toolbar"
              id="absenceFilterForm">

            <div class="filter-group" style="flex: 2;">
                <div class="filter-input">
            <span class="material-symbols-rounded" style="color: var(--text-muted);">
                search
            </span>

                    <input type="text"
                           id="absenceKeyword"
                           name="keyword"
                           value="${param.keyword}"
                           placeholder="Tìm học sinh, lớp học, lý do xin nghỉ...">
                </div>
            </div>

            <div class="filter-group">
                <div class="filter-input">
                    <select id="absenceClass" name="className">
                        <option value="">Lớp học</option>

                        <c:forEach var="absence" items="${requests}">
                            <c:set var="currentClassName" value="${absence.session.classEntity.className}" />

                            <c:if test="${not empty currentClassName}">
                                <option value="${currentClassName}"
                                    ${param.className == currentClassName ? 'selected' : ''}>
                                    <c:out value="${currentClassName}" />
                                </option>
                            </c:if>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="filter-group">
                <div class="filter-input">
                    <input type="date"
                           id="absenceDate"
                           name="sessionDate"
                           value="${param.sessionDate}">
                </div>
            </div>

            <button type="submit"
                    id="applyAbsenceFilter"
                    class="icon-btn"
                    style="background: var(--bg-page); border: 1px solid var(--border-color); width: 44px; height: 44px;">
                <span class="material-symbols-rounded">filter_list</span>
            </button>

            <a href="${pageContext.request.contextPath}/admin/absence"
               id="clearAbsenceFilter"
               class="clear-filter-link">
                Xóa lọc
            </a>
        </form>

        <div class="absence-table-card">
            <div class="table-header">
                <h2>Danh sách đơn chờ duyệt</h2>
                <span id="absencePageInfo">
            Tổng ${fn:length(requests)} đơn
        </span>
            </div>

            <div class="table-responsive">
                <c:choose>
                    <c:when test="${not empty requests}">
                        <table>
                            <thead>
                            <tr>
                                <th>Học sinh & Lớp</th>
                                <th>Buổi học</th>
                                <th>Lý do</th>
                                <th>Thao tác</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="absence" items="${requests}">
                                <tr class="absence-row"
                                    data-class="${absence.session.classEntity.className}"
                                    data-date="${absence.session.sessionDate}">
                                    <td>
                                        <div class="student-info">
                                            <div class="student-avatar">
                                                ${fn:substring(absence.student.fullName, 0, 1)}
                                            </div>
                                            <div class="student-details">
                                                <h4><c:out value="${absence.student.fullName}" /></h4>
                                                <p><c:out value="${absence.session.classEntity.className}" /></p>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="session-badge">
                                            <i class="fa-regular fa-calendar-check" style="margin-right: 6px;"></i>
                                            <c:out value="${absence.session.sessionDate}" />
                                        </div>
                                        <div style="font-size: 0.75rem; color: #94a3b8; margin-top: 4px; padding-left: 4px;">
                                            <c:out value="${absence.session.startTime}" /> - <c:out value="${absence.session.endTime}" />
                                        </div>
                                    </td>
                                    <td>
                                        <div class="reason-box" title="${absence.reason}">
                                            <c:out value="${absence.reason}" />
                                        </div>
                                    </td>
                                    <td>
                                        <div class="action-group">
                                            <form action="${pageContext.request.contextPath}/admin/absence/approve" method="post" style="margin:0">
                                                <input type="hidden" name="requestId" value="${absence.requestId}">
                                                <button type="submit" class="btn btn-approve">
                                                    <span class="material-symbols-rounded" style="font-size: 18px;">check</span>
                                                    Duyệt
                                                </button>
                                            </form>
                                            <button type="button" class="btn btn-reject-modal" 
                                                    onclick="openRejectModal('${absence.requestId}', '${absence.student.fullName}')">
                                                <span class="material-symbols-rounded" style="font-size: 18px;">close</span>
                                                Từ chối
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <tr id="noAbsenceResultRow" style="display: none;">
                                <td colspan="4" style="padding: 40px; text-align: center; color: #64748b; font-weight: 700;">
                                    Không tìm thấy đơn xin nghỉ phù hợp với điều kiện lọc.
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <span class="material-symbols-rounded">check_circle</span>
                            <h3>Không có đơn xin nghỉ nào cần duyệt</h3>
                            <p>Tất cả các yêu cầu đã được xử lý xong.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<!-- Reject Modal -->
<div id="rejectModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3>Từ chối đơn xin nghỉ</h3>
            <p id="studentDisplay" style="color: #64748b; font-size: 0.875rem; margin-top: 4px; font-weight: 500;"></p>
        </div>
        <form action="${pageContext.request.contextPath}/admin/absence/reject" method="post">
            <input type="hidden" name="requestId" id="rejectRequestId">
            <div class="form-group">
                <label for="rejectReason">Lý do từ chối</label>
                <textarea id="rejectReason" name="reason" class="form-control" rows="4" 
                          placeholder="Nhập lý do gửi đến phụ huynh..." required></textarea>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-ghost" onclick="closeRejectModal()">Hủy bỏ</button>
                <button type="submit" class="btn" style="background: var(--danger); color: white;">Xác nhận từ chối</button>
            </div>
        </form>
    </div>
</div>

<<script>
    function openRejectModal(id, name) {
        const rejectRequestId = document.getElementById('rejectRequestId');
        const studentDisplay = document.getElementById('studentDisplay');
        const rejectModal = document.getElementById('rejectModal');

        if (rejectRequestId) {
            rejectRequestId.value = id;
        }

        if (studentDisplay) {
            studentDisplay.innerText = 'Học sinh: ' + (name || '');
        }

        if (rejectModal) {
            rejectModal.classList.add('active');
        }
    }

    function closeRejectModal() {
        const rejectModal = document.getElementById('rejectModal');

        if (rejectModal) {
            rejectModal.classList.remove('active');
        }
    }

    document.addEventListener('DOMContentLoaded', function () {
        const keywordInput = document.getElementById('absenceKeyword');
        const classSelect = document.getElementById('absenceClass');
        const dateInput = document.getElementById('absenceDate');
        const applyButton = document.getElementById('applyAbsenceFilter');
        const clearButton = document.getElementById('clearAbsenceFilter');
        const filterForm = document.getElementById('absenceFilterForm');

        const rows = Array.from(document.querySelectorAll('.absence-row'));
        const noResultRow = document.getElementById('noAbsenceResultRow');
        const pageInfo = document.getElementById('absencePageInfo');

        const totalRows = rows.length;

        function normalizeText(value) {
            return (value || '')
                .toString()
                .toLowerCase()
                .normalize('NFD')
                .replace(/[\u0300-\u036f]/g, '')
                .trim();
        }

        function getInputValue(element) {
            return element ? element.value : '';
        }

        function updatePageInfo(visibleCount) {
            if (!pageInfo) {
                return;
            }

            if (visibleCount === totalRows) {
                pageInfo.innerText = 'Tổng ' + totalRows + ' đơn';
            } else {
                pageInfo.innerText = 'Hiển thị ' + visibleCount + ' / ' + totalRows + ' đơn';
            }
        }

        function applyAbsenceFilter() {
            const keyword = normalizeText(getInputValue(keywordInput));
            const selectedClass = normalizeText(getInputValue(classSelect));
            const selectedDate = getInputValue(dateInput);

            let visibleCount = 0;

            rows.forEach(function (row) {
                const rowText = normalizeText(row.innerText);
                const rowClass = normalizeText(row.getAttribute('data-class') || '');
                const rowDate = row.getAttribute('data-date') || '';

                const matchKeyword = keyword === '' || rowText.includes(keyword);
                const matchClass = selectedClass === '' || rowClass === selectedClass;
                const matchDate = selectedDate === '' || rowDate === selectedDate;

                if (matchKeyword && matchClass && matchDate) {
                    row.style.display = '';
                    visibleCount++;
                } else {
                    row.style.display = 'none';
                }
            });

            if (noResultRow) {
                noResultRow.style.display = visibleCount === 0 ? '' : 'none';
            }

            updatePageInfo(visibleCount);
        }

        function clearAbsenceFilter(event) {
            if (event) {
                event.preventDefault();
            }

            if (keywordInput) {
                keywordInput.value = '';
            }

            if (classSelect) {
                classSelect.value = '';
            }

            if (dateInput) {
                dateInput.value = '';
            }

            rows.forEach(function (row) {
                row.style.display = '';
            });

            if (noResultRow) {
                noResultRow.style.display = 'none';
            }

            updatePageInfo(totalRows);

            if (keywordInput) {
                keywordInput.focus();
            }

            if (window.history && window.history.replaceState) {
                const cleanUrl = window.location.origin + window.location.pathname;
                window.history.replaceState({}, document.title, cleanUrl);
            }
        }

        if (filterForm) {
            filterForm.addEventListener('submit', function (event) {
                event.preventDefault();
                applyAbsenceFilter();
            });
        }

        if (applyButton) {
            applyButton.addEventListener('click', function (event) {
                event.preventDefault();
                applyAbsenceFilter();
            });
        }

        if (clearButton) {
            clearButton.addEventListener('click', clearAbsenceFilter);
        }

        if (keywordInput) {
            keywordInput.addEventListener('keyup', function (event) {
                if (event.key === 'Enter') {
                    applyAbsenceFilter();
                }
            });
        }

        if (classSelect) {
            classSelect.addEventListener('change', applyAbsenceFilter);
        }

        if (dateInput) {
            dateInput.addEventListener('change', applyAbsenceFilter);
        }

        document.addEventListener('click', function (event) {
            const modal = document.getElementById('rejectModal');

            if (modal && event.target === modal) {
                closeRejectModal();
            }
        });
    });
</script>

</body>
</html>