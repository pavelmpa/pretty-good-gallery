/**
 * This file contains scripts that used on all pages.
 */

$(document).ready(function () {

    var url = window.location;

    $("ul.nav a").filter(function () {
        return this.href == url;
    }).parent().addClass("active");

    $('#sign-in').on('shown.bs.modal', function () {
        $(this).find("[autofocus]:first").focus();
    })
});
