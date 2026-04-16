DROP DATABASE IF EXISTS TCMS;
CREATE DATABASE TCMS CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE TCMS;

-- 1. ROLES - Bảng vai trò
CREATE TABLE roles (
    role_id INT PRIMARY KEY AUTO_INCREMENT,
    role_name VARCHAR(50) UNIQUE NOT NULL
);

-- 2. PERMISSIONS - Bảng quyền hạn
CREATE TABLE permissions (
    permission_id INT PRIMARY KEY AUTO_INCREMENT,
    permission_name VARCHAR(100) UNIQUE NOT NULL
);

-- 3. ROLE_PERMISSIONS - Bảng phân quyền cho vai trò
CREATE TABLE role_permissions (
    role_id INT,
    permission_id INT,
    PRIMARY KEY (role_id, permission_id),
    FOREIGN KEY (role_id) REFERENCES roles(role_id) ON DELETE CASCADE,
    FOREIGN KEY (permission_id) REFERENCES permissions(permission_id) ON DELETE CASCADE
);

-- 4. USERS - Bảng người dùng
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role_id INT,
    status BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES roles(role_id),
    INDEX idx_users_role (role_id),
    INDEX idx_users_status (status),
    INDEX idx_users_username (username)
);

-- 5. USER_PERMISSIONS - Bảng ghi đè quyền cá nhân
CREATE TABLE user_permissions (
    user_id INT,
    permission_id INT,
    PRIMARY KEY (user_id, permission_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (permission_id) REFERENCES permissions(permission_id) ON DELETE CASCADE
);

-- 6. TUTORS - Bảng gia sư
CREATE TABLE tutors (
    tutor_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT UNIQUE,
    full_name VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    dob DATE,
    gender VARCHAR(10),
    address VARCHAR(255),
    avatar VARCHAR(255),
    school VARCHAR(255),
    major VARCHAR(255),
    description TEXT,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_tutors_phone (phone),
    INDEX idx_tutors_email (email)
);

-- 7. ACHIEVEMENTS - Bảng thành tích gia sư
CREATE TABLE achievements (
    achievement_id INT PRIMARY KEY AUTO_INCREMENT,
    tutor_id INT,
    description TEXT,
    evidence VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (tutor_id) REFERENCES tutors(tutor_id) ON DELETE CASCADE,
    INDEX idx_achievements_tutor (tutor_id)
);

-- 8. PARENTS - Bảng phụ huynh
CREATE TABLE parents (
    parent_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT UNIQUE,
    full_name VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    dob DATE,
    gender VARCHAR(10),
    address VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_parents_phone (phone),
    INDEX idx_parents_email (email)
);

-- 9. STUDENTS - Bảng học sinh
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT UNIQUE,
    parent_id INT,
    full_name VARCHAR(100),
    dob DATE,
    gender VARCHAR(10),
    address VARCHAR(255),
    school VARCHAR(255),
    grade VARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (parent_id) REFERENCES parents(parent_id) ON DELETE SET NULL,
    INDEX idx_students_parent (parent_id),
    INDEX idx_students_user (user_id)
);

-- 10. CLASSES - Bảng lớp học
CREATE TABLE classes (
    class_id INT PRIMARY KEY AUTO_INCREMENT,
    class_name VARCHAR(100),
    subject VARCHAR(100),
    grade VARCHAR(20),
    tutor_id INT,
    tuition_fee_per_session DECIMAL(10,2),
    required_sessions INT,
    description TEXT,
    status BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (tutor_id) REFERENCES tutors(tutor_id) ON DELETE SET NULL,
    INDEX idx_classes_tutor (tutor_id),
    INDEX idx_classes_status (status),
    INDEX idx_classes_subject (subject)
);

-- 11. ENROLLMENTS - Bảng đăng ký lớp
CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    class_id INT,
    student_id INT,
    enrolled_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (class_id) REFERENCES classes(class_id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    UNIQUE KEY uk_enrollment (class_id, student_id),
    INDEX idx_enrollments_class (class_id),
    INDEX idx_enrollments_student (student_id)
);

-- 12. TEACHING_SCHEDULES - Bảng lịch học định kỳ
CREATE TABLE teaching_schedules (
    schedule_id INT PRIMARY KEY AUTO_INCREMENT,
    class_id INT,
    weekday INT COMMENT '2=Monday, 3=Tuesday, 4=Wednesday, 5=Thursday, 6=Friday, 7=Saturday, 8=Sunday',
    start_time TIME,
    end_time TIME,
    FOREIGN KEY (class_id) REFERENCES classes(class_id) ON DELETE CASCADE,
    INDEX idx_schedules_class (class_id),
    INDEX idx_schedules_weekday (weekday)
);

-- 13. TEACHING_SESSIONS - Bảng buổi học cụ thể
CREATE TABLE teaching_sessions (
    session_id INT PRIMARY KEY AUTO_INCREMENT,
    class_id INT,
    session_date DATE,
    start_time TIME,
    end_time TIME,
    topic VARCHAR(255),
    status ENUM('PLANNED', 'ONGOING', 'COMPLETED', 'CANCELLED') DEFAULT 'PLANNED',
    qr_code VARCHAR(255) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (class_id) REFERENCES classes(class_id) ON DELETE CASCADE,
    INDEX idx_sessions_class_date (class_id, session_date),
    INDEX idx_sessions_status (status),
    INDEX idx_sessions_qr (qr_code),
    INDEX idx_sessions_date (session_date)
);

-- 14. ATTENDANCE - Bảng điểm danh
CREATE TABLE attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    session_id INT,
    student_id INT,
    checkin_time DATETIME,
    checkout_time DATETIME,
    status ENUM('ATTENDED', 'ABSENT_UNEXCUSED', 'ABSENT_EXCUSED') DEFAULT 'ABSENT_UNEXCUSED',
    absence_reason VARCHAR(500),
    is_valid BOOLEAN DEFAULT FALSE,
    note VARCHAR(500),
    FOREIGN KEY (session_id) REFERENCES teaching_sessions(session_id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    UNIQUE KEY uk_attendance (session_id, student_id),
    INDEX idx_attendance_session (session_id),
    INDEX idx_attendance_student (student_id),
    INDEX idx_attendance_status (status)
);

