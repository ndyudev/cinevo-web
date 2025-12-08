<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>

        <nav class="navbar navbar-expand-lg navbar-dark text-white fw-bold bg-black sticky-top shadow-sm"
            style="z-index: 1020; border-bottom: 2px solid #dc3545;">
            <div class="container">

                <a class="navbar-brand d-flex align-items-center"
                    href="${pageContext.request.contextPath}/cinevo/admin">
                    <img src="${pageContext.request.contextPath}/images/cinevo-logo.svg" alt="Cinevo" width="150px">
                </a>

                <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse"
                    data-bs-target="#collapsibleNavbar">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="collapsibleNavbar">
                    <ul class="navbar-nav ms-auto me-3">
                    </ul>

                    <div class="d-flex align-items-center gap-3">
                        <div class="dropdown">
                            <a class="nav-link dropdown-toggle d-flex align-items-center text-white" href="#"
                                role="button" data-bs-toggle="dropdown">
                                <div class="rounded-circle bg-danger d-flex justify-content-center align-items-center me-2"
                                    style="width: 32px; height: 32px;">
                                    <i class="fa-solid fa-user-shield"></i>
                                </div>
                                <span>
                                    ${sessionScope.user.fullname != null ? sessionScope.user.fullname :
                                    sessionScope.user.email}
                                </span>
                            </a>
                            <ul
                                class="dropdown-menu dropdown-menu-dark dropdown-menu-end shadow rounded-0 border-0 p-0 fade-down">
                                <li>
                                    <div class="dropdown-item-text text-white-50 small">
                                        <i class="fa-solid fa-envelope me-2"></i>${sessionScope.user.email}
                                    </div>
                                </li>
                                <li>
                                    <hr class="dropdown-divider border-secondary">
                                </li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/cinevo/admin">
                                        <i class="fa-solid fa-gauge me-2"></i> Dashboard
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/cinevo/user">
                                        <i class="fa-solid fa-house me-2"></i> Về trang User
                                    </a>
                                </li>
                                <li>
                                    <hr class="dropdown-divider border-secondary">
                                </li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/auth/logout">
                                        <i class="fa-solid fa-right-from-bracket me-2"></i> Đăng xuất
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>

                </div>
            </div>
        </nav>

        <style>
            .navbar-toggler:focus {
                box-shadow: none;
            }

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