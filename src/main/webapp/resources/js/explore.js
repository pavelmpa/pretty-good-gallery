/**
 * Created by Paul on 14.02.14.
 */

$(document).ready(function () {

    // perform initial loading
    setTimeout('justifiedLayout.loadData()', 3000);

    $("#update").click(justifiedLayout.loadData);

    $("#tags").keyup(function (event) {
        if (event.keyCode == 13) {
            $("#update").click();
        }
    });
});

// Namespace justifiedLayout, using Dynamic namespaces pattern
// http://javascriptweblog.wordpress.com/2010/12/07/namespacing-in-javascript/
var justifiedLayout = {}, picsArray;

(function (context) {

    var minWidth = 800;
    var minHeight = 200;

    var lastWidth = 0;
    var photoArray = null;
    var maxPhotos = 30;
    // total number of images appearing in all previous rows
    var baseLine = 0;

    $(window).resize(function () {

        var nowWidth = $("div#picstest").innerWidth();
        if (nowWidth < minWidth) return;

        // test to see if the window resize is big enough to deserve a reprocess
        if (nowWidth * 1.1 < lastWidth || nowWidth * 0.9 > lastWidth) {
            // if so call method
            updateRows();
        }
    });

    context.loadData = function () {
        photoArray = null;
        baseLine = 0;
        maxPhotos = 30;
        $("div#pics").empty();
        $("#loading").show();

        var tags = $("#tags").val();
        var sort = $("#sort").val();

        photoArray = $('#thumbnails').find('img');
        updateRows();
        $.getJSON("/explore.json", { fromItem: 0 },
            function (data, status) {
                photoArray = data;
                updateRows();
                $("#loading").hide();
            }
        );
    };

    var clickHandler = function (photo) {
        return function () {
            //                var url = "http://www.flickr.com/photos/" + photo.owner + "/" + photo.id;
            var url = "#";
            location.href = url;
        };
    };

    // only call this when either the data is loaded, or the windows resizes by a chunk
    var updateRows = function () {
        lastWidth = $("div#picstest").innerWidth();
        lastWidth = Math.max(lastWidth, minWidth);
        baseLine = 0;
        //            processPhotos(photoArray);
        processImages(photoArray);
        $("div.picrow").width(lastWidth);
    };

    var processImages = function (thumbList) {
        if (!thumbList) return;

        var d = $("div#pics");
        if (baseLine === 0) {
            d.empty();
        }

        var w = lastWidth;
        var h = Math.max(minHeight, Math.floor(w / 5));
        var border = 5;

        var storedWidths = [];
        $.each(thumbList, function (key, val) {
            var wt = val.width;
            var ht = val.height;
            if (ht != h) {
                wt = Math.floor(wt * (h / ht));
            }
            storedWidths.push(wt);
        });

        var rowNum = 0;
        var limit = Math.min(maxPhotos, thumbList.length);

        while (baseLine < limit) {
            rowNum++;
            // number of images appearing in this row
            var numberOfImagesInRow = 0;
            // total width of images in this row - including margins
            var totalWidth = 0;

            // calculate width of images and number of images to view in this row.
            while ((totalWidth * 1.1 < w) && (baseLine + numberOfImagesInRow < limit)) {
                totalWidth += storedWidths[baseLine + numberOfImagesInRow++] + border * 2;
            }

            // skip the last row
            if (baseLine + numberOfImagesInRow >= limit) return;

            var d_row = $("<div/>", {"class": "picrow"});
            d.append(d_row);


            // Ratio of actual width of row to total width of images to be used.
            var ratio = w / totalWidth;

            // image number being processed
            var imageNumber = 0;
            // reset total width to be total width of processed images
            totalWidth = 0;
            // new height is not original height * ratio
            var newHeight = Math.floor(h * ratio);
            d_row.height(newHeight + border * 2);

            var thumbUrlTemplate = "/albums";

            while (imageNumber < numberOfImagesInRow) {
                var thumb = thumbList[baseLine + imageNumber];
                // Calculate new width based on ratio
                var wt = Math.floor(storedWidths[baseLine + imageNumber] * ratio);
                // add to total width with margins
                totalWidth += wt + border * 2;

                // Create image, set src, width, height and margin
                //                    var purl = listItem.url_n;
                var purl = thumbUrlTemplate + "/" + thumb.albumHolderId + "/images/" + thumb.id + '/' + thumb.fileName;
                //                    if( wt > listItem.width_n * 1.2 || newHeight > listItem.height_n * 1.2 ) purl = listItem.url_m;
                //                    if( wt > photo.width_m * 1.2 || ht > photo.height_m * 1.2 ) purl = photo.url_z;
                //                    if( wt > photo.width_z * 1.2 || ht > photo.height_z * 1.2 ) purl = photo.url_l;

                var img = $(
                    '<img/>',
                    {
                        "class": "photo",
                        src: purl,
                        width: wt,
                        height: newHeight
                    }).css("margin", border + "px");

                img.click(clickHandler(thumb));
                d_row.append(img);

                imageNumber++;
            }

            // set row height to actual height + margins
            baseLine += numberOfImagesInRow;

            // if total width is slightly smaller than
            // actual div width then add 1 to each
            // photo width till they match
            imageNumber = 0;
            while (totalWidth < w) {
                var img1 = d_row.find("img:nth-child(" + (imageNumber + 1) + ")");
                img1.width(img1.width() + 1);
                imageNumber = (imageNumber + 1) % numberOfImagesInRow;
                totalWidth++;
            }
            // if total width is slightly bigger than
            // actual div width then subtract 1 from each
            // photo width till they match
            imageNumber = 0;
            while (totalWidth > w) {
                var img2 = d_row.find("img:nth-child(" + (imageNumber + 1) + ")");
                img2.width(img2.width() - 1);
                imageNumber = (imageNumber + 1) % numberOfImagesInRow;
                totalWidth--;
            }
        }
    };

    var processPhotos = function (photos) {
        if (!photos) return;

        // divs to contain the images
        var d = $("div#pics");
        if (baseLine === 0) {
            d.empty();
        }

        // get row width - this is fixed.
        var w = lastWidth;

        // initial height - effectively the maximum height +/- 10%;
        var h = Math.max(minHeight, Math.floor(w / 5));
        // margin width
        var border = 5;

        // store relative widths of all images (scaled to match estimate height above)
        var ws = [];
        $.each(photos, function (key, val) {
            var wt = parseInt(val.width_n, 10);
            var ht = parseInt(val.height_n, 10);
            if (ht != h) {
                wt = Math.floor(wt * (h / ht));
            }
            ws.push(wt);
        });

        var rowNum = 0;
        var limit = Math.min(maxPhotos, photos.length);

        while (baseLine < limit) {
            rowNum++;
            // number of images appearing in this row
            var c = 0;
            // total width of images in this row - including margins
            var tw = 0;

            // calculate width of images and number of images to view in this row.
            while ((tw * 1.1 < w) && (baseLine + c < limit)) {
                tw += ws[baseLine + c++] + border * 2;
            }

            // skip the last row
            if (baseLine + c >= limit) return;

            var d_row = $("<div/>", {"class": "picrow"});
            d.append(d_row);


            // Ratio of actual width of row to total width of images to be used.
            var r = w / tw;

            // image number being processed
            var i = 0;
            // reset total width to be total width of processed images
            tw = 0;
            // new height is not original height * ratio
            var ht = Math.floor(h * r);
            d_row.height(ht + border * 2);

            while (i < c) {
                var photo = photos[baseLine + i];
                // Calculate new width based on ratio
                var wt = Math.floor(ws[baseLine + i] * r);
                // add to total width with margins
                tw += wt + border * 2;

                // Create image, set src, width, height and margin
                var purl = photo.url_n;
                if (wt > photo.width_n * 1.2 || ht > photo.height_n * 1.2) purl = photo.url_m;
                //                    if( wt > photo.width_m * 1.2 || ht > photo.height_m * 1.2 ) purl = photo.url_z;
                //                    if( wt > photo.width_z * 1.2 || ht > photo.height_z * 1.2 ) purl = photo.url_l;

                var img = $(
                    '<img/>',
                    {
                        "class": "photo",
                        src: purl,
                        width: wt,
                        height: ht
                    }).css("margin", border + "px");

                img.click(clickHandler(photo));
                d_row.append(img);

                i++;
            }

            // set row height to actual height + margins
            baseLine += c;

            // if total width is slightly smaller than
            // actual div width then add 1 to each
            // photo width till they match
            i = 0;
            while (tw < w) {
                var img1 = d_row.find("img:nth-child(" + (i + 1) + ")");
                img1.width(img1.width() + 1);
                i = (i + 1) % c;
                tw++;
            }
            // if total width is slightly bigger than
            // actual div width then subtract 1 from each
            // photo width till they match
            i = 0;
            while (tw > w) {
                var img2 = d_row.find("img:nth-child(" + (i + 1) + ")");
                img2.width(img2.width() - 1);
                i = (i + 1) % c;
                tw--;
            }

        }
    };

    // levelReached function taken from infiniteScroll jquery plugin
    // https://github.com/holtonma/infini_scroll

    var levelReached = function () {
        // is it low enough to add elements to bottom?
        var pageHeight = Math.max(document.body.scrollHeight ||
            document.body.offsetHeight);
        var viewportHeight = window.innerHeight ||
            document.documentElement.clientHeight ||
            document.body.clientHeight || 0;
        var scrollHeight = window.pageYOffset ||
            document.documentElement.scrollTop ||
            document.body.scrollTop || 0;
        // Trigger for scrolls within 20 pixels from page bottom
        return pageHeight - viewportHeight - scrollHeight < 10;
    };

    var pollLevel = function () {
        if (photoArray && levelReached()) {
            maxPhotos = Math.min(maxPhotos + 30, 150);
            processPhotos(photoArray);
        }
        setTimeout(pollLevel, 100);
    };

    pollLevel();

})(justifiedLayout);
