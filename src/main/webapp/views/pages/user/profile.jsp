<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>

        <div class="container py-5">
            <div class="row">
                <div class="col-md-6 mx-auto">
                    <div class="card bg-dark text-white border-secondary">
                        <div class="card-header bg-danger">
                            <h4 class="mb-0"><i class="fa-solid fa-user-circle me-2"></i>Hồ Sơ Cá Nhân</h4>
                        </div>
                        <div class="card-body p-4">
                            <div class="text-center mb-4">
                                <div class="rounded-circle bg-secondary d-inline-flex justify-content-center align-items-center"
                                    style="width: 100px; height: 100px;">
                                    <i class="fa-solid fa-user display-4"></i>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label text-secondary">Họ và tên</label>
                                <input type="text" class="form-control bg-black text-white border-secondary"
                                    value="${sessionScope.user.fullname}" readonly>
                            </div>

                            <div class="mb-3">
                                <label class="form-label text-secondary">Email</label>
                                <input type="email" class="form-control bg-black text-white border-secondary"
                                    value="${sessionScope.user.email}" readonly>
                            </div>

                            <div class="text-center mt-4">
                                <a href="${pageContext.request.contextPath}/user/change-password"
                                    class="btn btn-danger">
                                    <i class="fa-solid fa-key me-2"></i>Đổi mật khẩu
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>