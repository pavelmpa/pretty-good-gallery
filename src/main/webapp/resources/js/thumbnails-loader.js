/*
 *  Loading thumbnails.
 *  Receive data about images in JSON and create thumbnails list.
 */

$(document).ready(function () {
    var editable = false;

    $('#manage-pics').on('click', function () {
        var $manageButton = $(this);
        if (editable) {
            $('.pic-item-manage').removeClass("editable");
            $manageButton.removeClass("btn-danger");
            editable = false;
        } else {
            $('.pic-item-manage').addClass("editable");
            $manageButton.addClass("btn-danger");
            editable = true
        }
    });

    $('.fancybox').fancybox({
            openEffect: 'none',
            closeEffect: 'none'
        }
    );

    $('#confirm-delete').on("click", function () {
        var $deletePicDialog = $('#delete-pic-dialog');
        $deletePicDialog.modal('hide');
        squareThumbLayout.removePicture($deletePicDialog.data("photo-id"));
    });

    squareThumbLayout.loadNewThumbnails();
});

$(window).scroll(function () {
    if ($(document).height() - 50 <= $(window).scrollTop() + $(window).height()) {
        if (squareThumbLayout.isPreviousEventComplete && squareThumbLayout.isDataAvailable) {
            squareThumbLayout.isPreviousEventComplete = false;
            squareThumbLayout.loadNewThumbnails();
        }
    }
});

var squareThumbLayout = {};

(function (context) {
    context.isPreviousEventComplete = false;
    context.isDataAvailable = true;

    var availableLoadItems = 30, currentAmount = 0;

    var loadThumbnailsUrl = document.URL + "/images/";

    context.loadNewThumbnails = function () {
        $.getJSON(loadThumbnailsUrl, { fromItem: currentAmount, amount: availableLoadItems }).done(
            showImages
        ).fail(function () {
                alertBox.alertError("Something goes wrong.");
            });
    };

    function showImages(json) {
        var thumbnails = [];

        $.each(json, function (key, value) {
            thumbnails.push(getThumbElement(value));
        });

        $("#thumbnail-list").append(thumbnails.join(''));

        currentAmount += json.length;
        context.isPreviousEventComplete = true;

        if (json.length < availableLoadItems) context.isDataAvailable = false;
    }

    var getThumbElement = function (image) {
        var imgId = image.id, title = image.title;
        var thumbUrl = loadThumbnailsUrl + imgId + '/' + image.fileName;

        if (!title) {
            title = "";
        }

        var calculatedStyle = calculateImageSize(image.width, image.height);

        return '<li id="' + imgId + '">' +
            '<div class="thumb-wrap">' +
            '<a class="fancybox" rel="gallery" href="' + thumbUrl + '" title="' + title + '">' +
            '<img class="picture" src="' + thumbUrl + '" style="opacity: 0;' + calculatedStyle + '" onload="squareThumbLayout.thumbLoadedHandler(this)">' +
            '</a>' +
            '</div>' +
            '<div class="pic-item-manage">' +
            '<button class="remove-pic btn btn-danger" data-photo-id="' + imgId + '" onclick="squareThumbLayout.removeClickHandler(this)">' +
            '<span class="glyphicon glyphicon-remove"></span>' +
            '</button>' +
            '</div>' +
            '</li>';
    };

    var thumbHeight = 200, thumbWidth = 200;
    var thumbRatio = thumbWidth / thumbHeight;

    function calculateImageSize(width, height) {
        var imgRatio = width / height;

        var calculatedStyle;

        if (imgRatio > thumbRatio) {
            calculatedStyle = "height: 100%; ";
            var marginLeft = (thumbHeight * imgRatio - thumbHeight * thumbRatio) / 2;
            calculatedStyle = calculatedStyle + "margin-left: " + -marginLeft + "px;";
        } else {
            calculatedStyle = "width: 100%; ";
            var marginTop = (thumbWidth * imgRatio - thumbWidth * thumbRatio) / 2;
            calculatedStyle = calculatedStyle + "margin-top: " + marginTop + "px;";
        }

        return calculatedStyle;
    }

    context.thumbLoadedHandler = function (element) {
        $(element).css("opacity", 1);
    };

    context.removeClickHandler = function (element) {
        var $deletePicDialog = $('#delete-pic-dialog');
        $deletePicDialog.data("photo-id", $(element).data("photo-id"));
        $deletePicDialog.modal();
    };

    context.removePicture = function (pictureId) {
        var url = document.URL + "/images/" + pictureId;
        $.ajax({
            url: url,
            type: 'DELETE',
            timeout: 10000,
            success: function (response, statusCode, xhr) {
                if (xhr.status == 200) {
                    $('#' + pictureId).slideUp(500, function () {
                        $(this).remove();
                    });
                    alertBox.alertSuccess(response);
                } else if (xhr.status == 204) {
                    alertBox.alertWarning("Picture does not exist.");
                } else {
                    alertBox.alertWarning("Please try again.");
                }
            },
            error: function (xhr) {
                alertBox.alertError(xhr.responseText);
            }
        });
    };
})(squareThumbLayout);
