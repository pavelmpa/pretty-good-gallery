/*
 *  Loading thumbnails.
 *  Receive data about images in JSON and create thumbnails list.
 */

var currentAmount = 0, isPreviousEventComplete = false, isDataAvailable = true, availableLoadItems = 12, showDescription = false;

$(document).ready(function () {
    $('#album-title').on('click', function () {
        $('#album-description').toggle(function () {
            if (!showDescription) {
                $('#description-indicator').removeClass("icon-chevron-down").addClass("icon-chevron-up");
                $('#show-description').addClass("active");
                showDescription = true;
            } else {
                $('#description-indicator').removeClass("icon-chevron-up").addClass("icon-chevron-down");
                $('#show-description').removeClass("active");
                showDescription = false;
            }
        });
    });
    $('.fancybox').fancybox({
            openEffect: 'none',
            closeEffect: 'none'
        }
    );
    loadNewThumbnails();
});

$(window).scroll(function () {
    if ($(document).height() - 50 <= $(window).scrollTop() + $(window).height()) {
        if (isPreviousEventComplete && isDataAvailable) {
            isPreviousEventComplete = false;
            loadNewThumbnails();
        }
    }
});

function loadNewThumbnails() {
    var loadThumbnailsUrl = document.URL + "/images/";

    $.getJSON(loadThumbnailsUrl, { fromItem: currentAmount }).done(
            showImages
        ).fail(function () {
            $("#response-result").text("Something goes wrong.");
        });
}

function showImages(json) {
    var thumbnails = [];

    $.each(json, function (key, value) {
        thumbnails.push(getImageItem(value.id, value.title, value.fileName));
    });

    $(".thumbnails").append(thumbnails.join(''));

    currentAmount += json.length;
    isPreviousEventComplete = true;

    if (json.length < availableLoadItems) isDataAvailable = false;
}

function getImageItem(id, title, fileName) {
    var url = document.URL + "/images/";
    if (title == null) title = "None";
    return  '<li class="span3 thumbnail-loading" >' +
        '<a class="fancybox thumbnail" rel="gallery" title="' + title + '" href="' + url + id + '/' + fileName + '">' +
        '<img style="width: 220px; height: 200px;" src="' + url + id + '/' + fileName + '" />' +
        '</a>' +
        '</li>';
}