/**
 * Handle image uploading.
 */

$(document).ready(function () {
    imageUploader.resetUploadForm();

    $(':file').change(function () {
        var file = this.files[0];
        imageUploader.validate(file);
    });

    $('#upload').on("click", function () {
        imageUploader.uploadImage();
    });

    $('[data-toggle=tooltip]').tooltip();
});

$(document).ajaxStart(function () {
    imageUploader.isPreviousAjaxRequestComplete = false;
}).ajaxStop(function () {
    imageUploader.isPreviousAjaxRequestComplete = true;
});

var imageUploader = {};

(function (context) {
    context.isPreviousAjaxRequestComplete = true;

    var isLoadComplete = true;
    var $form = $('form')[0];

    context.resetUploadForm = function () {
        $form.reset();
    };

    context.uploadImage = function () {
        var formData = new FormData($form);

        var file = $('#uploaded-file')[0].files[0];

        if (isLoadComplete && context.isPreviousAjaxRequestComplete && context.validate(file)) {
            isLoadComplete = false;
            $.ajax({
                url: document.URL.replace("upload", "images"),
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                timeout: 10000,
                xhr: function () {  // Custom XMLHttpRequest
                    var xhr = $.ajaxSettings.xhr();
                    if (xhr.upload) { // Check if upload property exists
                        $('#image-upload-progress').addClass("active");
                        xhr.upload.addEventListener('progress', handleProgress, false); // For handling the progress of the upload
                        xhr.upload.addEventListener('load', handleLoadComplete, false); // For handling the progress of the upload
                        xhr.upload.onloadstart = progressStart;
                    }
                    return xhr;
                },
                success: function () {
                    alertBox.alertSuccess("success");
                },
                error: function () {
                    alertBox.alertError("error");
                }
            });
        }
    };

    var $progressWrap = $('#image-upload-progress');
    var $progressBar = $progressWrap.find('.progress-bar');

    function progressStart(event) {
        $progressWrap.addClass("active");
        $progressWrap.removeClass("hidden");
    }

    function handleProgress(event) {
        if (event.lengthComputable) {
            changeProgress((event.loaded / event.total) * 100);
        }
    }

    function handleLoadComplete(event) {
        changeProgress(100);
        $progressWrap.removeClass("active");

        setTimeout(function () {
            $progressWrap.addClass("hidden");
            resetProgressbar();
        }, 1000);

        function resetProgressbar() {
            changeProgress(0);
            context.resetUploadForm();
            isLoadComplete = true;
        }
    }

    function changeProgress(value) {
        $progressBar.attr('aria-valuenow', value);
        $progressBar.css('width', value + "%");
        $progressWrap.find('span').text(value + "% Complete");
    }

    context.validate = function (file) {
        $('#validation-errors').remove();

        var errors = [];
        var valid = true;

        if (file) {
            var fileSize = 102400;

            if (file.size > fileSize) {
                errors.push(error("File is to big. Maximum size is 102 kByte."));
            }

            if (!file.type.match('image/(p?jpeg|(x-)?png)')) {
                errors.push(error("File should be jpeg, png, x-png."));
            }
        } else {
            errors.push(error("Please select file"));
        }

        if (errors.length > 0) {
            showErrors(errors);
            valid = false;
        }

        function error(message) {
            return $('<p>', {text: message});
        }

        function showErrors(errors) {
            var $error = $('<div>', { id: "validation-errors", 'class': "alert alert-danger" });

            $.each(errors, function (k, v) {
                $error.append(v);
            });
            $('form').append($error);
        }

        return valid;
    }
})(imageUploader);
