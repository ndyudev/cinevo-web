<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="container-fluid bg-dark text-white py-5">
    <div class="container">
        
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="text-uppercase fw-bold border-start border-4 border-danger ps-3">
                Phim Đang Hot
            </h3>
            <a href="#" class="text-decoration-none text-danger fw-bold">Xem tất cả <i class="fa-solid fa-angle-right"></i></a>
        </div>

        <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-4 mb-5">
            
            <div class="col">
                <div class="card bg-transparent border-0 h-100 movie-card">
                    <div class="ratio ratio-16x9 overflow-hidden rounded shadow-sm position-relative">
                        <img src="https://img.youtube.com/vi/xvaRHXSU3WE/maxresdefault.jpg" class="card-img-top" alt="Avatar">
                        
                        <div class="movie-overlay d-flex align-items-center justify-content-center">
                            <a href="#" class="btn btn-danger rounded-circle btn-lg play-btn">
                                <i class="fa-solid fa-play"></i>
                            </a>
                        </div>
                        
                     
                    </div>
                    
                    <div class="card-body px-0 pt-3">
                        <h5 class="card-title text-white fw-bold text-truncate">Avatar: Dòng Chảy Của Nước</h5>
                        <div class="d-flex justify-content-between text-secondary small">
                            <span><i class="fa-solid fa-calendar-days me-1"></i> 2022</span>
                            <span><i class="fa-solid fa-eye me-1"></i> 1.2M views</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col">
                <div class="card bg-transparent border-0 h-100 movie-card">
                    <div class="ratio ratio-16x9 overflow-hidden rounded shadow-sm position-relative">
                        <img src="https://img.youtube.com/vi/TcMBFSGVi1c/maxresdefault.jpg" class="card-img-top" alt="Avengers">
                        <div class="movie-overlay d-flex align-items-center justify-content-center">
                            <a href="#" class="btn btn-danger rounded-circle btn-lg play-btn"><i class="fa-solid fa-play"></i></a>
                        </div>
                    </div>
                    <div class="card-body px-0 pt-3">
                        <h5 class="card-title text-white fw-bold text-truncate">Avengers: Endgame</h5>
                        <div class="d-flex justify-content-between text-secondary small">
                            <span><i class="fa-solid fa-calendar-days me-1"></i> 2019</span>
                            <span><i class="fa-solid fa-eye me-1"></i> 5M views</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col">
                <div class="card bg-transparent border-0 h-100 movie-card">
                    <div class="ratio ratio-16x9 overflow-hidden rounded shadow-sm position-relative">
                        <img src="https://img.youtube.com/vi/xvaRHXSU3WE/maxresdefault.jpg" class="card-img-top" alt="Spiderman">
                        <div class="movie-overlay d-flex align-items-center justify-content-center">
                            <a href="#" class="btn btn-danger rounded-circle btn-lg play-btn"><i class="fa-solid fa-play"></i></a>
                        </div>
                    </div>
                    <div class="card-body px-0 pt-3">
                        <h5 class="card-title text-white fw-bold text-truncate">Spider-Man: No Way Home</h5>
                        <div class="d-flex justify-content-between text-secondary small">
                            <span><i class="fa-solid fa-calendar-days me-1"></i> 2021</span>
                            <span><i class="fa-solid fa-eye me-1"></i> 3.4M views</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col">
                <div class="card bg-transparent border-0 h-100 movie-card">
                    <div class="ratio ratio-16x9 overflow-hidden rounded shadow-sm position-relative">
                        <img src="https://img.youtube.com/vi/qEVUtrk8_B4/maxresdefault.jpg" class="card-img-top" alt="John Wick">
                        <div class="movie-overlay d-flex align-items-center justify-content-center">
                            <a href="#" class="btn btn-danger rounded-circle btn-lg play-btn"><i class="fa-solid fa-play"></i></a>
                        </div>
                    </div>
                    <div class="card-body px-0 pt-3">
                        <h5 class="card-title text-white fw-bold text-truncate">John Wick: Chapter 4</h5>
                        <div class="d-flex justify-content-between text-secondary small">
                            <span><i class="fa-solid fa-calendar-days me-1"></i> 2023</span>
                            <span><i class="fa-solid fa-eye me-1"></i> 800K views</span>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<style>
    /* Hiệu ứng Zoom nhẹ khi hover vào ảnh */
    .movie-card img {
        transition: transform 0.4s ease;
        width: 100%;
        height: 100%;
        object-fit: cover; /* Đảm bảo ảnh lấp đầy khung 16:9 */
    }
    
    .movie-card:hover img {
        transform: scale(1.1);
    }

    /* Lớp phủ đen mờ khi hover */
    .movie-overlay {
        position: absolute;
        top: 0; left: 0; width: 100%; height: 100%;
        background: rgba(0,0,0,0.4);
        opacity: 0;
        transition: all 0.3s ease;
        z-index: 2;
    }

    .movie-card:hover .movie-overlay {
        opacity: 1;
    }

    /* Nút Play đẹp hơn */
    .play-btn {
        width: 50px; height: 50px;
        display: flex; align-items: center; justify-content: center;
        transform: scale(0.8);
        transition: transform 0.2s;
    }
    
    .movie-card:hover .play-btn {
        transform: scale(1.1);
    }
</style>