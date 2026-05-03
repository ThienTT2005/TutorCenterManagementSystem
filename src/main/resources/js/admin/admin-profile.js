document.addEventListener("DOMContentLoaded", function () {
    const form = document.querySelector("form");

    if (!form) return;

    form.addEventListener("submit", function (e) {
        const fullName = document.querySelector("[name='fullName']")?.value.trim();
        const dob = document.querySelector("[name='dob']")?.value;
        const parentId = document.querySelector("[name='parentId']")?.value;

        if (!fullName) {
            e.preventDefault();
            alert("Vui lòng nhập họ tên.");
            return;
        }

        if (parentId !== undefined && parentId === "") {
            e.preventDefault();
            alert("Vui lòng chọn phụ huynh.");
            return;
        }

        if (dob) {
            const selectedDate = new Date(dob);
            const today = new Date();

            if (selectedDate >= today) {
                e.preventDefault();
                alert("Ngày sinh không hợp lệ.");
                return;
            }
        }

        console.log("Profile form hợp lệ, đang submit...");
    });
});