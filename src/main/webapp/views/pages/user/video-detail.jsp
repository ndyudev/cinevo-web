<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

            <div class="container-fluid bg-dark text-white py-4">
                <div class="container">
                    <div class="row g-4">

                        <!-- Cột chính: Video Player và Thông tin chi tiết -->
                        <div class="col-lg-8">

                            <!-- Video Player -->
                            <div class="video-wrapper rounded overflow-hidden shadow-lg mb-4">
                                <div class="ratio ratio-16x9">
                                    <c:choose>
                                        <c:when test="${not empty video.videoUrl}">
                                            <iframe src="${video.videoUrl}" title="${video.title}"
                                                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                                                allowfullscreen style="border: none;">
                                            </iframe>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="d-flex align-items-center justify-content-center bg-black">
                                                <div class="text-center">
                                                    <i class="fa-solid fa-video-slash fa-3x text-secondary mb-3"></i>
                                                    <p class="text-secondary">Video không khả dụng</p>
                                                </div>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <!-- Tiêu đề và thông tin phim -->
                            <div class="video-info mb-4">
                                <h2 class="fw-bold text-white mb-3">
                                    ${not empty video.title ? video.title : 'Video không có tiêu đề'}
                                </h2>

                                <div class="d-flex flex-wrap gap-3 align-items-center mb-3">
                                    <c:if test="${not empty video.category}">
                                        <span class="badge bg-danger rounded-pill px-3 py-2">
                                            <i class="fa-solid fa-folder me-1"></i> ${video.category.name}
                                        </span>
                                    </c:if>
                                    <span class="text-secondary">
                                        <i class="fa-solid fa-calendar-days me-1"></i> ${not empty video.releaseYear ?
                                        video.releaseYear : 'N/A'}
                                    </span>
                                    <span class="text-secondary">
                                        <i class="fa-solid fa-eye me-1"></i>
                                        <fmt:formatNumber value="${video.views}" pattern="#,###" /> lượt xem
                                    </span>
                                </div>



                                <!-- Action Buttons -->
                                <div class="d-flex flex-wrap gap-2 mb-4">
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.user}">
                                            <c:if test="${!sessionScope.user.isAdmin}">
                                                <form action="${pageContext.request.contextPath}/api/like-video"
                                                    method="post" class="d-inline">
                                                    <input type="hidden" name="videoId" value="${video.id}">
                                                    <button type="submit"
                                                        class="btn ${isLiked ? 'btn-danger' : 'btn-outline-danger'} px-4 py-2 shadow-sm">
                                                        <i
                                                            class="fa-${isLiked ? 'solid' : 'regular'} fa-heart me-2"></i>
                                                        ${isLiked ? 'Đã thích' : 'Yêu thích'}
                                                    </button>
                                                </form>
                                                <button class="btn btn-outline-light px-4 py-2" data-bs-toggle="modal"
                                                    data-bs-target="#shareModal">
                                                    <i class="fa-solid fa-share-nodes me-2"></i> Chia sẻ
                                                </button>
                                            </c:if>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/cinevo/user?tab=login"
                                                class="btn btn-danger px-4 py-2 shadow-sm">
                                                <i class="fa-solid fa-heart me-2"></i> Yêu thích
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <!-- Mô tả phim -->
                                <div
                                    class="description bg-black bg-opacity-25 p-4 rounded border border-secondary border-opacity-25">
                                    <h5 class="fw-bold mb-3 border-start border-4 border-danger ps-3">
                                        <i class="fa-solid fa-file-lines me-2"></i> Nội dung phim
                                    </h5>
                                    <p class="text-secondary lh-lg" style="text-align: justify;">
                                        ${not empty video.description ? video.description : 'Chưa có mô tả cho video
                                        này.'}
                                    </p>

                                    <hr class="border-secondary border-opacity-25 my-3">

                                    <div class="row g-3">
                                        <div class="col-md-12">
                                            <p class="mb-2"><strong class="text-white">Đạo diễn:</strong>
                                                <span class="text-secondary">${not empty video.director ? video.director
                                                    : 'Đang cập nhật'}</span>
                                            </p>
                                            <p class="mb-2"><strong class="text-white">Năm phát hành:</strong>
                                                <span class="text-secondary">${not empty video.releaseYear ?
                                                    video.releaseYear : 'N/A'}</span>
                                            </p>
                                            <p class="mb-2"><strong class="text-white">Ngày tải lên:</strong>
                                                <span class="text-secondary">
                                                    <fmt:formatDate value="${video.uploadedDate}"
                                                        pattern="dd/MM/yyyy HH:mm" />
                                                </span>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Cột phụ: Phim liên quan -->
                        <div class="col-lg-4">
                            <div
                                class="sidebar bg-black bg-opacity-25 p-3 rounded border border-secondary border-opacity-25">

                                <div
                                    class="d-flex align-items-center mb-3 pb-2 border-bottom border-secondary border-opacity-25">
                                    <i class="fa-solid fa-film text-danger fs-5 me-2"></i>
                                    <h5 class="fw-bold text-white mb-0">Phim liên quan</h5>
                                </div>

                                <!-- Danh sách phim liên quan -->
                                <div class="related-videos">

                                    <c:choose>
                                        <c:when test="${not empty relatedVideos}">
                                            <c:forEach var="relatedVideo" items="${relatedVideos}">
                                                <a href="${pageContext.request.contextPath}/cinevo/user?tab=video-detail&id=${relatedVideo.id}"
                                                    class="text-decoration-none">
                                                    <div
                                                        class="related-item d-flex gap-3 mb-3 pb-3 border-bottom border-secondary border-opacity-25 hover-item">
                                                        <div class="ratio ratio-16x9 rounded overflow-hidden shadow-sm position-relative"
                                                            style="width: 120px; flex-shrink: 0;">
                                                            <img src="${relatedVideo.posterUrl}"
                                                                alt="${relatedVideo.title}" class="related-thumb"
                                                                onerror="this.src='https://via.placeholder.com/320x180?text=No+Image'">
                                                            <div class="related-overlay">
                                                                <i class="fa-solid fa-play text-white"></i>
                                                            </div>
                                                        </div>
                                                        <div class="flex-grow-1">
                                                            <h6 class="text-white fw-bold mb-2 text-truncate-2">
                                                                ${relatedVideo.title}</h6>
                                                            <div class="text-secondary small">
                                                                <div><i class="fa-solid fa-calendar-days me-1"></i>
                                                                    ${relatedVideo.releaseYear}</div>
                                                                <div><i class="fa-solid fa-eye me-1"></i>
                                                                    <fmt:formatNumber value="${relatedVideo.views}"
                                                                        pattern="#,###" /> views
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </a>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="text-center text-secondary py-4">
                                                <i class="fa-solid fa-film-slash fa-2x mb-2"></i>
                                                <p>Không có phim liên quan</p>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>

                                </div>

                            </div>
                        </div>

                    </div>
                </div>
            </div>

            <style>
                /* Video wrapper */
                .video-wrapper {
                    background: #000;
                }

                /* Text truncate 2 lines */
                .text-truncate-2 {
                    display: -webkit-box;
                    -webkit-line-clamp: 2;
                    -webkit-box-orient: vertical;
                    overflow: hidden;
                    line-height: 1.4;
                }

                /* Related videos hover effects */
                .hover-item {
                    transition: all 0.3s ease;
                    cursor: pointer;
                }

                .hover-item:hover {
                    background: rgba(220, 53, 69, 0.1);
                    padding: 8px;
                    border-radius: 8px;
                    margin: -8px;
                    margin-bottom: 4px;
                }

                .related-thumb {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                    transition: transform 0.3s ease;
                }

                .hover-item:hover .related-thumb {
                    transform: scale(1.1);
                }

                .related-overlay {
                    position: absolute;
                    top: 0;
                    left: 0;
                    width: 100%;
                    height: 100%;
                    background: rgba(0, 0, 0, 0.6);
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    opacity: 0;
                    transition: opacity 0.3s ease;
                    z-index: 2;
                }

                .hover-item:hover .related-overlay {
                    opacity: 1;
                }

                /* Form controls */
                .form-control:focus {
                    background-color: #1a1a1a;
                    border-color: #dc3545;
                    color: white;
                    box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.25);
                }

                .form-control::placeholder {
                    color: #6c757d;
                }

                /* Comment item hover */
                .comment-item {
                    transition: background 0.2s ease;
                }

                .comment-item:hover {
                    background: rgba(255, 255, 255, 0.02);
                    padding: 12px;
                    margin: -12px;
                    margin-bottom: 12px;
                    border-radius: 8px;
                }

                /* Button hover effects */
                .btn-outline-light:hover {
                    background-color: #343a40;
                    border-color: #343a40;
                    color: white;
                }

                .btn-outline-secondary:hover {
                    background-color: rgba(108, 117, 125, 0.2);
                    border-color: transparent;
                }

                /* Badge hover */
                .badge {
                    transition: all 0.2s ease;
                    cursor: pointer;
                }

                .badge:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
                }
            </style>

            <!-- Share Modal -->
            <div class="modal fade" id="shareModal" tabindex="-1" aria-labelledby="shareModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content bg-dark text-white border-secondary">
                        <div class="modal-header border-secondary">
                            <h5 class="modal-title" id="shareModalLabel">
                                <i class="fa-solid fa-share-nodes me-2 text-danger"></i>Chia sẻ video
                            </h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                        </div>
                        <form action="${pageContext.request.contextPath}/api/share-video" method="post">
                            <div class="modal-body">
                                <input type="hidden" name="videoId" value="${video.id}">
                                <div class="mb-3">
                                    <label class="form-label">Email người nhận <span
                                            class="text-danger">*</span></label>
                                    <input type="email" name="toEmail"
                                        class="form-control bg-black text-white border-secondary"
                                        placeholder="example@email.com" required>
                                </div>
                                <div class="alert alert-info bg-black border-secondary text-white-50">
                                    <i class="fa-solid fa-info-circle me-2"></i>
                                    Link video sẽ được gửi kèm tên của bạn đến email này.
                                </div>
                            </div>
                            <div class="modal-footer border-secondary">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                <button type="submit" class="btn btn-danger">
                                    <i class="fa-solid fa-paper-plane me-2"></i>Gửi
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>