-- 15. LEARNING_PLANS - Bảng kế hoạch giảng dạy
CREATE TABLE learning_plans (
    plan_id INT PRIMARY KEY AUTO_INCREMENT,
    session_id INT,
    tutor_id INT,
    lesson_name VARCHAR(255),
    content TEXT,
    objectives VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (session_id) REFERENCES teaching_sessions(session_id) ON DELETE CASCADE,
    FOREIGN KEY (tutor_id) REFERENCES tutors(tutor_id) ON DELETE SET NULL,
    INDEX idx_plans_session (session_id),
    INDEX idx_plans_tutor (tutor_id)
);

-- 16. FEEDBACK - Bảng feedback sau buổi học
CREATE TABLE feedback (
    feedback_id INT PRIMARY KEY AUTO_INCREMENT,
    session_id INT,
    student_id INT,
    rating ENUM('Xuất sắc', 'Giỏi', 'Khá', 'Trung bình', 'Yếu'),
    comment TEXT,
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_late BOOLEAN DEFAULT FALSE,
    penalty_rate DECIMAL(5,2) DEFAULT 0,
    status ENUM('PENDING', 'APPROVED', 'REJECTED') DEFAULT 'PENDING',
    rejected_reason VARCHAR(500),
    FOREIGN KEY (session_id) REFERENCES teaching_sessions(session_id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    UNIQUE KEY uk_feedback (session_id, student_id),
    INDEX idx_feedback_session (session_id),
    INDEX idx_feedback_student (student_id),
    INDEX idx_feedback_status (status)
);

-- 17. HOMEWORK - Bảng bài tập về nhà
CREATE TABLE homework (
    homework_id INT PRIMARY KEY AUTO_INCREMENT,
    session_id INT,
    tutor_id INT,
    title VARCHAR(255),
    type ENUM('MULTIPLE_CHOICE', 'ESSAY') NOT NULL,
    content TEXT,
    attachment_url VARCHAR(255),
    deadline DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (session_id) REFERENCES teaching_sessions(session_id) ON DELETE CASCADE,
    FOREIGN KEY (tutor_id) REFERENCES tutors(tutor_id) ON DELETE SET NULL,
    INDEX idx_homework_session (session_id),
    INDEX idx_homework_tutor (tutor_id),
    INDEX idx_homework_deadline (deadline)
);

-- 18. HOMEWORK_QUESTIONS - Bảng câu hỏi trắc nghiệm
CREATE TABLE homework_questions (
    question_id INT PRIMARY KEY AUTO_INCREMENT,
    homework_id INT,
    question_text TEXT,
    option_a VARCHAR(500),
    option_b VARCHAR(500),
    option_c VARCHAR(500),
    option_d VARCHAR(500),
    correct_answer CHAR(1),
    FOREIGN KEY (homework_id) REFERENCES homework(homework_id) ON DELETE CASCADE,
    INDEX idx_questions_homework (homework_id)
);

-- 19. HOMEWORK_SUBMISSIONS - Bảng bài làm của học sinh
CREATE TABLE homework_submissions (
    submission_id INT PRIMARY KEY AUTO_INCREMENT,
    homework_id INT,
    student_id INT,
    answers TEXT,
    attachment_url VARCHAR(255),
    score DECIMAL(5,2),
    teacher_feedback VARCHAR(500),
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    graded_at DATETIME,
    status ENUM('SUBMITTED', 'GRADED') DEFAULT 'SUBMITTED',
    FOREIGN KEY (homework_id) REFERENCES homework(homework_id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    UNIQUE KEY uk_submission (homework_id, student_id),
    INDEX idx_submissions_homework (homework_id),
    INDEX idx_submissions_student (student_id),
    INDEX idx_submissions_status (status)
);

-- 20. PAYMENTS - Bảng thanh toán
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    tutor_id INT,
    class_id INT,
    student_id INT,
    session_ids TEXT,
    total_sessions INT,
    amount DECIMAL(10,2),
    request_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    proof_url VARCHAR(255),
    tutor_confirmed_at DATETIME,
    admin_approved_at DATETIME,
    status ENUM('PENDING', 'PROOF_UPLOADED', 'TUTOR_CONFIRMED', 'ADMIN_APPROVED', 'COMPLETED', 'REJECTED') DEFAULT 'PENDING',
    note VARCHAR(500),
    rejection_reason VARCHAR(500),
    FOREIGN KEY (tutor_id) REFERENCES tutors(tutor_id) ON DELETE SET NULL,
    FOREIGN KEY (class_id) REFERENCES classes(class_id) ON DELETE SET NULL,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE SET NULL,
    INDEX idx_payments_status (status),
    INDEX idx_payments_tutor (tutor_id),
    INDEX idx_payments_class (class_id),
    INDEX idx_payments_student (student_id),
    INDEX idx_payments_request_date (request_date)
);

-- 21. ABSENCE_REQUESTS - Bảng yêu cầu xin nghỉ
CREATE TABLE absence_requests (
    request_id INT PRIMARY KEY AUTO_INCREMENT,
    session_id INT,
    student_id INT,
    parent_id INT,
    reason VARCHAR(500),
    requested_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('PENDING', 'APPROVED', 'REJECTED') DEFAULT 'PENDING',
    processed_at DATETIME,
    processed_by INT,
    rejection_reason VARCHAR(500),
    FOREIGN KEY (session_id) REFERENCES teaching_sessions(session_id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (parent_id) REFERENCES parents(parent_id) ON DELETE CASCADE,
    INDEX idx_absence_session (session_id),
    INDEX idx_absence_student (student_id),
    INDEX idx_absence_parent (parent_id),
    INDEX idx_absence_status (status)
);

-- 22. NOTIFICATIONS - Bảng thông báo
CREATE TABLE notifications (
    notification_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    title VARCHAR(255),
    content TEXT,
    type ENUM('ATTENDANCE', 'HOMEWORK', 'FEEDBACK', 'PAYMENT', 'SCHEDULE', 'SYSTEM') NOT NULL,
    reference_id INT,
    reference_table VARCHAR(50),
    is_read BOOLEAN DEFAULT FALSE,
    read_at DATETIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at DATETIME,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_notifications_user (user_id),
    INDEX idx_notifications_user_read (user_id, is_read),
    INDEX idx_notifications_created (created_at),
    INDEX idx_notifications_type (type),
    INDEX idx_notifications_expires (expires_at)
);

-- 23. SESSION_VALIDITY_LOG - Bảng log tính hợp lệ buổi học
CREATE TABLE session_validity_log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    session_id INT,
    student_id INT,
    attendance_valid BOOLEAN,
    feedback_status VARCHAR(20),
    feedback_penalty DECIMAL(5,2),
    feedback_submitted_at DATETIME,
    is_paid BOOLEAN DEFAULT FALSE,
    calculated_amount DECIMAL(10,2),
    payment_id INT,
    calculated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (session_id) REFERENCES teaching_sessions(session_id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (payment_id) REFERENCES payments(payment_id) ON DELETE SET NULL,
    INDEX idx_validity_session (session_id),
    INDEX idx_validity_student (student_id),
    INDEX idx_validity_paid (is_paid)
);

-- Dữ liệu cho bảng roles
INSERT INTO roles (role_name) VALUES 
('ADMIN'),
('TUTOR'),
('PARENT'),
('STUDENT');

-- Dữ liệu cho bảng permissions
INSERT INTO permissions (permission_name) VALUES
('CREATE_CLASS'),
('UPDATE_CLASS'),
('DELETE_CLASS'),
('VIEW_CLASS'),
('ASSIGN_TUTOR'),
('UPDATE_PROGRESS'),
('VIEW_PROGRESS'),
('SUBMIT_PAYMENT'),
('APPROVE_PAYMENT'),
('VIEW_REPORT'),
('CREATE_HOMEWORK'),
('DO_HOMEWORK'),
('GRADE_HOMEWORK'),
('REQUEST_ABSENCE'),
('VIEW_ATTENDANCE'),
('QR_CHECKINOUT');

-- Phân quyền cho ADMIN (tất cả quyền)
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.role_id, p.permission_id
FROM roles r, permissions p
WHERE r.role_name = 'ADMIN';

-- Phân quyền cho TUTOR
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.role_id, p.permission_id
FROM roles r, permissions p
WHERE r.role_name = 'TUTOR'
AND p.permission_name IN ('VIEW_CLASS', 'UPDATE_PROGRESS', 'VIEW_PROGRESS', 
                          'SUBMIT_PAYMENT', 'CREATE_HOMEWORK', 'GRADE_HOMEWORK',
                          'QR_CHECKINOUT', 'VIEW_ATTENDANCE');

-- Phân quyền cho PARENT
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.role_id, p.permission_id
FROM roles r, permissions p
WHERE r.role_name = 'PARENT'
AND p.permission_name IN ('VIEW_CLASS', 'VIEW_PROGRESS', 'VIEW_ATTENDANCE', 'REQUEST_ABSENCE');

-- Phân quyền cho STUDENT
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.role_id, p.permission_id
FROM roles r, permissions p
WHERE r.role_name = 'STUDENT'
AND p.permission_name IN ('VIEW_CLASS', 'VIEW_PROGRESS', 'DO_HOMEWORK');

-- Tạo tài khoản ADMIN mặc định
-- Username: admin, Password: admin123 (mã hóa MD5)
INSERT INTO users (username, password, role_id, status) VALUES 
('admin', MD5('admin123'), 1, TRUE);

DELIMITER //

-- TRIGGER 1: Tạo QR code tự động khi tạo buổi học mới
CREATE TRIGGER trg_generate_qr_code
BEFORE INSERT ON teaching_sessions
FOR EACH ROW
BEGIN
    IF NEW.qr_code IS NULL OR NEW.qr_code = '' THEN
        SET NEW.qr_code = CONCAT('TCMS_', NEW.class_id, '_', NEW.session_date, '_', 
                                 LPAD(FLOOR(RAND() * 1000000), 6, '0'));
    END IF;
END//

-- TRIGGER 2: Kiểm tra và xử lý feedback trễ hạn (sau 4 giờ)
CREATE TRIGGER trg_check_feedback_late
BEFORE INSERT ON feedback
FOR EACH ROW
BEGIN
    DECLARE v_session_datetime DATETIME;
    DECLARE v_feedback_deadline DATETIME;
    
    SELECT CONCAT(s.session_date, ' ', s.end_time) INTO v_session_datetime
    FROM teaching_sessions s
    WHERE s.session_id = NEW.session_id;
    
    SET v_feedback_deadline = DATE_ADD(v_session_datetime, INTERVAL 4 HOUR);
    
    IF NEW.submitted_at > v_feedback_deadline THEN
        SET NEW.is_late = TRUE;
        SET NEW.penalty_rate = 25;
    ELSE
        SET NEW.is_late = FALSE;
        SET NEW.penalty_rate = 0;
    END IF;
END//

-- TRIGGER 3: Tính hợp lệ của điểm danh (chênh lệch ±15 phút)
CREATE TRIGGER trg_calculate_attendance_validity
BEFORE UPDATE ON attendance
FOR EACH ROW
BEGIN
    DECLARE v_scheduled_start DATETIME;
    DECLARE v_scheduled_end DATETIME;
    DECLARE v_checkin_diff INT;
    DECLARE v_checkout_diff INT;
    
    IF NEW.checkin_time IS NOT NULL AND NEW.checkout_time IS NOT NULL THEN
        SELECT CONCAT(s.session_date, ' ', s.start_time),
               CONCAT(s.session_date, ' ', s.end_time)
        INTO v_scheduled_start, v_scheduled_end
        FROM teaching_sessions s
        WHERE s.session_id = NEW.session_id;
        
        SET v_checkin_diff = ABS(TIMESTAMPDIFF(MINUTE, v_scheduled_start, NEW.checkin_time));
        SET v_checkout_diff = ABS(TIMESTAMPDIFF(MINUTE, v_scheduled_end, NEW.checkout_time));
        
        IF v_checkin_diff <= 15 AND v_checkout_diff <= 15 AND NEW.status = 'ATTENDED' THEN
            SET NEW.is_valid = TRUE;
        ELSE
            SET NEW.is_valid = FALSE;
        END IF;
    END IF;
END//

-- TRIGGER 4: Tạo thông báo khi có feedback mới
CREATE TRIGGER trg_notification_on_feedback
AFTER INSERT ON feedback
FOR EACH ROW
BEGIN
    DECLARE v_user_id INT;
    DECLARE v_student_name VARCHAR(100);
    DECLARE v_session_date DATE;
    DECLARE v_parent_user_id INT;
    
    SELECT s.full_name, ses.session_date, s.user_id
    INTO v_student_name, v_session_date, v_user_id
    FROM students s
    JOIN teaching_sessions ses ON ses.session_id = NEW.session_id
    WHERE s.student_id = NEW.student_id;
    
    SELECT u.user_id INTO v_parent_user_id
    FROM parents p
    JOIN users u ON p.user_id = u.user_id
    WHERE p.parent_id = (SELECT parent_id FROM students WHERE student_id = NEW.student_id);
    
    IF v_parent_user_id IS NOT NULL THEN
        INSERT INTO notifications (user_id, title, content, type, reference_id, reference_table)
        VALUES (v_parent_user_id, 
                'Feedback mới',
                CONCAT('Học sinh ', v_student_name, ' đã có feedback cho buổi học ngày ', v_session_date),
                'FEEDBACK',
                NEW.feedback_id,
                'feedback');
    END IF;
    
    INSERT INTO notifications (user_id, title, content, type, reference_id, reference_table)
    VALUES (v_user_id, 
            'Feedback mới',
            CONCAT('Bạn đã có feedback cho buổi học ngày ', v_session_date),
            'FEEDBACK',
            NEW.feedback_id,
            'feedback');
END//

-- TRIGGER 5: Tạo thông báo khi có bài tập mới
CREATE TRIGGER trg_notification_on_homework
AFTER INSERT ON homework
FOR EACH ROW
BEGIN
    DECLARE v_class_id INT;
    DECLARE v_student_id INT;
    DECLARE v_student_user_id INT;
    DECLARE v_student_name VARCHAR(100);
    DECLARE v_parent_user_id INT;
    DECLARE done INT DEFAULT FALSE;
    
    DECLARE cur CURSOR FOR 
        SELECT DISTINCT s.student_id, s.user_id, s.full_name, pu.user_id as parent_user_id
        FROM enrollments e
        JOIN students s ON e.student_id = s.student_id
        LEFT JOIN parents p ON s.parent_id = p.parent_id
        LEFT JOIN users pu ON p.user_id = pu.user_id
        WHERE e.class_id = (SELECT class_id FROM teaching_sessions WHERE session_id = NEW.session_id);
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO v_student_id, v_student_user_id, v_student_name, v_parent_user_id;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        INSERT INTO notifications (user_id, title, content, type, reference_id, reference_table)
        VALUES (v_student_user_id, 
                'Bài tập về nhà mới',
                CONCAT('Bạn có bài tập mới: ', NEW.title, ' - Hạn nộp: ', NEW.deadline),
                'HOMEWORK',
                NEW.homework_id,
                'homework');
        
        IF v_parent_user_id IS NOT NULL THEN
            INSERT INTO notifications (user_id, title, content, type, reference_id, reference_table)
            VALUES (v_parent_user_id, 
                    'Bài tập về nhà mới cho con',
                    CONCAT('Con bạn ', v_student_name, ' có bài tập mới: ', NEW.title, ' - Hạn nộp: ', NEW.deadline),
                    'HOMEWORK',
                    NEW.homework_id,
                    'homework');
        END IF;
    END LOOP;
    CLOSE cur;
END//

-- TRIGGER 6: Tạo thông báo khi học sinh nộp bài tập
CREATE TRIGGER trg_notification_on_submission
AFTER INSERT ON homework_submissions
FOR EACH ROW
BEGIN
    DECLARE v_tutor_user_id INT;
    DECLARE v_homework_title VARCHAR(255);
    DECLARE v_student_name VARCHAR(100);
    
    SELECT t.user_id, h.title, s.full_name
    INTO v_tutor_user_id, v_homework_title, v_student_name
    FROM homework h
    JOIN teaching_sessions ses ON h.session_id = ses.session_id
    JOIN classes c ON ses.class_id = c.class_id
    JOIN tutors t ON c.tutor_id = t.tutor_id
    JOIN students s ON NEW.student_id = s.student_id
    WHERE h.homework_id = NEW.homework_id;
    
    INSERT INTO notifications (user_id, title, content, type, reference_id, reference_table)
    VALUES (v_tutor_user_id, 
            'Bài tập mới được nộp',
            CONCAT('Học sinh ', v_student_name, ' đã nộp bài tập "', v_homework_title, '"'),
            'HOMEWORK',
            NEW.submission_id,
            'homework_submissions');
END//

-- TRIGGER 7: Tạo thông báo khi có yêu cầu thanh toán
CREATE TRIGGER trg_notification_on_payment_request
AFTER INSERT ON payments
FOR EACH ROW
BEGIN
    DECLARE v_parent_user_id INT;
    DECLARE v_admin_user_id INT;
    DECLARE v_class_name VARCHAR(100);
    
    SELECT u.user_id, c.class_name
    INTO v_parent_user_id, v_class_name
    FROM students s
    JOIN parents p ON s.parent_id = p.parent_id
    JOIN users u ON p.user_id = u.user_id
    JOIN classes c ON NEW.class_id = c.class_id
    WHERE s.student_id = NEW.student_id;
    
    SELECT user_id INTO v_admin_user_id
    FROM users
    WHERE role_id = 1 LIMIT 1;
    
    IF v_parent_user_id IS NOT NULL THEN
        INSERT INTO notifications (user_id, title, content, type, reference_id, reference_table)
        VALUES (v_parent_user_id, 
                'Yêu cầu thanh toán mới',
                CONCAT('Lớp ', v_class_name, ' có yêu cầu thanh toán số tiền ', FORMAT(NEW.amount, 0), ' VNĐ'),
                'PAYMENT',
                NEW.payment_id,
                'payments');
    END IF;
    
    IF v_admin_user_id IS NOT NULL THEN
        INSERT INTO notifications (user_id, title, content, type, reference_id, reference_table)
        VALUES (v_admin_user_id, 
                'Yêu cầu thanh toán cần duyệt',
                CONCAT('Lớp ', v_class_name, ' - Số tiền: ', FORMAT(NEW.amount, 0), ' VNĐ'),
                'PAYMENT',
                NEW.payment_id,
                'payments');
    END IF;
END//

-- TRIGGER 8: Cập nhật thời gian xác nhận thanh toán
CREATE TRIGGER trg_payment_status_timestamps
BEFORE UPDATE ON payments
FOR EACH ROW
BEGIN
    IF NEW.status = 'PROOF_UPLOADED' AND OLD.status != 'PROOF_UPLOADED' THEN
        SET NEW.request_date = NOW();
    END IF;
    
    IF NEW.status = 'TUTOR_CONFIRMED' AND OLD.status != 'TUTOR_CONFIRMED' THEN
        SET NEW.tutor_confirmed_at = NOW();
    END IF;
    
    IF NEW.status IN ('ADMIN_APPROVED', 'COMPLETED') AND OLD.status NOT IN ('ADMIN_APPROVED', 'COMPLETED') THEN
        SET NEW.admin_approved_at = NOW();
    END IF;
END//

-- TRIGGER 9: Tính toán hợp lệ buổi học khi feedback được duyệt
CREATE TRIGGER trg_calculate_session_validity
AFTER UPDATE ON feedback
FOR EACH ROW
BEGIN
    DECLARE v_attendance_valid BOOLEAN;
    DECLARE v_tuition_fee DECIMAL(10,2);
    DECLARE v_calculated_amount DECIMAL(10,2);
    
    IF NEW.status = 'APPROVED' AND OLD.status != 'APPROVED' THEN
        SELECT is_valid INTO v_attendance_valid
        FROM attendance
        WHERE session_id = NEW.session_id AND student_id = NEW.student_id;
        
        SELECT c.tuition_fee_per_session INTO v_tuition_fee
        FROM teaching_sessions s
        JOIN classes c ON s.class_id = c.class_id
        WHERE s.session_id = NEW.session_id;
        
        IF v_attendance_valid = TRUE THEN
            SET v_calculated_amount = v_tuition_fee * (100 - NEW.penalty_rate) / 100;
        ELSE
            SET v_calculated_amount = 0;
        END IF;
        
        INSERT INTO session_validity_log (session_id, student_id, attendance_valid, 
                                           feedback_status, feedback_penalty, 
                                           feedback_submitted_at, calculated_amount)
        VALUES (NEW.session_id, NEW.student_id, v_attendance_valid,
                IF(NEW.is_late = TRUE, 'LATE', 'ON_TIME'),
                NEW.penalty_rate, NEW.submitted_at, v_calculated_amount);
    END IF;
END//

-- TRIGGER 10: Xử lý yêu cầu xin nghỉ của phụ huynh
CREATE TRIGGER trg_process_absence_request
AFTER UPDATE ON absence_requests
FOR EACH ROW
BEGIN
    IF NEW.status = 'APPROVED' AND OLD.status != 'APPROVED' THEN
        UPDATE attendance 
        SET status = 'ABSENT_EXCUSED',
            absence_reason = NEW.reason,
            is_valid = FALSE,
            note = CONCAT('Xin nghỉ có phép. Lý do: ', NEW.reason)
        WHERE session_id = NEW.session_id AND student_id = NEW.student_id;
        
        IF ROW_COUNT() = 0 THEN
            INSERT INTO attendance (session_id, student_id, status, absence_reason, is_valid, note)
            VALUES (NEW.session_id, NEW.student_id, 'ABSENT_EXCUSED', NEW.reason, FALSE, 
                    CONCAT('Xin nghỉ có phép. Lý do: ', NEW.reason));
        END IF;
        
        INSERT INTO notifications (user_id, title, content, type, reference_id, reference_table)
        SELECT t.user_id,
               'Học sinh xin nghỉ học',
               CONCAT('Học sinh đã được phép nghỉ buổi học ngày ', s.session_date, '. Lý do: ', NEW.reason),
               'ATTENDANCE',
               NEW.request_id,
               'absence_requests'
        FROM teaching_sessions s
        JOIN classes c ON s.class_id = c.class_id
        JOIN tutors t ON c.tutor_id = t.tutor_id
        WHERE s.session_id = NEW.session_id;
    END IF;
END//

DELIMITER ;

DELIMITER //

-- PROCEDURE 1: Tính hợp lệ cho 1 buổi học cụ thể
CREATE PROCEDURE sp_calculate_session_validity(
    IN p_session_id INT,
    IN p_student_id INT
)
BEGIN
    DECLARE v_attendance_valid BOOLEAN DEFAULT FALSE;
    DECLARE v_feedback_penalty DECIMAL(5,2) DEFAULT 0;
    DECLARE v_feedback_status VARCHAR(20);
    DECLARE v_calculated_amount DECIMAL(10,2);
    DECLARE v_tuition_fee DECIMAL(10,2);
    
    SELECT c.tuition_fee_per_session INTO v_tuition_fee
    FROM teaching_sessions s
    JOIN classes c ON s.class_id = c.class_id
    WHERE s.session_id = p_session_id;
    
    SELECT is_valid INTO v_attendance_valid
    FROM attendance
    WHERE session_id = p_session_id AND student_id = p_student_id;
    
    SELECT penalty_rate, IF(is_late = TRUE, 'LATE', 'ON_TIME')
    INTO v_feedback_penalty, v_feedback_status
    FROM feedback
    WHERE session_id = p_session_id AND student_id = p_student_id AND status = 'APPROVED';
    
    IF v_attendance_valid = TRUE AND v_feedback_status IS NOT NULL THEN
        SET v_calculated_amount = v_tuition_fee * (100 - v_feedback_penalty) / 100;
    ELSE
        SET v_calculated_amount = 0;
    END IF;
    
    INSERT INTO session_validity_log (session_id, student_id, attendance_valid, 
                                       feedback_status, feedback_penalty, calculated_amount)
    VALUES (p_session_id, p_student_id, v_attendance_valid, 
            v_feedback_status, v_feedback_penalty, v_calculated_amount)
    ON DUPLICATE KEY UPDATE
        attendance_valid = v_attendance_valid,
        feedback_status = v_feedback_status,
        feedback_penalty = v_feedback_penalty,
        calculated_amount = v_calculated_amount,
        calculated_at = CURRENT_TIMESTAMP;
END//

-- PROCEDURE 2: Tính hợp lệ cho tất cả buổi học của một lớp
CREATE PROCEDURE sp_calculate_class_validity(
    IN p_class_id INT
)
BEGIN
    DECLARE v_session_id INT;
    DECLARE v_student_id INT;
    DECLARE done INT DEFAULT FALSE;
    
    DECLARE cur CURSOR FOR 
        SELECT DISTINCT s.session_id, e.student_id
        FROM teaching_sessions s
        JOIN enrollments e ON s.class_id = e.class_id
        WHERE s.class_id = p_class_id AND s.status = 'COMPLETED';
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO v_session_id, v_student_id;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        CALL sp_calculate_session_validity(v_session_id, v_student_id);
    END LOOP;
    CLOSE cur;
END//

-- PROCEDURE 3: Tạo các buổi học từ lịch định kỳ
CREATE PROCEDURE sp_generate_sessions_from_schedule(
    IN p_class_id INT,
    IN p_start_date DATE,
    IN p_end_date DATE
)
BEGIN
    DECLARE v_current_date DATE;
    DECLARE v_weekday INT;
    DECLARE v_schedule_weekday INT;
    DECLARE v_start_time TIME;
    DECLARE v_end_time TIME;
    DECLARE done INT DEFAULT FALSE;
    
    DECLARE cur CURSOR FOR 
        SELECT weekday, start_time, end_time
        FROM teaching_schedules
        WHERE class_id = p_class_id;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    SET v_current_date = p_start_date;
    
    WHILE v_current_date <= p_end_date DO
        SET v_weekday = DAYOFWEEK(v_current_date);
        
        OPEN cur;
        read_loop: LOOP
            FETCH cur INTO v_schedule_weekday, v_start_time, v_end_time;
            IF done THEN
                SET done = FALSE;
                LEAVE read_loop;
            END IF;
            
            IF v_weekday = v_schedule_weekday THEN
                IF NOT EXISTS (
                    SELECT 1 FROM teaching_sessions 
                    WHERE class_id = p_class_id AND session_date = v_current_date
                ) THEN
                    INSERT INTO teaching_sessions (class_id, session_date, start_time, end_time, status)
                    VALUES (p_class_id, v_current_date, v_start_time, v_end_time, 'PLANNED');
                END IF;
            END IF;
        END LOOP;
        CLOSE cur;
        
        SET v_current_date = DATE_ADD(v_current_date, INTERVAL 1 DAY);
    END WHILE;
END//

-- PROCEDURE 4: Tính validity cho tất cả lớp
CREATE PROCEDURE sp_calculate_all_classes_validity()
BEGIN
    DECLARE v_class_id INT;
    DECLARE done INT DEFAULT FALSE;
    
    DECLARE cur CURSOR FOR SELECT class_id FROM classes WHERE status = TRUE;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO v_class_id;
        IF done THEN
            LEAVE read_loop;
        END IF;
        CALL sp_calculate_class_validity(v_class_id);
    END LOOP;
    CLOSE cur;
END//

-- PROCEDURE 5: Dashboard cho Tutor
CREATE PROCEDURE sp_tutor_dashboard(
    IN p_tutor_id INT
)
BEGIN
    SELECT COUNT(DISTINCT s.session_id) AS classes_today
    FROM teaching_sessions s
    JOIN classes c ON s.class_id = c.class_id
    WHERE c.tutor_id = p_tutor_id 
    AND s.session_date = CURDATE()
    AND s.status IN ('PLANNED', 'ONGOING');
    
    SELECT COUNT(DISTINCT f.feedback_id) AS pending_feedback
    FROM feedback f
    JOIN teaching_sessions s ON f.session_id = s.session_id
    JOIN classes c ON s.class_id = c.class_id
    WHERE c.tutor_id = p_tutor_id 
    AND f.status = 'PENDING';
    
    SELECT COUNT(DISTINCT hs.submission_id) AS homework_to_grade
    FROM homework_submissions hs
    JOIN homework h ON hs.homework_id = h.homework_id
    JOIN teaching_sessions s ON h.session_id = s.session_id
    JOIN classes c ON s.class_id = c.class_id
    WHERE c.tutor_id = p_tutor_id 
    AND hs.status = 'SUBMITTED';
    
    SELECT COUNT(*) AS pending_payments
    FROM payments
    WHERE tutor_id = p_tutor_id 
    AND status IN ('PENDING', 'PROOF_UPLOADED');
END//

-- PROCEDURE 6: Dashboard cho Parent
CREATE PROCEDURE sp_parent_dashboard(
    IN p_parent_id INT
)
BEGIN
    SELECT COUNT(DISTINCT s.session_id) AS classes_today
    FROM teaching_sessions s
    JOIN classes c ON s.class_id = c.class_id
    JOIN enrollments e ON c.class_id = e.class_id
    JOIN students st ON e.student_id = st.student_id
    WHERE st.parent_id = p_parent_id 
    AND s.session_date = CURDATE();
    
    SELECT COUNT(DISTINCT h.homework_id) AS homework_pending
    FROM homework h
    JOIN teaching_sessions s ON h.session_id = s.session_id
    JOIN classes c ON s.class_id = c.class_id
    JOIN enrollments e ON c.class_id = e.class_id
    JOIN students st ON e.student_id = st.student_id
    LEFT JOIN homework_submissions hs ON h.homework_id = hs.homework_id AND hs.student_id = st.student_id
    WHERE st.parent_id = p_parent_id 
    AND (hs.submission_id IS NULL OR hs.status = 'SUBMITTED' AND hs.graded_at IS NULL)
    AND h.deadline >= CURDATE();
    
    SELECT COUNT(*) AS new_feedback
    FROM feedback f
    JOIN teaching_sessions s ON f.session_id = s.session_id
    JOIN classes c ON s.class_id = c.class_id
    JOIN enrollments e ON c.class_id = e.class_id
    JOIN students st ON e.student_id = st.student_id
    WHERE st.parent_id = p_parent_id 
    AND f.created_at >= DATE_SUB(NOW(), INTERVAL 7 DAY);
    
    SELECT COUNT(*) AS pending_payments
    FROM payments p
    JOIN students st ON p.student_id = st.student_id
    WHERE st.parent_id = p_parent_id 
    AND p.status IN ('PENDING', 'PROOF_UPLOADED');
END//

-- PROCEDURE 7: Dashboard cho Student
CREATE PROCEDURE sp_student_dashboard(
    IN p_student_id INT
)
BEGIN
    SELECT COUNT(DISTINCT s.session_id) AS classes_today
    FROM teaching_sessions s
    JOIN classes c ON s.class_id = c.class_id
    JOIN enrollments e ON c.class_id = e.class_id
    WHERE e.student_id = p_student_id 
    AND s.session_date = CURDATE();
    
    SELECT COUNT(DISTINCT h.homework_id) AS homework_pending
    FROM homework h
    JOIN teaching_sessions s ON h.session_id = s.session_id
    JOIN classes c ON s.class_id = c.class_id
    JOIN enrollments e ON c.class_id = e.class_id
    LEFT JOIN homework_submissions hs ON h.homework_id = hs.homework_id AND hs.student_id = p_student_id
    WHERE e.student_id = p_student_id 
    AND (hs.submission_id IS NULL OR hs.status = 'SUBMITTED' AND hs.graded_at IS NULL)
    AND h.deadline >= CURDATE();
    
    SELECT COUNT(*) AS new_feedback
    FROM feedback
    WHERE student_id = p_student_id 
    AND created_at >= DATE_SUB(NOW(), INTERVAL 7 DAY);
END//

-- PROCEDURE 8: Dọn dẹp notification cũ
CREATE PROCEDURE sp_cleanup_old_notifications()
BEGIN
    DELETE FROM notifications 
    WHERE is_read = TRUE 
    AND read_at < DATE_SUB(NOW(), INTERVAL 1 DAY);
    
    DELETE FROM notifications 
    WHERE is_read = FALSE 
    AND created_at < DATE_SUB(NOW(), INTERVAL 30 DAY);
    
    DELETE FROM notifications 
    WHERE expires_at IS NOT NULL 
    AND expires_at < NOW();
END//

-- PROCEDURE 9: Gửi thông báo trước buổi học
CREATE PROCEDURE sp_send_upcoming_session_notifications()
BEGIN
    DECLARE v_session_id INT;
    DECLARE v_class_id INT;
    DECLARE v_session_date DATE;
    DECLARE v_start_time TIME;
    DECLARE v_tutor_user_id INT;
    DECLARE done INT DEFAULT FALSE;
    
    DECLARE cur_sessions CURSOR FOR 
        SELECT s.session_id, s.class_id, s.session_date, s.start_time
        FROM teaching_sessions s
        WHERE s.session_date = CURDATE()
        AND s.start_time BETWEEN CURTIME() AND ADDTIME(CURTIME(), '02:00:00')
        AND s.status = 'PLANNED';
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN cur_sessions;
    read_loop: LOOP
        FETCH cur_sessions INTO v_session_id, v_class_id, v_session_date, v_start_time;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- Thông báo cho tutor
        SELECT u.user_id INTO v_tutor_user_id
        FROM tutors t
        JOIN users u ON t.user_id = u.user_id
        JOIN classes c ON t.tutor_id = c.tutor_id
        WHERE c.class_id = v_class_id;
        
        IF v_tutor_user_id IS NOT NULL THEN
            INSERT INTO notifications (user_id, title, content, type, reference_id, reference_table, expires_at)
            VALUES (v_tutor_user_id, 
                    'Buổi dạy sắp diễn ra',
                    CONCAT('Bạn có buổi dạy vào lúc ', v_start_time, ' ngày hôm nay.'),
                    'SCHEDULE',
                    v_session_id,
                    'teaching_sessions',
                    DATE_ADD(CONCAT(v_session_date, ' ', v_start_time), INTERVAL 2 HOUR));
        END IF;
        
        -- Thông báo cho học sinh
        INSERT INTO notifications (user_id, title, content, type, reference_id, reference_table, expires_at)
        SELECT u.user_id,
               'Buổi học sắp diễn ra',
               CONCAT('Bạn có buổi học vào lúc ', v_start_time, ' ngày hôm nay. Hãy chuẩn bị bài đầy đủ nhé!'),
               'SCHEDULE',
               v_session_id,
               'teaching_sessions',
               DATE_ADD(CONCAT(v_session_date, ' ', v_start_time), INTERVAL 2 HOUR)
        FROM enrollments e
        JOIN students s ON e.student_id = s.student_id
        JOIN users u ON s.user_id = u.user_id
        WHERE e.class_id = v_class_id;
        
        -- Thông báo cho phụ huynh
        INSERT INTO notifications (user_id, title, content, type, reference_id, reference_table, expires_at)
        SELECT pu.user_id,
               'Con bạn sắp có buổi học',
               CONCAT('Con bạn ', s.full_name, ' có buổi học vào lúc ', v_start_time, ' ngày hôm nay.'),
               'SCHEDULE',
               v_session_id,
               'teaching_sessions',
               DATE_ADD(CONCAT(v_session_date, ' ', v_start_time), INTERVAL 2 HOUR)
        FROM enrollments e
        JOIN students s ON e.student_id = s.student_id
        JOIN parents p ON s.parent_id = p.parent_id
        JOIN users pu ON p.user_id = pu.user_id
        WHERE e.class_id = v_class_id;
        
    END LOOP;
    CLOSE cur_sessions;
END//

DELIMITER ;

-- Bật event scheduler
SET GLOBAL event_scheduler = ON;

-- EVENT 1: Dọn dẹp notification cũ (mỗi ngày lúc 2h sáng)
DROP EVENT IF EXISTS evt_cleanup_notifications;
CREATE EVENT evt_cleanup_notifications
ON SCHEDULE EVERY 1 DAY
STARTS TIMESTAMP(CURRENT_DATE, '02:00:00') + INTERVAL 1 DAY
DO
    CALL sp_cleanup_old_notifications();

-- EVENT 2: Gửi thông báo trước buổi học (mỗi giờ)
DROP EVENT IF EXISTS evt_send_upcoming_session_notifications;
CREATE EVENT evt_send_upcoming_session_notifications
ON SCHEDULE EVERY 1 HOUR
STARTS CURRENT_TIMESTAMP
DO
    CALL sp_send_upcoming_session_notifications();

-- EVENT 3: Tính validity cho các buổi học (mỗi ngày lúc 23h)
DROP EVENT IF EXISTS evt_calculate_daily_validity;
CREATE EVENT evt_calculate_daily_validity
ON SCHEDULE EVERY 1 DAY
STARTS TIMESTAMP(CURRENT_DATE, '23:00:00') + INTERVAL 1 DAY
DO
    CALL sp_calculate_all_classes_validity();

-- VIEW 1: Thống kê buổi học theo lớp
CREATE OR REPLACE VIEW vw_class_session_stats AS
SELECT 
    c.class_id,
    c.class_name,
    c.subject,
    t.full_name AS tutor_name,
    COUNT(s.session_id) AS total_sessions,
    SUM(CASE WHEN s.status = 'COMPLETED' THEN 1 ELSE 0 END) AS completed_sessions,
    SUM(CASE WHEN s.status = 'CANCELLED' THEN 1 ELSE 0 END) AS cancelled_sessions,
    SUM(CASE WHEN s.status = 'PLANNED' THEN 1 ELSE 0 END) AS planned_sessions
FROM classes c
LEFT JOIN tutors t ON c.tutor_id = t.tutor_id
LEFT JOIN teaching_sessions s ON c.class_id = s.class_id
GROUP BY c.class_id, c.class_name, c.subject, t.full_name;

-- VIEW 2: Thống kê thanh toán theo lớp
CREATE OR REPLACE VIEW vw_payment_stats AS
SELECT 
    c.class_id,
    c.class_name,
    p.status,
    COUNT(p.payment_id) AS payment_count,
    SUM(p.amount) AS total_amount,
    AVG(p.amount) AS avg_amount
FROM classes c
LEFT JOIN payments p ON c.class_id = p.class_id
GROUP BY c.class_id, c.class_name, p.status;

-- VIEW 3: Thống kê điểm danh theo học sinh
CREATE OR REPLACE VIEW vw_student_attendance_stats AS
SELECT 
    s.student_id,
    s.full_name,
    COUNT(a.attendance_id) AS total_sessions,
    SUM(CASE WHEN a.status = 'ATTENDED' AND a.is_valid = TRUE THEN 1 ELSE 0 END) AS attended_valid,
    SUM(CASE WHEN a.status = 'ATTENDED' AND a.is_valid = FALSE THEN 1 ELSE 0 END) AS attended_invalid,
    SUM(CASE WHEN a.status = 'ABSENT_EXCUSED' THEN 1 ELSE 0 END) AS absent_excused,
    SUM(CASE WHEN a.status = 'ABSENT_UNEXCUSED' THEN 1 ELSE 0 END) AS absent_unexcused,
    ROUND(SUM(CASE WHEN a.status = 'ATTENDED' AND a.is_valid = TRUE THEN 1 ELSE 0 END) * 100.0 / NULLIF(COUNT(a.attendance_id), 0), 2) AS attendance_rate
FROM students s
LEFT JOIN attendance a ON s.student_id = a.student_id
GROUP BY s.student_id, s.full_name;

-- VIEW 4: Tổng hợp feedback theo gia sư
CREATE OR REPLACE VIEW vw_feedback_summary AS
SELECT 
    t.tutor_id,
    t.full_name AS tutor_name,
    COUNT(f.feedback_id) AS total_feedback,
    SUM(CASE WHEN f.is_late = TRUE THEN 1 ELSE 0 END) AS late_feedback,
    SUM(CASE WHEN f.status = 'PENDING' THEN 1 ELSE 0 END) AS pending_feedback,
    AVG(CASE WHEN f.rating = 'Xuất sắc' THEN 5
             WHEN f.rating = 'Giỏi' THEN 4
             WHEN f.rating = 'Khá' THEN 3
             WHEN f.rating = 'Trung bình' THEN 2
             WHEN f.rating = 'Yếu' THEN 1
        END) AS avg_rating_score
FROM tutors t
LEFT JOIN classes c ON t.tutor_id = c.tutor_id
LEFT JOIN teaching_sessions s ON c.class_id = s.class_id
LEFT JOIN feedback f ON s.session_id = f.session_id
GROUP BY t.tutor_id, t.full_name;

-- VIEW 5: Tỷ lệ hoàn thành bài tập
CREATE OR REPLACE VIEW vw_homework_completion AS
SELECT 
    c.class_id,
    c.class_name,
    COUNT(DISTINCT h.homework_id) AS total_homework,
    COUNT(DISTINCT hs.submission_id) AS total_submissions,
    ROUND(COUNT(DISTINCT hs.submission_id) * 100.0 / NULLIF(COUNT(DISTINCT h.homework_id), 0), 2) AS submission_rate,
    AVG(hs.score) AS avg_score
FROM classes c
LEFT JOIN teaching_sessions s ON c.class_id = s.class_id
LEFT JOIN homework h ON s.session_id = h.session_id
LEFT JOIN homework_submissions hs ON h.homework_id = hs.homework_id
GROUP BY c.class_id, c.class_name;