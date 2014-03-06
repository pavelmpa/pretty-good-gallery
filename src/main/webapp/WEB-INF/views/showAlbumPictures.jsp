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

    <title>${album.title}</title>

    <!-- Bootstrap core CSS -->
    <link href="<c:url value="/resources/css/bootstrap.css"/>" rel="stylesheet">

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->

    <!-- Custom styles for this template -->
    <link href="<c:url value="/resources/css/template.css"/>" rel="stylesheet">
    <link href="<c:url value="/resources/css/jquery.fancybox.css"/>" rel="stylesheet"/>
    <link href="<c:url value="/resources/css/jquery.fancybox.fix.css"/>" rel="stylesheet"/>
    <link href="<c:url value="/resources/css/alert-box.css"/>" rel="stylesheet">
    <link href="<c:url value="/resources/css/album-pictures.css"/>" rel="stylesheet">
</head>
<body>
<div id="wrap">
    <!-- NAVBAR
    ================================================== -->
    <jsp:include page="templates/navbar.jsp"/>
    <!-- CONTENT
    ================================================== -->
    <div class="container text-center" style="padding-top: 20px;">
        <div id="album-info">
            <div class="row text-center">
                <div class="col-xs-6 col-md-2">
                    <a class="btn btn-primary btn-upload-image"
                       href="${requestScope['javax.servlet.forward.request_uri']}/upload">
                        Upload new picture
                    </a>
                </div>
                <div id="album-title" class="col-xs-12 col-md-8">
                <div class="panel panel-default text-left">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                                    ${album.title}
                                </a>
                            </h4>
                        </div>
                        <div id="collapseOne" class="panel-collapse collapse">
                            <div class="panel-body">
                                <c:if test="${album.description eq null}">
                                    <span style="color: #b3b3b3">No description</span>
                                </c:if>
                                <p class="lead">${album.description}</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xs-6-2">
                    <button id="manage-pics" class="btn btn-default btn-to" data-toggle="button">Manage pics</button>
                </div>
            </div>
        </div>
        <div id="thumb-wrap">
            <ul id="thumbnail-list">
            </ul>
        </div>
    </div>
</div>
<!-- FOOTER
================================================== -->
<jsp:include page="templates/footer.jsp"/>
<div id="wait-dialog" class="modal fade"></div>
<ul class="alert-box"></ul>
<div id="delete-pic-dialog" class="modal fade" data-photo-id="">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">Delete picture?</h4>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to delete this picture?</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button id="confirm-delete" class="btn btn-danger">Delete album</button>
            </div>
        </div>
    </div>
</div>
<script src="http://code.jquery.com/jquery-2.0.3.min.js"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js"/>"></script>
<script src="<c:url value="/resources/js/template.js"/>"></script>
<script src="<c:url value="/resources/js/jquery.fancybox.js" />"></script>
<script src="<c:url value="/resources/js/alert-box.js"/>"></script>
<script src="<c:url value="/resources/js/thumbnails-loader.js"/>"></script>
</body>
</html>
