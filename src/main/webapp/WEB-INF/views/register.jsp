<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Sign up</title>
    <link rel="stylesheet" type="text/css" href="<spring:url value="/resources/css/bootstrap.css" />"/>
    <link rel="stylesheet" type="text/css" href="<spring:url value="/resources/css/signin-signup.css" />"/>
    <link rel="stylesheet" type="text/css" href="<spring:url value="/resources/css/validate.css" />"/>
</head>
<body>
<div class="container">
    <h2 class="form-signin-heading text-center">Get pretty gallery</h2>
    <form:form id="register-form" class="container form-signin form-signup" commandName="user" method="post">
        <form:errors path="*" cssClass="alert alert-error" element="div"/>
        <fieldset>
            <legend class="help-inline">Optional info</legend>
            <form:input path="firstName" type="text" placeholder="First name"/>
            <br/>
            <form:input path="lastName" type="text" placeholder="Last name"/>
            <legend class="help-inline">Required info</legend>
            <form:input path="email" type="text" placeholder="Email" required="required"/>
            <br/>
            <form:input path="username" type="text" placeholder="Username" required="required"/>
            <br/>
            <form:input id="password" path="password" type="password" placeholder="Password" required="required"/>
            <br/>
            <form:input path="confirmPassword" type="password" placeholder="Confirm password" required="required"/>
            <br/>
            <input type="submit" value="Get it" class="btn btn-large btn-success"/>
        </fieldset>
    </form:form>
</div>
<script src="<spring:url value="/resources/js/jquery-2.0.0.js" />"></script>
<script src="<spring:url value="/resources/js/jquery.validate.js" />"></script>
<script src="<spring:url value="/resources/js/register.validate.js" />"></script>
</body>
</html>