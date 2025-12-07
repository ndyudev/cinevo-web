<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>

        <div class="container-fluid py-4">
            <h3 class="fw-bold text-white mb-4">
                <i class="fa-solid fa-list-ul text-danger me-2"></i>
                Quản Lý Danh Mục
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
                            <h5 class="mb-0 text-white"><i class="fa-solid fa-list me-2"></i>Danh Sách Danh Mục</h5>
                        </div>
                        <div class="card-body">
                            <table class="table table-dark table-hover">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Tên Danh Mục</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="category" items="${categories}" varStatus="status">
                                        <tr>
                                            <td>${status.count}</td>
                                            <td>${category.name}</td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/admin/categories/edit?id=${category.id}"
                                                    class="btn btn-sm btn-warning">
                                                    <i class="fa-solid fa-edit"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/admin/categories/delete?id=${category.id}"
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
                                action="${pageContext.request.contextPath}/admin/categories/${empty form.id ? 'create' : 'update'}"
                                method="post">
                                <c:if test="${not empty form.id}">
                                    <input type="hidden" name="id" value="${form.id}">
                                </c:if>

                                <div class="mb-3">
                                    <label class="text-white">Tên Danh Mục *</label>
                                    <input type="text" class="form-control bg-dark text-white" name="name"
                                        value="${form.name}" required>
                                </div>

                                <button type="submit" class="btn btn-danger w-100">
                                    <i class="fa-solid fa-save me-2"></i>Lưu
                                </button>
                                <a href="${pageContext.request.contextPath}/admin/categories/reset"
                                    class="btn btn-secondary w-100 mt-2">
                                    <i class="fa-solid fa-times me-2"></i>Hủy
                                </a>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>