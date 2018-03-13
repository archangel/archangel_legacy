(function () {
  'use strict';

  jQuery(function() {

    // Add class .active to current link
    $('nav > ul.nav').find('a').each(function(){
      var currentUrl = String(window.location).split('?')[0];

      if (currentUrl.substr(currentUrl.length - 1) == '#') {
        currentUrl = currentUrl.slice(0, -1);
      }

      if ($($(this))[0].href == currentUrl) {
        $(this).addClass('active');

        $(this).parents('ul').add(this).each(function(){
          $(this).parent().addClass('open');
        });
      }
    });

  });
}());
