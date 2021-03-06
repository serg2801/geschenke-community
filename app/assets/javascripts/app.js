$(document).ready(function () {

    if ($(".product").length > 0) {
        var column_width = $(".product").width();
    } else {
        var column_width = 300;
    }

    var $container = $('#products-container');
    $container.imagesLoaded(function () {
        $container.masonry({
            itemSelector: '.product',
            columnWidth: column_width,
            gutterWidth: 20
        });
    });

    $("[rel=tooltip]").tooltip();

    $("#products-container").on("click", ".add-to-list", function (event) {
        event.preventDefault();
        $(this).tooltip('hide');
        $(this).parent().animate({
            left: '-61px'
        }, 320);
    });

    $("#list-select select").on("change", function (event) {
        $(this).parent("form").submit();
    });

    $("#products-container").on("submit", ".product-list-add form", function (event) {
        event.preventDefault();
        $(this).find("button").attr("disabled", "disabled");
        var product_id = $(this).find("input[name='product_id']").val();
        var list_id = $(this).find("select[name='list_id']").val();
        $.ajax({
            type: "POST",
            dataType: "script",
            data: {"product_id": product_id, "list_id": list_id},
            url: $(this).attr('action')
        });
    });

    $(".window a.close").on("click", function (event) {
        event.preventDefault();
        $(".window-container").hide();
    });

    $(".cta-signup").on("click", function (event) {
        event.preventDefault();
        $("#signup").fadeIn("fast");
    });

    $("#navigation .topic").on("click", function (event) {
        if (typeof $(this).attr("href") !== 'undefined' && attr !== false) {
            return false;
        }
        if ($(this).parent().hasClass("active")) {
            $(this).parent().removeClass("active");
        } else {
            $("#navigation .top.active").removeClass("active");
            $(this).parent().addClass("active");
        }
    });

    $("#filter-form select").on("change", function (event) {
        $("#filter-form").submit();
    });

    $("#more-products").on("click", function (event) {
        event.preventDefault();
        $(this).addClass("loading");
        $.ajax({
            type: "GET",
            dataType: "script",
            url: $(this).attr('href')
        });
    });

    $(document).on("click", ".go", function (event) {
        var slug = $(event.target).data("slug")
        if (slug == null) {
            slug = $(event.target).parent().data("slug")
        }

        $.ajax({
            type: "post",
            url: "/track/click",
            data: {
                "slug": slug
            }
        });
    });

    // start-nav-mobile

    $(".js_btn_menu-mobile").click(function () {
        $("#navigation").toggle();
    });

    //start-resize-window

    function auto_width() {
        var _w = $(window).width();

        if (_w > 767) {
            $('#navigation').removeAttr('style');
        }
    }

    auto_width();

    $(window).resize(function () {
        auto_width();
    });

    //end-resize-window

});