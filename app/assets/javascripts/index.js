window.resizeMasthead = function () {
  // Because sometimes you just you know, shit fucks up, and don't fuck w fixed.
  if (typeof(navbar) !== null && typeof(masthead) !== null &&
      ! navbar.hasClass("fixed")) {

    viewport = $(window).height();
    masthead.height(viewport - navbar.height());
  }
}

window.fixNavBar = function () {
  if (typeof(navbar) !== null) {
    // People scroll fast as fuck sometimes and it makes it less choppy.
    if ($(window).scrollTop() > (navbar_position - (navbar.height() * 2))) {
      navbar.addClass("fixed");
      // Because Jim wanted it.
    }

    else {
      // So there aren't problems.
      navbar.removeClass("fixed");
    }
  }
}

$(document).ready(function () {
  window.navbar = $("header.navbar").first();
  window.navbar_position = navbar.position().top;
  window.masthead = $(".masthead").first();

  resizeMasthead();
  $(window).on("scroll", fixNavBar);
  $(window).on("resize orientationChanged", resizeMasthead);
})
