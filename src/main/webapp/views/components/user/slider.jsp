<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html>

            <head>
                <style>
                    /* --- 1. CẤU TRÚC CHUNG --- */
                    .movie-slider-item {
                        height: 75vh;
                        min-height: 500px;
                        position: relative;
                        overflow: hidden;
                        background-color: #000;
                    }

                    /* --- 2. ẢNH NỀN MỜ (Backdrop) --- */
                    .youtube-backdrop {
                        position: absolute;
                        inset: 0;
                        /* Phủ kín khung */
                        background-size: cover;
                        background-position: center;
                        filter: blur(20px) brightness(0.4);
                        /* Làm mờ và tối đi */
                        transform: scale(1.1);
                        /* Phóng to nhẹ để che viền mờ */
                        z-index: 0;
                    }

                    /* --- 3. CONTAINER NỘI DUNG (Dùng Flexbox để chia cột và căn giữa) --- */
                    .slider-content-wrapper {
                        position: absolute;
                        inset: 0;
                        z-index: 2;
                        display: flex;
                        /* Kích hoạt Flexbox */
                        align-items: center;
                        /* Căn giữa theo chiều dọc */
                        padding: 0 8%;
                        /* Cách lề trái phải để tránh nút mũi tên */
                    }

                    /* --- Cột Chữ (Trái) --- */
                    .movie-info-col {
                        flex: 1;
                        /* Chiếm hết không gian còn lại */
                        padding-right: 20px;
                        color: white;
                        text-align: left;
                        z-index: 3;
                    }

                    .movie-title {
                        font-size: 2rem;
                        font-weight: 900;
                        text-transform: uppercase;
                        text-shadow: 2px 2px 10px rgba(0, 0, 0, 0.8);
                        margin-bottom: 1rem;
                        line-height: 1.2;
                    }

                    /* Responsive font size */
                    @media (min-width: 992px) {
                        .movie-title {
                            font-size: 3.5rem;
                        }

                        .movie-info-col {
                            padding-right: 50px;
                        }
                    }

                    .movie-meta span {
                        margin-right: 15px;
                        font-size: 0.9rem;
                        display: inline-flex;
                        align-items: center;
                        font-weight: 600;
                        text-transform: uppercase;
                    }

                    .movie-desc {
                        display: -webkit-box;
                        -webkit-line-clamp: 3;
                        /* Giới hạn 3 dòng */
                        -webkit-box-orient: vertical;
                        overflow: hidden;
                        margin-bottom: 2rem;
                        text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.8);
                        font-size: 1.1rem;
                        opacity: 0.9;
                    }

                    /* --- Cột Ảnh Poster (Phải) --- */
                    .movie-poster-col {
                        width: 50%;
                        /* Chiếm 50% chiều rộng */
                        max-width: 700px;
                        display: none;
                        /* Ẩn trên mobile */
                        position: relative;
                        z-index: 3;
                    }

                    /* Chỉ hiện ảnh phải trên màn hình lớn */
                    @media (min-width: 992px) {
                        .movie-poster-col {
                            display: block;
                        }

                        .movie-info-col {
                            max-width: 50%;
                        }

                        /* Chia đôi màn hình */
                    }

                    .poster-frame {
                        box-shadow: 0 0 50px rgba(0, 0, 0, 0.8);
                        border-radius: 12px;
                        overflow: hidden;
                        transition: transform 0.3s ease;
                        border: 1px solid rgba(255, 255, 255, 0.1);
                    }

                    .poster-frame:hover {
                        transform: scale(1.02);
                    }

                    .poster-img {
                        width: 100%;
                        display: block;
                    }

                    /* --- 4. NÚT ĐIỀU HƯỚNG (Mũi tên) --- */
                    .carousel-control-prev,
                    .carousel-control-next {
                        width: 5%;
                        /* Thu hẹp vùng bấm để dính sát lề */
                        opacity: 0.5;
                        z-index: 10;
                    }

                    .carousel-control-prev-icon,
                    .carousel-control-next-icon {
                        width: 3rem;
                        height: 3rem;
                        filter: drop-shadow(0px 0px 3px rgba(0, 0, 0, 1));
                    }

                    .carousel-indicators {
                        bottom: 15px;
                        z-index: 10;
                    }
                </style>
            </head>

            <body>

                <div id="heroCarousel" class="carousel slide carousel-fade" data-bs-ride="carousel"
                    data-bs-interval="5000">

                    <div class="carousel-indicators">
                        <c:forEach var="video" items="${latestVideos}" varStatus="status">
                            <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="${status.index}"
                                class="${status.first ? 'active' : ''}"></button>
                        </c:forEach>
                    </div>

                    <div class="carousel-inner">

                        <c:forEach var="video" items="${latestVideos}" varStatus="status">
                            <div class="carousel-item ${status.first ? 'active' : ''} movie-slider-item">
                                <div class="youtube-backdrop" style="background-image: url('${video.posterUrl}');">
                                </div>

                                <div class="slider-content-wrapper">

                                    <div class="movie-info-col">
                                        <h1 class="movie-title">${video.title}</h1>

                                        <div class="movie-meta mb-4 text-light">
                                            <span
                                                class="badge bg-danger rounded-1 px-2 py-1">${video.category.name}</span>
                                            <span><i class="fa-solid fa-user-tie me-2 text-danger"></i>
                                                ${video.director}</span>
                                            <span><i class="fa-solid fa-eye me-2 text-danger"></i>
                                                <fmt:formatNumber value="${video.views}" pattern="#,###" /> views
                                            </span>
                                        </div>

                                        <p class="lead text-white-50 movie-desc d-none d-lg-block">
                                            ${video.description}
                                        </p>

                                        <div>
                                            <a href="${pageContext.request.contextPath}/cinevo/user?tab=video-detail&id=${video.id}"
                                                class="btn btn-danger btn-lg rounded-pill px-5 fw-bold shadow border-2 border-white">
                                                <i class="fa-solid fa-play me-2"></i> Xem Ngay
                                            </a>
                                        </div>
                                    </div>

                                    <div class="movie-poster-col">
                                        <div class="ratio ratio-16x9 poster-frame">
                                            <a
                                                href="${pageContext.request.contextPath}/cinevo/user?tab=video-detail&id=${video.id}">
                                                <img src="${video.posterUrl}" class="poster-img" alt="${video.title}">
                                                <div
                                                    class="position-absolute top-50 start-50 translate-middle text-white opacity-75">

                                                </div>
                                            </a>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </c:forEach>

                    </div>

                    <button class="carousel-control-prev" type="button" data-bs-target="#heroCarousel"
                        data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#heroCarousel"
                        data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    </button>
                </div>

            </body>

            </html>