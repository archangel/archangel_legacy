$(document).ready(function () {

  $(window).bind('resize', function () {
    $('body').toggleClass('body-small', ($(window).width() <= 768));
  }).trigger('resize');

  $('[data-toggle=popover]').popover();

  if (localStorageSupport()) {
    var collapse = localStorage.getItem('collapse_menu');
    var body = $('body');

    if (collapse == 'on') {
      if ( ! body.hasClass('body-small')) {
        body.addClass('mini-navbar');
      }
    }
  }

});

function localStorageSupport() {
  return (('localStorage' in window) && window['localStorage'] !== null);
}
