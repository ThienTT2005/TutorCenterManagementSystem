# TCMS - Backend API Documentation

Tài liệu này tổng hợp đầy đủ các API và Endpoint hiện có trong hệ thống Quản lý Trung tâm Gia sư (TCMS) sau khi đã được tái cấu trúc.

## 1. Hệ thống Xác thực (Authentication)
**Controller:** `AuthController`
**Cơ chế:** Manual Session (HttpSession)

| Phương thức | Endpoint | Tham số | Tác dụng |
| :--- | :--- | :--- | :--- |
| `GET` | `/login` | Không | Hiển thị giao diện đăng nhập (`auth/login.jsp`). |
| `POST` | `/login` | `LoginRequest` | Kiểm tra tài khoản, lưu `currentUser` và `role` vào Session. Điều hướng người dùng về Dashboard tương ứng. |
| `GET` | `/logout` | Không | Hủy (invalidate) Session hiện tại và chuyển hướng về trang login. |

---

## 2. Quản trị Người dùng (Admin User Management)
**Controller:** `AdminUserController`
**Yêu cầu:** Quyền ADMIN (kiểm tra qua Session)

| Phương thức | Endpoint | Tham số | Tác dụng |
| :--- | :--- | :--- | :--- |
| `GET` | `/admin/users` | Không | Hiển thị danh sách toàn bộ người dùng trong hệ thống. |
| `GET` | `/admin/users/create` | Không | Hiển thị form tạo tài khoản đăng nhập cơ bản. |
| `POST` | `/admin/users/create` | `CreateAccountRequest` | Tạo User mới. Tùy vào Role được chọn sẽ điều hướng tiếp sang form tạo Profile (Gia sư/PH/HS). |
| `GET` | `/admin/users/{id}/profile/tutor` | `userId` | Hiển thị form nhập thông tin chuyên môn cho Gia sư. |
| `POST` | `/admin/users/{id}/profile/tutor` | `CreateTutorProfileRequest` | Lưu thông tin chi tiết Gia sư (Trường, chuyên ngành, bằng cấp...). |
| `GET` | `/admin/users/{id}/profile/parent` | `userId` | Hiển thị form nhập thông tin Phụ huynh. |
| `POST` | `/admin/users/{id}/profile/parent` | `CreateParentProfileRequest` | Lưu thông tin chi tiết Phụ huynh. |
| `GET` | `/admin/users/{id}/profile/student` | `userId` | Hiển thị form nhập thông tin Học sinh. |
| `POST` | `/admin/users/{id}/profile/student` | `CreateStudentProfileRequest` | Lưu thông tin chi tiết Học sinh và liên kết với Phụ huynh. |

---

## 3. Quản lý Lớp học (Class Management)
**Controller:** `ClassController`

| Phương thức | Endpoint | Tham số | Tác dụng |
| :--- | :--- | :--- | :--- |
| `GET` | `/admin/classes` | Không | Hiển thị danh sách tất cả các lớp học hiện có. |
| `GET` | `/admin/classes/create` | Không | Hiển thị form tạo lớp học (gồm chọn Gia sư, Học sinh và các thông tin cơ bản). |
| `POST` | `/admin/classes/create` | `CreateClassRequest` | Khởi tạo lớp học mới trong hệ thống. |
| `GET` | `/admin/classes/{classId}` | `classId` | Xem trang chi tiết lớp học: bao gồm danh sách học viên, lịch học và danh sách buổi học. |

---

## 4. Quản lý Lịch học & Buổi học
**Controllers:** `ScheduleController`, `SessionController`

| Phương thức | Endpoint | Tham số | Tác dụng |
| :--- | :--- | :--- | :--- |
| `GET` | `/admin/classes/{id}/schedules/create` | `classId` | Hiển thị form thêm lịch học định kỳ (ví dụ: Thứ 2, 18h-20h). |
| `POST` | `/admin/classes/{id}/schedules/create` | `CreateScheduleRequest` | Lưu lịch học cố định cho lớp. |
| `GET` | `/admin/classes/{id}/sessions/generate` | `classId` | Hiển thị form chọn khoảng thời gian để tạo buổi học cụ thể. |
| `POST` | `/admin/classes/{id}/sessions/generate` | `GenerateSessionsRequest` | Tự động tạo các bản ghi buổi học (Sessions) dựa trên lịch học cố định. |

---

## 5. Hệ thống Dashboard
**Controller:** `DashboardController`

| Phương thức | Endpoint | Tác dụng |
| :--- | :--- | :--- |
| `GET` | `/admin/dashboard` | Giao diện điều hướng chính cho Quản trị viên. |
| `GET` | `/tutor/dashboard` | Giao diện dành riêng cho Gia sư (xem lịch dạy, lớp dạy). |
| `GET` | `/parent/dashboard` | Giao diện dành cho Phụ huynh (theo dõi học tập của con). |
| `GET` | `/student/dashboard` | Giao diện dành cho Học sinh (xem lịch học, tài liệu). |

---
**Ghi chú:** Tất cả các Endpoint bắt đầu bằng `/admin` đều được kiểm tra quyền ADMIN thông qua `HttpSession`. Nếu chưa đăng nhập hoặc không đúng quyền, hệ thống sẽ tự động `redirect:/login`.
