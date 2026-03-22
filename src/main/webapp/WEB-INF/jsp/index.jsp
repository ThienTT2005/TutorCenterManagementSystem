<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <link href="assets/css/style.css" rel="stylesheet" />
    <title>Trang chủ - Academic Atelier</title>
</head>
<body>
        <!-- Section 1: TopAppBar -->
        <header class="header">
            <div class="header-container">
                <a href="${pageContext.request.contextPath}/" class="logo">Academic Atelier</a>
                <nav class="nav-menu">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/">Trang chủ</a>
                    <a class="nav-link" href="#">Phụ huynh</a>
                    <a class="nav-link" href="#">Gia sư</a>
                    <a class="nav-link" href="#">Khóa học</a>
                    <a class="nav-link" href="#">Tin tức</a>
                </nav>
                <div class="header-actions">
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-text">Đăng nhập</a>
                    <a href="${pageContext.request.contextPath}/register" class="btn btn-primary">Đăng ký</a>
                </div>
            </div>
        </header>
        <main>
            <!-- Section 2: Banner 1 (Hero) -->
            <section class="hero-section">
                <div class="hero-bg">
                    <img alt="Student studying with focus"
                        data-alt="A university student studying intently in a library"
                        src="https://lh3.googleusercontent.com/aida-public/AB6AXuAsCzAFJku_-pvD6QFLk7HfQkn6YJI0rzFAB7NyQrjSrLaHnDYnSwvnYHT-KCa2xYU2EN8hK6fvVg6kUHwEBGsJHGs3g2kTxvpwVeMJFoG_7wS9VHQuax5syqzJifELuC8pBsJkU16Immn6odwrUJvxqhdXHNaBlcEZmbZq0HB87XqP_6orhQ9OzOkEmQtvT1We4FG1qyrhHheiffcjsyYUNSUvEqfbI6fiHsZIfR6T5VIiIDoFKn61cVFvNDVMWOMrl1aN3FZe2Zbe" />
                    <div class="hero-overlay"></div>
                </div>
                <div class="hero-content">
                    <div class="hero-text-container">
                        <h1 class="hero-title">
                            Connecting <span>Tutors</span> &amp; <br /> Parents
                        </h1>
                        <p class="hero-desc">
                            Nâng tầm tri thức Việt thông qua mạng lưới gia sư chuyên
                            nghiệp và tận tâm nhất. Giải pháp học tập cá nhân hóa cho mọi trình độ.
                        </p>
                        <!-- Search Component -->
                        <div class="search-box">
                            <div class="search-fields">
                                <select class="search-select">
                                    <option>Chọn lớp</option>
                                    <option>Lơ 1 - 5</option>
                                    <option>Lớp 6 - 9</option>
                                    <option>Lớp 10 - 12</option>
                                    <option>Ôn thi đại học</option>
                                </select>
                                <select class="search-select">
                                    <option>Chọn Môn Học</option>
                                    <option>Toán Học</option>
                                    <option>Ngữ Văn</option>
                                    <option>Tiếng Anh</option>
                                    <option>Vật Lý</option>
                                </select>
                                <select class="search-select">
                                    <option>Chọn Khu Vực</option>
                                    <option>Hà Nội</option>
                                    <option>TP. Hồ Chí Minh</option>
                                    <option>Đà Nẵng</option>
                                </select>
                            </div>
                            <button class="btn-search">
                                <span class="material-symbols-outlined">search</span> Tìm Kiếm
                            </button>
                        </div>
                    </div>
                </div>
            </section>
            <!-- Section 3: Banner 2 (Top Tutors) -->
            <section class="section-padding section-tutors">
                <div class="section-container">
                    <div class="section-header">
                        <div>
                            <span class="section-subtitle">Expert Network</span>
                            <h2 class="section-title">Đội Ngũ Gia Sư Tiêu Biểu</h2>
                        </div>
                        <div class="section-actions">
                            <button class="btn-icon">
                                <span class="material-symbols-outlined">chevron_left</span>
                            </button>
                            <button class="btn-icon">
                                <span class="material-symbols-outlined">chevron_right</span>
                            </button>
                        </div>
                    </div>
                    <div class="grid-4">
                        <!-- Tutor Card 1 -->
                        <div class="tutor-card">
                            <div class="tutor-img-wrap">
                                <img alt="Female tutor profile"
                                    data-alt="Professional portrait of a female academic tutor"
                                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuAJrX8fhYGMWWk8WcmJmnT70beoSYyoETPXrktI9tGHV-KVzdUjH66Fpj7LdbWaNBlaM8ktti4NIabrrrGJklCkRnt9bJx3ylHiwRZjXoRF8v8_CrtGD3ISmv0Mgu49XhMRJLFqzIOTfinIvfBkcAHiXC4wFuJBavLbboypX_zCWkv-jI7nfCy0H2Jq9kxUWlytGI9H_ug55h1Tg13bqFRXfzKF9MFCzQWnqoswmbLtGH-zgv1UAAGgvjOxedL57s4W8ychyFdD5eVA" />
                                <div class="tutor-rating">
                                    <span class="material-symbols-outlined">star</span>
                                    <span class="score">4.9</span>
                                </div>
                            </div>
                            <div class="tutor-info">
                                <h3 class="tutor-name">Nguyễn Văn A</h3>
                                <p class="tutor-title">Thạc sĩ Toán học</p>
                                <div class="tutor-tags">
                                    <span class="tag">Toán</span>
                                    <span class="tag">Lý</span>
                                </div>
                            </div>
                        </div>
                        <!-- Tutor Card 2 -->
                        <div class="tutor-card">
                            <div class="tutor-img-wrap">
                                <img alt="Male tutor profile"
                                    data-alt="Portrait of a young male professional tutor"
                                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuCTCGS7dGY91DoLPCHwnYacztDbiJ1Net_Bo8kahlYfDPBB0AEeLIQwUdMv81lKDO__yuoThmm6u5A8YG1k4a207g0ObXtXZSw860x_tmhXwIZ5pfTkjNFDFlfNyR8v6WvYyMr26EIoDbMkKtfUiF71QtaRusYFV-EQueN4dKYLyBX629Zi7E50tvoka7eJ067oTqhTgqPboYN0lfZQUJJgHzl352MjAhVY1pBXpqWMJB0W2u-t4CArsxqE1JGaDg25M02KxMSWThl5" />
                                <div class="tutor-rating">
                                    <span class="material-symbols-outlined">star</span>
                                    <span class="score">5.0</span>
                                </div>
                            </div>
                            <div class="tutor-info">
                                <h3 class="tutor-name">Trần Thị B</h3>
                                <p class="tutor-title">Cử nhân Ngôn ngữ Anh</p>
                                <div class="tutor-tags">
                                    <span class="tag">Tiếng Anh</span>
                                    <span class="tag">IELTS</span>
                                </div>
                            </div>
                        </div>
                        <!-- Tutor Card 3 -->
                        <div class="tutor-card">
                            <div class="tutor-img-wrap">
                                <img alt="Professional tutor profile"
                                    data-alt="Experienced tutor in formal attire"
                                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuAWfvrYlb78pGtw443pZ4164PNnq-UVNjFQb6wCBakThnrjXWiGUqP5UENfF4HI8J-M0KNBCQgOAQB_xoeeC7e0AZYGGz7A6RA3niOlFUD_2qDg2yvXAcu723-Exjx-94kvXwJCZ_nWgzCdL3kTswDi2ih1ihDjdSpF5BHz0sxUoSllxjI9gVuwK8kw1QMQVYMmF10ANsX6qU-sFs8le6aT3WrkSsNXHo8_EKrcC5uCj5fo_YddJ8ns_3xgZMGLMk_n2GA7CL7U6tax" />
                                <div class="tutor-rating">
                                    <span class="material-symbols-outlined">star</span>
                                    <span class="score">4.8</span>
                                </div>
                            </div>
                            <div class="tutor-info">
                                <h3 class="tutor-name">Lã Quang C</h3>
                                <p class="tutor-title">Thạc sỹ Vật Lý</p>
                                <div class="tutor-tags">
                                    <span class="tag">Vật Lý</span>
                                    <span class="tag">Hóa Học</span>
                                </div>
                            </div>
                        </div>
                        <!-- Tutor Card 4 -->
                        <div class="tutor-card">
                            <div class="tutor-img-wrap">
                                <img alt="Female academic tutor profile"
                                    data-alt="Friendly female academic tutor smiling"
                                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuDjpPV51ERLIZzp2d3GaNPm9tJY7s4qu_NoSCCJxfisYBWXDgnaAhZ4rKvRM9NPcS9f0HsL50OMEZ0vRO6JYZo4iF-_RGNVcjZVUVd3Ow3ZVVkjxCzmYdIsU8XmZpMx4KKbi5r-Q_N8oto3AyjZEKaLcPSQ6X0sHC6SspnHdFcTzteaJek9oQHQZubEO-Rjn_xT46nIbWmL4HVRCQWW77cnPWZs2JOQJ5iymzueIqKNi0QXe6FNjE5yVYIIPBkNWl4chtAVofP_c_dq" />
                                <div class="tutor-rating">
                                    <span class="material-symbols-outlined">star</span>
                                    <span class="score">4.9</span>
                                </div>
                            </div>
                            <div class="tutor-info">
                                <h3 class="tutor-name">Phạm Minh D</h3>
                                <p class="tutor-title">Thạc sĩ văn học</p>
                                <div class="tutor-tags">
                                    <span class="tag">Ngữ Văn</span>
                                    <span class="tag">Lịch Sử</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- Section 4: Banner 3 (Featured Courses) -->
            <section class="section-padding section-courses">
                <div class="section-container">
                    <div class="section-header">
                        <div class="max-w-xl">
                            <span class="section-subtitle">Premium Education</span>
                            <h2 class="section-title">Khóa Học Tiêu Biểu</h2>
                            <p class="section-desc">Những lộ trình học tập được thiết kế riêng biệt để bứt phá điểm số và tư duy.</p>
                        </div>
                        <div class="section-actions">
                            <button class="btn-icon btn-icon-outline">
                                <span class="material-symbols-outlined">chevron_left</span>
                            </button>
                            <button class="btn-icon btn-icon-outline">
                                <span class="material-symbols-outlined">chevron_right</span>
                            </button>
                        </div>
                    </div>
                    <div class="grid-3">
                        <!-- Course Card 1 -->
                        <div class="course-card">
                            <div class="course-img-wrap">
                                <img alt="University preparation course"
                                    data-alt="Academic books and stationery for university entrance preparation"
                                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuBg7Lc5G-zguiUXBjcPl4xZg4aERyT5mMmmPaAYsoh58zlmZm30cXm_2o68Sz2KbYXNvjt1H_ztCol-t7VtziC5dKfb0xGbe1a9luKvH_GGQXRH6oJ4zP__dVq3DKbUY3L8t4UF_uO-e8q2ZIZBWn7gUmNifM7pAWQY-kZFUhqhz0YTxGsUblur6iufNhEbUDQkUboyuKJ-3OhivC60HStiYrNVxfsBoZravOPq0RUyhsTc8emlXICO9M86KTs1GkLoa55ITGWeg1Ck" />
                                <div class="course-badge">Bán chạy nhất</div>
                            </div>
                            <div class="course-info">
                                <h3 class="course-name">Luyện thi đại học khối A</h3>
                                <div class="course-meta">
                                    <div class="course-meta-item">
                                        <span class="material-symbols-outlined">schedule</span>
                                        <span class="course-meta-text">12 Tháng</span>
                                    </div>
                                    <div class="course-meta-item">
                                        <span class="material-symbols-outlined">payments</span>
                                        <span class="course-price">3.500.00đ</span>
                                    </div>
                                </div>
                                <button class="btn-course">Chi tiết khóa học</button>
                            </div>
                        </div>
                        <!-- Course Card 2 -->
                        <div class="course-card">
                            <div class="course-img-wrap">
                                <img alt="IELTS intensive course"
                                    data-alt="Student practicing writing for English exam"
                                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuBeA5jyF8mNNZddpEbalkRzTTj_sUP3pICmnidfDt367Kq50wuc-7ag9u20Mmqi2wiMdJq2vLVPY_hO2pmxRHFprR2zYp8HmKQD2i-sGk0G51estiMDXDbNQjGUnWvX7Jeg9FuRTd26HScwwYN-gWa8mkDuYuiBy1u8WB6ehTgLG3oEKTuEgAQ0Nfob8cGKwqtGS13bU5wGhTpVEFkDqmT-iQMsf6iJKXiwvftLQ-W7Auo92qtiDHr5S1klBOUjlMCxwZdBDOPDHTLz" />
                            </div>
                            <div class="course-info">
                                <h3 class="course-name">Luyện thi IELTS Cấp Tốc 7.5+</h3>
                                <div class="course-meta">
                                    <div class="course-meta-item">
                                        <span class="material-symbols-outlined">schedule</span>
                                        <span class="course-meta-text">6 Tháng</span>
                                    </div>
                                    <div class="course-meta-item">
                                        <span class="material-symbols-outlined">payments</span>
                                        <span class="course-price">5.200.000đ</span>
                                    </div>
                                </div>
                                <button class="btn-course">Chi tiết khóa học</button>
                            </div>
                        </div>
                        <!-- Course Card 3 -->
                        <div class="course-card">
                            <div class="course-img-wrap">
                                <img alt="Middle school math course"
                                    data-alt="School child studying math on a chalkboard"
                                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuB1cKhAMKnOiB8uVROs20c2K61iTC5GccVeZyUQhiqSUdTE0myUxvYAEoPp689-tAcSNwlLjGEE6h1DBZ1HBhUp-XWLRgbp-jXviEU5ME_rtGhHt_3PTFoa-xIS85LqDEVhYlu1mifVZ3st7_hjv2Nz-wqH_0r4oRNyDyG_kuf4EE0DwMn0ugQigDIjuOI7T3j1HIg4fKij-cSBI-aiMJs65PYZ41DXJGsz9QT5lWgttnWE8wqGyvVhJFkbrla-S54kFk5xltAwoVI0" />
                            </div>
                            <div class="course-info">
                                <h3 class="course-name">Bồi dưỡng Toán lớp 9 &amp; Luyện thi vào 10</h3>
                                <div class="course-meta">
                                    <div class="course-meta-item">
                                        <span class="material-symbols-outlined">schedule</span>
                                        <span class="course-meta-text">9 Tháng</span>
                                    </div>
                                    <div class="course-meta-item">
                                        <span class="material-symbols-outlined">payments</span>
                                        <span class="course-price">2.800.000đ</span>
                                    </div>
                                </div>
                                <button class="btn-course">Chi tiết khóa học</button>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- Section 5: Banner 4 (Parent Testimonials) -->
            <section class="section-padding section-testimonials">
                <div class="testimonials-bg"></div>
                <div class="testimonials-content">
                    <div class="testimonials-header">
                        <span class="section-subtitle">Real Results</span>
                        <h2 class="section-title">Phụ Huynh Nói Gì Về Chúng Tôi</h2>
                    </div>
                    <div class="grid-2">
                        <!-- Quote 1 -->
                        <div class="testimonial-card">
                            <span class="material-symbols-outlined quote-icon">format_quote</span>
                            <p class="testimonial-text">
                                "Con tôi từ một học sinh trung bình môn Toán đã vươn lên top đầu của lớp sau 3 tháng học cùng gia sư của Academic Atelier. Phương pháp dạy rất trực quan và dễ hiểu."
                            </p>
                            <div class="testimonial-author">
                                <div class="author-img">
                                    <img alt="Parent avatar"
                                        data-alt="Profile photo of a middle-aged female parent"
                                        src="https://lh3.googleusercontent.com/aida-public/AB6AXuD5t6K2SDFapKQVMxDWSGELtqSgSbSYFkyg-ans3_GfXpJB0O6oGv9I0C3BpWnD4h-J8lrbTXHqISKLiLstpKUE_04LYemtjy95kszvR2j1SJ9gTyV32VGC5MyqYrx78huuXS169TTZkhQE0FiUaSixlIouihMusLCyQU0HWrUA0UwVFvNfKd6ScCWZZl4uUAacRLc6CKgHJFVVguV9y8c8O7EN6umMHlEoHIQ-ro_SCVCPTHzfy3MiiNkG20les6KPkgHf8lH-OKs8" />
                                </div>
                                <div>
                                    <h4 class="author-name">Chị Nguyễn Mai Phương</h4>
                                    <p class="author-title">Phụ huynh bé Gia Bảo - Lớp 8</p>
                                </div>
                            </div>
                        </div>
                        <!-- Quote 2 -->
                        <div class="testimonial-card">
                            <span class="material-symbols-outlined quote-icon">format_quote</span>
                            <p class="testimonial-text">
                               "Tôi rất hài lòng với đội ngũ gia sư tại đây. Không chỉ dạy kiến thức, các thầy cô còn truyền cảm hứng học tập và giúp con tôi tự tin hơn trong giao tiếp tiếng Anh."
                            </p>
                            <div class="testimonial-author">
                                <div class="author-img">
                                    <img alt="Parent avatar"
                                        data-alt="Profile photo of a professional male parent"
                                        src="https://lh3.googleusercontent.com/aida-public/AB6AXuA2EjouC4kJVCowz00a56AHArxsu8aVTXnL5YiD5zZev0Mtdczw5VS-p99yrCrtLqdbPr5MHktWq-kDDRJ51Ov5JQrb4wv-rbIBhoT5h7Jm1OZJ-87ifWaMlQqhbb0BtmBfRnZs_NMHuos36siEcHdDXsHbcAT75NxD2clKBmOaGjv2uB8QHw37t4SDEJ8J5xvDOBNt72r8pp1dGC7CCP9306EIIoicBGHTsmR4ASzchfROWqg-aIQyMH4N394jJuA8-RKPkZRKefhg" />
                                </div>
                                <div>
                                    <h4 class="author-name">Anh Lê Hoàng Long</h4>
                                    <p class="author-title">Phụ huynh bé Minh Anh - Lớp 11</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="slider-dots">
                        <button class="dot active"></button>
                        <button class="dot"></button>
                        <button class="dot"></button>
                    </div>
                </div>
            </section>
        </main>
        <!-- Section 6: Footer (Shared Component) -->
        <footer class="footer">
            <div class="footer-grid">
                <!-- Brand & Info -->
                <div>
                    <span class="footer-brand">Academic Atelier</span>
                    <p class="footer-desc">
                        Hệ thống quản lý và kết nối gia sư hàng đầu, mang đến giải pháp giáo dục toàn diện cho gia đình Việt.
                    </p>
                    <div class="social-links">
                        <a class="social-link" href="#">
                            <span class="material-symbols-outlined text-lg">public</span>
                        </a>
                        <a class="social-link" href="#">
                            <span class="material-symbols-outlined text-lg">mail</span>
                        </a>
                        <a class="social-link" href="#">
                            <span class="material-symbols-outlined text-lg">call</span>
                        </a>
                    </div>
                </div>
                <!-- Links -->
                <div class="footer-links-container">
                    <div>
                        <h4 class="footer-title">Thông tin</h4>
                        <ul class="footer-links">
                            <li><a class="footer-link" href="#">Về chúng tôi</a></li>
                            <li><a class="footer-link" href="#">Liên hệ</a></li>
                            <li><a class="footer-link" href="#">Hỗ trợ</a></li>
                        </ul>
                    </div>
                    <div>
                        <h4 class="footer-title">Hỗ trợ</h4>
                        <ul class="footer-links">
                            <li><a class="footer-link" href="#">FAQ</a></li>
                            <li><a class="footer-link" href="#">Chính sách bảo mật</a></li>
                            <li><a class="footer-link" href="#">Điều khoản sử dụng</a></li>
                        </ul>
                    </div>
                </div>
                <!-- Newsletter -->
                <div>
                    <h4 class="footer-title">Kết nối</h4>
                    <p class="newsletter-desc">Đăng ký nhận để cập nhật những kiến thức giáo dục mới nhất.</p>
                    <form class="newsletter-form">
                        <input class="newsletter-input" placeholder="Email của bạn" type="email" />
                        <button class="btn-send">
                            <span class="material-symbols-outlined">send</span>
                        </button>
                    </form>
                </div>
            </div>
            <div class="footer-bottom">
                <p class="copyright">© 2024 Academic Atelier. Nâng tầm tri thức Việt.</p>
                <div class="footer-bottom-links">
                    <a class="footer-bottom-link" href="#">Facebook</a>
                    <a class="footer-bottom-link" href="#">LinkedIn</a>
                    <a class="footer-bottom-link" href="#">YouTube</a>
                </div>
            </div>
        </footer>
    </body>

    </html>