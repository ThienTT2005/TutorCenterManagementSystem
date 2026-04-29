# Báo Cáo Tính Đồng Bộ API (Frontend & Backend)

Tài liệu này liệt kê tất cả các API bị lệch (chỉ tồn tại ở Frontend hoặc chỉ tồn tại ở Backend) trong dự án. Các API này **chưa được sửa đổi code** nhằm đảm bảo không phá vỡ cấu trúc hiện tại của dự án theo đúng yêu cầu.

---

## 1. Frontend gọi API nhưng Backend KHÔNG CÓ endpoint tương ứng
*(Frontend đang cố gọi các đường dẫn dạng `/api/...` bằng `fetch` hoặc `$.ajax`, nhưng Backend chưa có `@RestController` hay phương thức nào xử lý các đường dẫn này)*

| Frontend API Path | HTTP Method | Chức năng (Dự đoán từ UI) |
| :--- | :--- | :--- |
| `/api/admin/users/parents` | GET | Lấy danh sách phụ huynh để chọn khi tạo tài khoản học sinh |
| `/api/admin/users/exists/{username}` | GET | Kiểm tra trùng lặp tên đăng nhập |
| `/api/admin/users/exists-email?email=...` | GET | Kiểm tra trùng lặp email |
| `/api/admin/users/exists-phone?phone=...` | GET | Kiểm tra trùng lặp số điện thoại |
| `/api/admin/users/upload-avatar` | POST | Upload ảnh đại diện qua AJAX |
| `/api/admin/users/{userId}` | GET / PUT | Lấy chi tiết / cập nhật nhanh người dùng |
| `/api/admin/users/{userId}/update-password` | PUT / POST | Đổi mật khẩu cho một user cụ thể |
| `/api/admin/users/{userId}/lock` | PUT | Khóa tài khoản người dùng |
| `/api/admin/users/{userId}/unlock` | PUT | Mở khóa tài khoản người dùng |
| `/api/admin/classes/{classId}/schedule` | GET / POST | Thêm / Xem lịch học định kỳ (thứ mấy, giờ nào) |
| `/api/admin/classes/{classId}/schedule/{scheduleId}`| PUT / DELETE | Sửa / Xóa lịch học định kỳ |
| `/api/admin/classes/{classId}` | PUT | Cập nhật thông tin lớp học (AJAX) |
| `/api/admin/classes/{classId}/students` | GET / POST | Thêm học sinh vào lớp bằng danh sách ID |
| `/api/admin/classes/{classId}/students/{studentId}` | DELETE | Xóa một học sinh khỏi lớp học |
| `/api/admin/profile/change-password` | POST | Admin tự đổi mật khẩu cá nhân |
| `/api/auth/change-password` | POST | User tự đổi mật khẩu cá nhân |
| `/api/auth/me` | GET | Lấy thông tin user đang đăng nhập hiện tại |
| `/api/tutor/attendance/scan` | POST | Điểm danh / Quét mã QR điểm danh |

---

## 2. Backend CÓ endpoint nhưng Frontend KHÔNG GỌI bằng AJAX/Fetch
*(Backend xử lý các logic này thông qua Form submit truyền thống trực tiếp từ HTML form hoặc thẻ `<a>`, thay vì dùng Javascript AJAX `fetch` ở frontend)*

| Backend MVC Endpoint | HTTP Method | Chức năng |
| :--- | :--- | :--- |
| `/login` | POST | Đăng nhập hệ thống (Form Submit chuẩn của Spring Security) |
| `/admin/users` | GET | Trả về View danh sách người dùng (`account_list.jsp`) |
| `/admin/users/{userId}/profile/tutor` | POST | Lưu form cập nhật thông tin Gia sư |
| `/admin/users/{userId}/profile/parent` | POST | Lưu form cập nhật thông tin Phụ huynh |
| `/admin/users/{userId}/profile/student`| POST | Lưu form cập nhật thông tin Học sinh |
| `/admin/classes/{classId}/schedules/create` | POST | Form tạo lịch học lớp (MVC form flow) |
| `/payment/create` | POST | Form tạo hóa đơn / yêu cầu thanh toán |
| `/payment/upload-proof` | POST | Form tải lên minh chứng thanh toán |
| `/payment/tutor-confirm` | POST | Gia sư xác nhận đã nhận lương |
| `/payment/admin-approve` | POST | Admin duyệt chứng từ |
| `/payment/admin-reject` | POST | Admin từ chối chứng từ |
| `/notifications/{id}/read` | POST / GET | Đánh dấu 1 thông báo là đã đọc (Redirect) |
| `/notifications/read-all` | POST / GET | Đánh dấu tất cả thông báo là đã đọc (Redirect) |
| `/tutor/homework/...` | POST | Quản lý bài tập về nhà của gia sư |
| `/student/homework/...` | POST | Học sinh nộp bài tập |

> **Khuyến nghị:** Nếu trong tương lai dự án muốn chuyển đổi hoàn toàn sang mô hình Client-Server (như React/Vue/Angular), bạn sẽ cần viết thêm các `@RestController` cho các API ở mục 1, và chuyển đổi các Controller ở mục 2 sang trả về JSON thay vì View HTML.
