<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <title>Temporary not available</title>
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
        <div class="jumbotron">
            <h1>:(</h1>

            <p>Sorry this function or page not implemented yet.</p>
        </div>
        <div id="push"></div>
    </div>
</div>
<jsp:include page="templates/footer.jsp"/>
<script src="<spring:url value="/resources/js/jquery-2.0.0.js" />"></script>
<script src="<spring:url value="/resources/js/bootstrap.js" />"></script>
<script src="<spring:url value="/resources/js/templates.js" />"></script>
</body>
</html>
