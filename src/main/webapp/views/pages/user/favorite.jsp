<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>

        <div class="container py-5">
            <div class="row">
                <div class="col-md-8 mx-auto">
                    <div class="card bg-dark text-white border-secondary">
                        <div class="card-header bg-danger">
                            <h4 class="mb-0"><i class="fa-solid fa-heart me-2"></i>Video Yêu Thích</h4>
                        </div>
                        <div class="card-body">
                            <c:if test="${empty favoriteList}">
							    <p class="text-center text-secondary py-5">
							        <i class="fa-solid fa-heart display-1 mb-3 d-block"></i>
							        Danh sách video yêu thích của bạn sẽ hiển thị ở đây.
							    </p>
							</c:if>
							
							<c:if test="${not empty favoriteList}">
							    <div class="list-group">
							        <c:forEach var="fav" items="${favoriteList}">
							            <div class="list-group-item bg-dark text-white border-secondary mb-2">
							                <div class="d-flex align-items-center">
							                    <img src="${fav.video.posterUrl}" alt="${fav.video.title}" class="me-3" style="width:120px;">
							                    <div class="flex-grow-1">
							                        <h5>${fav.video.title}</h5>
							                        <p class="mb-1">${fav.video.description}</p>
							                        <small>Thời gian thích: ${fav.likeDate}</small>
							                    </div>
							                    <form method="post" action="${pageContext.request.contextPath}/user/favorite">
							                        <input type="hidden" name="action" value="remove">
							                        <input type="hidden" name="videoId" value="${fav.video.id}">
							                        <button type="submit" class="btn btn-danger btn-sm ms-2">
							                            <i class="fa-solid fa-trash"></i> Xóa
							                        </button>
							                    </form>
							                </div>
							            </div>
							        </c:forEach>
							    </div>
							</c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>