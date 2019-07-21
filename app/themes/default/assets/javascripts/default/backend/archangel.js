$(document).ready(function () {

  $(window).bind('resize', function () {
    $('body').toggleClass('body-small', ($(window).width() <= 768));
  }).trigger('resize');

  $(document).on('scroll', function() {
    var scrollDistance = $(this).scrollTop();

    if (scrollDistance > 100) {
      $('.scroll-to-top').fadeIn();
    } else {
      $('.scroll-to-top').fadeOut();
    }
  });

  $('a.scroll-to-top').click(function(e) {
    $('html, body').scrollTop(0);

    e.preventDefault();
  });

  $('[data-toggle=popover]').popover();

});
