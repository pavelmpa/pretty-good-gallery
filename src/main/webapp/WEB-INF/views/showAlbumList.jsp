<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Albums</title>
    <link rel="stylesheet" type="text/css" href="<spring:url value="/resources/css/bootstrap.css" />"/>
    <link rel="stylesheet" type="text/css" href="<spring:url value="/resources/css/templates.css" />"/>
    <link rel="stylesheet" type="text/css" href="<spring:url value="/resources/css/validate.css" />"/>
    <link rel="stylesheet" type="text/css" href="<spring:url value="/resources/css/albums-list.css" />"/>
</head>
<body>
<div id="wrap">
    <div class="container">
        <jsp:include page="templates/pageHead.jsp"/>
        <div id="albums-holder">
            <div class="text-center">
                <a id="create-album" class="btn btn-primary btn-large" href="#">
                    Create new album <i class="icon-plus icon-white"></i>
                </a>
            </div>
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>#</th>
                    <th>Title</th>
                    <th>Description</th>
                    <th>Images</th>
                    <th>Created</th>
                    <th>Edit</th>
                    <th>Delete</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${albums}" var="album" varStatus="varStatus">
                    <tr id="${album.id}">
                        <td>${varStatus.index + 1}</td>
                        <td class="title">
                            <a href="<spring:url value="/albums/${album.id}" />">${album.title}</a>
                        </td>
                        <c:choose>
                            <c:when test="${empty album.description}">
                                <td class="no-description">&#8212</td>
                            </c:when>
                            <c:when test="${not empty album.description}">
                                <td class="description">${album.description}</td>
                            </c:when>
                        </c:choose>
                        <td>${album.numberOfImages}</td>
                        <td>${album.created}</td>
                        <td>
                            <a class="album-edit" href="#${album.id}">
                                <i class="icon-edit"></i>
                            </a>
                        </td>
                        <td>
                            <a class="album-delete" href="#${album.id}">
                                <i class="icon-remove"></i>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <div id="push"></div>
</div>
<jsp:include page="templates/footer.jsp"/>
<div id="delete-dialog" class="modal hide fade" data-album-id="">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h3>Delete album?</h3>
    </div>
    <div class="modal-body">
        <p>Are you sure you want delete this album and all images in album?</p>
    </div>
    <div class="modal-footer">
        <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
        <a id="confirm-delete" href="" class="btn btn-danger">Delete album</a>
    </div>
</div>
<div id="edit-dialog" class="modal hide fade" data-album-id="">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h3>Empty</h3>
    </div>
    <form id="edit-form" name="album" action="" method="">
        <div class="modal-body">
            <label for="title">Title</label>
            <input id="title" class="input-xxlarge" type="text" name="title" value=""/>
            <label for="description">Description</label>
            <textarea id="description" class="input-xxlarge area-limits" rows="4" name="description"></textarea>
        </div>
        <div class="modal-footer">
            <button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button>
            <input class="btn btn-primary" type="submit" value="Save"/>
        </div>
    </form>
</div>
<div id="wait-dialog" class="modal hide fade"></div>
<ul class="alert-box"></ul>
<script src="<spring:url value="/resources/js/jquery-2.0.0.js" />"></script>
<script src="<spring:url value="/resources/js/bootstrap.js"/>"></script>
<script src="<spring:url value="/resources/js/templates.js" />"></script>
<script src="<spring:url value="/resources/js/alert-box.js" />"></script>
<script src="<spring:url value="/resources/js/jquery.validate.js"/>"></script>
<script src="<spring:url value="/resources/js/album.js" />"></script>
</body>
</html>
