$(document).ready(function() {

  var $container = $('#products-container');
  $container.imagesLoaded(function(){
    $container.masonry({
      itemSelector: '.product',
      columnWidth: 300,
      gutterWidth: 20
    });
  });

  $("#navigation .topic").on("click", function(event) {

    if(typeof $(this).attr("href") !== 'undefined' && attr !== false) {
      return false;
    }

    if($(this).parent().hasClass("active")) {
      $(this).parent().removeClass("active");
    } else {
      $("#navigation .top.active").removeClass("active");
      $(this).parent().addClass("active");
    }
  });

  $("#filter-form select").on("change", function(event) {
    $("#filter-form").submit();
  });

  $("#more-products").on("click", function(event) {
    event.preventDefault();

    $(this).addClass("loading");

    $.ajax({
      type: "GET",
      dataType: "script",
      url: $(this).attr('href')
    });
  });

});