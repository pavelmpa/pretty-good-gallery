<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
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
    <link href="<c:url value="/resources/css/template.css"/>" rel="stylesheet">
    <link href="<c:url value="/resources/css/alert-box.css"/>" rel="stylesheet">
    <link href="<c:url value="/resources/css/album-list.css"/>" rel="stylesheet">
    <link href="<c:url value="/resources/css/validate.css"/>" rel="stylesheet">
</head>
<body>
<div id="wrap">
    <!-- NAVBAR
    ================================================== -->
    <jsp:include page="templates/navbar.jsp"/>
    <!-- CONTENT
    ================================================== -->
    <div class="container" style="padding-top: 10px">
        <div id="album-list-properties" class="row">
            <div class="col-xs-6 col-md-4 text-left">
                <div class="btn-group">
                    <a class="btn btn-default" href="<c:url value="/albums"/>">
                    <span class="glyphicon glyphicon-th"></span>
                    </a>
                    <a class="btn btn-default active" href="#">
                        <span class="glyphicon glyphicon-th-list"></span>
                    </a>
                </div>
            </div>
            <div class="col-xs-6 col-md-4 text-center">
                <h4>${userOwner}</h4>
            </div>
            <div class="col-xs-6 col-md-4 text-right">
                <a id="create-album" class="btn btn-primary btn-large" href="#">
                    Create new album
                </a>
            </div>
        </div>
        <hr>
        <div id="album-wrap" data-presentation="table">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>Title</th>
                    <th>Description</th>
                    <th>Pictures</th>
                    <th>Created</th>
                    <th>Edit</th>
                    <th>Delete</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${albums}" var="album" varStatus="varStatus">
                    <tr id="${album.id}">
                        <td class="title">
                            <a href="<c:url value="/albums/${album.id}"/>">${album.title}</a>
                        </td>
                        <c:choose>
                            <c:when test="${empty album.description}">
                                <td class="no-description">&#8212</td>
                            </c:when>
                            <c:when test="${not empty album.description}">
                                <td class="description">${album.description}</td>
                            </c:when>
                        </c:choose>
                        <td><span class="badge">${album.numberOfImages}</span></td>
                        <td>${album.created}</td>
                        <td>
                            <a class="album-edit" href="#${album.id}">
                                <span class="glyphicon glyphicon-edit"></span>
                            </a>
                        </td>
                        <td>
                            <a class="album-delete" href="#${album.id}">
                                <span class="glyphicon glyphicon-remove"></span>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<!-- FOOTER -->
<jsp:include page="templates/footer.jsp"/>
<div id="delete-dialog" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">Delete album?</h4>
            </div>
            <div class="modal-body">
                <p>Are you sure you want delete this album and all images in album?</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <a id="confirm-delete" href="" class="btn btn-danger">Delete album</a>
            </div>
        </div>
    </div>
</div>
<div id="edit-dialog" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title"></h4>
            </div>
            <form id="edit-form" class="form-horizontal" role="form" method="post">
                <div class="modal-body">
                    <div class="form-group">
                        <label for="title" class="col-sm-2 control-label">Title</label>

                        <div class="col-sm-10">
                            <input id="title" type="text" class="form-control" name="title">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="description" class="col-sm-2 control-label">Description</label>

                        <div class="col-sm-10">
                            <textarea id="description" class="form-control" rows="4" name="description"></textarea>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            <input class="btn btn-primary" type="submit" value="Save">
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<div id="wait-dialog" class="modal fade"></div>
<ul class="alert-box"></ul>
<script src="http://code.jquery.com/jquery-2.0.3.min.js"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js"/>"></script>
<script src="<c:url value="/resources/js/jquery.validate.js"/>"></script>
<script src="<c:url value="/resources/js/template.js"/>"></script>
<script src="<c:url value="/resources/js/alert-box.js"/>"></script>
<script src="<c:url value="/resources/js/album-manage-list.js"/>"></script>
<%--Todo: fix create new album validation--%>
</body>
</html>
