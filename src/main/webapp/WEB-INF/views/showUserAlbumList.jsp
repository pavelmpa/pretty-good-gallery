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

    <title>Your album list</title>

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
    <style type="text/css">
        #wait-dialog {
            height: 50px;
            width: 50px;
            background: #000000 url('/resources/img/fancybox_loading.gif') center center no-repeat;
            border-radius: 5px;

            position: fixed;
            top: 50%;
            left: 50%;

            margin-top: -22px;
            margin-left: -22px;

            opacity: 0.8;
            z-index: 8060;
            overflow: hidden;
        }

        .album-thumb a img {
            top: 0;
            left: 0;
            position: absolute;
        }
    </style>
</head>
<body>
<div id="wrap">
    <!-- NAVBAR
    ================================================== -->
    <jsp:include page="templates/navbar.jsp"/>
    <!-- CONTENT
    ================================================== -->
    <div class="container text-center" style="padding-top: 10px;">
        <div id="album-list-properties" class="row">
            <div class="col-xs-6 col-md-4 text-left">
                <div class="btn-group">
                    <a class="btn btn-default active" href="#">
                        <span class="glyphicon glyphicon-th"></span>
                    </a>
                    <a class="btn btn-default" href="${requestScope['javax.servlet.forward.request_uri']}/manage">
                        <span class="glyphicon glyphicon-th-list"></span>
                    </a>
                </div>
            </div>
            <div class="col-xs-6 col-md-4 text-center">
                <h4>User owner</h4>
            </div>
            <div class="col-xs-6 col-md-4 text-right">
                <a id="create-album" class="btn btn-primary btn-large" href="#">
                    Create new album
                </a>
            </div>
        </div>
        <hr>
        <div id="album-list-wrap" data-album-layout="greed">
            <div id="album-holder">
            </div>
        </div>
    </div>
</div>
<!-- FOOTER
================================================== -->
<jsp:include page="templates/footer.jsp"/>
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
<script src="<c:url value="/resources/js/alert-box.js"/>"></script>
<script src="<c:url value="/resources/js/jquery.validate.js"/>"></script>
<script src="<c:url value="/resources/js/album-list.js"/>"></script>
</body>
</html>
