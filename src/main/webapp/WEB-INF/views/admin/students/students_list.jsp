<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý học sinh | TCMS Admin</title>

    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0"/>
    <link rel="stylesheet" href="<c:url value='/css/core-dashboard.css' />">

    <style>
        .student-header-actions {
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

        .student-table-header,
        .student-table-row {
            display: grid;
            grid-template-columns: 0.5fr 2.2fr 2fr 1.8fr 1.3fr 1.3fr;
            align-items: center;
        }

        .student-table-row {
            padding: 18px 24px;
            border-bottom: 1px solid #f1f5f9;
        }

        .student-table-row:hover {
            background: var(--bg-page);
        }

        .student-id {
            font-size: 11px;
            color: var(--text-muted);
            font-weight: 600;
        }

        .parent-info {
            display: flex;
            flex-direction: column;
            gap: 3px;
            font-size: 13px;
        }

        .parent-info strong {
            color: var(--text-dark);
        }

        .parent-info span {
            color: var(--text-muted);
            font-size: 12px;
        }

        .school-info {
            display: flex;
            flex-direction: column;
            gap: 5px;
            font-size: 13px;
            font-weight: 700;
        }

        .grade-badge {
            width: fit-content;
            padding: 4px 8px;
            border-radius: 8px;
            background: #eef2ff;
            color: #4f46e5;
            font-size: 11px;
            font-weight: 800;
        }

        .student-status {
            width: fit-content;
            padding: 6px 12px;
            border-radius: 999px;
            font-size: 11px;
            font-weight: 900;
            text-transform: uppercase;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .student-status.active {
            background: #dcfce7;
            color: #16a34a;
        }

        .student-status.waiting {
            background: #fef3c7;
            color: #d97706;
        }

        .student-status.blocked {
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

        .pagination-dots {
            color: #94a3b8;
            font-weight: 800;
        }
    </style>
</head>

<body>

<c:set var="activePage" value="students" scope="request"/>

<jsp:include page="../common/sidebar.jsp"/>

<main class="main-content">
    <jsp:include page="../common/header.jsp"/>

    <div class="dashboard-body">

        <!-- HEADER -->
        <div class="page-header">
            <div class="page-title">
                <h2>Quản lý học sinh</h2>
                <p>Quản lý hồ sơ, lớp học và tình trạng học tập của toàn bộ học sinh.</p>
            </div>

            <div class="student-header-actions">
                <a href="${pageContext.request.contextPath}/admin/students/export"
                   class="btn-export">
                    <span class="material-symbols-rounded">download</span>
                    Xuất báo cáo
                </a>

                <a href="${pageContext.request.contextPath}/admin/accounts/create?role=STUDENT"
                   class="btn-primary"
                   style="text-decoration:none;">
                    <span class="material-symbols-rounded">add</span>
                    Thêm học sinh
                </a>
            </div>
        </div>

        <!-- STATS -->
        <section class="stats-grid">
            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-icon blue">
                        <span class="material-symbols-rounded">groups</span>
                    </div>
                </div>
                <div class="stat-title">Tổng học sinh</div>
                <div class="stat-value">${stats.totalStudents}</div>
            </div>

            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-icon cyan">
                        <span class="material-symbols-rounded">check_circle</span>
                    </div>
                </div>
                <div class="stat-title">Đang học</div>
                <div class="stat-value">${stats.activeStudents}</div>
            </div>

            <div class="stat-card" style="border-left: 4px solid #facc15;">
                <div class="stat-header">
                    <div class="stat-icon yellow">
                        <span class="material-symbols-rounded">warning</span>
                    </div>
                </div>
                <div class="stat-title">Chưa có lớp</div>
                <div class="stat-value">${stats.noClassStudents}</div>
            </div>

            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-icon purple">
                        <span class="material-symbols-rounded">person_add</span>
                    </div>
                </div>
                <div class="stat-title">Đăng ký mới</div>
                <div class="stat-value">${stats.newStudentsThisMonth}</div>
            </div>
        </section>

        <!-- FILTER -->
        <form action="${pageContext.request.contextPath}/admin/students"
              method="GET"
              class="filters-toolbar">

            <div class="filter-group" style="flex: 2;">
                <div class="filter-input">
                    <span class="material-symbols-rounded" style="color: var(--text-muted);">search</span>
                    <input type="text"
                           name="keyword"
                           value="${param.keyword}"
                           placeholder="Tìm kiếm tên, mã HS, trường hoặc lớp...">
                </div>
            </div>

            <div class="filter-group">
                <div class="filter-input">
                    <select name="grade">
                        <option value="">Khối/Lớp</option>
                        <option value="1" ${param.grade == '1' ? 'selected' : ''}>Khối 1</option>
                        <option value="2" ${param.grade == '2' ? 'selected' : ''}>Khối 2</option>
                        <option value="3" ${param.grade == '3' ? 'selected' : ''}>Khối 3</option>
                        <option value="4" ${param.grade == '4' ? 'selected' : ''}>Khối 4</option>
                        <option value="5" ${param.grade == '5' ? 'selected' : ''}>Khối 5</option>
                        <option value="6" ${param.grade == '6' ? 'selected' : ''}>Khối 6</option>
                        <option value="7" ${param.grade == '7' ? 'selected' : ''}>Khối 7</option>
                        <option value="8" ${param.grade == '8' ? 'selected' : ''}>Khối 8</option>
                        <option value="9" ${param.grade == '9' ? 'selected' : ''}>Khối 9</option>
                        <option value="10" ${param.grade == '10' ? 'selected' : ''}>Khối 10</option>
                        <option value="11" ${param.grade == '11' ? 'selected' : ''}>Khối 11</option>
                        <option value="12" ${param.grade == '12' ? 'selected' : ''}>Khối 12</option>
                    </select>
                </div>
            </div>

            <div class="filter-group">
                <div class="filter-input">
                    <input type="text"
                           name="school"
                           value="${param.school}"
                           placeholder="Trường">
                </div>
            </div>

            <div class="filter-group">
                <div class="filter-input">
                    <select name="status">
                        <option value="">Trạng thái</option>
                        <option value="true" ${param.status == 'true' ? 'selected' : ''}>Đang học</option>
                        <option value="false" ${param.status == 'false' ? 'selected' : ''}>Đã khóa</option>
                    </select>
                </div>
            </div>

            <button type="submit"
                    class="icon-btn"
                    style="background: var(--bg-page); border: 1px solid var(--border-color); width: 44px; height: 44px;">
                <span class="material-symbols-rounded">filter_list</span>
            </button>

            <a href="${pageContext.request.contextPath}/admin/students"
               style="color: var(--primary); font-size: 13px; font-weight: 700; text-decoration: none;">
                Xóa bộ lọc
            </a>
        </form>

        <!-- TABLE -->
        <div class="card">
            <div class="table-container">

                <div class="table-header student-table-header">
                    <div class="th center">STT</div>
                    <div class="th">HỌC SINH</div>
                    <div class="th">PHỤ HUYNH</div>
                    <div class="th">TRƯỜNG / LỚP</div>
                    <div class="th">TRẠNG THÁI</div>
                    <div class="th center">THAO TÁC</div>
                </div>

                <c:choose>
                    <c:when test="${not empty students}">
                        <c:forEach items="${students}" var="student" varStatus="status">

                            <div class="student-table-row">

                                <!-- STT -->
                                <div class="center" style="color: var(--text-muted); font-weight: 700;">
                                        ${studentPage.number * studentPage.size + status.index + 1}
                                </div>

                                <!-- HỌC SINH -->
                                <div class="user-cell">
                                    <c:choose>
                                        <c:when test="${not empty student.avatar and student.avatar != 'default-avatar.png'}">
                                            <img src="${pageContext.request.contextPath}/uploads/${student.avatar}"
                                                 class="user-initials"
                                                 style="width: 38px; height: 38px; object-fit: cover; border-radius: 50%;"
                                                 onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/images/default-avatar.png'">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="user-initials initials-blue">
                                                    ${fn:substring(student.fullName, 0, 1)}
                                            </div>
                                        </c:otherwise>
                                    </c:choose>

                                    <div class="user-detail">
                                        <h4 style="margin:0;">${empty student.fullName ? 'Chưa cập nhật' : student.fullName}</h4>
                                        <span class="student-id">
                                            ID: ${empty student.id ? '---' : student.id}
                                        </span>
                                    </div>
                                </div>

                                <!-- PHỤ HUYNH -->
                                <div class="parent-info">
                                    <c:choose>
                                        <c:when test="${not empty student.parent}">
                                            <strong>${student.parent.fullName}</strong>
                                            <span>${empty student.parent.phone ? 'Chưa có SĐT' : student.parent.phone}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <strong style="color: var(--danger);">Chưa gán phụ huynh</strong>
                                            <span>---</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <!-- TRƯỜNG / LỚP -->
                                <div class="school-info">
                                    <span>${empty student.school ? 'Chưa cập nhật trường' : student.school}</span>
                                    <span class="grade-badge">
                                            ${empty student.grade ? 'Chưa có lớp' : student.grade}
                                    </span>
                                </div>

                                <!-- TRẠNG THÁI -->
                                <div>
                                    <c:choose>
                                        <c:when test="${not empty student.user and student.user.status}">
                                            <span class="student-status active">
                                                <span class="status-dot-small"></span>
                                                Đang học
                                            </span>
                                        </c:when>

                                        <c:otherwise>
                                            <span class="student-status blocked">
                                                <span class="status-dot-small"></span>
                                                Bảo lưu
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <!-- THAO TÁC -->
                                <div class="actions-cell">
                                    <button type="button"
                                            class="action-btn"
                                            title="Xem chi tiết"
                                            onclick="goDetail(event, '${student.user.id}')">
                                        <span class="material-symbols-rounded">visibility</span>
                                    </button>

                                    <button type="button"
                                            class="action-btn"
                                            title="Sửa"
                                            onclick="goEdit(event, '${student.user.id}')">
                                        <span class="material-symbols-rounded">edit_note</span>
                                    </button>

                                    <c:choose>
                                        <c:when test="${not empty student.user and student.user.status}">
                                            <button type="button"
                                                    class="action-btn danger"
                                                    title="Khóa tài khoản"
                                                    onclick="lockUser(event, '${student.user.id}')">
                                                <span class="material-symbols-rounded">lock</span>
                                            </button>
                                        </c:when>

                                        <c:otherwise>
                                            <button type="button"
                                                    class="action-btn"
                                                    title="Mở khóa tài khoản"
                                                    onclick="unlockUser(event, '${student.user.id}')">
                                                <span class="material-symbols-rounded">lock_open</span>
                                            </button>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                            </div>
                        </c:forEach>
                    </c:when>

                    <c:otherwise>
                        <div style="padding: 60px 20px; text-align: center; color: var(--text-muted);">
                            <span class="material-symbols-rounded" style="font-size: 56px; opacity: 0.4;">person_off</span>
                            <h4>Chưa có dữ liệu học sinh</h4>
                            <p>Thử thay đổi bộ lọc hoặc thêm học sinh mới.</p>
                        </div>
                    </c:otherwise>
                </c:choose>

                <!-- PAGINATION -->
                <div class="pagination-container">
                    <div class="pagination-info">
                        Hiển thị <strong>${students.size()}</strong> /
                        <strong>${studentPage.totalElements}</strong> học sinh
                    </div>

                    <div class="pagination-controls">

                        <c:choose>
                            <c:when test="${studentPage.number > 0}">
                                <a class="btn-page"
                                   href="<c:url value='/admin/students?keyword=${param.keyword}&grade=${param.grade}&school=${param.school}&status=${param.status}&page=${studentPage.number - 1}' />">
                                    <span class="material-symbols-rounded">chevron_left</span>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <div class="btn-page disabled">
                                    <span class="material-symbols-rounded">chevron_left</span>
                                </div>
                            </c:otherwise>
                        </c:choose>

                        <c:set var="total" value="${studentPage.totalPages}"/>
                        <c:set var="current" value="${studentPage.number}"/>

                        <c:if test="${total > 0}">
                            <c:forEach begin="0" end="${total - 1}" var="p">
                                <a class="btn-page ${p == current ? 'active' : ''}"
                                   href="<c:url value='/admin/students?keyword=${param.keyword}&grade=${param.grade}&school=${param.school}&status=${param.status}&page=${p}' />">
                                        ${p + 1}
                                </a>
                            </c:forEach>
                        </c:if>

                        <c:choose>
                            <c:when test="${studentPage.number < studentPage.totalPages - 1}">
                                <a class="btn-page"
                                   href="<c:url value='/admin/students?keyword=${param.keyword}&grade=${param.grade}&school=${param.school}&status=${param.status}&page=${studentPage.number + 1}' />">
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
</main>

<script>
    const contextPath = '${pageContext.request.contextPath}';

    function goDetail(event, userId) {
        event.stopPropagation();
        window.location.href = contextPath + '/admin/accounts/' + userId + '/detail';
    }

    function goEdit(event, userId) {
        event.stopPropagation();
        window.location.href = contextPath + '/admin/accounts/' + userId + '/edit';
    }

    async function lockUser(event, userId) {
        event.stopPropagation();

        if (!confirm('Bạn có chắc muốn khóa tài khoản học sinh này?')) return;

        try {
            const response = await fetch(contextPath + '/api/admin/users/' + userId + '/lock', {
                method: 'PATCH'
            });

            const data = await response.json();

            if (!response.ok) {
                alert(data.message || 'Khóa tài khoản thất bại');
                return;
            }

            alert(data.message || 'Đã khóa tài khoản');
            location.reload();
        } catch (e) {
            alert('Khóa tài khoản thất bại');
        }
    }

    async function unlockUser(event, userId) {
        event.stopPropagation();

        if (!confirm('Bạn có chắc muốn mở khóa tài khoản học sinh này?')) return;

        try {
            const response = await fetch(contextPath + '/api/admin/users/' + userId + '/unlock', {
                method: 'PATCH'
            });

            const data = await response.json();

            if (!response.ok) {
                alert(data.message || 'Mở khóa tài khoản thất bại');
                return;
            }

            alert(data.message || 'Đã mở khóa tài khoản');
            location.reload();
        } catch (e) {
            alert('Mở khóa tài khoản thất bại');
        }
    }
</script>

</body>
</html>