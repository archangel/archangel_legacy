(function () {
  'use strict';

  jQuery(function() {

    $('.card-actions').on('click', 'a, button', function(evt) {
      evt.preventDefault();

      if ($(this).hasClass('btn-close')) {
        $(this).parent().parent().parent().fadeOut();
      } else if ($(this).hasClass('btn-minimize')) {
        var panelIconOpened = 'icon-arrow-up',
            panelIconClosed = 'icon-arrow-down';

        if ($(this).hasClass('collapsed')) {
          $('i', $(this)).removeClass(panelIconOpened).addClass(panelIconClosed);
        } else {
          $('i', $(this)).removeClass(panelIconClosed).addClass(panelIconOpened);
        }
      }
    });

  });
}());
