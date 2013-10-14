<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Sign in</title>
    <link rel="stylesheet" type="text/css" href="<spring:url value="/resources/css/bootstrap.css" />"/>
    <link rel="stylesheet" type="text/css" href="<spring:url value="/resources/css/signin-signup.css" />"/>
    <link rel="stylesheet" type="text/css" href="<spring:url value="/resources/css/validate.css" />"/>
</head>
<body>
<div class="container">
    <form id="login" class="form-signin" action="<spring:url value="/j_spring_security_check" />" method="post">
        <h2 class="form-signin-heading">Please sign in</h2>
        <c:if test="${ param.failure == true }">
            <p class="error">
                    ${loginFailure}
            </p>
        </c:if>
        <label for="email">Email</label>
        <input id="email" type="email" class="input-block-level" placeholder="Email address" name="j_username"
               required="true">
        <label for="password">Password</label>
        <input id="password" type="password" class="input-block-level" placeholder="Password" name="j_password"
               required="true">
        <button class="btn btn-large btn-primary" type="submit" onclick="">Sign in</button>
    </form>
    <div class="form-signin">
        <h3>Not have account yet?</h3>
        <a href="<spring:url value="/register" />" class="btn btn-large btn-success">Sign up</a>
    </div>
</div>
<script src="<spring:url value="/resources/js/jquery-2.0.0.js" />"></script>
<script src="<spring:url value="/resources/js/jquery.validate.js" />"></script>
<script src="<spring:url value="/resources/js/login.validate.js" />"></script>
</body>
</html>