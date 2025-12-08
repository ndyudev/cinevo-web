<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>

        <nav class="navbar navbar-expand-lg navbar-dark text-white fw-bold bg-black sticky-top shadow-sm"
            style="z-index: 1020; border-bottom: 1px solid #333;">
            <div class="container">

                <a class="navbar-brand" href="${pageContext.request.contextPath}/cinevo/user">
                    <img src="${pageContext.request.contextPath}/images/cinevo-logo.svg" alt="Cinevo" width="150px">
                </a>

                <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse"
                    data-bs-target="#collapsibleNavbar">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="collapsibleNavbar">
                    <ul class="navbar-nav ms-auto me-auto mb-2 mb-lg-0">

                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle header-link" href="#" role="button"
                                data-bs-toggle="dropdown">
                                <i class="fa-solid fa-list-ul me-1"></i> Thể loại
                            </a>
                            <ul class="dropdown-menu dropdown-menu-dark shadow fade-down rounded-0 p-0 border-0">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/cinevo/user">Tất
                                        cả thể loại</a></li>
                                <c:forEach var="category" items="${categories}">
                                    <li><a class="dropdown-item"
                                            href="${pageContext.request.contextPath}/cinevo/user?categoryId=${category.id}">${category.name}</a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </li>

                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle header-link" href="#" role="button"
                                data-bs-toggle="dropdown">
                                <i class="fa-solid fa-video me-1"></i> Năm sản xuất
                            </a>
                            <ul
                                class="dropdown-menu dropdown-menu-dark shadow fade-down scrollable-menu rounded-0 p-0 border-0">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/cinevo/user">Tất
                                        cả năm</a></li>
                                <c:forEach var="year" begin="0" end="35">
                                    <c:set var="currentYear" value="${2025 - year}" />
                                    <li>
                                        <a class="dropdown-item"
                                            href="${pageContext.request.contextPath}/cinevo/user?year=${currentYear}">Năm
                                            ${currentYear}</a>
                                    </li>
                                </c:forEach>

                            </ul>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link header-link" href="#"><i class="fa-solid fa-film me-1"></i> Phim hay</a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link header-link" href="${pageContext.request.contextPath}/cinevo/user">
                                <i class="fa-solid fa-photo-film me-1"></i> Phim mới
                            </a>
                        </li>
                    </ul>

                    <div class="d-flex align-items-center gap-3">
                        <form class="d-flex" role="search" action="${pageContext.request.contextPath}/cinevo/user"
                            method="get">
                            <div class="input-group input-group-sm">
                                <input type="text" name="search"
                                    class="form-control bg-dark text-white border-secondary"
                                    placeholder="Tìm phim, đạo diễn..." value="${param.search}" style="width: 200px;">
                                <button class="btn btn-danger text-white" type="submit">
                                    <i class="fa-solid fa-magnifying-glass"></i>
                                </button>
                            </div>
                        </form>

                        <div class="dropdown">
                            <a class="nav-link dropdown-toggle d-flex align-items-center text-white" href="#"
                                role="button" data-bs-toggle="dropdown">
                                <div class="rounded-circle bg-secondary d-flex justify-content-center align-items-center me-2"
                                    style="width: 32px; height: 32px;">
                                    <i class="fa-solid fa-user"></i>
                                </div>
                                <span>
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.user}">
                                            ${sessionScope.user.fullname != null ? sessionScope.user.fullname :
                                            sessionScope.user.email}
                                        </c:when>
                                        <c:otherwise>
                                            Tài khoản
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                            </a>
                            <ul
                                class="dropdown-menu dropdown-menu-dark dropdown-menu-end shadow rounded-0 border-0 p-0 fade-down">

                                <c:choose>
                                    <c:when test="${not empty sessionScope.user}">
                                        <!-- Menu cho user đã đăng nhập -->
                                        <li>
                                            <div class="dropdown-item-text text-white-50 small">
                                                <i class="fa-solid fa-envelope me-2"></i>${sessionScope.user.email}
                                            </div>
                                        </li>
                                        <li>
                                            <hr class="dropdown-divider border-secondary">
                                        </li>
                                        <li>
                                            <a class="dropdown-item"
                                                href="${pageContext.request.contextPath}/user/profile">
                                                <i class="fa-solid fa-user-circle me-2"></i> Hồ sơ
                                            </a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item"
                                                href="${pageContext.request.contextPath}/user/favorite">
                                                <i class="fa-solid fa-heart me-2"></i> Yêu thích
                                            </a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item"
                                                href="${pageContext.request.contextPath}/user/share">
                                                <i class="fa-solid fa-share me-2"></i> Chia sẻ
                                            </a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item"
                                                href="${pageContext.request.contextPath}/user/change-password">
                                                <i class="fa-solid fa-key me-2"></i> Đổi mật khẩu
                                            </a>
                                        </li>

                                        <!-- Menu admin -->
                                        <c:if test="${sessionScope.user.isAdmin}">
                                            <li>
                                                <hr class="dropdown-divider border-secondary">
                                            </li>
                                            <li>
                                                <a class="dropdown-item text-danger"
                                                    href="${pageContext.request.contextPath}/cinevo/admin">
                                                    <i class="fa-solid fa-shield-halved me-2"></i> Quản trị
                                                </a>
                                            </li>
                                        </c:if>

                                        <li>
                                            <hr class="dropdown-divider border-secondary">
                                        </li>
                                        <li>
                                            <a class="dropdown-item"
                                                href="${pageContext.request.contextPath}/auth/logout">
                                                <i class="fa-solid fa-right-from-bracket me-2"></i> Đăng xuất
                                            </a>
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- Menu cho user chưa đăng nhập -->
                                        <li>
                                            <a class="dropdown-item"
                                                href="${pageContext.request.contextPath}/cinevo/user?tab=login">
                                                <i class="fa-solid fa-right-to-bracket me-2"></i> Đăng nhập
                                            </a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item"
                                                href="${pageContext.request.contextPath}/cinevo/user?tab=register">
                                                <i class="fa-solid fa-user-plus me-2"></i> Đăng ký
                                            </a>
                                        </li>
                                    </c:otherwise>
                                </c:choose>

                            </ul>
                        </div>
                    </div>

                </div>
            </div>
        </nav>

        <style>
            /* Hiệu ứng hover cho link menu */
            .header-link {
                transition: color 0.3s;
                color: #ccc !important;
            }

            .header-link:hover {
                color: #dc3545 !important;
            }

            .form-control:focus {
                box-shadow: none;
                border-color: #dc3545;
            }

            .navbar-toggler:focus {
                box-shadow: none;
            }

            /* --- CSS MỚI: THANH CUỘN CHO NĂM SẢN XUẤT --- */
            .scrollable-menu {
                height: auto;
                max-height: 300px;
                /* Giới hạn chiều cao 300px */
                overflow-x: hidden;
                /* Ẩn thanh cuộn ngang */
                overflow-y: auto;
                /* Hiện thanh cuộn dọc nếu dài quá */
            }

            /* Tùy chỉnh thanh cuộn cho đẹp (Chrome/Safari/Edge) */
            .scrollable-menu::-webkit-scrollbar {
                width: 6px;
            }

            .scrollable-menu::-webkit-scrollbar-track {
                background: #333;
            }

            .scrollable-menu::-webkit-scrollbar-thumb {
                background: #dc3545;
                border-radius: 10px;
            }

            /* Hiệu ứng menu dropdown hiện ra mượt mà */
            .dropdown-menu.fade-down {
                animation-name: fadeInDown;
                animation-duration: 0.3s;
                animation-fill-mode: both;
            }

            @keyframes fadeInDown {
                0% {
                    opacity: 0;
                    transform: translate3d(0, -10px, 0);
                }

                100% {
                    opacity: 1;
                    transform: none;
                }
            }
        </style>