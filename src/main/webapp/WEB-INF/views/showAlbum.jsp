<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>${album.title}</title>
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/bootstrap.css" />"/>
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/jquery.fancybox.css" />"/>
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/template.css" />"/>
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/jquery.fancybox.fix.css"/>"/>
    <style type="text/css">
        .btn-round {
            border-radius: 15px;
            width: 25px;
            height: 25px;
            text-align: center;
            padding: 0 0 0 1px;
        }

        .btn-upload-image {
            margin: 10px 10px 0 0;
        }

        #album-info {
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
<div id="wrap">
    <div class="container">
        <jsp:include page="templates/pageHead.jsp"/>
        <div id="album-info" style="text-align: center; cursor: pointer;">
            <div class="row">
                <div id="album-title" class="span9">
                    <h2>${album.title}</h2>
                    <button id="show-description" class="btn btn-small btn-round">
                        <i id="description-indicator" class="icon-chevron-down"></i>
                    </button>
                    <div id="album-description" hidden="hidden">
                        <c:if test="${album.description eq null}">
                            <span style="color: #b3b3b3">No description</span>
                        </c:if>
                        <p class="lead">${album.description}</p>
                    </div>
                </div>
                <div class="span3">
                    <a class="btn btn-primary btn-upload-image"
                       href="${requestScope['javax.servlet.forward.request_uri']}/upload">Upload new image <i
                            class="icon-align-center icon-plus icon-white"></i></a>
                </div>
            </div>
        </div>
        <ul class="thumbnails"></ul>
    </div>
    <div id="push"></div>
</div>
<jsp:include page="templates/footer.jsp"/>
<script src="<c:url value="/resources/js/jquery-2.0.0.js" />"></script>
<script src="<c:url value="/resources/js/bootstrap.js" />"></script>
<script src="<c:url value="/resources/js/jquery.fancybox.js" />"></script>
<script src="<c:url value="/resources/js/template.js"/>"></script>
<script src="<c:url value="/resources/js/thumbnails-loader.js"/>"></script>
</body>
</html>