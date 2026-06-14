document.addEventListener("DOMContentLoaded", function () {
    const form = document.querySelector(".create-form");
    const checkAllStudents = document.getElementById("checkAllStudents");
    const studentSearch = document.getElementById("studentSearch");
    const tutorSelect = document.getElementById("tutorSelect");

    if (checkAllStudents) {
        checkAllStudents.addEventListener("change", function () {
            document.querySelectorAll("input[name='studentIds']").forEach(cb => {
                cb.checked = this.checked;
            });
        });
    }

    if (studentSearch) {
        studentSearch.addEventListener("keyup", function () {
            const keyword = this.value.toLowerCase();
            const rows = document.querySelectorAll("#studentTable tbody tr");

            rows.forEach(row => {
                row.style.display = row.innerText.toLowerCase().includes(keyword) ? "" : "none";
            });
        });
    }

    if (tutorSelect) {
        tutorSelect.addEventListener("change", showTutorInfo);
    }

    if (form) {
        form.addEventListener("submit", function (e) {
            const tutorId = tutorSelect?.value;
            const selectedStudents = document.querySelectorAll("input[name='studentIds']:checked");

            if (!tutorId || tutorId.trim() === "") {
                e.preventDefault();
                alert("Vui lòng chọn gia sư phụ trách.");
                return;
            }

            if (selectedStudents.length === 0) {
                e.preventDefault();
                alert("Vui lòng chọn ít nhất 1 học sinh.");
                return;
            }

            console.log("Tạo lớp hợp lệ. Tutor:", tutorId);
            console.log("Students:", Array.from(selectedStudents).map(cb => cb.value));
        });
    }
});

function showTutorInfo() {
    const contextPath = window.contextPath || "";
    const select = document.getElementById("tutorSelect");
    const option = select.options[select.selectedIndex];
    const card = document.getElementById("selectedTutorCard");

    if (!card || !option.value) {
        card?.classList.add("hidden");
        return;
    }

    document.getElementById("tutorName").innerText =
        option.getAttribute("data-name") || "Chưa có tên";

    document.getElementById("tutorMajor").innerText =
        option.getAttribute("data-major") || "Chưa cập nhật";

    document.getElementById("tutorSchool").innerText =
        option.getAttribute("data-school") || "Chưa cập nhật trường";

    document.getElementById("tutorPhone").innerText =
        option.getAttribute("data-phone") || "Chưa có SĐT";

    document.getElementById("tutorEmail").innerText =
        option.getAttribute("data-email") || "Chưa có email";

    let avatar = option.getAttribute("data-avatar") || "/images/default-avatar.png";

    if (!avatar.startsWith("http") && !avatar.startsWith("/")) {
        avatar = contextPath + "/uploads/" + avatar;
    } else if (avatar.startsWith("/")) {
        avatar = contextPath + avatar;
    }

    document.getElementById("tutorAvatar").src = avatar;
    card.classList.remove("hidden");
}