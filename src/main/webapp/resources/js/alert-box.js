/**
 * Shows alerts in the top of screen.
 */

function alertError(message) {
    abstractAlert("Error!", 'alert-error', message);
}

function alertWarning(message) {
    abstractAlert("Warning!", '', message);
}

function alertSuccess(message) {
    abstractAlert("Success!", 'alert-success', message);
}

function alertInfo(message) {
    abstractAlert("Info!", 'alert-info', message);
}

function abstractAlert(type, alertClass, message) {
    var alert = '<li class="alert ' + alertClass + '" style="overflow: hidden"><button type="button" class="close" data-dismiss="alert">&times;</button><strong>' + type + '</strong> ' + message + '</li>';
    var alertBox = $('.alert-box');

    if (alertBox.children('li').size() < 3) {
        alertBox.append(alert);
    } else {
        alertBox.find("li").first().remove();
        alertBox.append(alert);
    }
    var item = alertBox.find("li").last();
    setTimeout(function () {
        $(item).remove();
    }, 5000);
}
