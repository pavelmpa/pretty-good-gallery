<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>User profile</title>
    <link href="<spring:url value="/resources/css/bootstrap.css" />" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" type="text/css" href="<spring:url value="/resources/css/templates.css" />"/>
    <link rel="stylesheet" type="text/css" href="<spring:url value="/resources/css/validate.css" />"/>
</head>
<body>
<div id="wrap">
    <div class="container">
        <jsp:include page="templates/pageHead.jsp"/>
        <fieldset>
            <legend>Personal info</legend>
            <span class="help-block">First name</span>
            <h4>${first_name}</h4>
            <span class="help-block">Last name</span>
            <h4>${last_name}</h4>
            <legend>Info</legend>
            <span class="help-block">Email</span>
            <h4>${email}</h4>
            <span class="help-block">Status</span>
            <h4>${admin_status}</h4>
        </fieldset>
    </div>
    <div id="push"></div>
</div>
<jsp:include page="templates/footer.jsp"/>
<script src="<spring:url value="/resources/js/jquery-2.0.0.js" />"></script>
<script src="<spring:url value="/resources/js/templates.js" />"></script>
</body>
</html>