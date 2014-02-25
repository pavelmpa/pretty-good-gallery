<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="<c:url value="/resources/ico/favicon.ico"/>">

    <title>Home</title>

    <!-- Bootstrap core CSS -->
    <link href="<c:url value="/resources/css/bootstrap.css"/>" rel="stylesheet">

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->

    <!-- Custom styles for this template -->
    <link href="<c:url value="/resources/css/sign.css"/>" rel="stylesheet">
    <link href="<c:url value="/resources/css/validate.css"/>" rel="stylesheet">
</head>
<body>
<div class="container">
    <c:if test="${loginFailure != null}">
        <div class="alert alert-danger alert-dismissable">
            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
            <strong>Error!</strong> ${loginFailure}
        </div>
    </c:if>
    <h3 class="form-signin-heading text-center">Please sign in to pretty good gallery</h3>

    <form class="form-signin" role="form" method="post" action="<c:url value="/j_spring_security_check"/>">
        <input type="email" id="email" class="form-control" placeholder="Email address" name="j_username" required
               autofocus>
        <input type="password" id="password" class="form-control" placeholder="Password" name="j_password" required>
        <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
    </form>
    <div class="form-signin">
        <h3 class="text-center">No account yet</h3>
        <a class="btn btn-lg btn-success btn-block" type="submit">Sign up</a>
    </div>
</div>
<!-- /container -->

<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="<c:url value="/resources/js/jquery-2.0.0.js" />"></script>
<script src="<c:url value="/resources/js/jquery.validate.js" />"></script>
</body>
</html>