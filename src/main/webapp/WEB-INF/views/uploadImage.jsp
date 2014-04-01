<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="<c:url value="/resources/ico/favicon.ico"/>">

    <title>Uploading new something new</title>

    <!-- Bootstrap core CSS -->
    <link href="<c:url value="/resources/css/bootstrap.css"/>" rel="stylesheet">

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->

    <!-- Custom styles for this template -->
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/bootstrap-fileupload.css"/>">

    <link href="<c:url value="/resources/css/template.css"/>" rel="stylesheet">
    <link href="<c:url value="/resources/css/alert-box.css"/>" rel="stylesheet">
    <style type="text/css">
        .fileinput .thumbnail > img {
            max-height: 390px;
        }

        #image-upload-progress {
            margin-top: 30px;
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
    <div class="container text-center" style="padding-top: 10px">
        <div class="row text-left">
            <a class="btn btn-default" href="<c:url value="/albums/${albumId}"/>" data-toggle="tooltip"
               data-placement="bottom" title="Back to album">
                <span class="glyphicon glyphicon-arrow-left"></span>
            </a>
        </div>
        <h2>Upload new picture</h2>
        <form>
            <div class="fileinput fileinput-new" data-provides="fileinput">
                <div class="fileinput-new thumbnail" style="min-width: 480px; min-height: 320px;">
                    <img src="http://www.placehold.it/480x320/EFEFEF/AAAAAA&text=no+image" alt="Please select image">
                </div>
                <div class="fileinput-preview fileinput-exists thumbnail"
                     style="max-width: 600px; max-height: 400px;"></div>
                <div class="form-group">
                    <input type="text" class="form-control" id="title" placeholder="Title" name="title">
                </div>
                <div>
                    <span class="btn btn-default btn-file">
                        <span class="fileinput-new">Select image</span>
                        <span class="fileinput-exists">Change</span>
                        <input id="uploaded-file" type="file" name="file" accept="image/*">
                    </span>
                    <button class="btn btn-default fileinput-exists" data-dismiss="fileinput">Remove</button>
                    <button id="upload" class="btn btn-primary" type="button">Upload</button>
                </div>
            </div>
        </form>
        <div id="image-upload-progress" class="progress progress-striped hidden">
            <div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">
                <span class="sr-only">0% Complete</span>
            </div>
        </div>
    </div>
</div>
<!-- FOOTER
================================================== -->
<jsp:include page="templates/footer.jsp"/>
<ul class="alert-box"></ul>
<script src="http://code.jquery.com/jquery-2.0.3.min.js"></script>
<script src="<c:url value="/resources/js/bootstrap.js"/>"></script>
<script src="<c:url value="/resources/js/bootstrap-fileupload.js"/>"></script>
<script src="<c:url value="/resources/js/alert-box.js"/>"></script>
<script src="<c:url value="/resources/js/imageUpload.js"/>"></script>
</body>
</html>