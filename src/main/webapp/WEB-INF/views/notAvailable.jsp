<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="<c:url value="/resources/ico/favicon.ico"/>">

    <title>Oops!</title>

    <!-- Bootstrap core CSS -->
    <link href="<c:url value="/resources/css/bootstrap.css"/>" rel="stylesheet">

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->

    <!-- Custom styles for this template -->
    <link href="<c:url value="/resources/css/template.css"/>" rel="stylesheet">
</head>
<body>
<div id="wrap">
    <!-- NAVBAR
    ================================================== -->
    <jsp:include page="templates/navbar.jsp"/>
    <!-- CONTENT
    ================================================== -->
    <div class="container" style="padding-top: 10px">
        <div class="jumbotron starter-template" style="text-align: center">
            <h1>:(</h1>

            <p>Sorry this function or page not implemented yet.</p>
        </div>
    </div>
</div>
<!-- FOOTER
================================================== -->
<jsp:include page="templates/footer.jsp"/>
<script src="http://code.jquery.com/jquery-2.0.3.min.js"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js"/>"></script>
<script src="<c:url value="/resources/js/template.js"/>"></script>
</body>
</html>
