// clearボタンを押した時の動作
$(function() {
    $("#js_conditions_clear").on("click", function() {
        clearForm(this.form);
    });

    function clearForm(form) {
        $(form)
            .find("input, select, textarea")
            .not(":button, :submit, :reset, :hidden")
            .val("")
            .prop("checked", false)
            .prop("selected", false);
        $("select[name=sort_order]").children().first().attr("selected", true);
        $("#children_category_search").remove();
        $("#grandchildren_category_checkboxes").remove();
    }
});