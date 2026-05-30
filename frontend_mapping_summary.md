# Bảng tra cứu Controller → Frontend JSP (Đã cập nhật)

> **Cập nhật:** 2026-05-05. Đã kiểm tra toàn bộ backend controllers, sửa đường dẫn sai, và tạo JSP còn thiếu.

---

## AdminAbsenceController.java
**Base Route:** `/admin/absence`

| HTTP Method | Route | JSP trả về | Trạng thái |
| :--- | :--- | :--- | :---: |
| GET | `/admin/absence/pending` | `admin/absence/pending.jsp` | ✅ |
| POST | `/admin/absence/approve` | *(Redirect → /admin/absence/pending)* | — |
| POST | `/admin/absence/reject` | *(Redirect → /admin/absence/pending)* | — |

---

## ParentAbsenceController.java
**Base Route:** `/parent/absence`

| HTTP Method | Route | JSP trả về | Trạng thái |
| :--- | :--- | :--- | :---: |
| GET | `/parent/absence/create` | `parent/absence/create.jsp` | ✅ |
| POST | `/parent/absence/create` | *(Redirect → /parent/absence/list)* | ✅ |
| GET | `/parent/absence/list` | `parent/absence/list.jsp` | ✅ |

---

## AttendanceController.java
**Base Route:** `/tutor/sessions`

| HTTP Method | Route | JSP trả về | Trạng thái |
| :--- | :--- | :--- | :---: |
| GET | `/tutor/sessions/{sessionId}/attendance` | `tutor/attendance/form.jsp` | ✅ |
| POST | `/tutor/sessions/{sessionId}/attendance/checkin` | *(Redirect)* hoặc `tutor/attendance/form.jsp` | ✅ |
| POST | `/tutor/sessions/{sessionId}/attendance/checkout` | *(Redirect)* hoặc `tutor/attendance/form.jsp` | ✅ |

---

## AuthController.java

| HTTP Method | Route | JSP trả về | Trạng thái |
| :--- | :--- | :--- | :---: |
| GET | `/login` | `auth/login.jsp` | ✅ |
| POST | `/login` | *(Redirect → dashboard)* hoặc `auth/login.jsp` | ✅ |
| GET | `/logout` | *(Redirect → /login)* | — |

---

## ChangePasswordController.java
**Base Route:** `/change-password`

| HTTP Method | Route | JSP trả về | Trạng thái |
| :--- | :--- | :--- | :---: |
| GET | `/change-password` | `auth/change-password.jsp` | ✅ |
| POST | `/change-password` | `auth/change-password.jsp` | ✅ |

---

## ClassController.java
**Base Route:** `/admin/classes`

| HTTP Method | Route | JSP trả về | Trạng thái |
| :--- | :--- | :--- | :---: |
| GET | `/admin/classes` | `admin/classes/list.jsp` | ✅ |
| GET | `/admin/classes/create` | `admin/classes/create.jsp` | ✅ |
| POST | `/admin/classes/create` | *(Redirect)* hoặc `admin/classes/create.jsp` | ✅ |
| GET | `/admin/classes/{classId}` | `admin/classes/detail.jsp` | ✅ |
| GET | `/admin/classes/{classId}/edit` | `admin/classes/class_update.jsp` | ✅ 🔧 |
| POST | `/admin/classes/{classId}/edit` | *(Redirect)* hoặc `admin/classes/class_update.jsp` | ✅ 🔧 |
| POST | `/admin/classes/{classId}/delete` | *(Redirect → /admin/classes)* | — |

> 🔧 Controller đã sửa từ `admin/classes/edit` → `admin/classes/class_update`

---

## DashboardController.java

| HTTP Method | Route | JSP trả về | Trạng thái |
| :--- | :--- | :--- | :---: |
| GET | `/admin/dashboard` | `admin/dashboard.jsp` | ✅ |
| GET | `/tutor/dashboard` | `tutor/dashboard.jsp` | ✅ |
| GET | `/parent/dashboard` | `parent/dashboard.jsp` | ✅ |
| GET | `/student/dashboard` | `student/dashboard.jsp` | ✅ |

