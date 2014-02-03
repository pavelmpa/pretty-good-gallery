/**
 * Handle and process album creation edition and deletion actions from albums-list page.
 */

$(document).ready(function () {
    $('#create-album').on("click", function () {
        albumsManager.createAlbum();
    });

    $('#edit-dialog').on('hidden.bs.modal', function () {
        albumsManager.cleanEditForm();
    });

    $('#wait-dialog').on('hidden.bs.modal', function () {
        albumsManager.isWaitDialogHide = true;
    });

    var $editForm = $('#edit-form');

    $editForm.on("submit", function (event) {
        event.preventDefault();

        if (albumsManager.isPreviousAjaxRequestComplete && albumsManager.isWaitDialogHide && $editForm.valid()) {
            var x = $editForm.validate();
            alert(x);
            var url = document.URL.replace("#", "/");
            var type = $editForm.attr("method");
            var data = $editForm.serializeObject();

            var presentation = $('#album-wrap').data('presentation');

            if (type == "POST") {
                albumsManager.createAlbumRequest(url, data);
            } else if (type === "PUT") {
                albumsManager.editAlbumRequest(url, data);
            }
        }
    });

    $('#confirm-delete').on('click', function () {
        $('#delete-dialog').modal('hide');
        var url = document.URL.replace("#", "/");
        albumsManager.deleteAlbumRequest(url);
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

$(document).on("click", '.album-edit', function () {
    albumsManager.editAlbum(this);
});

$(document).on("click", '.album-delete', function () {
    var reference = $(this).attr("href");
    $('#confirm-delete').attr("href", reference);
    $('#delete-dialog').modal();
});

$(document).ajaxSend(function () {
    albumsManager.isPreviousAjaxRequestComplete = false;
    albumsManager.isWaitDialogHide = false;
    $('#wait-dialog').modal();
}).ajaxComplete(function () {
    albumsManager.isPreviousAjaxRequestComplete = true;
    $('#wait-dialog').modal('hide');
});

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

var albumsManager = {};

(function (context) {
    context.isPreviousAjaxRequestComplete = true;
    context.isWaitDialogHide = true;

    context.deleteAlbumRequest = function (url) {
        if (context.isPreviousAjaxRequestComplete && context.isWaitDialogHide) {
            $.ajax({
                url: url,
                type: 'DELETE',
                timeout: 10000,
                success: function (response, statusCode, xhr) {
                    if (xhr.status == 200) {
                        var rowToRemove = $('#confirm-delete').attr("href");
                        $(rowToRemove).slideUp(500);
                        alertBox.alertSuccess(response.message);
                    } else if (xhr.status == 204) {
                        alertBox.alertWarning("Album does not exist.");
                    } else {
                        alertBox.alertWarning("Please try again.");
                    }
                },
                error: function (xhr) {
                    alertBox.alertError(xhr.responseText.message);
                }
            });
        }
    };

    context.editAlbumRequest = function (url, data) {
        if (context.isPreviousAjaxRequestComplete && context.isWaitDialogHide) {

            $.ajax({
                url: url,
                type: 'PUT',
                dataType: 'json',
                contentType: 'application/json; charset=UTF-8',
                data: JSON.stringify(data),
                timeout: 10000,
                success: editAlbumCallback,
                error: function (xhr) {
                    if (xhr.status == 400) {
                        alertBox.showErrors(xhr.responseText);
                    } else {
                        alertBox.alertError("Try it again please.");
                    }
                }
            });
        }
    };

    var editAlbumCallback = function (response, statusCode, xhr) {
        var message = response.message;
        var album = response.album;

        if (xhr.status == 201) {
            updateAlbumInTable(album);
            alertBox.alertSuccess(message);
        } else if (xhr.status == 204) {
            alertBox.alertWarning(response);
        } else {
            alertInfo(message);
        }
        $('#edit-dialog').modal('hide');
    };

    context.createAlbumRequest = function (url, data) {
        if (context.isPreviousAjaxRequestComplete && context.isWaitDialogHide) {

            $.ajax({
                url: url,
                type: "POST",
                dataType: 'json',
                contentType: 'application/json; charset=UTF-8',
                data: JSON.stringify(data),
                timeout: 10000,
                success: successAlbumCreateCallback,
                error: function (xhr) {
                    if (xhr.status == 400) {
                        showErrors(xhr.responseText);
                    } else {
                        alertBox.alertError("Try it again please.");
                    }
                }
            });
        }
    };

    var successAlbumCreateCallback = function (response, statusCode, xhr) {
        var message = response.message;
        var album = response.album;
        var presentation = $('#album-wrap').data('presentation');
        var addNewAlbum;

        if (presentation === 'table') {
            addNewAlbum = addAlbumRow;
        } else if (presentation === 'cells') {
            addNewAlbum = addAlbumCell;
        }

        if (xhr.status == 200) {
            addNewAlbum(album);
            alertBox.alertSuccess(message);
        } else if (xhr.status == 204) {
            alertBox.alertWarning(response);
        } else {
            alertBox.alertInfo(message)
        }
        $('#edit-dialog').modal('hide');
    };

    var addAlbumCell = function (album) {
    };

    var addAlbumRow = function (album) {
        var id = album.id;
        var $newRow = $('<tr id="' + id + '"></tr>');
        var td = [];

        td.push($('<td>' + getNumberCell() + '</td>'));
        td.push($('<td class="title"><a href="/albums/' + id + '">' + album.title + '</a></td>'));
        td.push(getDescription(album.description));
        td.push($('<td>' + album.numberOfImages + '</td>'));
        td.push($('<td>' + album.created + '</td>'));
        td.push($('<td><a class="album-edit" href="#' + id + '"><span class="glyphicon glyphicon-edit"></span></a></td>'));
        td.push($('<td><a class="album-delete" href="#' + id + '"><span class="glyphicon glyphicon-remove"></span></i></a></td>'));

        $.each(td, function (key, value) {
            $newRow.append(value);
        });

        $('tbody').append($newRow);

        function getNumberCell() {
            var lastNumber = parseInt($('tbody').children('tr').last().children('td').first().text());
            return (isNaN(lastNumber)) ? 1 : lastNumber + 1;
        }

        function getDescription(description) {
            var $description = $('<td class="description"></td>');

            if (description) {
                $description.text(description);
            } else {
                $description.addClass('no-description').text("\u2014");
            }

            return $description;
        }
    };

    context.updateAlbumInTable = function (albumJson) {
        var $album = $('#' + albumJson.id);

        $album.children('.title').find('a').text(albumJson.title);
        setDescription(albumJson.description);

        function setDescription(description) {
            var $description = $album.children('.description');

            if ($.isEmptyObject(description)) {
                $description.addClass('no-description');
                $description.text("\u2014");
            } else {
                $description.removeClass('no-description');
                $description.text(description);
            }
        }
    };

    context.showErrors = function (data) {
        $('#field-errors').remove();
        var json = $.parseJSON(data);
        var $fieldErrors = $('<div id="field-errors" class="error"></div>');

        $.each(json.fieldErrors, function (key, value) {
            $($fieldErrors).append($('<p>' + value.message + '</p>'));
        });
        $('form').children('.modal-body').prepend($fieldErrors);

        alertBox.alertError(json.message);
    };

    context.createAlbum = function () {
        showEditDialog("Create album", "POST");
    };

    context.editAlbum = function (element) {
        var $row = $($(element).attr("href"));
        var title = $row.children('.title').text();
        var description = $row.children('.description:not(.no-description)').text();

        showEditDialog("Edit album", "PUT", title.trim(), description.trim());
    };

    function showEditDialog(header, method, title, descriprion) {
        var $editDialog = $('#edit-dialog');

        $editDialog.find('h4').text(header);
        $editDialog.find('form').attr("method", method);

        $('#title').attr("value", title);
        $('#description').text(descriprion);

        $editDialog.modal();
    }

    context.cleanEditForm = function () {
        $('#field-errors').remove();
        $('label.error').remove();

        $('#title').attr("value", "");
        $('#description').text("");

        $("#edit-form")[0].reset();
    };
})(albumsManager);

