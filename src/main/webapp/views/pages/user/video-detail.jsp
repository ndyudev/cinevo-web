<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>

        <div class="container-fluid bg-dark text-white py-4">
            <div class="container">
                <div class="row g-4">

                    <!-- Cột chính: Video Player và Thông tin chi tiết -->
                    <div class="col-lg-8">

                        <!-- Video Player -->
                        <div class="video-wrapper rounded overflow-hidden shadow-lg mb-4">
                            <div class="ratio ratio-16x9">
                                <iframe
                                    src="https://www.youtube.com/embed/${param.id != null ? param.id : 'qEVUtrk8_B4'}?rel=0&showinfo=0&modestbranding=1"
                                    title="Video player"
                                    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                                    allowfullscreen style="border: none;">
                                </iframe>
                            </div>
                        </div>

                        <!-- Tiêu đề và thông tin phim -->
                        <div class="video-info mb-4">
                            <h2 class="fw-bold text-white mb-3">
                                ${video.title != null ? video.title : 'John Wick: Chapter 4'}
                            </h2>

                            <div class="d-flex flex-wrap gap-3 align-items-center mb-3">
                                <span class="badge bg-danger rounded-pill px-3 py-2">
                                    <i class="fa-solid fa-star me-1"></i> 8.5/10
                                </span>
                                <span class="text-secondary">
                                    <i class="fa-solid fa-calendar-days me-1"></i> ${video.year != null ? video.year :
                                    '2023'}
                                </span>
                                <span class="text-secondary">
                                    <i class="fa-solid fa-clock me-1"></i> ${video.duration != null ? video.duration :
                                    '169 phút'}
                                </span>
                                <span class="text-secondary">
                                    <i class="fa-solid fa-eye me-1"></i> ${video.views != null ? video.views : '2.5M'}
                                    lượt xem
                                </span>
                            </div>

                            <div class="d-flex flex-wrap gap-2 mb-4">
                                <c:choose>
                                    <c:when test="${not empty video.categories}">
                                        <c:forEach var="category" items="${video.categories}">
                                            <span
                                                class="badge bg-secondary bg-opacity-25 border border-secondary text-white px-3 py-2">
                                                ${category}
                                            </span>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <span
                                            class="badge bg-secondary bg-opacity-25 border border-secondary text-white px-3 py-2">Hành
                                            Động</span>
                                        <span
                                            class="badge bg-secondary bg-opacity-25 border border-secondary text-white px-3 py-2">Kinh
                                            Dị</span>
                                        <span
                                            class="badge bg-secondary bg-opacity-25 border border-secondary text-white px-3 py-2">Phiêu
                                            Lưu</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <!-- Action Buttons -->
                            <div class="d-flex flex-wrap gap-2 mb-4">
                                <button class="btn btn-danger px-4 py-2 shadow-sm" id="likeBtn">
                                    <i class="fa-solid fa-heart me-2"></i> Yêu thích
                                </button>
                                <button class="btn btn-outline-light px-4 py-2" id="shareBtn">
                                    <i class="fa-solid fa-share-nodes me-2"></i> Chia sẻ
                                </button>
                                <button class="btn btn-outline-light px-4 py-2">
                                    <i class="fa-solid fa-list-ul me-2"></i> Playlist
                                </button>
                            </div>

                            <!-- Mô tả phim -->
                            <div
                                class="description bg-black bg-opacity-25 p-4 rounded border border-secondary border-opacity-25">
                                <h5 class="fw-bold mb-3 border-start border-4 border-danger ps-3">
                                    <i class="fa-solid fa-file-lines me-2"></i> Nội dung phim
                                </h5>
                                <p class="text-secondary lh-lg" style="text-align: justify;">
                                    ${video.description != null ? video.description :
                                    'John Wick phát hiện ra cách để đánh bại High Table. Nhưng trước khi có thể giành
                                    được tự do, Wick phải đối đầu với kẻ thù mới với những liên minh mạnh mẽ trên khắp
                                    thế giới và những thế lực biến những người bạn cũ thành kẻ thù.'}
                                </p>

                                <hr class="border-secondary border-opacity-25 my-3">

                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <p class="mb-2"><strong class="text-white">Đạo diễn:</strong>
                                            <span class="text-secondary">${video.director != null ? video.director :
                                                'Chad Stahelski'}</span>
                                        </p>
                                        <p class="mb-2"><strong class="text-white">Diễn viên:</strong>
                                            <span class="text-secondary">${video.cast != null ? video.cast : 'Keanu
                                                Reeves, Donnie Yen, Bill Skarsgård'}</span>
                                        </p>
                                    </div>
                                    <div class="col-md-6">
                                        <p class="mb-2"><strong class="text-white">Quốc gia:</strong>
                                            <span class="text-secondary">${video.country != null ? video.country :
                                                'Mỹ'}</span>
                                        </p>
                                        <p class="mb-2"><strong class="text-white">Ngôn ngữ:</strong>
                                            <span class="text-secondary">${video.language != null ? video.language :
                                                'Tiếng Anh (Phụ đề)'}</span>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Bình luận section -->
                        <div
                            class="comments-section bg-black bg-opacity-25 p-4 rounded border border-secondary border-opacity-25">
                            <h5 class="fw-bold mb-4 border-start border-4 border-danger ps-3">
                                <i class="fa-solid fa-comments me-2"></i> Bình luận (142)
                            </h5>

                            <!-- Form bình luận -->
                            <div class="mb-4">
                                <textarea class="form-control bg-dark text-white border-secondary" rows="3"
                                    placeholder="Viết bình luận của bạn..."></textarea>
                                <button class="btn btn-danger mt-2 px-4">
                                    <i class="fa-solid fa-paper-plane me-2"></i> Gửi
                                </button>
                            </div>

                            <!-- Danh sách bình luận mẫu -->
                            <div
                                class="comment-item d-flex gap-3 mb-3 pb-3 border-bottom border-secondary border-opacity-25">
                                <div class="rounded-circle bg-secondary d-flex justify-content-center align-items-center"
                                    style="width: 45px; height: 45px; flex-shrink: 0;">
                                    <i class="fa-solid fa-user text-white"></i>
                                </div>
                                <div class="flex-grow-1">
                                    <div class="d-flex justify-content-between align-items-center mb-1">
                                        <h6 class="mb-0 fw-bold text-white">Nguyễn Văn A</h6>
                                        <small class="text-secondary">2 giờ trước</small>
                                    </div>
                                    <p class="text-secondary mb-2">Phim hay quá! John Wick phần này đỉnh cao hành động.
                                        Cảnh quay mãn nhãn.</p>
                                    <button class="btn btn-sm btn-outline-secondary border-0 px-2">
                                        <i class="fa-solid fa-thumbs-up me-1"></i> 24
                                    </button>
                                </div>
                            </div>

                            <div
                                class="comment-item d-flex gap-3 mb-3 pb-3 border-bottom border-secondary border-opacity-25">
                                <div class="rounded-circle bg-secondary d-flex justify-content-center align-items-center"
                                    style="width: 45px; height: 45px; flex-shrink: 0;">
                                    <i class="fa-solid fa-user text-white"></i>
                                </div>
                                <div class="flex-grow-1">
                                    <div class="d-flex justify-content-between align-items-center mb-1">
                                        <h6 class="mb-0 fw-bold text-white">Trần Thị B</h6>
                                        <small class="text-secondary">1 ngày trước</small>
                                    </div>
                                    <p class="text-secondary mb-2">Keanu Reeves xuất sắc. Mãi xem không chán 🔥</p>
                                    <button class="btn btn-sm btn-outline-secondary border-0 px-2">
                                        <i class="fa-solid fa-thumbs-up me-1"></i> 15
                                    </button>
                                </div>
                            </div>

                            <button class="btn btn-outline-light btn-sm w-100 mt-3">
                                <i class="fa-solid fa-angle-down me-2"></i> Xem thêm bình luận
                            </button>
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

                                <a href="${pageContext.request.contextPath}/cinevo/user?tab=video-detail"
                                    class="text-decoration-none">
                                    <div
                                        class="related-item d-flex gap-3 mb-3 pb-3 border-bottom border-secondary border-opacity-25 hover-item">
                                        <div class="ratio ratio-16x9 rounded overflow-hidden shadow-sm position-relative"
                                            style="width: 120px; flex-shrink: 0;">
                                            <img src="https://img.youtube.com/vi/TcMBFSGVi1c/mqdefault.jpg"
                                                alt="Avengers Endgame" class="related-thumb">
                                            <div class="related-overlay">
                                                <i class="fa-solid fa-play text-white"></i>
                                            </div>
                                        </div>
                                        <div class="flex-grow-1">
                                            <h6 class="text-white fw-bold mb-2 text-truncate-2">Avengers: Endgame</h6>
                                            <div class="text-secondary small">
                                                <div><i class="fa-solid fa-calendar-days me-1"></i> 2019</div>
                                                <div><i class="fa-solid fa-eye me-1"></i> 5M views</div>
                                            </div>
                                        </div>
                                    </div>
                                </a>

                                <a href="${pageContext.request.contextPath}/cinevo/user?tab=video-detail"
                                    class="text-decoration-none">
                                    <div
                                        class="related-item d-flex gap-3 mb-3 pb-3 border-bottom border-secondary border-opacity-25 hover-item">
                                        <div class="ratio ratio-16x9 rounded overflow-hidden shadow-sm position-relative"
                                            style="width: 120px; flex-shrink: 0;">
                                            <img src="https://img.youtube.com/vi/Otp3fV5yd8c/mqdefault.jpg"
                                                alt="Interstellar" class="related-thumb">
                                            <div class="related-overlay">
                                                <i class="fa-solid fa-play text-white"></i>
                                            </div>
                                        </div>
                                        <div class="flex-grow-1">
                                            <h6 class="text-white fw-bold mb-2 text-truncate-2">Interstellar</h6>
                                            <div class="text-secondary small">
                                                <div><i class="fa-solid fa-calendar-days me-1"></i> 2014</div>
                                                <div><i class="fa-solid fa-eye me-1"></i> 3.8M views</div>
                                            </div>
                                        </div>
                                    </div>
                                </a>

                                <a href="${pageContext.request.contextPath}/cinevo/user?tab=video-detail"
                                    class="text-decoration-none">
                                    <div
                                        class="related-item d-flex gap-3 mb-3 pb-3 border-bottom border-secondary border-opacity-25 hover-item">
                                        <div class="ratio ratio-16x9 rounded overflow-hidden shadow-sm position-relative"
                                            style="width: 120px; flex-shrink: 0;">
                                            <img src="https://img.youtube.com/vi/xvaRHXSU3WE/mqdefault.jpg"
                                                alt="Shutter Island" class="related-thumb">
                                            <div class="related-overlay">
                                                <i class="fa-solid fa-play text-white"></i>
                                            </div>
                                        </div>
                                        <div class="flex-grow-1">
                                            <h6 class="text-white fw-bold mb-2 text-truncate-2">Shutter Island</h6>
                                            <div class="text-secondary small">
                                                <div><i class="fa-solid fa-calendar-days me-1"></i> 2010</div>
                                                <div><i class="fa-solid fa-eye me-1"></i> 1.2M views</div>
                                            </div>
                                        </div>
                                    </div>
                                </a>

                                <a href="${pageContext.request.contextPath}/cinevo/user?tab=video-detail"
                                    class="text-decoration-none">
                                    <div
                                        class="related-item d-flex gap-3 mb-3 pb-3 border-bottom border-secondary border-opacity-25 hover-item">
                                        <div class="ratio ratio-16x9 rounded overflow-hidden shadow-sm position-relative"
                                            style="width: 120px; flex-shrink: 0;">
                                            <img src="https://img.youtube.com/vi/uujdjah8wAA/mqdefault.jpg"
                                                alt="Titanic" class="related-thumb">
                                            <div class="related-overlay">
                                                <i class="fa-solid fa-play text-white"></i>
                                            </div>
                                        </div>
                                        <div class="flex-grow-1">
                                            <h6 class="text-white fw-bold mb-2 text-truncate-2">Titanic</h6>
                                            <div class="text-secondary small">
                                                <div><i class="fa-solid fa-calendar-days me-1"></i> 1997</div>
                                                <div><i class="fa-solid fa-eye me-1"></i> 12M views</div>
                                            </div>
                                        </div>
                                    </div>
                                </a>

                                <a href="${pageContext.request.contextPath}/cinevo/user?tab=video-detail"
                                    class="text-decoration-none">
                                    <div class="related-item d-flex gap-3 mb-3 hover-item">
                                        <div class="ratio ratio-16x9 rounded overflow-hidden shadow-sm position-relative"
                                            style="width: 120px; flex-shrink: 0;">
                                            <img src="https://img.youtube.com/vi/4H2Ui3ZKy7s/mqdefault.jpg"
                                                alt="The Conjuring" class="related-thumb">
                                            <div class="related-overlay">
                                                <i class="fa-solid fa-play text-white"></i>
                                            </div>
                                        </div>
                                        <div class="flex-grow-1">
                                            <h6 class="text-white fw-bold mb-2 text-truncate-2">The Conjuring</h6>
                                            <div class="text-secondary small">
                                                <div><i class="fa-solid fa-calendar-days me-1"></i> 2013</div>
                                                <div><i class="fa-solid fa-eye me-1"></i> 2.1M views</div>
                                            </div>
                                        </div>
                                    </div>
                                </a>

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

        <script>
            // Like button functionality
            document.getElementById('likeBtn').addEventListener('click', function () {
                const icon = this.querySelector('i');
                if (icon.classList.contains('fa-solid')) {
                    icon.classList.remove('fa-solid');
                    icon.classList.add('fa-regular');
                    this.classList.remove('btn-danger');
                    this.classList.add('btn-outline-danger');
                } else {
                    icon.classList.remove('fa-regular');
                    icon.classList.add('fa-solid');
                    this.classList.remove('btn-outline-danger');
                    this.classList.add('btn-danger');
                }
            });

            // Share button functionality
            document.getElementById('shareBtn').addEventListener('click', function () {
                if (navigator.share) {
                    navigator.share({
                        title: document.querySelector('h2').textContent,
                        url: window.location.href
                    });
                } else {
                    // Fallback: copy URL to clipboard
                    navigator.clipboard.writeText(window.location.href).then(() => {
                        alert('Đã sao chép link vào clipboard!');
                    });
                }
            });
        </script>