<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%--TODO: Remove this page. Create Ajax album creation on albumList page.--%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>Create new album</title>
    <link rel="stylesheet" type="text/css" href="<spring:url value="/resources/css/bootstrap.css" />"/>
    <link rel="stylesheet" type="text/css" href="<spring:url value="/resources/css/templates.css" />"/>
    <style type="text/css">
        .area-limits {
            max-width: 550px;
            max-height: 300px;
        }
    </style>
</head>
<body>
<div id="wrap">
    <div class="container">
        <jsp:include page="templates/pageHead.jsp"/>
        <spring:url var="actionUrl" value="/albums"/>
        <div>
            <form:form id="create_album" cssClass="form-signin" action="${actionUrl}" commandName="album" method="post">
                <form:errors path="*" cssClass="alert alert-error" element="div"/>
                <fieldset>
                    <legend>Create new album</legend>
                    <label for="title">Title</label>
                    <form:input path="title" id="title" cssClass="input-xxlarge" type="text" value="${album.title}"/>
                    <label for="description">Description</label>
                    <form:textarea path="description" id="description"
                                   cssClass="input-xxlarge area-limits" cssStyle="" rows="4"
                                   value="${album.description}"/>
                    <br/>
                    <input type="submit" class="btn btn-success" value="Create"/>
                </fieldset>
            </form:form>
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