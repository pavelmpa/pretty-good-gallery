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

        .album-edit, .album-delete {
            text-align: center;
            width: 20px;
            height: 20px;
            border-radius: 5px;
        }

        .album-edit:hover, .album-delete:hover {
            background: #333333;
        }

        .alert-box {
            top: 0;
            /*left: 5%;*/
            position: fixed;
            width: 100%;
            height: auto;
            margin: 0;
            padding: 0;
            list-style-type: none;
            z-index: 9999999;
        }

        .alert {
            text-align: center;
            margin-bottom: 0;
        }

        #wait-dialog {
            height: 50px;
            width: 50px;
            background: #000000 url('/resources/img/fancybox_loading.gif') center center no-repeat;
            position: fixed;
            top: 50%;
            left: 50%;
            margin-top: -22px;
            margin-left: -22px;
            opacity: 0.8;
            cursor: pointer;
            z-index: 8060;
        }

        .description {
            max-width: 300px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
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
                    <tr id="${album.id}">
                        <td>${varStatus.index + 1}</td>
                        <td class="title">
                        <a href="<spring:url value="/albums/${album.id}" />">${album.title}</a>
                        </td>
                        <td class="description">
                        <c:if test="${album.description eq null}">
                                <span style="color: #b3b3b3">No description</span>
                            </c:if>
                                ${album.description}
                        </td>
                        <td>${album.created}</td>
                        <td>
                            <a class="album-edit" href="<spring:url value="/albums/${album.id}/edit" />">
                            <i class="icon-edit"></i>
                            </a>
                        </td>
                        <td>
                            <a class="album-delete" href="#${album.id}" data-album-id="${album.id}"
                               onclick="deleteAlbum(this)" data-toggle="modal" data-target="#modal">
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
        <a id="confirm-delete" href="#" class="btn btn-danger">Delete album</a>
    </div>
</div>
<div id="wait-dialog" class="modal hide fade"></div>
<ul class="alert-box"></ul>
<script src="<spring:url value="/resources/js/jquery-2.0.0.js" />"></script>
<script src="<spring:url value="/resources/js/bootstrap.js"/>"></script>
<script src="<spring:url value="/resources/js/templates.js" />"></script>
<script src="<spring:url value="/resources/js/alert-box.js" />"></script>
<script src="<spring:url value="/resources/js/album.js" />"></script>
</body>
</html>
