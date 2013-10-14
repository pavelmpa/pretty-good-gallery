<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Home</title>
    <link rel="stylesheet" type="text/css" href="<spring:url value="/resources/css/bootstrap.css" />"/>
    <link rel="stylesheet" type="text/css" href="<spring:url value="/resources/css/jumbo.css" />"/>
    <link rel="stylesheet" type="text/css" href="<spring:url value="/resources/css/templates.css" />"/>
</head>
<body>
<div id="wrap">
    <div class="container">
        <jsp:include page="templates/pageHead.jsp"/>
        <security:authorize access="isAnonymous()">
            <div class="jumbotron">
                <h1>Create your own gallery!</h1>

                <p></p>
                <a class="btn btn-large btn-success" href="<spring:url value="/register" />">Get started</a>
            </div>
        </security:authorize>
        <security:authorize access="isAuthenticated()">
            <p class="lead">Here will be something soon. But now you can visit
                <a href="<spring:url value="/albums" />">you albums</a> page.</p>
        </security:authorize>
        <div id="push"></div>
    </div>
</div>
<jsp:include page="templates/footer.jsp"/>
<script src="<spring:url value="/resources/js/jquery-2.0.0.js" />"></script>
<script src="<spring:url value="/resources/js/bootstrap.js" />"></script>
<script src="<spring:url value="/resources/js/templates.js" />"></script>
</body>
</html>