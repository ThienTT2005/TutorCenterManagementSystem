# Bảng tra cứu Controller và Frontend JSPs

Dưới đây là danh sách tất cả các Controller, đường dẫn (Route) và file giao diện `.jsp` tương ứng mà hệ thống yêu cầu.

## AdminAbsenceController.java
**Base Route:** `/admin/absence` 

| HTTP Method | Route | Tên file JSP trả về (thư mục: WEB-INF/views/) |
| :--- | :--- | :--- |
| GET | `/admin/absence/pending` | `admin/absence/pending.jsp` |
| POST | `/admin/absence/approve` | *(Xử lý Logic/Redirect)* |
| POST | `/admin/absence/reject` | *(Xử lý Logic/Redirect)* |

## ParentAbsenceController.java
**Base Route:** `/parent/absence` 

| HTTP Method | Route | Tên file JSP trả về (thư mục: WEB-INF/views/) |
| :--- | :--- | :--- |
| GET | `/parent/absence/create` | `parent/absence/create.jsp` |
| POST | `/parent/absence/create` | `parent/absence/create.jsp` |
| GET | `/parent/absence/list` | `parent/absence/list.jsp` |

## AttendanceController.java
**Base Route:** `/tutor/sessions` 

| HTTP Method | Route | Tên file JSP trả về (thư mục: WEB-INF/views/) |
| :--- | :--- | :--- |
| GET | `/tutor/sessions/{sessionId}/attendance` | `tutor/attendance/form.jsp` |
| POST | `/tutor/sessions/{sessionId}/attendance/checkin` | `tutor/attendance/form.jsp` |
| POST | `/tutor/sessions/{sessionId}/attendance/checkout` | `tutor/attendance/form.jsp` |

## AuthController.java
**Base Route:** `` 

| HTTP Method | Route | Tên file JSP trả về (thư mục: WEB-INF/views/) |
| :--- | :--- | :--- |
| GET | `/login` | `auth/login.jsp` |
| POST | `/login` | `auth/login.jsp` |
| GET | `/logout` | *(Xử lý Logic/Redirect)* |

## ChangePasswordController.java
**Base Route:** `/change-password` 

| HTTP Method | Route | Tên file JSP trả về (thư mục: WEB-INF/views/) |
| :--- | :--- | :--- |
| GET | `/change-password` | `auth/change-password.jsp` |
| POST | `/change-password` | `auth/change-password.jsp` |

## ClassController.java
**Base Route:** `/admin/classes` 

| HTTP Method | Route | Tên file JSP trả về (thư mục: WEB-INF/views/) |
| :--- | :--- | :--- |
| GET | `/admin/classes` | `admin/classes/list.jsp` |
| GET | `/admin/classes/create` | `admin/classes/create.jsp` |
| POST | `/admin/classes/create` | `admin/classes/create.jsp` |
| GET | `/admin/classes/{classId}` | `admin/classes/detail.jsp` |

## DashboardController.java
**Base Route:** `` 

| HTTP Method | Route | Tên file JSP trả về (thư mục: WEB-INF/views/) |
| :--- | :--- | :--- |
| GET | `/admin/dashboard` | `admin/dashboard.jsp` |
| GET | `/tutor/dashboard` | `tutor/dashboard.jsp` |
| GET | `/parent/dashboard` | `parent/dashboard.jsp` |
| GET | `/student/dashboard` | `student/dashboard.jsp` |

## AdminFeedbackController.java
**Base Route:** `/admin/feedback` 

| HTTP Method | Route | Tên file JSP trả về (thư mục: WEB-INF/views/) |
| :--- | :--- | :--- |
| GET | `/admin/feedback/pending` | `admin/feedback/pending.jsp` |
| POST | `/admin/feedback/{feedbackId}/approve` | *(Xử lý Logic/Redirect)* |
| POST | `/admin/feedback/{feedbackId}/reject` | *(Xử lý Logic/Redirect)* |

## TutorFeedbackController.java
**Base Route:** `/tutor/sessions` 

| HTTP Method | Route | Tên file JSP trả về (thư mục: WEB-INF/views/) |
| :--- | :--- | :--- |
| GET | `/tutor/sessions/{sessionId}/feedback` | `tutor/feedback/form.jsp` |
| POST | `/tutor/sessions/{sessionId}/feedback` | `tutor/feedback/form.jsp` |

## StudentHomeworkController.java
**Base Route:** `/student/homework` 

| HTTP Method | Route | Tên file JSP trả về (thư mục: WEB-INF/views/) |
| :--- | :--- | :--- |
| GET | `/student/homework` | `student/homework/list.jsp` |
| GET | `/student/homework/session/{sessionId}` | `student/homework/list.jsp` |
| GET | `/student/homework/detail/{id}` | `student/homework/detail.jsp` |
| POST | `/student/homework/submit` | `student/homework/detail.jsp` |

## TutorHomeworkController.java
**Base Route:** `/tutor/homework` 

| HTTP Method | Route | Tên file JSP trả về (thư mục: WEB-INF/views/) |
| :--- | :--- | :--- |
| GET | `/tutor/homework/create` | `tutor/homework/create.jsp` |
| POST | `/tutor/homework/create` | `tutor/homework/create.jsp` |
| GET | `/tutor/homework/session/{sessionId}` | `tutor/homework/list.jsp` |

## TutorHomeworkSubmissionController.java
**Base Route:** `/tutor/homework/submissions` 

| HTTP Method | Route | Tên file JSP trả về (thư mục: WEB-INF/views/) |
| :--- | :--- | :--- |
| GET | `/tutor/homework/submissions/homework/{homeworkId}` | `tutor/homework/submissions.jsp` |
| GET | `/tutor/homework/submissions/{submissionId}` | `tutor/homework/submission-detail.jsp` |
| POST | `/tutor/homework/submissions/grade` | *(Xử lý Logic/Redirect)* |

