$(document).ready(function() {
  $(".menu-container .menu-hamburguer-container").click(function() {
    $("#menu").slideToggle();
  });

  $(window).resize(function() {
    if (window.innerWidth > 1024) {
      $(".menu-container #menu").removeAttr("style");
    }
  });

  var topBar = $(".menu-container .menu-hamburguer li:nth-child(1)"),
    middleBar = $(".menu-container .menu-hamburguer li:nth-child(2)"),
    bottomBar = $(".menu-container .menu-hamburguer li:nth-child(3)");

  $(".menu-container .menu-hamburguer-container").on("click", function() {
    if (middleBar.hasClass("rot-45deg")) 
    {
      topBar.removeClass("rot45deg");
      middleBar.removeClass("rot-45deg");
      bottomBar.removeClass("hidden");
    } 
    else 
    {
      bottomBar.addClass("hidden");
      topBar.addClass("rot45deg");
      middleBar.addClass("rot-45deg");
    }
  });
});
