/**
 *
 * Validate registration form. *
 */

$(document).ready(function () {
    $.validator.addMethod("usernameRule", function (value, element) {
        return this.optional(element) || /^[a-z][a-z0-9]{5,19}$/.test(value)
    }, "Username should be in 6 - 20 range and contain latin letters.");

    $("#register-form").validate({
        rules: {
            firstName: {
                maxlength: 30
            },
            lastName: {
                maxlength: 30
            },
            email: {
                required: true,
                email: true
            },
            username: "usernameRule",
            password: {
                minlength: 6,
                maxlength: 30,
                required: true
            },
            confirmPassword: {
                minlength: 6,
                maxlength: 30,
                required: true,
                equalTo: '#password'
            }
        },
        messages: {
            confirmPassword: {
                equalTo: "Passwords don't match."
            }
        }
    });
});
