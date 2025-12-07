<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container py-5">
    <div class="row">
        <div class="col-md-8 mx-auto">
            <div class="card bg-dark text-white border-secondary">
                <div class="card-header bg-danger">
                    <h4 class="mb-0">
                        <i class="fa-solid fa-share-nodes me-2"></i>
                        Video Đã Chia Sẻ
                    </h4>
                </div>

                <div class="card-body">

                    <c:choose>
                        <c:when test="${empty sharedList}">
                            <p class="text-center text-secondary py-5">
                                <i class="fa-solid fa-share-nodes display-1 mb-3 d-block"></i>
                                Danh sách video đã chia sẻ sẽ hiển thị ở đây.
                            </p>
                        </c:when>

                        <c:otherwise>

                            <ul class="list-group list-group-flush">

                                <c:forEach var="item" items="${sharedList}">
                                    <li class="list-group-item bg-dark text-white border-secondary">
                                        <div class="d-flex align-items-center">

                                            <img src="${item.video.posterUrl}" 
                                                 alt="${item.video.title}" 
                                                 class="rounded me-3" 
                                                 style="width:80px; height:60px; object-fit:cover;">
                                        
                                            <div class="flex-grow-1">
                                                <h5 class="mb-1">${item.video.title}</h5>

                                                <p class="mb-1 text-secondary">
                                                    Chia sẻ tới: 
                                                    <strong>${item.sharedToEmail}</strong>
                                                </p>

                                                <small class="text-secondary">
                                                    Lúc: ${item.shareDate}
                                                </small>
                                            </div>
                                        </div>
                                    </li>
                                </c:forEach>

                            </ul>

                        </c:otherwise>
                    </c:choose>

                </div>
            </div>
        </div>
    </div>
</div>
