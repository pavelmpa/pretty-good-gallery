/**
 * Created by Paul on 13.02.14.
 */

$(document).ready(function () {
    albumLayout.loadAlbumList();

    $('#create-album').on("click", function () {
        albumLayout.createAlbum();
    });

    $('#edit-dialog').on('hidden.bs.modal', function () {
        albumLayout.cleanEditForm();
    });

    var $editForm = $('#edit-form');

    $editForm.on("submit", function (event) {
        event.preventDefault();
        albumLayout.createAlbumSubmitHandler();
    });

    $editForm.validate({
        rules: {
            title: {
                maxlength: 100,
                required: true
            },
            description: {
                maxlength: 300
            }
        }
    });
});

var albumLayout = {};

(function (context) {
    var isPreviousAjaxRequestComplete = true;
    var url = document.URL.replace("#", "").replace("manage", "");

    context.cleanEditForm = function () {
        $('#field-errors').remove();
        $('label.error').remove();

        $('#title').attr("value", "");
        $('#description').text("");

        $("#edit-form")[0].reset();
    };

    context.createAlbum = function () {
        showEditDialog("Create album", "POST");
    };

    var showEditDialog = function (header, method, title, descriprion) {
        var $editDialog = $('#edit-dialog');

        $editDialog.find('h4').text(header);
        $editDialog.find('form').attr("method", method);

        $('#title').attr("value", title);
        $('#description').text(descriprion);

        $editDialog.modal();
    };

    context.createAlbumSubmitHandler = function () {
        var $editForm = $('#edit-form');

        var createAlbumRequest = function (data) {
            $.ajax({
                url: url,
                type: "POST",
                dataType: 'json',
                contentType: 'application/json; charset=UTF-8',
                data: JSON.stringify(data),
                timeout: 10000,
                success: createAlbumSuccessCallback,
                error: function (xhr) {
                    if (xhr.status == 400) {
                        showErrors(xhr.responseText);
                    } else {
                        alertBox.alertError("Try it again please.");
                    }
                }
            });
        };

        if (isPreviousAjaxRequestComplete && $editForm.valid()) {
            var data = $editForm.serializeObject();
            createAlbumRequest(data);
        }
    };

    var createAlbumSuccessCallback = function (response, statusCode, xhr) {
        var message = response.message;
        var album = response.album;
        var presentation = $('#album-list-wrap').data('presentation');

        if (xhr.status == 201) {
            appendAlbumToLayout(album);
            alertBox.alertSuccess(message);
        } else {
            alertBox.alertWarning(message)
        }
        $('#edit-dialog').modal('hide');
    };

    var processAlbumListJson = function (data) {
        $.each(data, function (key, value) {
            appendAlbumToLayout(value)
        });
    };

    //TODO: Implement covers loading indicator
    var appendAlbumToLayout = function (album) {
        var albumId = album.id;
        var albumUrl = url + "/" + albumId;
        var covers = [];

        $.getJSON(albumUrl + "/images", { fromItem: 0, amount: 3 }).done(function (albumCovers) {
            if (albumCovers.length > 0) {
                for (var key in albumCovers) {
                    if (albumCovers.hasOwnProperty(key)) {
                        covers.push({
                            coverUrl: albumUrl + "/images/" + albumCovers[key].id + "/" + albumCovers[key].fileName,
                            coverWidth: albumCovers[key].width,
                            coverHeight: albumCovers[key].height
                        });
                    }
                }
            } else {
                covers.push({
                    coverUrl: "http://www.placehold.it/300x200/3c3c3c/ffffff&text=No%20pics%20yet",
                    coverWidth: 300,
                    coverHeight: 200
                });
            }

            createAlbumItem(albumId, albumUrl, album.title, covers);
        }).fail(function () {
            covers.push({
                coverUrl: "http://www.placehold.it/300x200&text=Can't load covers",
                coverWidth: 300,
                coverHeight: 200
            });

            createAlbumItem(albumId, albumUrl, album.title, covers);
        });

        var createAlbumItem = function (albumId, albumUrl, albumTitle, covers) {
            var loop = null, images = $();

            var $albumsWrap = $('#album-holder');

            var $albumItem = $('<div/>', { id: albumId, 'class': "album-item"});
            var $albumThumb = $('<div/>', { 'class': "album-thumb" });
            var $album = $('<a/>', {
                href: albumUrl,
                on: {
                    mouseenter: function () {
                        animationTrigger();
                    },
                    mouseleave: function () {
                        stopAnimation();
                    }
                }
            });
            var $titleContainer = $('<div/>', { 'class': "title-container" });
            var $title = $('<p/>', { text: albumTitle });
            var $cover = $('<img>', {
                src: covers[0].coverUrl,
                css: calculateImageSize(covers[0].coverWidth, covers[0].coverHeight)
            });

            $titleContainer.append($title);
            $album.append($cover).append($titleContainer);
            $albumThumb.append($album);
            $albumItem.append($albumThumb);

            $albumsWrap.append($albumItem);

            var animationTrigger = function () {
                if ($album.data("covers")) return;

                if (!images.length) {
                    for (var index = 1; index < covers.length; index++) {
                        var style = calculateImageSize(covers[index].coverWidth, covers[index].coverHeight);
                        style.opacity = 0;

                        images = images.add('<img>', {
                            src: covers[index].coverUrl,
                            css: style
                        });

                        $cover.after(images);

                        images.first().load(function () {
                            startAnimation();
                        });
                    }
                } else {
                    startAnimation();
                }
            };

            var startAnimation = function () {
                var coverChangeDelay = 1000;

                (function animator() {

                    $album.removeClass('loading');

                    var currentImage = $album.find('img').filter(function () {
                        return ($(this).css('opacity') == 1);
                    });

                    var nextFirst = function (currentImg, e) {
                        var next = currentImg.nextAll(e).first();
                        return (next.length) ? next : currentImg.prevAll(e).last();
                    };

                    currentImage.animate({
                        'opacity': 0
                    });
                    nextFirst(currentImage, 'img').animate({
                        'opacity': 1
                    });

                    loop = setTimeout(animator, coverChangeDelay);
                })();

            };

            var stopAnimation = function () {

                $album.removeClass('loading');
                clearTimeout(loop);
            };
        };
    };

    context.loadAlbumList = function () {
        $.getJSON(url, { format: 'json' }, processAlbumListJson).fail(function () {
            alertBox.alertError("Fail.");
        });
    };

    var calculateImageSize = function (originalWidth, originalHeight) {
        var thumbWidth = 300, thumbHeight = 200;
        var thumbRatio = thumbWidth / thumbHeight;
        var originalRatio = originalWidth / originalHeight;

        if (originalRatio >= thumbRatio) {
            return {
                height: "100%",
                'margin-left': (thumbWidth - originalRatio * thumbHeight) / 2
            };
        } else {
            return {
                width: "100%",
                'margin-top': (thumbHeight - thumbWidth * originalRatio) / 2
            };
        }
    };

    jQuery.fn.serializeObject = function () {
        var arrayData, objectData;
        arrayData = this.serializeArray();
        objectData = {};

        $.each(arrayData, function () {
            var value;

            if (this.value != null) {
                value = this.value;
            } else {
                value = '';
            }

            if (objectData[this.name] != null) {
                if (!objectData[this.name].push) {
                    objectData[this.name] = [objectData[this.name]];
                }

                objectData[this.name].push(value);
            } else {
                objectData[this.name] = value;
            }
        });

        return objectData;
    };
})(albumLayout);
