<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

                <div class="container-fluid bg-dark text-white py-5">
                    <div class="container">
                        <div
                            class="d-flex justify-content-between align-items-center mb-4 border-bottom border-secondary pb-2">
                            <h3 class="text-uppercase fw-bold border-start border-4 border-danger ps-3 mb-0">
                                <i class="fa-solid fa-share-nodes text-danger me-2"></i> Lịch Sử Chia Sẻ
                            </h3>
                        </div>

                        <c:choose>
                            <c:when test="${empty shares}">
                                <div class="text-center py-5">
                                    <i class="fa-solid fa-share-from-square display-1 text-secondary mb-3"></i>
                                    <p class="text-secondary fs-5">Bạn chưa chia sẻ video nào.</p>
                                    <a href="${pageContext.request.contextPath}/cinevo/user"
                                        class="btn btn-danger mt-3">
                                        <i class="fa-solid fa-film me-2"></i>Khám phá phim
                                    </a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="row">
                                    <div class="col-12">
                                        <div class="card bg-black bg-opacity-25 border border-secondary">
                                            <div class="card-body p-0">
                                                <div class="table-responsive">
                                                    <table class="table table-dark table-hover mb-0">
                                                        <thead>
                                                            <tr>
                                                                <th width="5%">#</th>
                                                                <th width="35%">Video</th>
                                                                <th width="25%">Email người nhận</th>
                                                                <th width="20%">Ngày chia sẻ</th>
                                                                <th width="15%">Thao tác</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="share" items="${shares}" varStatus="status">
                                                                <tr>
                                                                    <td>${status.count}</td>
                                                                    <td>
                                                                        <div class="d-flex align-items-center">
                                                                            <img src="${share.video.posterUrl}"
                                                                                alt="${share.video.title}"
                                                                                class="rounded me-3"
                                                                                style="width: 80px; height: 45px; object-fit: cover;">
                                                                            <div>
                                                                                <h6 class="mb-0 text-white">
                                                                                    <c:choose>
                                                                                        <c:when
                                                                                            test="${fn:length(share.video.title) > 50}">
                                                                                            ${fn:substring(share.video.title,
                                                                                            0,
                                                                                            50)}...
                                                                                        </c:when>
                                                                                        <c:otherwise>
                                                                                            ${share.video.title}
                                                                                        </c:otherwise>
                                                                                    </c:choose>
                                                                                </h6>
                                                                                <small class="text-secondary">
                                                                                    ${share.video.category.name} •
                                                                                    ${share.video.releaseYear}
                                                                                </small>
                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <i
                                                                            class="fa-solid fa-envelope me-2 text-secondary"></i>
                                                                        ${share.sharedToEmail}
                                                                    </td>
                                                                    <td>
                                                                        <i
                                                                            class="fa-solid fa-clock me-2 text-secondary"></i>
                                                                        <fmt:formatDate value="${share.shareDate}"
                                                                            pattern="dd/MM/yyyy HH:mm" />
                                                                    </td>
                                                                    <td>
                                                                        <a href="${pageContext.request.contextPath}/cinevo/user?tab=video-detail&id=${share.video.id}"
                                                                            class="btn btn-sm btn-outline-danger">
                                                                            <i class="fa-solid fa-play me-1"></i>Xem
                                                                        </a>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>