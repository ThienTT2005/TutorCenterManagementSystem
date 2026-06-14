(function () {
    "use strict";

    function getContextPath() {
        return window.contextPath || "";
    }

    function normalize(value) {
        return (value || "").toString().trim().toLowerCase();
    }

    function getDefaultAvatar() {
        return getContextPath() + "/images/default-avatar.png";
    }

    function resolveAvatarUrl(avatar) {
        if (!avatar || avatar.trim() === "") {
            return getDefaultAvatar();
        }

        avatar = avatar.trim();

        if (avatar.startsWith("http://") || avatar.startsWith("https://")) {
            return avatar;
        }

        if (avatar.startsWith("/")) {
            return getContextPath() + avatar;
        }

        if (avatar.startsWith("assets/")) {
            return getContextPath() + "/" + avatar;
        }

        if (avatar.startsWith("uploads/")) {
            return getContextPath() + "/" + avatar;
        }

        return getContextPath() + "/uploads/" + avatar;
    }

    function filterStudents() {
        const searchInput = document.getElementById("studentSearch");
        const table = document.getElementById("studentTable");

        if (!searchInput || !table) {
            return;
        }

        const keyword = normalize(searchInput.value);
        const rows = Array.from(table.querySelectorAll("tbody tr"));

        rows.forEach(function (row) {
            if (row.querySelector(".empty-cell")) {
                return;
            }

            const text = normalize(row.textContent);
            row.style.display = text.includes(keyword) ? "" : "none";
        });
    }

    function setupCheckAllStudents() {
        const checkAll = document.getElementById("checkAllStudents");
        const table = document.getElementById("studentTable");

        if (!checkAll || !table) {
            return;
        }

        checkAll.addEventListener("change", function () {
            const studentCheckboxes = table.querySelectorAll('tbody input[type="checkbox"][name="studentIds"]');

            studentCheckboxes.forEach(function (checkbox) {
                const row = checkbox.closest("tr");

                if (!row || row.style.display === "none") {
                    return;
                }

                checkbox.checked = checkAll.checked;
            });
        });

        table.addEventListener("change", function (event) {
            const target = event.target;

            if (!target.matches('input[type="checkbox"][name="studentIds"]')) {
                return;
            }

            const visibleCheckboxes = Array.from(
                table.querySelectorAll('tbody input[type="checkbox"][name="studentIds"]')
            ).filter(function (checkbox) {
                const row = checkbox.closest("tr");
                return row && row.style.display !== "none";
            });

            if (visibleCheckboxes.length === 0) {
                checkAll.checked = false;
                return;
            }

            checkAll.checked = visibleCheckboxes.every(function (checkbox) {
                return checkbox.checked;
            });
        });
    }

    function showTutorInfo() {
        const tutorSelect = document.getElementById("tutorSelect");
        const selectedTutorCard = document.getElementById("selectedTutorCard");

        const tutorAvatar = document.getElementById("tutorAvatar");
        const tutorName = document.getElementById("tutorName");
        const tutorMajor = document.getElementById("tutorMajor");
        const tutorSchool = document.getElementById("tutorSchool");
        const tutorPhone = document.getElementById("tutorPhone");
        const tutorEmail = document.getElementById("tutorEmail");

        if (!tutorSelect || !selectedTutorCard) {
            return;
        }

        const selectedOption = tutorSelect.options[tutorSelect.selectedIndex];

        if (!selectedOption || !selectedOption.value) {
            selectedTutorCard.classList.add("hidden");

            if (tutorAvatar) {
                tutorAvatar.src = getDefaultAvatar();
            }

            if (tutorName) {
                tutorName.textContent = "Tên gia sư";
            }

            if (tutorMajor) {
                tutorMajor.textContent = "Chuyên ngành";
            }

            if (tutorSchool) {
                tutorSchool.textContent = "Trường học";
            }

            if (tutorPhone) {
                tutorPhone.textContent = "SĐT";
            }

            if (tutorEmail) {
                tutorEmail.textContent = "Email";
            }

            return;
        }

        const name = selectedOption.dataset.name || "Chưa cập nhật";
        const phone = selectedOption.dataset.phone || "Chưa cập nhật";
        const email = selectedOption.dataset.email || "Chưa cập nhật";
        const major = selectedOption.dataset.major || "Chưa cập nhật";
        const school = selectedOption.dataset.school || "Chưa cập nhật";
        const avatar = selectedOption.dataset.avatar || "";

        if (tutorAvatar) {
            tutorAvatar.src = resolveAvatarUrl(avatar);
            tutorAvatar.onerror = function () {
                this.onerror = null;
                this.src = getDefaultAvatar();
            };
        }

        if (tutorName) {
            tutorName.textContent = name;
        }

        if (tutorMajor) {
            tutorMajor.textContent = major;
        }

        if (tutorSchool) {
            tutorSchool.textContent = school;
        }

        if (tutorPhone) {
            tutorPhone.textContent = phone;
        }

        if (tutorEmail) {
            tutorEmail.textContent = email;
        }

        selectedTutorCard.classList.remove("hidden");
    }

    function validateCreateClassForm() {
        const form = document.querySelector("form.create-form");

        if (!form) {
            return;
        }

        form.addEventListener("submit", function (event) {
            const className = form.querySelector('input[name="className"]');
            const subject = form.querySelector('select[name="subject"]');
            const grade = form.querySelector('select[name="grade"]');
            const tuitionFee = form.querySelector('input[name="tuitionFeePerSession"]');
            const requiredSessions = form.querySelector('input[name="requiredSessionsPerMonth"]');
            const tutorSelect = form.querySelector('select[name="tutorId"]');

            if (className && className.value.trim() === "") {
                event.preventDefault();
                alert("Vui lòng nhập tên lớp học.");
                className.focus();
                return;
            }

            if (subject && subject.value.trim() === "") {
                event.preventDefault();
                alert("Vui lòng chọn môn học.");
                subject.focus();
                return;
            }

            if (grade && grade.value.trim() === "") {
                event.preventDefault();
                alert("Vui lòng chọn khối / trình độ.");
                grade.focus();
                return;
            }

            if (tuitionFee && Number(tuitionFee.value) < 0) {
                event.preventDefault();
                alert("Học phí không được nhỏ hơn 0.");
                tuitionFee.focus();
                return;
            }

            if (requiredSessions && Number(requiredSessions.value) <= 0) {
                event.preventDefault();
                alert("Số buổi học yêu cầu phải lớn hơn 0.");
                requiredSessions.focus();
                return;
            }

            if (tutorSelect && tutorSelect.value.trim() === "") {
                event.preventDefault();
                alert("Vui lòng chọn gia sư phụ trách.");
                tutorSelect.focus();
            }
        });
    }

    function setupStudentFilterButton() {
        const filterButton = document.querySelector(".student-tools .filter-btn");

        if (!filterButton) {
            return;
        }

        filterButton.addEventListener("click", function () {
            filterStudents();
        });
    }

    document.addEventListener("DOMContentLoaded", function () {
        setupCheckAllStudents();
        setupStudentFilterButton();
        validateCreateClassForm();
        showTutorInfo();
    });

    /*
        Các hàm này phải đưa ra window vì JSP đang gọi inline:
        onkeyup="filterStudents()"
        onchange="showTutorInfo()"
    */
    window.filterStudents = filterStudents;
    window.showTutorInfo = showTutorInfo;
})();