## LearningPlanController.java
**Base Route:** `/tutor/sessions` 

| HTTP Method | Route | Tên file JSP trả về (thư mục: WEB-INF/views/) |
| :--- | :--- | :--- |
| GET | `/tutor/sessions/{sessionId}/learning-plan` | `tutor/learningplans/form.jsp` |
| POST | `/tutor/sessions/{sessionId}/learning-plan` | `tutor/learningplans/form.jsp` |

## NotificationController.java
**Base Route:** `/notifications` 

| HTTP Method | Route | Tên file JSP trả về (thư mục: WEB-INF/views/) |
| :--- | :--- | :--- |
| GET | `/notifications` | `notifications/list.jsp` |
| POST | `/notifications/{notificationId}/read` | *(Xử lý Logic/Redirect)* |
| POST | `/notifications/read-all` | *(Xử lý Logic/Redirect)* |

## ParentClassController.java
**Base Route:** `/parent/classes` 

| HTTP Method | Route | Tên file JSP trả về (thư mục: WEB-INF/views/) |
| :--- | :--- | :--- |
| GET | `/parent/classes` | `parent/classes/list.jsp` |
| GET | `/parent/classes/{studentId}/{classId}` | `parent/classes/detail.jsp` |

## PaymentController.java
**Base Route:** `/payment` 

| HTTP Method | Route | Tên file JSP trả về (thư mục: WEB-INF/views/) |
| :--- | :--- | :--- |
| POST | `/payment/create` | *(Xử lý Logic/Redirect)* |
| POST | `/payment/upload-proof` | *(Xử lý Logic/Redirect)* |
| POST | `/payment/tutor-confirm` | *(Xử lý Logic/Redirect)* |
| POST | `/payment/admin-approve` | *(Xử lý Logic/Redirect)* |
| POST | `/payment/admin-reject` | *(Xử lý Logic/Redirect)* |
| GET | `/payment/tutor` | `tutor/payments.jsp` |
| GET | `/payment/parent` | `parent/payments.jsp` |
| GET | `/payment/admin` | `admin/payments.jsp` |

## ProfileController.java
**Base Route:** `/profile` 

| HTTP Method | Route | Tên file JSP trả về (thư mục: WEB-INF/views/) |
| :--- | :--- | :--- |
| GET | `/profile` | `profile/view.jsp` |
| POST | `/profile/update` | *(Xử lý Logic/Redirect)* |
| POST | `/profile/avatar` | *(Xử lý Logic/Redirect)* |

## ScheduleController.java
**Base Route:** `/admin/classes/{classId}/schedules` 

| HTTP Method | Route | Tên file JSP trả về (thư mục: WEB-INF/views/) |
| :--- | :--- | :--- |
| GET | `/admin/classes/{classId}/schedules/create` | `admin/schedules/create.jsp` |
| POST | `/admin/classes/{classId}/schedules/create` | `admin/schedules/create.jsp` |

## SessionController.java
**Base Route:** `/admin/classes/{classId}/sessions` 

| HTTP Method | Route | Tên file JSP trả về (thư mục: WEB-INF/views/) |
| :--- | :--- | :--- |
| GET | `/admin/classes/{classId}/sessions/generate` | `admin/sessions/generate.jsp` |
| POST | `/admin/classes/{classId}/sessions/generate` | `admin/sessions/generate.jsp` |

## StudentClassController.java
**Base Route:** `/student/classes` 

| HTTP Method | Route | Tên file JSP trả về (thư mục: WEB-INF/views/) |
| :--- | :--- | :--- |
| GET | `/student/classes` | `student/classes/list.jsp` |
| GET | `/student/classes/{classId}` | `student/classes/detail.jsp` |

## StudentSessionController.java
**Base Route:** `/student/sessions` 

| HTTP Method | Route | Tên file JSP trả về (thư mục: WEB-INF/views/) |
| :--- | :--- | :--- |
| GET | `/student/sessions/{sessionId}/learning-plan` | `student/learningplans/detail.jsp` |
| GET | `/student/sessions/{sessionId}/feedback` | `student/feedback/detail.jsp` |

## TutorClassController.java
**Base Route:** `/tutor/classes` 

| HTTP Method | Route | Tên file JSP trả về (thư mục: WEB-INF/views/) |
| :--- | :--- | :--- |
| GET | `/tutor/classes` | `tutor/classes/list.jsp` |
| GET | `/tutor/classes/{classId}` | `tutor/classes/detail.jsp` |

## AdminUserController.java
**Base Route:** `/admin/users` 

| HTTP Method | Route | Tên file JSP trả về (thư mục: WEB-INF/views/) |
| :--- | :--- | :--- |
| GET | `/admin/users` | `admin/users/list.jsp` |
| GET | `/admin/users/create` | `admin/users/create-account.jsp` |
| POST | `/admin/users/create` | `admin/users/create-account.jsp` |
| GET | `/admin/users/{userId}/profile/tutor` | `admin/users/create-tutor-profile.jsp` |
| POST | `/admin/users/{userId}/profile/tutor` | `admin/users/create-tutor-profile.jsp` |
| GET | `/admin/users/{userId}/profile/parent` | `admin/users/create-parent-profile.jsp` |
| POST | `/admin/users/{userId}/profile/parent` | `admin/users/create-parent-profile.jsp` |
| GET | `/admin/users/{userId}/profile/student` | `admin/users/create-student-profile.jsp` |
| GET | `/admin/users/{userId}/profile/student` | `admin/users/create-student-profile.jsp` |
| POST | `/admin/users/{userId}/profile/student` | `admin/users/create-student-profile.jsp` |

