<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

            <div class="container-fluid bg-dark text-white py-5">
                <div class="container">
                    <div
                        class="d-flex justify-content-between align-items-center mb-4 border-bottom border-secondary pb-2">
                        <h3 class="text-uppercase fw-bold border-start border-4 border-danger ps-3 mb-0">
                            <i class="fa-solid fa-heart text-danger me-2"></i> Video Yêu Thích
                        </h3>
                    </div>

                    <c:choose>
                        <c:when test="${empty favoriteVideos}">
                            <div class="text-center py-5">
                                <i class="fa-solid fa-heart-crack display-1 text-secondary mb-3"></i>
                                <p class="text-secondary fs-5">Bạn chưa có video yêu thích nào.</p>
                                <a href="${pageContext.request.contextPath}/cinevo/user" class="btn btn-danger mt-3">
                                    <i class="fa-solid fa-film me-2"></i>Khám phá phim
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 row-cols-xl-4 g-4">
                                <c:forEach var="video" items="${favoriteVideos}">
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
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>