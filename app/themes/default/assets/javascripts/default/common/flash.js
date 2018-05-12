(function () {
  'use strict';

  document.addEventListener('DOMContentLoaded', function() {
    var messagesContainer = document.querySelector('#alert-messages'),
        alertItems = messagesContainer.querySelectorAll('.alert'),
        alertItemCount = alertItems.length;

    function setOpacity(element, opacity, filterOpacity) {
      element.style.opacity = opacity;
      element.style.filter = 'alpha(opacity = ' + filterOpacity + ')';
    }

    function fadeOutFlash(element, startLevel, endLevel, duration, callback) {
      var fadeInternal,
          level = startLevel;

      fadeInternal = setInterval(function() {
        if (level <= endLevel) {
          setOpacity(element, endLevel, endLevel);

          clearInterval(fadeInternal);

          if (typeof callback === 'function') { callback(true); }
        }

        else {
          level -= 0.1;

          setOpacity(element, level, (level * 100));
        }
      }, duration);
    }

    ////
    // Fade flash messages out
    //
    for (var i = 0; i < alertItemCount; i += 1) {
      var item = alertItems[i];

      setTimeout(function() {
        fadeOutFlash(item, 1, 0, 50, function() {
          item.parentNode.removeChild(item);
        });
      }, 3000);
    }
  });
}());
