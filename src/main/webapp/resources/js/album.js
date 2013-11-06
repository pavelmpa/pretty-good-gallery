/**
 * Process delete actions from albums-list page.
 */

$(document).ready(function () {
    $('.album-delete, .album-edit').on({
        mouseenter: function () {
            $(this).children('i').addClass('icon-white');
        },
        mouseleave: function () {
            $(this).children('i').removeClass('icon-white');
        }
    });

    $('#confirm-delete').on('click', function () {
        var albumId = $('#delete-dialog').data('album-id');
        var url = document.URL + "/" + albumId;
        var elementIdToRemove = "#" + albumId;
        url = url.replace("#", "");
        $.ajax({
            url: url,
            type: 'DELETE',
            timeout: 10000,
            beforeSend: function () {
                var deleteDialog = $('#delete-dialog');
                deleteDialog.removeData('album-id');
                deleteDialog.modal('hide');
                $('#wait-dialog').modal();
            },
            success: function (response, statusCode, xhr) {
                if (xhr.status == 200) {
                    var title = $(elementIdToRemove + ' td.title').text().trim();
                    $(elementIdToRemove).slideUp(500);
                    alertSuccess("Album <strong>\"" + title + "\"</strong> has been deleted.");
                } else if (xhr.status == 204) {
                    alertWarning("Album does not exist.");
                } else {
                    alertWarning("Please try again.");
                }
                $('#wait-dialog').modal('hide');
            },
            error: function (response, statusCode) {
                $('#wait-dialog').modal('hide');
                alertError(response.responseText);
            }
        });
    });
});

function deleteAlbum(object) {
    var dialog = $('#delete-dialog');
    var clickedButton = $(object);
    dialog.data("album-id", clickedButton.data('album-id'));
    dialog.modal();
}
