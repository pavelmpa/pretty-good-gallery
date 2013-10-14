<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Test</title>
    <link rel="stylesheet" type="text/css" href="<spring:url value="/resources/css/bootstrap.css" />"/>
    <link rel="stylesheet" type="text/css" href="<spring:url value="/resources/css/templates.css" />"/>
    <style type="text/css" media="screen">
        table tr td a {
            display: block;
            height: 100%;
            width: 100%;
        }
    </style>
</head>
<body>
<div id="wrap">
    <div class="container">
        <jsp:include page="templates/pageHead.jsp"/>
        <div id="albums-holder">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>#</th>
                    <th>Title</th>
                    <th>Description</th>
                    <th>Created</th>
                    <th>Edit</th>
                    <th>Delete</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${albums}" var="album" varStatus="varStatus">
                    <tr data-album-id="${album.id}">
                        <td>${varStatus.index + 1}</td>
                        <td>
                            <a href="<spring:url value="/albums/${album.id}" />">${album.title}</a>
                        </td>
                        <td>
                            <c:if test="${album.description eq null}">
                                <span style="color: #b3b3b3">No description</span>
                            </c:if>
                                ${album.description}
                        </td>
                        <td>${album.created}</td>
                        <td>
                            <a href="<spring:url value="/albums/${album.id}/edit" />">
                                <i class="icon-edit"></i>
                            </a>
                        </td>
                        <td>
                            <a href="<spring:url value="/albums/${album.id}/remove" />">
                                <i class="icon-remove"></i>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                <tr>
                    <td colspan="6">
                        <a href="<spring:url value="/albums/create" />">
                            Create new album <i class="icon-plus"></i>
                        </a>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div id="push"></div>
</div>
<jsp:include page="templates/footer.jsp"/>
<script src="<spring:url value="/resources/js/jquery-2.0.0.js" />"></script>
<script src="<spring:url value="/resources/js/templates.js" />"></script>
</body>
</html>