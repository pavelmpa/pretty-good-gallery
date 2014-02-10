/*
 *  Loading thumbnails.
 *  Receive data about images in JSON and create thumbnails list.
 */

$(document).ready(function () {
    $('.fancybox').fancybox({
            openEffect: 'none',
            closeEffect: 'none'
        }
    );
//    squareThumbLayout.loadNewThumbnails();
});

//$(window).scroll(function () {
//    if ($(document).height() - 50 <= $(window).scrollTop() + $(window).height()) {
//        if (squareThumbLayout.isPreviousEventComplete && squareThumbLayout.isDataAvailable) {
//            squareThumbLayout.isPreviousEventComplete = false;
//            squareThumbLayout.loadNewThumbnails();
//        }
//    }
//});

var squareThumbLayout = {};

(function (context) {
    context.isPreviousEventComplete = false;
    context.isDataAvailable = true;

    var availableLoadItems = 12, currentAmount = 0;

    var loadThumbnailsUrl = document.URL + "/images/";

    context.loadNewThumbnails = function () {
        $.getJSON(loadThumbnailsUrl, { fromItem: currentAmount }).done(
                showImages
            ).fail(function () {
                alertBox.alertError("Something goes wrong.");
            });
    };

    function showImages(json) {
        var thumbnails = [];

        $.each(json, function (key, value) {
            thumbnails.push(createThumbItem(value));
        });

        $("#thumbnails").append(thumbnails.join(''));

        currentAmount += json.length;
        context.isPreviousEventComplete = true;

        if (json.length < availableLoadItems) context.isDataAvailable = false;
    }

    function createThumbItem(image) {
        var thumbUrl = loadThumbnailsUrl + image.id + '/' + image.fileName;

        if (!image.title) {
            image.title = "";
        }

        var calculatedStyle = calculateImageSize(image.width, image.height);

        return '<li><a class="fancybox" rel="gallery" href="' + thumbUrl + '" title="' + image.title + '"><img class="picture" src="' + thumbUrl + '" style="' + calculatedStyle + '"></a></li>';
    }

    var thumbHeight = 200, thumbWidth = 200;
    var thumbRatio = thumbWidth / thumbHeight;

    function calculateImageSize(width, height) {
        var imgRatio = width / height;

        var calculatedStyle;

        if (imgRatio > thumbRatio) {
            calculatedStyle = "height: 100%; ";
            var marginLeft = (thumbHeight * imgRatio - thumbHeight * thumbRatio) / 2;
            calculatedStyle = calculatedStyle + "margin-left: " + -marginLeft + ";";
        } else {
            calculatedStyle = "width: 100%; ";
            var marginTop = (thumbWidth * imgRatio - thumbWidth * thumbRatio) / 2;
            calculatedStyle = calculatedStyle + "margin-top: " + marginTop + ";";
        }

        return calculatedStyle;
    }

})(squareThumbLayout);
