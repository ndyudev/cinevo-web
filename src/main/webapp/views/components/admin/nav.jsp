<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>

        <div class="w-100 bg-black border-bottom border-secondary border-opacity-25 py-2">
            <div class="container">
                <ul class="nav nav-pills justify-content-center admin-nav-horizontal">

                    <li class="nav-item mx-1">
                        <a href="${pageContext.request.contextPath}/cinevo/admin?tab=dashboard"
                            class="nav-link ${param.tab == 'dashboard' || param.tab == null ? 'active bg-danger' : 'text-white'}">
                            Dashboard
                        </a>
                    </li>

                    <li class="nav-item mx-1">
                        <a href="${pageContext.request.contextPath}/cinevo/admin?tab=videos"
                            class="nav-link ${param.tab == 'videos' ? 'active bg-danger' : 'text-white'}">
                            Quản lý Video
                        </a>
                    </li>

                    <li class="nav-item mx-1">
                        <a href="${pageContext.request.contextPath}/cinevo/admin?tab=category"
                            class="nav-link ${param.tab == 'category' ? 'active bg-danger' : 'text-white'}">
                            Quản lý Danh mục
                        </a>
                    </li>

                    <li class="nav-item mx-1">
                        <a href="${pageContext.request.contextPath}/cinevo/admin?tab=users"
                            class="nav-link ${param.tab == 'users' ? 'active bg-danger' : 'text-white'}">
                            Quản lý Tài khoản
                        </a>
                    </li>

                    <li class="nav-item mx-1">
                        <a href="${pageContext.request.contextPath}/cinevo/admin?tab=reports"
                            class="nav-link ${param.tab == 'reports' ? 'active bg-danger' : 'text-white'}">
                            Báo cáo
                        </a>
                    </li>

                    <li class="nav-item mx-1 ms-auto">
                        <a href="${pageContext.request.contextPath}/cinevo/user" class="nav-link text-white-50">
                            <i class="fa-solid fa-arrow-left me-1"></i> Về trang User
                        </a>
                    </li>
                </ul>
            </div>
        </div>

        <style>
            /* CSS cho nút bấm gọn gàng */
            .admin-nav-horizontal .nav-link {
                border-radius: 20px;
                padding: 8px 20px;
                font-weight: 500;
                transition: all 0.3s;
            }

            .admin-nav-horizontal .nav-link:not(.active):hover {
                background-color: rgba(220, 53, 69, 0.2);
                color: #dc3545 !important;
            }

            /* Active màu đỏ */
            .nav-pills .nav-link.active,
            .nav-pills .show>.nav-link {
                background-color: #dc3545 !important;
                color: white !important;
            }
        </style>