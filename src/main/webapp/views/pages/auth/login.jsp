<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>

        <div class="container d-flex align-items-center justify-content-center" style="min-height: 80vh;">
            <div class="card bg-dark text-white border border-secondary border-opacity-25 shadow-lg"
                style="width: 400px;">
                <div class="card-body p-5">
                    <h2 class="text-center fw-bold mb-4 text-danger">ĐĂNG NHẬP</h2>

                    <!-- Hiển thị thông báo lỗi -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fa-solid fa-circle-exclamation me-2"></i>${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <!-- Hiển thị thông báo security message -->
                    <c:if test="${not empty sessionScope.securityMessage}">
                        <div class="alert alert-warning alert-dismissible fade show" role="alert">
                            <i class="fa-solid fa-triangle-exclamation me-2"></i>${sessionScope.securityMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <c:remove var="securityMessage" scope="session" />
                    </c:if>

                    <form action="${pageContext.request.contextPath}/auth/login" method="post">
                        <div class="mb-3">
                            <label class="form-label text-secondary">Email</label>
                            <div class="input-group">
                                <span class="input-group-text bg-black text-secondary border-secondary"><i
                                        class="fa-solid fa-envelope"></i></span>
                                <input type="email" name="email"
                                    class="form-control bg-black text-white border-secondary"
                                    placeholder="name@example.com" value="${email}" required>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label text-secondary">Mật khẩu</label>
                            <div class="input-group">
                                <span class="input-group-text bg-black text-secondary border-secondary"><i
                                        class="fa-solid fa-lock"></i></span>
                                <input type="password" name="password"
                                    class="form-control bg-black text-white border-secondary" placeholder="••••••••"
                                    required>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-danger w-100 fw-bold mb-3">Đăng Nhập</button>

                        <div class="form-check text-secondary small">
                            <input class="form-check-input bg-secondary border-0" type="checkbox" id="remember">
                            <label class="form-check-label" for="remember">Ghi nhớ tôi</label>
                        </div>
                    </form>

                    <div class="text-center mt-4 pt-3 border-top border-secondary border-opacity-25">
                        <span class="text-secondary">Chưa có tài khoản? </span>
                        <a href="${pageContext.request.contextPath}/cinevo/user?tab=register"
                            class="text-white fw-bold text-decoration-none">Đăng ký ngay</a>
                    </div>
                </div>
            </div>
        </div>