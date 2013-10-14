/**
 * Created by Paul on 16.05.13.
 */

$(document).ready(function () {
    $("#login").validate({
        rules: {
            j_username: {
                required: true,
                email: true
            },
            j_password: {
                required: true
            }
        }
    });
});