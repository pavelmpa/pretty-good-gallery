<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
    <form:form id="register-form" class="form-horizontal form-signup" role="form" commandName="user" method="post">
        <form:errors path="*" cssClass="alert alert-danger " element="div"/>
        <h2>Sign up</h2>
        <fieldset>
            <legend>Required info</legend>
            <div class="form-group">
                <label for="email" class="col-sm-3 control-label">Email</label>

                <div class="col-sm-9">
                    <form:input type="email" class="form-control" id="email" placeholder="Email" path="email"/>
                </div>
            </div>
            <div class="form-group">
                <label for="username" class="col-sm-3 control-label">Username</label>

                <div class="col-sm-9">
                    <form:input type="text" class="form-control" id="username" placeholder="Username" path="username"/>
                </div>
            </div>
            <div class="form-group">
                <label for="password" class="col-sm-3 control-label">Password</label>

                <div class="col-sm-9">
                    <form:input type="password" class="form-control" id="password" placeholder="Password"
                                path="password" showPassword="falese"/>
                </div>
            </div>
            <div class="form-group">
                <label for="confirm-password" class="col-sm-3 control-label">Confirm password</label>

                <div class="col-sm-9">
                    <form:input type="password" class="form-control" id="confirm-password"
                                placeholder="Confirm password" path="confirmPassword" showPassword="falese"/>
                </div>
            </div>
        </fieldset>
        <fieldset>
            <legend>Optional info</legend>
            <div class="form-group">
                <label for="first-name" class="col-sm-3 control-label">First name</label>

                <div class="col-sm-9">
                    <form:input type="text" class="form-control" id="first-name" placeholder="First name"
                                path="firstName"/>
                </div>
            </div>
            <div class="form-group">
                <label for="last-name" class="col-sm-3 control-label">Last name</label>

                <div class="col-sm-9">
                    <form:input type="text" class="form-control" id="last-name" placeholder="Last name"
                                path="lastName"/>
                </div>
            </div>
        </fieldset>
        <fieldset>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10 text-right">
                    <button class="btn btn-lg btn-success" type="submit">Sign up</button>
                </div>
            </div>
        </fieldset>
    </form:form>
</div>
<!-- /container -->

<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="<spring:url value="/resources/js/jquery-2.0.0.js" />"></script>
<script src="<spring:url value="/resources/js/jquery.validate.js" />"></script>
<script src="<spring:url value="/resources/js/register.validate.js" />"></script>
</body>
</html>