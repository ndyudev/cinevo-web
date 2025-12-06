<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>

        <div class="container py-5">
            <div class="row">
                <div class="col-md-5 mx-auto">
                    <div class="card bg-dark text-white border-secondary">
                        <div class="card-header bg-danger">
                            <h4 class="mb-0"><i class="fa-solid fa-key me-2"></i>Đổi Mật Khẩu</h4>
                        </div>
                        <div class="card-body p-4">

                            <c:if test="${not empty error}">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <i class="fa-solid fa-circle-exclamation me-2"></i>${error}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>

                            <form method="post">
                                <div class="mb-3">
                                    <label class="form-label text-secondary">Mật khẩu cũ</label>
                                    <input type="password" name="oldPassword"
                                        class="form-control bg-black text-white border-secondary" placeholder="••••••••"
                                        required>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label text-secondary">Mật khẩu mới</label>
                                    <input type="password" name="newPassword"
                                        class="form-control bg-black text-white border-secondary" placeholder="••••••••"
                                        required>
                                </div>

                                <div class="mb-4">
                                    <label class="form-label text-secondary">Nhập lại mật khẩu mới</label>
                                    <input type="password" name="confirmPassword"
                                        class="form-control bg-black text-white border-secondary" placeholder="••••••••"
                                        required>
                                </div>

                                <div class="d-grid gap-2">
                                    <button type="submit" class="btn btn-danger">
                                        <i class="fa-solid fa-check me-2"></i>Đổi mật khẩu
                                    </button>
                                    <a href="${pageContext.request.contextPath}/cinevo/user" class="btn btn-secondary">
                                        <i class="fa-solid fa-arrow-left me-2"></i>Quay lại
                                    </a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>