---

## AdminFeedbackController.java
**Base Route:** `/admin/feedback`

| HTTP Method | Route | JSP trả về | Trạng thái |
| :--- | :--- | :--- | :---: |
| GET | `/admin/feedback/pending` | `admin/feedback/pending.jsp` | ✅ |
| POST | `/admin/feedback/{feedbackId}/approve` | *(Redirect)* | — |
| POST | `/admin/feedback/{feedbackId}/reject` | *(Redirect)* | — |

---

## TutorFeedbackController.java
**Base Route:** `/tutor/sessions`

| HTTP Method | Route | JSP trả về | Trạng thái |
| :--- | :--- | :--- | :---: |
| GET | `/tutor/sessions/{sessionId}/feedback` | `tutor/feedback/form.jsp` | ✅ |
| POST | `/tutor/sessions/{sessionId}/feedback` | *(Redirect)* hoặc `tutor/feedback/form.jsp` | ✅ |

---

## StudentHomeworkController.java
**Base Route:** `/student/homework`

| HTTP Method | Route | JSP trả về | Trạng thái |
| :--- | :--- | :--- | :---: |
| GET | `/student/homework` | `student/homework/list.jsp` | ✅ |
| GET | `/student/homework/session/{sessionId}` | `student/homework/list.jsp` | ✅ |
| GET | `/student/homework/detail/{id}` | `student/homework/detail.jsp` | ✅ |
| POST | `/student/homework/submit` | *(Redirect)* hoặc `student/homework/detail.jsp` | ✅ |

---

## TutorHomeworkController.java
**Base Route:** `/tutor/homework`

| HTTP Method | Route | JSP trả về | Trạng thái |
| :--- | :--- | :--- | :---: |
| GET | `/tutor/homework/session/{sessionId}` | `tutor/homework/list.jsp` | ✅ |
| GET | `/tutor/homework/create` | `tutor/homework/create.jsp` | ✅ |
| POST | `/tutor/homework/create` | *(Redirect)* hoặc `tutor/homework/create.jsp` | ✅ |
| GET | `/tutor/homework/{homeworkId}/edit` | `tutor/homework/edit.jsp` | ✅ 🆕 |
| POST | `/tutor/homework/{homeworkId}/edit` | *(Redirect)* hoặc `tutor/homework/edit.jsp` | ✅ 🆕 |
| POST | `/tutor/homework/{homeworkId}/delete` | *(Redirect)* | — |

> 🆕 JSP `tutor/homework/edit.jsp` đã được tạo mới

---

## TutorHomeworkSubmissionController.java
**Base Route:** `/tutor/homework/submissions`

| HTTP Method | Route | JSP trả về | Trạng thái |
| :--- | :--- | :--- | :---: |
| GET | `/tutor/homework/submissions/homework/{homeworkId}` | `tutor/homework/submissions.jsp` | ✅ |
| GET | `/tutor/homework/submissions/{submissionId}` | `tutor/homework/submission-detail.jsp` | ✅ |
| POST | `/tutor/homework/submissions/grade` | *(Redirect)* | — |

---

## LearningPlanController.java
**Base Route:** `/tutor/sessions`

| HTTP Method | Route | JSP trả về | Trạng thái |
| :--- | :--- | :--- | :---: |
| GET | `/tutor/sessions/{sessionId}/learning-plan` | `tutor/learningplans/form.jsp` | ✅ |
| POST | `/tutor/sessions/{sessionId}/learning-plan` | *(Redirect)* hoặc `tutor/learningplans/form.jsp` | ✅ |

---

## NotificationController.java
**Base Route:** `/notifications`

