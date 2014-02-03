/**
 * Created by Paul on 14.12.13.
 */

var alertBox = {};
(function (context) {
    alertBox.alertError = function (message) {
        abstractAlert("Error!", 'alert-danger', message);
    };

    alertBox.alertWarning = function (message) {
        abstractAlert("Warning!", '', message);
    };

    alertBox.alertSuccess = function (message) {
        abstractAlert("Success!", 'alert-success', message);
    };

    alertBox.alertInfo = function (message) {
        abstractAlert("Info!", 'alert-info', message);
    };

    function abstractAlert(type, alertClass, message) {
//    var alert = '<li class="alert ' + alertClass + '" style="overflow: hidden"><button type="button" class="close" data-dismiss="alert">&times;</button><strong>' + type + '</strong> ' + message + '</li>';
        var alert = '<li class="alert alert-dismissable ' + alertClass + '"><button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button><strong>' + type + '</strong> ' + message + '</li>';
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
})(alertBox);
