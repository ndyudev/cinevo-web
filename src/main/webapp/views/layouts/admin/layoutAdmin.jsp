<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/f4e3fc99b3.js" crossorigin="anonymous"></script>
    <link rel="icon" href="${pageContext.request.contextPath}/images/cinevo.svg" type="image/x-icon" />
    <style>
        body { background-color: #000; color: white; }
    </style>
</head>
<body>
    <jsp:include page="/views/components/user/header.jsp" />
   	<jsp:include page="/views/components/user/nav.jsp" />
    <jsp:include page="${view}" />

    <jsp:include page="/views/components/user/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>