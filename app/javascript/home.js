$(function() {
    $("#info-show").on("click", function() {
        $("#info-first").fadeIn(1000);
        $(this).hide();
        $("#info-close").show();
    });
    $("#info-close").on("click", function() {
        $("#info-first").fadeOut(1000);
        $(this).hide();
        $("#info-show").show();
    });
    $("#howto-show").on("click", function() {
        $("#info-second").fadeIn(1000);
        $(this).hide();
        $("#howto-close").show();
    });
    $("#howto-close").on("click", function() {
        $("#info-second").fadeOut(1000);
        $(this).hide();
        $("#howto-show").show();
    });
});