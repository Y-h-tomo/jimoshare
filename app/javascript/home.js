$(function() {
    $("#info-show").on("click", function() {
        $("#info-first").slideDown(1000);
        $(this).hide();
        $("#info-close").show();
    });
    $("#info-close").on("click", function() {
        $("#info-first").slideUp(1000);
        $(this).hide();
        $("#info-show").show();
    });
    $("#howto-show").on("click", function() {
        $("#info-second").slideDown(1000);
        $(this).hide();
        $("#howto-close").show();
    });
    $("#howto-close").on("click", function() {
        $("#info-second").slideUp(1000);
        $(this).hide();
        $("#howto-show").show();
    });
    $("#card-earth").on("click", function() {
        $("#card-earth-show").fadeIn(1000);
        $(this).hide();
    });
    $("#card-earth-show").on("click", function() {
        $("#card-earth").fadeIn(1000);
        $(this).hide();
    });
    $("#card-loss").on("click", function() {
        $("#card-loss-show").fadeIn(1000);
        $(this).hide();
    });
    $("#card-loss-show").on("click", function() {
        $("#card-loss").fadeIn(1000);
        $(this).hide();
    });
    $("#card-child").on("click", function() {
        $("#card-child-show").fadeIn(1000);
        $(this).hide();
    });
    $("#card-child-show").on("click", function() {
        $("#card-child").fadeIn(1000);
        $(this).hide();
    });
    $("#card-dev").on("click", function() {
        $("#card-dev-show").fadeIn(1000);
        $(this).hide();
    });
    $("#card-dev-show").on("click", function() {
        $("#card-dev").fadeIn(1000);
        $(this).hide();
    });
});