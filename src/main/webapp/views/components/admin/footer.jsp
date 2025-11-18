<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<footer class="bg-black text-white pt-5 pb-3 border-top border-secondary border-opacity-25">
    <div class="container">
        <div class="row g-4">
            
            <div class="col-md-4 col-lg-4">
                <a href="${pageContext.request.contextPath}/home" class="text-decoration-none mb-3 d-block">
                     <img src="${pageContext.request.contextPath}/images/cinevo-logo.svg" alt="Cinevo" width="150px">
                </a>
                <p class="text-secondary small">
                    Cinevo - Trang web xem phim trực tuyến miễn phí chất lượng cao. Kho phim đa dạng, cập nhật liên tục các bom tấn mới nhất từ rạp.
                </p>
                <div class="d-flex gap-3 mt-4">
                    <a href="#" class="social-icon rounded-circle bg-dark text-white d-flex align-items-center justify-content-center">
                        <i class="fa-brands fa-facebook-f"></i>
                    </a>
                    <a href="#" class="social-icon rounded-circle bg-dark text-white d-flex align-items-center justify-content-center">
                        <i class="fa-brands fa-youtube"></i>
                    </a>
                    <a href="#" class="social-icon rounded-circle bg-dark text-white d-flex align-items-center justify-content-center">
                        <i class="fa-brands fa-tiktok"></i>
                    </a>
                    <a href="#" class="social-icon rounded-circle bg-dark text-white d-flex align-items-center justify-content-center">
                        <i class="fa-brands fa-instagram"></i>
                    </a>
                </div>
            </div>

            <div class="col-6 col-md-4 col-lg-2">
                <h5 class="fw-bold mb-3 text-uppercase fs-6 border-start border-4 border-danger ps-2">Phim Mới</h5>
                <ul class="list-unstyled text-secondary small footer-links">
                    <li class="mb-2"><a href="#" class="text-decoration-none text-secondary">Phim Hành Động</a></li>
                    <li class="mb-2"><a href="#" class="text-decoration-none text-secondary">Phim Viễn Tưởng</a></li>
                    <li class="mb-2"><a href="#" class="text-decoration-none text-secondary">Phim Tình Cảm</a></li>
                    <li class="mb-2"><a href="#" class="text-decoration-none text-secondary">Phim Hoạt Hình</a></li>
                    <li class="mb-2"><a href="#" class="text-decoration-none text-secondary">Phim Chiếu Rạp</a></li>
                </ul>
            </div>

            <div class="col-6 col-md-4 col-lg-2">
                <h5 class="fw-bold mb-3 text-uppercase fs-6 border-start border-4 border-danger ps-2">Hỗ Trợ</h5>
                <ul class="list-unstyled text-secondary small footer-links">
                    <li class="mb-2"><a href="#" class="text-decoration-none text-secondary">Tài khoản của tôi</a></li>
                    <li class="mb-2"><a href="#" class="text-decoration-none text-secondary">Đăng ký hội viên</a></li>
                    <li class="mb-2"><a href="#" class="text-decoration-none text-secondary">Chính sách bảo mật</a></li>
                    <li class="mb-2"><a href="#" class="text-decoration-none text-secondary">Khiếu nại bản quyền</a></li>
                    <li class="mb-2"><a href="#" class="text-decoration-none text-secondary">Liên hệ quảng cáo</a></li>
                </ul>
            </div>

            <div class="col-md-12 col-lg-4">
                 <h5 class="fw-bold mb-3 text-uppercase fs-6 border-start border-4 border-danger ps-2">Liên Hệ</h5>
                 <ul class="list-unstyled text-secondary small">
                    <li class="mb-3"><i class="fa-solid fa-location-dot me-2 text-danger"></i> Tòa nhà FPT Polytechnic, Cần Thơ</li>
                    <li class="mb-3"><i class="fa-solid fa-envelope me-2 text-danger"></i> contact@cinevo.com</li>
                    <li class="mb-3"><i class="fa-solid fa-phone me-2 text-danger"></i> (+84) 999 888 777</li>
                </ul>
                
                <div class="input-group mt-4">
                    <input type="text" class="form-control bg-dark border-0 text-white shadow-none" placeholder="Nhập email nhận phim mới...">
                    <button class="btn btn-danger fw-bold" type="button"><i class="fa-solid fa-paper-plane"></i></button>
                </div>
            </div>
        </div>

        <div class="row mt-5 pt-3 border-top border-secondary border-opacity-25">
            <div class="col-md-6 text-center text-md-start">
                <p class="small text-secondary mb-0">&copy; 2025 <strong>Cinevo</strong>. All Rights Reserved. Designed by <strong>Dyu Dev</strong>.</p>
            </div>
            <div class="col-md-6 text-center text-md-end d-none d-md-block">
                <img src="https://upload.wikimedia.org/wikipedia/commons/0/04/Visa.svg" alt="Visa" width="40" class="mx-1 opacity-50">
                <img src="https://upload.wikimedia.org/wikipedia/commons/b/b5/PayPal.svg" alt="Paypal" width="40" class="mx-1 opacity-50">
                <img src="https://upload.wikimedia.org/wikipedia/commons/2/2a/Mastercard-logo.svg" alt="Mastercard" width="40" class="mx-1 opacity-50">
            </div>
        </div>
    </div>
</footer>

<style>
    /* CSS RIÊNG CHO FOOTER */
    
    /* Hiệu ứng hover link */
    .footer-links a {
        transition: all 0.3s ease;
    }
    .footer-links a:hover {
        color: #dc3545 !important; /* Màu đỏ Bootstrap khi hover */
        padding-left: 5px; /* Dịch chuyển nhẹ sang phải */
    }

    /* Social Icons */
    .social-icon {
        width: 35px;
        height: 35px;
        transition: all 0.3s ease;
        text-decoration: none;
    }
    .social-icon:hover {
        background-color: #dc3545 !important; /* Đổi nền đỏ khi hover */
        transform: translateY(-3px); /* Nổi lên nhẹ */
    }
</style>