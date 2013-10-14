<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <meta charset="utf-8">
    <title>Uploading new something new</title>
    <link rel="stylesheet" type="text/css" href="<spring:url value="/resources/css/bootstrap.css" />"/>
    <link rel="stylesheet" type="text/css" href="<spring:url value="/resources/css/bootstrap-fileupload.min.css" />"/>
    <link rel="stylesheet" type="text/css" href="<spring:url value="/resources/css/templates.css" />"/>
    <link rel="stylesheet" type="text/css" href="<spring:url value="/resources/css/validate.css" />"/>
</head>
<body>
<div id="wrap">
    <div class="container">
        <jsp:include page="templates/pageHead.jsp"/>
        <c:if test="${param.result eq 'success'}">
            <p class="alert alert-success">
                <strong>Upload successful!</strong>
            </p>
        </c:if>
        <c:if test="${param.result eq 'fault'}">
            <p class="alert alert-error">
                <strong>Upload failed.</strong>
            </p>
        </c:if>
        <%
            String[] path = request.getAttribute("javax.servlet.forward.request_uri").toString().split("/upload");
            String url = path[0] + "/images";
        %>
        <div class="fileupload fileupload-new text-center" data-provides="fileupload">
            <div class="fileupload-new thumbnail" style="width: 480px; height: 320px;">
                <img src="http://www.placehold.it/480x320/EFEFEF/AAAAAA&text=no+image"/>
            </div>
            <div class="fileupload-preview fileupload-exists thumbnail"
                 style="max-width: 480px; max-height: 320px; line-height: 20px;"></div>
            <form id="image-upload-form" method="post" action="<%=url%>" enctype="multipart/form-data">
                <fieldset>
                    <legend>Upload new image</legend>
                    <input class="input-large" style="height: 30px; margin-bottom: 0;" name="title" type="text" value=""
                           placeholder="Title"/>
                            <span class="btn btn-file">
                                <span class="fileupload-new">Select picture</span>
                                <span class="fileupload-exists">Change</span>
                                <input id="file-upload-input" name="file" type="file" accept="image/*"/>
                            </span>
                    <a href="#" class="btn fileupload-exists" data-dismiss="fileupload">Remove</a>
                    <input type="submit" value="Upload" class="btn btn-success form-upload" style="height: 30px;"/>
                </fieldset>
            </form>
        </div>
        <div id="errors_block"></div>
    </div>
    <div id="push"></div>
</div>
<jsp:include page="templates/footer.jsp"/>
<script src="<spring:url value="/resources/js/jquery-2.0.0.js" />"></script>
<script src="<spring:url value="/resources/js/bootstrap.js" />"></script>
<script src="<spring:url value="/resources/js/bootstrap-fileupload.js" />"></script>
<script src="<spring:url value="/resources/js/jquery.validate.js" />"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/additional-methods.js"></script>
<script src="<spring:url value="/resources/js/templates.js" />"></script>
<script src="<spring:url value="/resources/js/image.upload.validate.js" />"></script>
</body>
</html>