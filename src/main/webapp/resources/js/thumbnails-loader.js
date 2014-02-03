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
    thumbnailLoader.loadNewThumbnails();
});

$(window).scroll(function () {
    if ($(document).height() - 50 <= $(window).scrollTop() + $(window).height()) {
        if (thumbnailLoader.isPreviousEventComplete && thumbnailLoader.isDataAvailable) {
            thumbnailLoader.isPreviousEventComplete = false;
            thumbnailLoader.loadNewThumbnails();
        }
    }
});

var thumbnailLoader = {};

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
            thumbnails.push(createThumbItem(value.id, value.title, value.fileName));
        });

        $("#thumbnails").append(thumbnails.join(''));

        currentAmount += json.length;
        isPreviousEventComplete = true;

        if (json.length < availableLoadItems) isDataAvailable = false;
    }

    function createThumbItem(id, title, fileName) {
        var thumbUrl = loadThumbnailsUrl + id + '/' + fileName;
        if (!title) title = "";
        return '<li><a class="thumbnail fancybox" rel="gallery" href="' + thumbUrl + '" title="' + title + '"><img class="picture" src="' + thumbUrl + '"></a></li>';
    }
})(thumbnailLoader);
