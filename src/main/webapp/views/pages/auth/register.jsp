<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="container d-flex align-items-center justify-content-center" style="min-height: 80vh;">
    <div class="card bg-dark text-white border border-secondary border-opacity-25 shadow-lg" style="width: 450px;">
        <div class="card-body p-5">
            <h2 class="text-center fw-bold mb-4 text-danger">ĐĂNG KÝ</h2>
            
            <form action="" method="post">
                <div class="mb-3">
                    <label class="form-label text-secondary">Họ và tên</label>
                    <input type="text" class="form-control bg-black text-white border-secondary" placeholder="Nguyễn Văn A">
                </div>

                <div class="mb-3">
                    <label class="form-label text-secondary">Email</label>
                    <input type="email" class="form-control bg-black text-white border-secondary" placeholder="name@example.com">
                </div>

                <div class="mb-3">
                    <label class="form-label text-secondary">Mật khẩu</label>
                    <input type="password" class="form-control bg-black text-white border-secondary" placeholder="••••••••">
                </div>

                <div class="mb-4">
                    <label class="form-label text-secondary">Nhập lại mật khẩu</label>
                    <input type="password" class="form-control bg-black text-white border-secondary" placeholder="••••••••">
                </div>

                <button type="submit" class="btn btn-danger w-100 fw-bold mb-3">Đăng Ký</button>
            </form>
            
            <div class="text-center mt-3 pt-3 border-top border-secondary border-opacity-25">
                <span class="text-secondary">Đã có tài khoản? </span>
                <a href="${pageContext.request.contextPath}/cinevo/user?tab=login" class="text-white fw-bold text-decoration-none">Đăng nhập</a>
            </div>
        </div>
    </div>
</div>