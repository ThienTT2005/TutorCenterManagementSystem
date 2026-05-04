let tempScheduleIndex = 0;

function getWeekdayName(weekday) {
    switch (String(weekday)) {
        case "2":
            return "Thứ Hai";
        case "3":
            return "Thứ Ba";
        case "4":
            return "Thứ Tư";
        case "5":
            return "Thứ Năm";
        case "6":
            return "Thứ Sáu";
        case "7":
            return "Thứ Bảy";
        case "8":
            return "Chủ nhật";
        default:
            return "Chưa chọn";
    }
}

function removeEmptyRow() {
    const tableBody = document.getElementById("scheduleTableBody");

    if (!tableBody) {
        return;
    }

    const emptyRow = tableBody.querySelector(".empty");

    if (emptyRow) {
        const row = emptyRow.closest("tr");
        if (row) {
            row.remove();
        }
    }
}

function addHiddenScheduleInputs(index, weekday, startTime, endTime) {
    const hiddenContainer = document.getElementById("hiddenScheduleInputs");

    if (!hiddenContainer) {
        alert("Không tìm thấy vùng hiddenScheduleInputs trong form.");
        return;
    }

    const wrapper = document.createElement("div");
    wrapper.setAttribute("data-temp-index", index);

    /*
        CÁCH 1: dùng dạng list.
        Nếu backend của bạn nhận List schedules thì dùng được:
        schedules[0].weekday
        schedules[0].startTime
        schedules[0].endTime
    */
    wrapper.innerHTML =
        '<input type="hidden" name="schedules[' + index + '].weekday" value="' + weekday + '">' +
        '<input type="hidden" name="schedules[' + index + '].startTime" value="' + startTime + '">' +
        '<input type="hidden" name="schedules[' + index + '].endTime" value="' + endTime + '">' +

        /*
            CÁCH 2: thêm dạng mảng song song để phòng backend đang nhận:
            weekdayList, startTimeList, endTimeList.
            Nếu backend không dùng thì cũng không ảnh hưởng frontend.
        */
        '<input type="hidden" name="weekdayList" value="' + weekday + '">' +
        '<input type="hidden" name="startTimeList" value="' + startTime + '">' +
        '<input type="hidden" name="endTimeList" value="' + endTime + '">';

    hiddenContainer.appendChild(wrapper);
}

function removeTempSchedule(button, index) {
    const row = button.closest("tr");

    if (row) {
        row.remove();
    }

    const hiddenContainer = document.getElementById("hiddenScheduleInputs");

    if (hiddenContainer) {
        const hiddenWrapper = hiddenContainer.querySelector('[data-temp-index="' + index + '"]');

        if (hiddenWrapper) {
            hiddenWrapper.remove();
        }
    }

    renderEmptyRowIfNeeded();
}

function renderEmptyRowIfNeeded() {
    const tableBody = document.getElementById("scheduleTableBody");

    if (!tableBody) {
        return;
    }

    const rows = tableBody.querySelectorAll("tr");

    if (rows.length === 0) {
        tableBody.innerHTML =
            '<tr>' +
            '<td colspan="4" class="empty">' +
            'Lớp này chưa có lịch học nào.' +
            '</td>' +
            '</tr>';
    }
}

function addScheduleTemp() {
    const weekdayInput = document.getElementById("weekdayInput");
    const startTimeInput = document.getElementById("startTimeInput");
    const endTimeInput = document.getElementById("endTimeInput");
    const tableBody = document.getElementById("scheduleTableBody");

    if (!weekdayInput || !startTimeInput || !endTimeInput || !tableBody) {
        alert("Thiếu thành phần HTML để thêm lịch. Kiểm tra lại id weekdayInput, startTimeInput, endTimeInput, scheduleTableBody.");
        return;
    }

    const weekday = weekdayInput.value;
    const startTime = startTimeInput.value;
    const endTime = endTimeInput.value;

    if (!weekday) {
        alert("Vui lòng chọn thứ trong tuần.");
        weekdayInput.focus();
        return;
    }

    if (!startTime) {
        alert("Vui lòng chọn giờ bắt đầu.");
        startTimeInput.focus();
        return;
    }

    if (!endTime) {
        alert("Vui lòng chọn giờ kết thúc.");
        endTimeInput.focus();
        return;
    }

    if (startTime >= endTime) {
        alert("Giờ kết thúc phải lớn hơn giờ bắt đầu.");
        endTimeInput.focus();
        return;
    }

    removeEmptyRow();

    const index = tempScheduleIndex++;
    const weekdayName = getWeekdayName(weekday);

    const row = document.createElement("tr");
    row.setAttribute("data-temp-index", index);

    row.innerHTML =
        '<td>' +
        '<div class="day-cell">' +
        '<div class="day-number">' + weekday + '</div>' +
        '<div>' + weekdayName + '</div>' +
        '</div>' +
        '</td>' +

        '<td>' +
        startTime + ' - ' + endTime +
        '</td>' +

        '<td>' +
        '<span class="status-badge">' +
        '<span class="dot"></span>' +
        'Chờ lưu' +
        '</span>' +
        '</td>' +

        '<td>' +
        '<button type="button" class="delete-btn" onclick="removeTempSchedule(this, ' + index + ')">' +
        '<span class="material-symbols-rounded" style="font-size:18px;">delete</span>' +
        '</button>' +
        '</td>';

    tableBody.appendChild(row);

    addHiddenScheduleInputs(index, weekday, startTime, endTime);

    weekdayInput.value = "";
    startTimeInput.value = "";
    endTimeInput.value = "";
}

/*
    Quan trọng:
    Vì JSP đang gọi onclick="addScheduleTemp()",
    hàm phải nằm trên window để browser tìm thấy.
*/
window.addScheduleTemp = addScheduleTemp;
window.removeTempSchedule = removeTempSchedule;