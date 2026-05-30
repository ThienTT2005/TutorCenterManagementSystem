const tempSchedules = [];

document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("scheduleForm");

    if (!form) return;

    form.addEventListener("submit", function (e) {
        if (tempSchedules.length === 0) {
            e.preventDefault();
            alert("Vui lòng thêm ít nhất một lịch học trước khi lưu.");
            return;
        }

        renderHiddenInputs();
        console.log("Danh sách lịch gửi lên:", tempSchedules);
    });
});

function weekdayText(value) {
    switch (String(value)) {
        case "2": return "Thứ Hai";
        case "3": return "Thứ Ba";
        case "4": return "Thứ Tư";
        case "5": return "Thứ Năm";
        case "6": return "Thứ Sáu";
        case "7": return "Thứ Bảy";
        case "8": return "Chủ nhật";
        default: return "";
    }
}

function addScheduleTemp() {
    const weekday = document.getElementById("weekdayInput").value;
    const startTime = document.getElementById("startTimeInput").value;
    const endTime = document.getElementById("endTimeInput").value;

    if (!weekday) {
        alert("Vui lòng chọn thứ trong tuần.");
        return;
    }

    if (!startTime || !endTime) {
        alert("Vui lòng nhập đầy đủ giờ bắt đầu và giờ kết thúc.");
        return;
    }

    if (startTime >= endTime) {
        alert("Giờ bắt đầu phải nhỏ hơn giờ kết thúc.");
        return;
    }

    const duplicated = tempSchedules.some(item =>
        item.weekday === weekday &&
        item.startTime === startTime &&
        item.endTime === endTime
    );

    if (duplicated) {
        alert("Lịch này đã được thêm vào danh sách tạm.");
        return;
    }

    tempSchedules.push({
        weekday,
        startTime,
        endTime
    });

    renderTempSchedules();
    renderHiddenInputs();
    clearScheduleInput();

    console.log("Đã thêm lịch tạm:", tempSchedules);
}

function removeTempSchedule(index) {
    tempSchedules.splice(index, 1);
    renderTempSchedules();
    renderHiddenInputs();
}

function renderTempSchedules() {
    const tbody = document.getElementById("scheduleTableBody");

    if (!tbody) {
        console.error("Không tìm thấy #scheduleTableBody");
        return;
    }

    document.querySelectorAll(".temp-schedule-row").forEach(row => row.remove());

    tempSchedules.forEach((item, index) => {
        const row = document.createElement("tr");
        row.className = "temp-schedule-row";

        row.innerHTML = `
            <td>
                <div class="day-cell">
                    <div class="day-number">${item.weekday}</div>
                    <div>${weekdayText(item.weekday)}</div>
                </div>
            </td>
            <td>${item.startTime} - ${item.endTime}</td>
            <td>
                <span class="status-badge">
                    <span class="dot"></span>
                    Chờ lưu
                </span>
            </td>
            <td>
                <button type="button" class="delete-btn" onclick="removeTempSchedule(${index})">
                    <span class="material-symbols-rounded" style="font-size:18px;">delete</span>
                </button>
            </td>
        `;

        tbody.appendChild(row);
    });
}

function renderHiddenInputs() {
    const container = document.getElementById("hiddenScheduleInputs");

    if (!container) {
        console.error("Không tìm thấy #hiddenScheduleInputs");
        return;
    }

    container.innerHTML = "";

    tempSchedules.forEach((item, index) => {
        container.innerHTML += `
            <input type="hidden" name="schedules[${index}].weekday" value="${item.weekday}">
            <input type="hidden" name="schedules[${index}].startTime" value="${item.startTime}">
            <input type="hidden" name="schedules[${index}].endTime" value="${item.endTime}">
        `;
    });
}

function clearScheduleInput() {
    document.getElementById("weekdayInput").value = "";
    document.getElementById("startTimeInput").value = "";
    document.getElementById("endTimeInput").value = "";
}