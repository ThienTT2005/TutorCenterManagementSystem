<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="activePage" value="homework" scope="request" />
<c:set var="submission" value="${submissionMap[hw.homeworkId]}" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Bài tập của tôi | TCMS Student</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0"/>
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/student-dashboard.css">

    <style>
        :root {
            --primary: #0057bf;
            --bg-page: #f1f5f9;
            --text-dark: #1e293b;
            --text-muted: #94a3b8;
            --danger: #ef4444;
            --success: #10b981;
            --warning: #f59e0b;
        }

        .homework-page {
            padding: 2.5rem;
            background: #fdfdfe;
            min-height: 100vh;
        }

        /* Top Header & Tabs */
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .header-title h1 {
            font-size: 26px;
            font-weight: 900;
            color: #2c3e50;
            margin-bottom: 8px;
        }

        .header-title p {
            color: #7f8c8d;
            font-size: 14px;
            font-weight: 600;
        }

        .filter-tabs {
            display: flex;
            background: #fff;
            border: 1px solid #edf2f7;
            padding: 4px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.03);
        }

        .tab-btn {
            border: 0;
            padding: 10px 22px;
            border-radius: 10px;
            font-size: 13px;
            font-weight: 800;
            color: #64748b;
            cursor: pointer;
            transition: all 0.2s;
            background: transparent;
        }

        .tab-btn.active {
            background: var(--primary);
            color: #fff;
        }

                /* Homework Table Area */
        .homework-section {
            background: #fff;
            border: 1px solid #edf2f7;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 40px rgba(0,0,0,0.03);
        }

        .table-wrap {
            width: 100%;
            overflow-x: auto;
        }

        .hw-table {
            width: 100%;
            min-width: 950px;
            border-collapse: collapse;
            table-layout: fixed;
        }

        .hw-table th {
            padding: 24px 20px;
            background: #fcfdfe;
            color: #94a3b8;
            font-size: 11px;
            font-weight: 900;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            text-align: left;
            border-bottom: 1px solid #f1f5f9;
        }

        .hw-table td {
            padding: 22px 20px;
            border-bottom: 1px solid #f8fafc;
            vertical-align: middle;
        }

        /* Column Specifics */
        .col-title { width: 30%; }
        .col-teacher { width: 18%; }
        .col-deadline { width: 16%; }
        .col-status { width: 12%; text-align: center; }
        .col-score { width: 8%; text-align: center; }
        .col-action { width: 16%; text-align: right; }

        .title-cell-flex {
            display: flex;
            align-items: center;
            gap: 16px;
            min-width: 0;
        }

        .hw-icon-box {
            width: 38px;
            height: 38px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            font-size: 16px;
        }

        .hw-icon-box.blue { background: #eff6ff; color: #3b82f6; }
        .hw-icon-box.orange { background: #fff7ed; color: #f97316; }
        .hw-icon-box.green { background: #ecfdf5; color: #10b981; }

        .title-meta { min-width: 0; }
        .title-meta h3 {
            margin: 0 0 5px;
            font-size: 14px;
            font-weight: 800;
            color: #1e293b;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .title-meta span {
            font-size: 12px;
            font-weight: 600;
            color: #94a3b8;
        }

        .teacher-info {
            font-size: 13px;
            font-weight: 700;
            color: #475569;
            line-height: 1.5;
        }

        .deadline-info {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 13px;
            font-weight: 700;
            color: #64748b;
        }

        .deadline-info i { font-size: 15px; }
        .deadline-info.urgent { color: var(--danger); }
        .deadline-info.warning { color: var(--warning); }

        /* Badge Round Styling */
        .status-badge-round {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            display: inline-flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            font-size: 8px;
            font-weight: 900;
            line-height: 1.1;
            text-align: center;
            border: 1px solid currentColor;
        }

        .badge-red { background: #fff5f5; color: #ef4444; border-color: #fee2e2; }
        .badge-blue { background: #eff6ff; color: #3b82f6; border-color: #dbeafe; }
        .badge-green { background: #ecfdf5; color: #10b981; border-color: #d1fae5; }

        .score-val {
            font-size: 15px;
            font-weight: 900;
            color: #1e293b;
        }

        .score-val.high { color: var(--success); }

        /* Buttons */
        .action-flex {
            display: flex;
            align-items: center;
            justify-content: flex-end;
            gap: 12px;
        }

        .btn-submit {
            background: var(--primary);
            color: #fff;
            padding: 10px 24px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 800;
            text-decoration: none;
            transition: all 0.2s;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,87,191,0.2);
        }

        .btn-detail {
            background: #f1f5f9;
            color: #475569;
            padding: 10px 24px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 800;
            text-decoration: none;
        }

        .btn-detail:hover { background: #e2e8f0; }

        .more-dots {
            color: #cbd5e1;
            cursor: pointer;
            padding: 4px;
        }

        /* Footer */
        .section-footer {
            padding: 24px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-top: 1px solid #f1f5f9;
        }

        .results-info {
            color: #94a3b8;
            font-size: 13px;
            font-weight: 700;
        }

        .pagination {
            display: flex;
            gap: 10px;
        }

        .pg-btn {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            border: 1px solid #edf2f7;
            background: #fff;
            color: #64748b;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.2s;
        }

        .pg-btn:hover {
            background: #f8fafc;
            color: var(--primary);
            border-color: var(--primary);
        }

        .truncate {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        @media (max-width: 1200px) {
            .homework-page { padding: 1.5rem; }
        }
    </style>
</head>

<body>
    <jsp:include page="../common/sidebar.jsp" />

    <div class="main-content">
        <jsp:include page="../common/header.jsp" />

        <main class="homework-page">
            <div class="page-header">
                <div class="header-title">
                    <h1>Bài tập của tôi</h1>
                    <p>Theo dõi bài tập, hạn nộp và kết quả chấm điểm</p>
                </div>

                <div class="filter-tabs">
                    <button class="tab-btn active" data-filter="unfinished">Chưa hoàn thành</button>
                    <button class="tab-btn" data-filter="completed">Đã hoàn thành</button>
                    <button class="tab-btn" data-filter="all">Tất cả</button>
                </div>
            </div>


            <!-- Homework Table -->
            <section class="homework-section">
                <div class="table-wrap">
                    <table class="hw-table">
                        <thead>
                            <tr>
                                <th class="col-title">Tên bài tập</th>
                                <th class="col-teacher">Giảng viên giao</th>
                                <th class="col-deadline">Hạn cuối</th>
                                <th class="col-status">Trạng thái</th>
                                <th class="col-score">Điểm số</th>
                                <th class="col-action">Hành động</th>
                            </tr>
                        </thead>
                        <tbody id="homeworkRows">
                            <c:choose>
                                <c:when test="${not empty homeworks}">
                                    <c:forEach var="hw" items="${homeworks}" varStatus="loop">
                                        <c:set var="statusValue" value="${empty submissionStatusMap[hw.homeworkId] ? 'NOT_SUBMITTED' : submissionStatusMap[hw.homeworkId]}" />
                                        <c:set var="scoreValue" value="${empty scoreMap[hw.homeworkId] ? '' : scoreMap[hw.homeworkId]}" />
                                        <c:set var="iconColor" value="${loop.index % 3 == 0 ? 'blue' : (loop.index % 3 == 1 ? 'orange' : 'green')}" />
                                        <c:set var="rowStatus" value="${statusValue == 'SUBMITTED' || statusValue == 'GRADED' ? 'completed' : 'unfinished'}" />

                                        <tr class="hw-row" data-status="${rowStatus}" data-deadline="${hw.deadline}">
                                            <td class="col-title">
                                                <div class="title-cell-flex">
                                                    <div class="hw-icon-box ${iconColor}">
                                                        <c:choose>
                                                            <c:when test="${iconColor == 'blue'}"><i class="fa-solid fa-calculator"></i></c:when>
                                                            <c:when test="${iconColor == 'orange'}"><i class="fa-solid fa-code"></i></c:when>
                                                            <c:otherwise><i class="fa-solid fa-scroll"></i></c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <div class="title-meta truncate">
                                                        <h3 class="truncate"><c:out value="${hw.title}" /></h3>
                                                        <span class="truncate">
                                                            <c:out value="${not empty hw.session.classEntity ? hw.session.classEntity.subject : 'Môn học'}" />
                                                        </span>
                                                    </div>
                                                </div>
                                            </td>

                                            <td class="col-teacher">
                                                <div class="teacher-info">
                                                    <c:out value="${not empty hw.session.classEntity.tutor ? hw.session.classEntity.tutor.fullName : 'Giảng viên'}" />
                                                </div>
                                            </td>

                                            <td class="col-deadline">
                                                <!-- Simplified logic for display, real logic in JS below -->
                                                <div class="deadline-info" id="deadline-${hw.homeworkId}">
                                                    <i class="fa-regular fa-clock"></i>
                                                    <span><c:out value="${hw.deadline}" /></span>
                                                </div>
                                            </td>

                                            <td class="col-status">
                                                <c:choose>
                                                    <c:when test="${statusValue == 'GRADED'}">
                                                        <div class="status-badge-round badge-green">ĐÃ<br>CHẤM</div>
                                                    </c:when>
                                                    <c:when test="${statusValue == 'SUBMITTED'}">
                                                        <div class="status-badge-round badge-blue">ĐÃ<br>NỘP</div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="status-badge-round badge-red">CHƯA<br>NỘP</div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>

                                            <td class="col-score">
                                                <div class="score-val ${scoreValue >= 9 ? 'high' : ''}">
                                                    <c:out value="${empty scoreValue ? '--' : scoreValue}" />
                                                </div>
                                            </td>

                                            <td class="col-action">
                                                <div class="action-flex">
                                                    <c:choose>
                                                        <c:when test="${statusValue == 'NOT_SUBMITTED'}">
                                                            <a href="${pageContext.request.contextPath}/student/homework/detail/${hw.homeworkId}" class="btn-submit">Nộp bài</a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a href="${pageContext.request.contextPath}/student/homework/detail/${hw.homeworkId}" class="btn-detail">Chi tiết</a>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <div class="more-dots"><i class="fa-solid fa-ellipsis-vertical"></i></div>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="6" style="text-align: center; padding: 4rem; color: #94a3b8;">
                                            Chưa có dữ liệu bài tập
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>

                <div class="section-footer">
                    <div class="results-info" id="visibleCount">
                        Hiển thị ${fn:length(homeworks)} trên ${fn:length(homeworks)} bài tập
                    </div>
                    <div class="pagination">
                        <div class="pg-btn"><i class="fa-solid fa-chevron-left"></i></div>
                        <div class="pg-btn"><i class="fa-solid fa-chevron-right"></i></div>
                    </div>
                </div>
            </section>
        </main>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const tabs = document.querySelectorAll('.tab-btn');
            const rows = document.querySelectorAll('.hw-row');
            const visibleText = document.getElementById('visibleCount');

            // Tab Switching
            tabs.forEach(tab => {
                tab.addEventListener('click', () => {
                    tabs.forEach(t => t.classList.remove('active'));
                    tab.classList.add('active');

                    const filter = tab.dataset.filter;
                    let count = 0;

                    rows.forEach(row => {
                        if (filter === 'all' || row.dataset.status === filter) {
                            row.style.display = 'table-row';
                            count++;
                        } else {
                            row.style.display = 'none';
                        }
                    });

                    if (visibleText) {
                        visibleText.textContent = 'Hiển thị ' + count + ' trên ' + rows.length + ' bài tập';
                    }
                });
            });

            // Deadline Coloring Logic
            const now = new Date();

            rows.forEach(row => {
                const deadlineStr = row.dataset.deadline;

                if (!deadlineStr) {
                    return;
                }

                const deadlineDate = new Date(deadlineStr.replace(' ', 'T'));

                if (isNaN(deadlineDate.getTime())) {
                    return;
                }

                const diffMs = deadlineDate.getTime() - now.getTime();
                const diffDays = diffMs / (1000 * 60 * 60 * 24);

                const infoDiv = row.querySelector('.deadline-info');

                if (!infoDiv) {
                    return;
                }

                const span = infoDiv.querySelector('span');
                const icon = infoDiv.querySelector('i');

                if (diffMs < 0) {
                    if (span) {
                        span.textContent = 'Đã hết hạn';
                    }

                    infoDiv.classList.add('urgent');
                } else if (diffDays < 1) {
                    if (span) {
                        const timePart = deadlineStr.includes(' ')
                            ? deadlineStr.split(' ')[1]
                            : '';

                        span.textContent = timePart ? 'Hôm nay, ' + timePart : 'Hôm nay';
                    }

                    if (icon) {
                        icon.className = 'fa-solid fa-clock-rotate-left';
                    }

                    infoDiv.classList.add('urgent');
                } else if (diffDays < 3) {
                    if (span) {
                        span.textContent = 'Còn ' + Math.ceil(diffDays) + ' ngày';
                    }

                    infoDiv.classList.add('warning');
                }
            });

            // Initial filter call
            if (tabs.length > 0) {
                tabs[0].click();
            }
        });
    </script>
</body>
</html>