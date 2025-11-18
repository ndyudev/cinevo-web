<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
                <a href="${pageContext.request.contextPath}/cinevo/admin?tab=video" 
                   class="nav-link ${param.tab == 'video' ? 'active bg-danger' : 'text-white'}">
                    Video
                </a>
            </li>

            <li class="nav-item mx-1">
                <a href="${pageContext.request.contextPath}/cinevo/admin?tab=category" 
                   class="nav-link ${param.tab == 'category' ? 'active bg-danger' : 'text-white'}">
                    Danh mục
                </a>
            </li>
            
            <li class="nav-item mx-1">
                <a href="${pageContext.request.contextPath}/cinevo/admin?tab=users" 
                   class="nav-link ${param.tab == 'users' ? 'active bg-danger' : 'text-white'}">
                    Người dùng
                </a>
            </li>

            <li class="nav-item mx-1">
                <a href="${pageContext.request.contextPath}/cinevo/admin?tab=favorites" 
                   class="nav-link ${param.tab == 'favorites' ? 'active bg-danger' : 'text-white'}">
                    Yêu thích
                </a>
            </li>

             <li class="nav-item mx-1">
                <a href="${pageContext.request.contextPath}/cinevo/admin?tab=shares" 
                   class="nav-link ${param.tab == 'shares' ? 'active bg-danger' : 'text-white'}">
                    Chia sẻ
                </a>
            </li>

            <li class="nav-item mx-1">
                <a href="#" class="nav-link text-danger fw-bold">
                    Đăng xuất
                </a>
            </li>
        </ul>
    </div>
</div>

<style>
    .admin-nav-horizontal .nav-link {
        border-radius: 20px; padding: 8px 20px; font-weight: 500; transition: all 0.2s;
    }
    .admin-nav-horizontal .nav-link:hover {
        background-color: rgba(255,255,255,0.1); color: #dc3545 !important;
    }
    .nav-pills .nav-link.active, .nav-pills .show>.nav-link {
        background-color: #dc3545 !important; color: white !important;
    }
</style>