<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

            <div class="container-fluid bg-dark text-white py-5">
                <div class="container">
                    <div class="row g-4">

                        <div class="col-lg-8">
                            <div
                                class="d-flex justify-content-between align-items-center mb-4 border-bottom border-secondary pb-2">
                                <h3 class="text-uppercase fw-bold border-start border-4 border-danger ps-3 mb-0">
                                    Phim Mới Cập Nhật
                                </h3>
                            </div>

                            <div class="row row-cols-1 row-cols-md-2 row-cols-xl-3 g-3">
                                <c:forEach var="video" items="${allVideos}">
                                    <div class="col">
                                        <div class="card bg-transparent border-0 h-100 movie-card">
                                            <div
                                                class="ratio ratio-16x9 overflow-hidden rounded shadow-sm position-relative">
                                                <img src="${video.posterUrl}" class="card-img-top" alt="${video.title}">
                                                <div
                                                    class="movie-overlay d-flex align-items-center justify-content-center">
                                                    <a href="${pageContext.request.contextPath}/cinevo/user?tab=video-detail&id=${video.id}"
                                                        class="btn btn-danger rounded-circle btn-lg play-btn">
                                                        <i class="fa-solid fa-play"></i>
                                                    </a>
                                                </div>
                                            </div>
                                            <div class="card-body px-0 pt-3">
                                                <h5 class="card-title text-white fw-bold text-truncate">${video.title}
                                                </h5>
                                                <div class="d-flex justify-content-between text-secondary small">
                                                    <span><i class="fa-solid fa-calendar-days me-1"></i>
                                                        ${video.releaseYear}</span>
                                                    <span><i class="fa-solid fa-eye me-1"></i>
                                                        <fmt:formatNumber value="${video.views}" pattern="#,###" />
                                                        views
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>

                            <!-- Pagination -->
                            <c:if test="${totalPages > 1}">
                                <nav aria-label="Page navigation" class="mt-5">
                                    <ul class="pagination justify-content-center custom-pagination">
                                        <!-- Previous Button -->
                                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                            <a class="page-link"
                                                href="${pageContext.request.contextPath}/cinevo/user?page=${currentPage - 1}${selectedCategoryId != null ? '&categoryId='.concat(selectedCategoryId) : ''}${selectedYear != null ? '&year='.concat(selectedYear) : ''}"
                                                tabindex="-1">
                                                <i class="fa-solid fa-chevron-left"></i>
                                            </a>
                                        </li>

                                        <!-- Page Numbers -->
                                        <c:forEach var="i" begin="1" end="${totalPages}">
                                            <c:if
                                                test="${i == 1 || i == totalPages || (i >= currentPage - 2 && i <= currentPage + 2)}">
                                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                    <a class="page-link"
                                                        href="${pageContext.request.contextPath}/cinevo/user?page=${i}${selectedCategoryId != null ? '&categoryId='.concat(selectedCategoryId) : ''}${selectedYear != null ? '&year='.concat(selectedYear) : ''}">
                                                        ${i}
                                                    </a>
                                                </li>
                                            </c:if>
                                            <c:if test="${i == currentPage - 3 || i == currentPage + 3}">
                                                <li class="page-item disabled">
                                                    <span class="page-link">...</span>
                                                </li>
                                            </c:if>
                                        </c:forEach>

                                        <!-- Next Button -->
                                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                            <a class="page-link"
                                                href="${pageContext.request.contextPath}/cinevo/user?page=${currentPage + 1}${selectedCategoryId != null ? '&categoryId='.concat(selectedCategoryId) : ''}${selectedYear != null ? '&year='.concat(selectedYear) : ''}">
                                                <i class="fa-solid fa-chevron-right"></i>
                                            </a>
                                        </li>
                                    </ul>
                                </nav>
                            </c:if>
                        </div>

                        <div class="col-lg-4">
                            <div
                                class="sidebar bg-black bg-opacity-25 p-3 rounded h-100 border border-secondary border-opacity-25">

                                <div
                                    class="d-flex align-items-center mb-3 pb-2 border-bottom border-secondary border-opacity-25">
                                    <i class="fa-solid fa-fire text-danger fs-5 me-2"></i>
                                    <h5 class="fw-bold text-white mb-0">Được xem nhiều</h5>
                                </div>

                                <ul class="nav nav-tabs trending-tabs border-secondary border-opacity-25 mb-3"
                                    id="myTab" role="tablist">
                                    <li class="nav-item" role="presentation">
                                        <button class="nav-link text-secondary" id="day-tab" data-bs-toggle="tab"
                                            data-bs-target="#day" type="button">Ngày</button>
                                    </li>
                                    <li class="nav-item" role="presentation">
                                        <button class="nav-link active" id="week-tab" data-bs-toggle="tab"
                                            data-bs-target="#week" type="button">Tuần</button>
                                    </li>
                                    <li class="nav-item" role="presentation">
                                        <button class="nav-link text-secondary" id="month-tab" data-bs-toggle="tab"
                                            data-bs-target="#month" type="button">Tháng</button>
                                    </li>
                                </ul>

                                <div class="tab-content" id="myTabContent">

                                    <div class="tab-pane fade" id="day" role="tabpanel">
                                        <div class="row row-cols-2 g-3">
                                            <c:forEach var="video" items="${top4Today}">
                                                <div class="col">
                                                    <div class="card bg-transparent border-0 h-100 movie-card">
                                                        <div
                                                            class="ratio ratio-16x9 overflow-hidden rounded shadow-sm position-relative">
                                                            <img src="${video.posterUrl}" class="card-img-top"
                                                                alt="${video.title}">
                                                            <div
                                                                class="movie-overlay d-flex align-items-center justify-content-center">
                                                                <a href="${pageContext.request.contextPath}/cinevo/user?tab=video-detail&id=${video.id}"
                                                                    class="btn btn-danger rounded-circle btn-lg play-btn">
                                                                    <i class="fa-solid fa-play"></i>
                                                                </a>
                                                            </div>
                                                        </div>
                                                        <div class="card-body px-0 pt-3">
                                                            <h6
                                                                class="card-title text-white fw-bold text-truncate font-sm">
                                                                ${video.title}</h6>
                                                            <div
                                                                class="d-flex justify-content-between text-secondary font-xs">
                                                                <span>${video.releaseYear}</span>
                                                                <span>
                                                                    <fmt:formatNumber value="${video.views}"
                                                                        pattern="#,###" /> views
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>

                                    <div class="tab-pane fade show active" id="week" role="tabpanel">
                                        <div class="row row-cols-2 g-3">
                                            <c:forEach var="video" items="${top4Week}">
                                                <div class="col">
                                                    <div class="card bg-transparent border-0 h-100 movie-card">
                                                        <div
                                                            class="ratio ratio-16x9 overflow-hidden rounded shadow-sm position-relative">
                                                            <img src="${video.posterUrl}" class="card-img-top"
                                                                alt="${video.title}">
                                                            <div
                                                                class="movie-overlay d-flex align-items-center justify-content-center">
                                                                <a href="${pageContext.request.contextPath}/cinevo/user?tab=video-detail&id=${video.id}"
                                                                    class="btn btn-danger rounded-circle btn-lg play-btn">
                                                                    <i class="fa-solid fa-play"></i>
                                                                </a>
                                                            </div>
                                                        </div>
                                                        <div class="card-body px-0 pt-3">
                                                            <h6
                                                                class="card-title text-white fw-bold text-truncate font-sm">
                                                                ${video.title}</h6>
                                                            <div
                                                                class="d-flex justify-content-between text-secondary font-xs">
                                                                <span>${video.releaseYear}</span>
                                                                <span>
                                                                    <fmt:formatNumber value="${video.views}"
                                                                        pattern="#,###" /> views
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>

                                    <div class="tab-pane fade" id="month" role="tabpanel">
                                        <div class="row row-cols-2 g-3">
                                            <c:forEach var="video" items="${top4Month}">
                                                <div class="col">
                                                    <div class="card bg-transparent border-0 h-100 movie-card">
                                                        <div
                                                            class="ratio ratio-16x9 overflow-hidden rounded shadow-sm position-relative">
                                                            <img src="${video.posterUrl}" class="card-img-top"
                                                                alt="${video.title}">
                                                            <div
                                                                class="movie-overlay d-flex align-items-center justify-content-center">
                                                                <a href="${pageContext.request.contextPath}/cinevo/user?tab=video-detail&id=${video.id}"
                                                                    class="btn btn-danger rounded-circle btn-lg play-btn">
                                                                    <i class="fa-solid fa-play"></i>
                                                                </a>
                                                            </div>
                                                        </div>
                                                        <div class="card-body px-0 pt-3">
                                                            <h6
                                                                class="card-title text-white fw-bold text-truncate font-sm">
                                                                ${video.title}</h6>
                                                            <div
                                                                class="d-flex justify-content-between text-secondary font-xs">
                                                                <span>${video.releaseYear}</span>
                                                                <span>
                                                                    <fmt:formatNumber value="${video.views}"
                                                                        pattern="#,###" /> views
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <style>
                .font-sm {
                    font-size: 0.85rem;
                }

                .font-xs {
                    font-size: 0.75rem;
                }

                .hover-link:hover {
                    color: #fff !important;
                    text-decoration: none !important;
                }

                /* CSS Card */
                .movie-card img {
                    transition: transform 0.4s ease;
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                }

                .movie-card:hover img {
                    transform: scale(1.1);
                }

                .movie-overlay {
                    position: absolute;
                    top: 0;
                    left: 0;
                    width: 100%;
                    height: 100%;
                    background: rgba(0, 0, 0, 0.4);
                    opacity: 0;
                    transition: all 0.3s ease;
                    z-index: 2;
                }

                .movie-card:hover .movie-overlay {
                    opacity: 1;
                }

                .play-btn {
                    width: 50px;
                    height: 50px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    transform: scale(0.8);
                    transition: transform 0.2s;
                }

                .movie-card:hover .play-btn {
                    transform: scale(1.1);
                }

                /* CSS Tabs */
                .trending-tabs {
                    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
                }

                .trending-tabs .nav-link {
                    color: #adb5bd;
                    background: transparent !important;
                    border: none;
                    border-bottom: 3px solid transparent;
                    padding: 8px 15px;
                    font-weight: 600;
                    font-size: 0.9rem;
                    transition: all 0.3s ease;
                }

                .trending-tabs .nav-link:hover {
                    color: #fff;
                }

                .trending-tabs .nav-link.active {
                    color: #dc3545 !important;
                    background: transparent !important;
                    border-bottom: 3px solid #dc3545 !important;
                }

                /* CSS Pagination */
                .custom-pagination .page-link {
                    color: #adb5bd;
                    background-color: transparent;
                    border: 1px solid #444;
                    margin: 0 3px;
                    border-radius: 4px;
                }

                .custom-pagination .page-link:hover {
                    color: #fff;
                    background-color: #333;
                    border-color: #555;
                }

                .custom-pagination .page-item.active .page-link {
                    color: #fff;
                    background-color: #dc3545;
                    border-color: #dc3545;
                }

                .custom-pagination .page-item.disabled .page-link {
                    color: #6c757d;
                    background-color: transparent;
                    border-color: #333;
                }

                .page-link:focus {
                    box-shadow: none;
                }
            </style>