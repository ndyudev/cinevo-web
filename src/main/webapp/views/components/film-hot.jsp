<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

            <div class="container-fluid bg-dark text-white py-5">
                <div class="container">

                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h3 class="text-uppercase fw-bold border-start border-4 border-danger ps-3">
                            Phim Đang Hot
                        </h3>
                        <a href="#" class="text-decoration-none text-danger fw-bold">Xem tất cả <i
                                class="fa-solid fa-angle-right"></i></a>
                    </div>

                    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-4 mb-5">

                        <c:forEach items="${top10Videos}" var="video" begin="0" end="3">
                            <div class="col">
                                <div class="card bg-transparent border-0 h-100 movie-card">
                                    <a href="${pageContext.request.contextPath}/cinevo/user?tab=video-detail&id=${video.id}"
                                        class="text-decoration-none">
                                        <div
                                            class="ratio ratio-16x9 overflow-hidden rounded shadow-sm position-relative">
                                            <img src="${video.posterUrl}" class="card-img-top" alt="${video.title}"
                                                onerror="this.src='https://via.placeholder.com/640x360?text=No+Image'">

                                            <div class="movie-overlay d-flex align-items-center justify-content-center">
                                                <div class="btn btn-danger rounded-circle btn-lg play-btn">
                                                    <i class="fa-solid fa-play"></i>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="card-body px-0 pt-3">
                                            <h5 class="card-title text-white fw-bold text-truncate">${video.title}</h5>
                                            <div class="d-flex justify-content-between text-secondary small">
                                                <span><i class="fa-solid fa-calendar-days me-1"></i>
                                                    ${video.releaseYear}</span>
                                                <span><i class="fa-solid fa-eye me-1"></i>
                                                    <fmt:formatNumber value="${video.views}" pattern="#,###" /> views
                                                </span>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </div>
                        </c:forEach>

                    </div>
                </div>
            </div>

            <style>
                /* Hiệu ứng Zoom nhẹ khi hover vào ảnh */
                .movie-card img {
                    transition: transform 0.4s ease;
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                }

                .movie-card:hover img {
                    transform: scale(1.1);
                }

                /* Lớp phủ đen mờ khi hover */
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

                /* Nút Play đẹp hơn */
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
            </style>