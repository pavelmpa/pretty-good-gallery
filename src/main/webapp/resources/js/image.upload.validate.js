/**
 *
 * File upload form validator.
 */

$(document).ready(function () {
    $.validator.addMethod("fileSize", function (value, element, param) {
        // param = size (en bytes)
        // element = element to validate (<input>)
        // value = value of the element (file name)
        return this.optional(element) || (element.files[0].size <= param)
    });

    $("#image-upload-form").validate({
        errorLabelContainer: "#errors_block",
        rules: {
            file: {
                required: true,
                accept: "png|jpe?g|gif",
                fileSize: 102400
            }
        },
        messages: {
            file: "Please select image file, it must be JPG, JPEG or PNG less 100 kBytes."
        }
    });
});