| HTTP Method | Route | JSP trả về | Trạng thái |
| :--- | :--- | :--- | :---: |
| GET | `/notifications` | `notifications/list.jsp` | ✅ |
| POST | `/notifications/{notificationId}/read` | *(Redirect)* | — |
| POST | `/notifications/read-all` | *(Redirect)* | — |

---

## ParentClassController.java
**Base Route:** `/parent/classes`

| HTTP Method | Route | JSP trả về | Trạng thái |
| :--- | :--- | :--- | :---: |
| GET | `/parent/classes` | `parent/classes/list.jsp` | ✅ |
| GET | `/parent/classes/{studentId}/{classId}` | `parent/classes/detail.jsp` | ✅ |

---

## PaymentController.java
**Base Route:** `/payment`

| HTTP Method | Route | JSP trả về | Trạng thái |
| :--- | :--- | :--- | :---: |
| POST | `/payment/create` | *(Redirect → /payment/tutor)* | — |
| POST | `/payment/upload-proof` | *(Redirect → /payment/parent)* | — |
| POST | `/payment/tutor-confirm` | *(Redirect → /payment/tutor)* | — |
| POST | `/payment/admin-approve` | *(Redirect → /payment/admin)* | — |
| POST | `/payment/admin-reject` | *(Redirect → /payment/admin)* | — |
| GET | `/payment/tutor` | `tutor/payments.jsp` | ✅ |
| GET | `/payment/parent` | `parent/payments.jsp` | ✅ |
| GET | `/payment/admin` | `admin/payments/payments_list.jsp` | ✅ |

---

## ProfileController.java
**Base Route:** `/profile`

| HTTP Method | Route | JSP trả về | Trạng thái |
| :--- | :--- | :--- | :---: |
| GET | `/profile` | `profile/view.jsp` | ✅ |
| POST | `/profile/update` | *(Redirect)* hoặc `profile/view.jsp` | ✅ |
| POST | `/profile/avatar` | *(Redirect)* hoặc `profile/view.jsp` | ✅ |

---

## ReportController.java
**Base Route:** `/admin/reports`

| HTTP Method | Route | JSP trả về | Trạng thái |
| :--- | :--- | :--- | :---: |
| GET | `/admin/reports` | `admin/reports/dashboard.jsp` | ✅ 🆕 |

> 🆕 JSP `admin/reports/dashboard.jsp` đã được tạo mới

---

## ScheduleController.java
**Base Route:** `/admin/classes/{classId}/schedules`

| HTTP Method | Route | JSP trả về | Trạng thái |
| :--- | :--- | :--- | :---: |
| GET | `/admin/classes/{classId}/schedules/create` | `admin/schedules/create.jsp` | ✅ |
| POST | `/admin/classes/{classId}/schedules/create` | *(Redirect)* hoặc `admin/schedules/create.jsp` | ✅ |

---

## SessionController.java
**Base Route:** `/admin/classes/{classId}/sessions`

| HTTP Method | Route | JSP trả về | Trạng thái |
| :--- | :--- | :--- | :---: |
| GET | `/admin/classes/{classId}/sessions/generate` | `admin/sessions/generate.jsp` | ✅ |
| POST | `/admin/classes/{classId}/sessions/generate` | *(Redirect)* hoặc `admin/sessions/generate.jsp` | ✅ |

---

## StudentClassController.java
**Base Route:** `/student/classes`

| HTTP Method | Route | JSP trả về | Trạng thái |
| :--- | :--- | :--- | :---: |
| GET | `/student/classes` | `student/classes/list.jsp` | ✅ |
| GET | `/student/classes/{classId}` | `student/classes/detail.jsp` | ✅ |

---

## StudentSessionController.java
**Base Route:** `/student/sessions`

| HTTP Method | Route | JSP trả về | Trạng thái |
| :--- | :--- | :--- | :---: |
| GET | `/student/sessions/{sessionId}/learning-plan` | `student/learningplans/detail.jsp` | ✅ |
| GET | `/student/sessions/{sessionId}/feedback` | `student/feedback/detail.jsp` | ✅ |

