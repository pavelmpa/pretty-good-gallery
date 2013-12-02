/**
 * Handle and process album creation edition and deletion actions from albums-list page.
 */

var isPreviousAjaxRequestComplete = true, isWaitDialogHide = true;

$(document).ready(function () {
    $('#create-album').on("click", function () {
        createAlbum();
    });

    $('#edit-dialog').on('hidden.bs.modal', function () {
        cleanEditForm();
    });

    $('#wait-dialog').on('hidden.bc.modal', function () {
        isWaitDialogHide = true;
    });

    var $editForm = $('#edit-form');

    $editForm.on("submit", function (event) {
        event.preventDefault();

        if (isPreviousAjaxRequestComplete && isWaitDialogHide && $editForm.valid()) {
            var url = document.URL.replace("#", "/");
            var type = $editForm.attr("method");
            var data = $editForm.serializeObject();

            $.ajax({
                url: url,
                type: type,
                dataType: 'json',
                contentType: 'application/json; charset=UTF-8',
                data: JSON.stringify(data),
                timeout: 10000,
                success: function (response, statusCode, xhr) {
                    var message = response.message;
                    var album = response.album;

                    if (xhr.status == 200) {
                        updateAlbumInTable(album);
                        alertSuccess(message);
                    } else if (xhr.status == 201) {
                        addAlbumToTable(album);
                        alertSuccess(message);
                    } else if (xhr.status == 204) {
                        alertWarning(response);
                    } else {
                        alertInfo(message)
                    }
                    $('#edit-dialog').modal('hide');
                },
                error: function (xhr) {
                    if (xhr.status == 400) {
                        showErrors(xhr.responseText);
                    } else {
                        alertError("Try it again please.");
                    }
                }
            });
        }
    });

    $('#confirm-delete').on('click', function () {
        if (isPreviousAjaxRequestComplete && isWaitDialogHide) {

            $('#delete-dialog').modal('hide');
            var url = document.URL.replace("#", "/");

            $.ajax({
                url: url,
                type: 'DELETE',
                timeout: 10000,
                success: function (response, statusCode, xhr) {
                    if (xhr.status == 200) {
                        var rowToRemove = $('#confirm-delete').attr("href");
                        $(rowToRemove).slideUp(500);
                        alertSuccess(response.message);
                    } else if (xhr.status == 204) {
                        alertWarning("Album does not exist.");
                    } else {
                        alertWarning("Please try again.");
                    }
                },
                error: function (xhr) {
                    alertError(xhr.responseText.message);
                }
            });
        }
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

$(document).on({
    mouseenter: function () {
        $(this).children('i').addClass('icon-white');
    },
    mouseleave: function () {
        $(this).children('i').removeClass('icon-white');
    }
}, '.album-delete, .album-edit');

$(document).on("click", '.album-edit', function () {
    editAlbum(this);
});

$(document).on("click", '.album-delete', function () {
    var reference = $(this).attr("href");
    $('#confirm-delete').attr("href", reference);
    $('#delete-dialog').modal();
});

$(document).ajaxSend(function () {
    isPreviousAjaxRequestComplete = false;
    isWaitDialogHide = false;
    $('#wait-dialog').modal();
}).ajaxComplete(function () {
        isPreviousAjaxRequestComplete = true;
        $('#wait-dialog').modal('hide');
    });

var showErrors = function (data) {
    $('#field-errors').remove();
    var json = $.parseJSON(data);
    var $fieldErrors = $('<div id="field-errors" class="error"></div>');

    $.each(json.fieldErrors, function (key, value) {
        $($fieldErrors).append($('<p>' + value.message + '</p>'));
    });
    $('form').children('.modal-body').prepend($fieldErrors);

    alertError(json.message);
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

function createAlbum() {
    showEditDialog("Create album", "POST");
}

function editAlbum(element) {
    var $row = $($(element).attr("href"));
    var title = $row.children('.title').text();
    var description = $row.children('.description:not(.no-description)').text();

    showEditDialog("Edit album", "PUT", title.trim(), description.trim());
}

function showEditDialog(header, method, title, descriprion) {
    var $editDialog = $('#edit-dialog');

    $editDialog.find('h3').text(header);
    $editDialog.find('form').attr("method", method);

    $('#title').attr("value", title);
    $('#description').text(descriprion);

    $editDialog.modal();
}

function cleanEditForm() {
    $('#field-errors').remove();
    $('label.error').remove();

    $('#title').attr("value", "");
    $('#description').text("");

    $("#edit-form")[0].reset();
}

function addAlbumToTable(album) {
    var id = album.id;
    var $newRow = $('<tr id="' + id + '"></tr>');
    var td = [];

    td.push($('<td>' + getNumberCell() + '</td>'));
    td.push($('<td class="title"><a href="/albums/' + id + '">' + album.title + '</a></td>'));
    td.push(getDescription(album.description));
    td.push($('<td>' + album.numberOfImages + '</td>'));
    td.push($('<td>' + album.created + '</td>'));
    td.push($('<td>' +
        '<a class="album-edit" href="#' + id + '"><i class="icon-edit"></i></a>' +
        '</td>'));
    td.push($('<td>' +
        '<a class="album-delete" href="#' + id + '">' +
        '<i class="icon-remove"></i>' +
        '</a>' +
        '</td>'));

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
}

function updateAlbumInTable(albumJson) {
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
}
