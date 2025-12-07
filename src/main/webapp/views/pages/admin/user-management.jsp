<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>

        <div class="container-fluid py-4">
            <h3 class="fw-bold text-white mb-4">
                <i class="fa-solid fa-users text-danger me-2"></i>
                Quản Lý Người Dùng
            </h3>

            <!-- Messages -->
            <c:if test="${not empty message}">
                <div class="alert alert-info alert-dismissible fade show">
                    ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <div class="row">
                <!-- Left: Danh sách -->
                <div class="col-md-8">
                    <div class="card bg-black bg-opacity-25 border border-secondary">
                        <div class="card-header bg-dark">
                            <h5 class="mb-0 text-white"><i class="fa-solid fa-list me-2"></i>Danh Sách</h5>
                        </div>
                        <div class="card-body">
                            <table class="table table-dark table-hover">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Email</th>
                                        <th>Họ tên</th>
                                        <th>Vai trò</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="user" items="${users}" varStatus="status">
                                        <tr>
                                            <td>${status.count}</td>
                                            <td>${user.email}</td>
                                            <td>${user.fullname}</td>
                                            <td>
                                                <c:if test="${user.isAdmin}">
                                                    <span class="badge bg-danger">Admin</span>
                                                </c:if>
                                                <c:if test="${!user.isAdmin}">
                                                    <span class="badge bg-secondary">User</span>
                                                </c:if>
                                            </td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/admin/users/edit?id=${user.id}"
                                                    class="btn btn-sm btn-warning">
                                                    <i class="fa-solid fa-edit"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/admin/users/delete?id=${user.id}"
                                                    class="btn btn-sm btn-danger">
                                                    <i class="fa-solid fa-trash"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- Right: Form -->
                <div class="col-md-4">
                    <div class="card bg-black bg-opacity-25 border border-secondary">
                        <div class="card-header bg-dark">
                            <h5 class="mb-0 text-white">
                                <i class="fa-solid fa-${empty form.id ? 'plus' : 'edit'} me-2"></i>
                                ${empty form.id ? 'Thêm Mới' : 'Chỉnh Sửa'}
                            </h5>
                        </div>
                        <div class="card-body">
                            <form
                                action="${pageContext.request.contextPath}/admin/users/${empty form.id ? 'create' : 'update'}"
                                method="post">
                                <input type="hidden" name="id" value="${form.id}">

                                <div class="mb-3">
                                    <label class="text-white">Email *</label>
                                    <input type="email" class="form-control bg-dark text-white" name="email"
                                        value="${form.email}" required>
                                </div>

                                <div class="mb-3">
                                    <label class="text-white">Mật khẩu ${empty form.id ? '*' : ''}</label>
                                    <input type="password" class="form-control bg-dark text-white" name="password"
                                        value="${form.password}" ${empty form.id ? 'required' : '' }>
                                </div>

                                <div class="mb-3">
                                    <label class="text-white">Họ tên</label>
                                    <input type="text" class="form-control bg-dark text-white" name="fullname"
                                        value="${form.fullname}">
                                </div>

                                <div class="mb-3 form-check">
                                    <input type="checkbox" class="form-check-input" name="isAdmin" ${form.isAdmin
                                        ? 'checked' : '' }>
                                    <label class="form-check-label text-white">Admin</label>
                                </div>

                                <button type="submit" class="btn btn-danger w-100">
                                    <i class="fa-solid fa-save me-2"></i>Lưu
                                </button>
                                <a href="${pageContext.request.contextPath}/admin/users/reset"
                                    class="btn btn-secondary w-100 mt-2">
                                    <i class="fa-solid fa-times me-2"></i>Hủy
                                </a>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>