---

## TutorClassController.java
**Base Route:** `/tutor/classes`

| HTTP Method | Route | JSP trả về | Trạng thái |
| :--- | :--- | :--- | :---: |
| GET | `/tutor/classes` | `tutor/classes/list.jsp` | ✅ |
| GET | `/tutor/classes/{classId}` | `tutor/classes/detail.jsp` | ✅ |

---

## AdminUserController.java
**Base Route:** `/admin/users`

| HTTP Method | Route | JSP trả về | Trạng thái |
| :--- | :--- | :--- | :---: |
| GET | `/admin/users` | `admin/users/list.jsp` | ✅ 🔧 |
| GET | `/admin/users/create` | `admin/users/create-account.jsp` | ✅ |
| POST | `/admin/users/create` | *(Redirect theo role)* | — |
| GET | `/admin/users/{userId}` | `admin/users/detail.jsp` | ✅ 🔧 |
| GET | `/admin/users/{userId}/edit-profile` | `admin/users/edit-profile.jsp` | ✅ 🔧🆕 |
| POST | `/admin/users/{userId}/edit-profile` | *(Redirect)* hoặc `admin/users/edit-profile.jsp` | ✅ 🆕 |
| GET | `/admin/users/{userId}/profile/tutor` | `admin/users/create-tutor-profile.jsp` | ✅ |
| POST | `/admin/users/{userId}/profile/tutor` | *(Redirect)* | ✅ |
| GET | `/admin/users/{userId}/profile/parent` | `admin/users/create-parent-profile.jsp` | ✅ |
| POST | `/admin/users/{userId}/profile/parent` | *(Redirect)* | ✅ |
| GET | `/admin/users/{userId}/profile/student` | `admin/users/create-student-profile.jsp` | ✅ |
| POST | `/admin/users/{userId}/profile/student` | *(Redirect)* | ✅ |
| GET | `/admin/users/parents` | `admin/parents/parent_list.jsp` | ✅ |
| GET | `/admin/users/students` | `admin/students/students_list.jsp` | ✅ |
| GET | `/admin/users/tutors` | `admin/tutors/tutor_list.jsp` | ✅ |

> 🔧 Controller đã sửa: `admin/accounts/account_list` → `admin/users/list`, `admin/accounts/account_detail` → `admin/users/detail`, `admin/accounts/account_edit` → `admin/users/edit-profile`
>
> 🆕 JSP `admin/users/edit-profile.jsp` đã được tạo mới

---

## Tổng kết thay đổi

### Controller đã sửa đường dẫn (3 file)

| Controller | Return cũ (sai) | Return mới (đúng) |
| :--- | :--- | :--- |
| AdminUserController | `admin/accounts/account_list` | `admin/users/list` |
| AdminUserController | `admin/accounts/account_detail` | `admin/users/detail` |
| AdminUserController | `admin/accounts/account_edit` | `admin/users/edit-profile` |
| ClassController | `admin/classes/edit` | `admin/classes/class_update` |

### JSP đã tạo mới (3 file)

| File | Mô tả |
| :--- | :--- |
| `admin/users/edit-profile.jsp` | Form chỉnh sửa hồ sơ người dùng (Admin) |
| `admin/reports/dashboard.jsp` | Trang báo cáo & thống kê (Admin) |
| `tutor/homework/edit.jsp` | Form chỉnh sửa bài tập (Tutor) |

### JSP tồn tại nhưng không có controller gọi

| File | Ghi chú |
| :--- | :--- |
| `admin/payments.jsp` | Đã thay bằng `admin/payments/payments_list.jsp` |
| `admin/payments/payemts_detail.jsp` | Không controller nào trả về (có typo) |
| `admin/profile/profile.jsp` | Không controller nào trả về |
| `admin/profile/change_password.jsp` | Không controller nào trả về |
| `admin/classes/class_update.jsp` | Đã được ClassController sử dụng (sau khi sửa) |
