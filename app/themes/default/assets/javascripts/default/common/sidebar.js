(function () {
  'use strict';

  jQuery(function() {

    function resizeBroadcast() {
      var timesRun = 0,
          interval = setInterval(function() {
            timesRun += 1;
            if (timesRun === 5) {
              clearInterval(interval);
            }
            window.dispatchEvent(new Event('resize'));
          }, 62.5);
    }

    // Dropdown Menu
    $('nav > ul.nav').on('click', 'a', function(evt) {
      if ($.ajaxLoad) {
        evt.preventDefault();
      }

      if ($(this).hasClass('nav-dropdown-toggle')) {
        $(this).parent().toggleClass('open');

        resizeBroadcast();
      }
    });

    $('.sidebar-toggler').click(function(){
      $('body').toggleClass('sidebar-hidden');

      resizeBroadcast();
    });

    $('.sidebar-minimizer').click(function(){
      $('body').toggleClass('sidebar-minimized');

      resizeBroadcast();
    });

    $('.brand-minimizer').click(function(){
      $('body').toggleClass('brand-minimized');
    });

    $('.mobile-sidebar-toggler').click(function(){
      $('body').toggleClass('sidebar-mobile-show');

      resizeBroadcast();
    });

  });
}());
