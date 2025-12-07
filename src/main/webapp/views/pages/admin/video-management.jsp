<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>


                <div class="container-fluid py-4">
                    <h3 class="fw-bold text-white mb-4">
                        <i class="fa-solid fa-video text-danger me-2"></i> Quản Lý Video
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
                                    <h5 class="mb-0 text-white">
                                        <i class="fa-solid fa-list me-2"></i>Danh Sách
                                    </h5>
                                </div>
                                <div class="card-body">
                                    <table class="table table-dark table-hover">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Tiêu đề</th>
                                                <th>Đạo diễn</th>
                                                <th>Năm</th>
                                                <th>Danh mục</th>
                                                <th>Lượt xem</th>
                                                <th>Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="video" items="${videos}" varStatus="status">
                                                <tr>
                                                    <td>${status.count}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${fn:length(video.title) > 50}">
                                                                ${fn:substring(video.title, 0, 50)}...
                                                            </c:when>
                                                            <c:otherwise>
                                                                ${video.title}
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>${video.director}</td>
                                                    <td>${video.releaseYear}</td>
                                                    <td>${video.category.name}</td>
                                                    <td>${video.views}</td>
                                                    <td><a href="${pageContext.request.contextPath}/admin/videos/edit?id=${video.id}"
                                                            class="btn btn-sm btn-warning"> <i
                                                                class="fa-solid fa-edit"></i>
                                                        </a> <a
                                                            href="${pageContext.request.contextPath}/admin/videos/delete?id=${video.id}"
                                                            class="btn btn-sm btn-danger"> <i
                                                                class="fa-solid fa-trash"></i>
                                                        </a></td>
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
                                        action="${pageContext.request.contextPath}/admin/videos/${empty form.id ? 'create' : 'update'}"
                                        method="post">
                                        <input type="hidden" name="id" value="${form.id}">

                                        <!-- Tiêu đề -->
                                        <div class="mb-3">
                                            <label class="text-white">Tiêu đề <span class="text-danger">*</span></label>
                                            <input type="text" name="title" class="form-control bg-dark text-white"
                                                value="${form.title}" required>
                                        </div>

                                        <!-- Video URL (YouTube) -->
                                        <div class="mb-3">
                                            <label class="text-white">Link Video YouTube <span
                                                    class="text-danger">*</span></label> <input type="text"
                                                name="videoUrl" class="form-control bg-dark text-white"
                                                value="${form.videoUrl}" placeholder="Otp3fV5yd8c" required> <small
                                                class="form-text text-muted">Nhập mã video (từ link:
                                                https://youtube.com/embed/<b>Otp3fV5yd8c</b>)
                                            </small>
                                        </div>

                                        <!-- Poster URL -->
                                        <div class="mb-3">
                                            <label class="text-white">Link Poster <span
                                                    class="text-danger">*</span></label> <input type="text"
                                                name="posterUrl" class="form-control bg-dark text-white"
                                                value="${form.posterUrl}"
                                                placeholder="https://img.youtube.com/vi/Otp3fV5yd8c/maxresdefault.jpg"
                                                required> <small class="form-text text-muted">Copy
                                                link này:
                                                <code>https://img.youtube.com/vi/Otp3fV5yd8c/maxresdefault.jpg</code>
                                                và đổi <b>Otp3fV5yd8c</b> thành mã video
                                            </small>
                                        </div>

                                        <!-- Mô tả -->
                                        <div class="mb-3">
                                            <label class="text-white">Mô tả</label>
                                            <textarea name="description" class="form-control bg-dark text-white"
                                                rows="3">${form.description}</textarea>
                                        </div>

                                        <!-- Đạo diễn -->
                                        <div class="mb-3">
                                            <label class="text-white">Đạo diễn</label> <input type="text"
                                                name="director" class="form-control bg-dark text-white"
                                                value="${form.director}">
                                        </div>

                                        <!-- Năm phát hành -->
                                        <div class="mb-3">
                                            <label class="text-white">Năm phát hành</label> <input type="number"
                                                name="releaseYear" class="form-control bg-dark text-white"
                                                value="${form.releaseYear}" min="1900" max="2100">
                                        </div>

                                        <!-- Danh mục -->
                                        <div class="mb-3">
                                            <label class="text-white">Danh mục <span
                                                    class="text-danger">*</span></label> <select name="categoryId"
                                                class="form-select bg-dark text-white" required>
                                                <option value="">-- Chọn danh mục --</option>
                                                <c:forEach var="cat" items="${categories}">
                                                    <option value="${cat.id}" ${form.category.id==cat.id ? 'selected'
                                                        : '' }>
                                                        ${cat.name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>

                                        <!-- Buttons -->
                                        <button type="submit" class="btn btn-danger w-100">
                                            <i class="fa-solid fa-save me-2"></i>${empty form.id ? 'Thêm mới' : 'Cập
                                            nhật'}
                                        </button>
                                        <a href="${pageContext.request.contextPath}/admin/videos/reset"
                                            class="btn btn-secondary w-100 mt-2"> <i
                                                class="fa-solid fa-times me-2"></i>Hủy
                                        </a>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>