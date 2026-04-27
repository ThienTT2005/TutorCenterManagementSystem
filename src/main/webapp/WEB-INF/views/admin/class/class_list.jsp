<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý lớp học | TCMS Admin</title>

    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0"/>
    <link rel="stylesheet" href="<c:url value='/css/core-dashboard.css' />">

    <style>
        .class-header-actions {
            display: flex;
            gap: 12px;
            align-items: center;
        }

        .btn-export {
            height: 44px;
            padding: 0 18px;
            border-radius: 12px;
            border: 1px solid var(--border-color);
            background: white;
            color: var(--text-dark);
            font-weight: 700;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .class-table-header,
        .class-table-row {
            display: grid;
            grid-template-columns: 0.5fr 2fr 1.3fr 1.2fr 1.7fr 1.2fr 1.2fr 1.4fr;
            align-items: center;
        }

        .class-table-row {
            padding: 18px 24px;
            border-bottom: 1px solid #f1f5f9;
        }

        .class-table-row:hover {
            background: var(--bg-page);
        }

        .class-code {
            color: var(--text-muted);
            font-size: 12px;
            margin-top: 3px;
        }

        .class-name {

            font-weight: 700;
            color: #0f172a;
            font-size: 13px;
        }

        .subject-badge {
            width: fit-content;
            padding: 5px 10px;
            border-radius: 999px;
            background: #eef2ff;
            color: #4f46e5;
            font-size: 12px;
            font-weight: 700;
        }

        .grade-badge {
            width: fit-content;
            padding: 5px 10px;
            border-radius: 999px;
            color: #0891b2;
            font-size: 12px;
            font-weight: 700;
        }

        .tutor-info {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .tutor-name{
            font-size: 14px;
            font-weight: 600;
        }

        .tutor-avatar {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background: #e0f2fe;
            color: #0369a1;
            display: flex;
            align-items: center;
            justify-content: center;

        }

        .price-info strong {
            color: #0057bf;
            font-size: 14px;


        }

        .price-info span {
            display: block;
            font-size: 11px;
            color: var(--text-muted);
            margin-top: 3px;
        }

        .class-status {
            width: fit-content;
            padding: 6px 12px;
            border-radius: 999px;
            font-size: 11px;
            font-weight: 700;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .class-status.active {
            background: #dcfce7;
            color: #16a34a;
        }

        .class-status.pending {
            background: #fef3c7;
            color: #d97706;
        }

        .class-status.inactive {
            background: #f1f5f9;
            color: #64748b;
        }

        .status-dot-small {
            width: 6px;
            height: 6px;
            border-radius: 50%;
            background: currentColor;
        }

        .actions-cell {
            display: flex;
            gap: 8px;
            justify-content: center;
        }

        .action-btn {
            width: 34px;
            height: 34px;
            border-radius: 8px;
            border: none;
            background: transparent;
            color: #94a3b8;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .action-btn:hover {
            background: #e0f2fe;
            color: var(--primary);
        }

        .action-btn.danger:hover {
            background: #fee2e2;
            color: var(--danger);
        }

        .pagination-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 24px;
            background: #fff;
            border-top: 1px solid #f1f5f9;
        }

        .pagination-info {
            font-size: 13px;
            color: #64748b;
            font-weight: 500;
        }

        .pagination-controls {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .btn-page {
            display: flex;
            align-items: center;
            justify-content: center;
            min-width: 36px;
            height: 36px;
            padding: 0 6px;
            border-radius: 10px;
            border: 1px solid #e2e8f0;
            background: #fff;
            color: #334155;
            font-size: 14px;
            font-weight: 700;
            text-decoration: none;
        }

        .btn-page.active {
            background: #0057bf;
            color: white;
            border-color: #0057bf;
        }

        .btn-page.disabled {
            opacity: 0.5;
            pointer-events: none;
        }
        .tutor-name-sm {
            font-family: 'Inter', sans-serif;
            font-weight: 500;      /* Medium thay vì bold */
            font-size: 14px;       /* nhỏ lại */
            line-height: 20px;
            color: #191C1E;
        }
    </style>
</head>

<body>

<c:set var="activePage" value="classes" scope="request"/>

<jsp:include page="../common/sidebar.jsp"/>

<main class="main-content">
    <jsp:include page="../common/header.jsp"/>

    <div class="dashboard-body">

        <div class="page-header">
            <div class="page-title">
                <h2>Quản lý lớp học</h2>
                <p>Quản lý danh sách lớp học, phân phối gia sư, học sinh và theo dõi lịch trình đào tạo.</p>
            </div>

            <div class="class-header-actions">
                <a href="${pageContext.request.contextPath}/admin/classes/export"
                   class="btn-export">
                    <span class="material-symbols-rounded">download</span>
                    Xuất danh sách
                </a>

                <a href="${pageContext.request.contextPath}/admin/classes/create"
                   class="btn-primary"
                   style="text-decoration:none;">
                    <span class="material-symbols-rounded">add_circle</span>
                    Tạo lớp học
                </a>
            </div>
        </div>

        <section class="stats-grid">
            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-icon blue">
                        <span class="material-symbols-rounded">layers</span>
                    </div>
                </div>
                <div class="stat-title">Tổng số lớp học</div>
                <div class="stat-value">${stats.totalClasses}</div>
            </div>

            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-icon cyan">
                        <span class="material-symbols-rounded">check_circle</span>
                    </div>
                </div>
                <div class="stat-title">Đang hoạt động</div>
                <div class="stat-value">${stats.activeClasses}</div>
            </div>

            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-icon yellow">
                        <span class="material-symbols-rounded">hourglass_empty</span>
                    </div>
                </div>
                <div class="stat-title">Chờ xếp lịch</div>
                <div class="stat-value">${stats.pendingClasses}</div>
            </div>

            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-icon purple">
                        <span class="material-symbols-rounded">event_available</span>
                    </div>
                </div>
                <div class="stat-title">Số buổi học hôm nay</div>
                <div class="stat-value">${stats.todayClasses}</div>
            </div>
        </section>

        <form action="${pageContext.request.contextPath}/admin/classes"
              method="GET"
              class="filters-toolbar">

            <div class="filter-group" style="flex: 2;">
                <div class="filter-input">
                    <span class="material-symbols-rounded" style="color: var(--text-muted);">search</span>
                    <input type="text"
                           name="keyword"
                           value="${param.keyword}"
                           placeholder="Tìm tên lớp, môn học, gia sư...">
                </div>
            </div>

            <div class="filter-group">
                <div class="filter-input">
                    <select name="subject">
                        <option value="">Môn học</option>
                        <c:forEach items="${subjects}" var="subject">
                            <option value="${subject}" ${param.subject == subject ? 'selected' : ''}>
                                    ${subject}
                            </option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="filter-group">
                <div class="filter-input">
                    <select name="grade">
                        <option value="">Lớp</option>
                        <c:forEach items="${grades}" var="grade">
                            <option value="${grade}" ${param.grade == grade ? 'selected' : ''}>
                                    ${grade}
                            </option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="filter-group">
                <div class="filter-input">
                    <select name="status">
                        <option value="">Trạng thái</option>
                        <option value="true"  ${param.status == 'true'  ? 'selected' : ''}>Đang hoạt động</option>
                        <option value="false" ${param.status == 'false' ? 'selected' : ''}>Tạm dừng</option>
                    </select>
                </div>
            </div>

            <button type="submit"
                    class="icon-btn"
                    style="background: var(--bg-page); border: 1px solid var(--border-color); width: 44px; height: 44px;">
                <span class="material-symbols-rounded">filter_list</span>
            </button>

            <a href="${pageContext.request.contextPath}/admin/classes"
               style="color: var(--primary); font-size: 13px; font-weight: 700; text-decoration: none;">
                Xóa lọc
            </a>
        </form>

        <div class="card">
            <div class="table-container">

                <div class="table-header class-table-header">
                    <div class="th center">STT</div>
                    <div class="th">TÊN LỚP</div>
                    <div class="th">MÔN HỌC</div>
                    <div class="th">LỚP</div>
                    <div class="th">GIA SƯ</div>
                    <div class="th">HỌC PHÍ</div>
                    <div class="th">TRẠNG THÁI</div>
                    <div class="th center">THAO TÁC</div>
                </div>

                <c:choose>
                    <c:when test="${not empty classes}">
                        <c:forEach items="${classes}" var="clazz" varStatus="stt">

                            <div class="class-table-row">

                                <div class="center" style="color: var(--text-muted); font-weight: 700;">
                                        ${classPage.number * classPage.size + stt.index + 1}
                                </div>

                                <div>
                                    <div class="class-name">
                                            ${empty clazz.className ? 'Chưa cập nhật tên lớp' : clazz.className}
                                    </div>
                                    <div class="class-code">
                                        #${empty clazz.id ? '---' : clazz.id}
                                    </div>

                                </div>

                                <div>
                                    <span class="subject-badge">
                                            ${empty clazz.subject ? '---' : clazz.subject}
                                    </span>
                                </div>

                                <div>
                                    <span class="grade-badge">
                                            ${empty clazz.grade ? '---' : clazz.grade}
                                    </span>
                                </div>

                                <div>
                                    <c:choose>
                                        <c:when test="${not empty clazz.tutor}">
                                            <div class="tutor-info">
                                                <div class="tutor-name">
                                                    <strong>${clazz.tutor.fullName}</strong>
                                                    <div style="font-size: 12px; color: var(--text-muted);">
                                                            ${empty clazz.tutor.phone ? '' : clazz.tutor.phone}
                                                    </div>
                                                </div>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color: var(--danger); font-size: 13px; font-weight: 700;">
                                                Chưa phân công
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <div class="price-info">
                                    <strong>
                                        <c:choose>
                                            <c:when test="${not empty clazz.tuitionFeePerSession}">
                                                ${clazz.tuitionFeePerSession}k
                                            </c:when>
                                            <c:otherwise>---</c:otherwise>
                                        </c:choose>
                                    </strong>
                                    <span>/ buổi học</span>
                                </div>

                                <div>
                                    <c:choose>
                                        <c:when test="${clazz.status == true}">
                                            <span class="class-status active">
                                                <span class="status-dot-small"></span>
                                                Active
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="class-status inactive">
                                                <span class="status-dot-small"></span>
                                                Inactive
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <div class="actions-cell">
                                    <button type="button"
                                            class="action-btn"
                                            title="Xem chi tiết"
                                            onclick="goDetail(event, '${clazz.id}')">
                                        <span class="material-symbols-rounded">visibility</span>
                                    </button>

                                    <button type="button"
                                            class="action-btn"
                                            title="Sửa lớp"
                                            onclick="goEdit(event, '${clazz.id}')">
                                        <span class="material-symbols-rounded">edit_note</span>
                                    </button>



                                    <button type="button"
                                            class="action-btn danger"
                                            title="${clazz.status ? 'Khóa lớp' : 'Mở khóa lớp'}"
                                            onclick="toggleStatus(event, '${clazz.id}')">
                                        <span class="material-symbols-rounded">${clazz.status ? 'lock' : 'lock_open'}</span>
                                    </button>
                                </div>

                            </div>

                        </c:forEach>
                    </c:when>

                    <c:otherwise>
                        <div style="padding: 60px 20px; text-align: center; color: var(--text-muted);">
                            <span class="material-symbols-rounded" style="font-size: 56px; opacity: 0.4;">school</span>
                            <h4>Chưa có dữ liệu lớp học</h4>
                            <p>Thử thay đổi bộ lọc hoặc tạo lớp học mới.</p>
                        </div>
                    </c:otherwise>
                </c:choose>

                <div class="pagination-container">
                    <div class="pagination-info">
                        Hiển thị <strong>${empty classes ? 0 : classes.size()}</strong> /
                        <strong>${classPage.totalElements}</strong> lớp học
                    </div>

                    <div class="pagination-controls">

                        <c:choose>
                            <c:when test="${classPage.number > 0}">
                                <a class="btn-page"
                                   href="<c:url value='/admin/classes?keyword=${param.keyword}&subject=${param.subject}&grade=${param.grade}&status=${param.status}&page=${classPage.number - 1}' />">
                                    <span class="material-symbols-rounded">chevron_left</span>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <div class="btn-page disabled">
                                    <span class="material-symbols-rounded">chevron_left</span>
                                </div>
                            </c:otherwise>
                        </c:choose>

                        <c:set var="total" value="${classPage.totalPages}"/>
                        <c:set var="current" value="${classPage.number}"/>

                        <c:if test="${total > 0}">
                            <c:forEach begin="0" end="${total - 1}" var="p">
                                <a class="btn-page ${p == current ? 'active' : ''}"
                                   href="<c:url value='/admin/classes?keyword=${param.keyword}&subject=${param.subject}&grade=${param.grade}&status=${param.status}&page=${p}' />">
                                        ${p + 1}
                                </a>
                            </c:forEach>
                        </c:if>

                        <c:choose>
                            <c:when test="${classPage.number < classPage.totalPages - 1}">
                                <a class="btn-page"
                                   href="<c:url value='/admin/classes?keyword=${param.keyword}&subject=${param.subject}&grade=${param.grade}&status=${param.status}&page=${classPage.number + 1}' />">
                                    <span class="material-symbols-rounded">chevron_right</span>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <div class="btn-page disabled">
                                    <span class="material-symbols-rounded">chevron_right</span>
                                </div>
                            </c:otherwise>
                        </c:choose>

                    </div>
                </div>

            </div>
        </div>

    </div>

    <!-- Hidden form for toggle status -->
    <form id="toggleStatusForm" method="post" style="display: none;"></form>
</main>

<script>
    const contextPath = '${pageContext.request.contextPath}';

    function goDetail(event, classId) {
        event.stopPropagation();
        window.location.href = contextPath + '/admin/classes/' + classId;
    }

    function goEdit(event, classId) {
        event.stopPropagation();
        window.location.href = contextPath + '/admin/classes/edit/' + classId;
    }

    function goSchedule(event, classId) {
        event.stopPropagation();
        window.location.href = contextPath + '/admin/classes/' + classId;
    }

    function toggleStatus(event, classId) {
        event.stopPropagation();
        if (confirm('Bạn có chắc muốn thay đổi trạng thái lớp này?')) {
            const form = document.getElementById('toggleStatusForm');
            form.action = contextPath + '/admin/classes/' + classId + '/toggle-status';
            form.submit();
        }
    }
</script>

</body>
</html>