(function(object) {
  'use strict';

  object.url = {
    segment: function(collection) {
      var url = new URL(window.location.href),
          path = url.pathname.replace(/^\/|\/$/g, '').split('/'),
          segment = null;

      for (var p = 0; p < path.length; p++) {
        if (path[p] === collection) {
          segment = path[p + 1];

          break;
        }
      }

      return segment;
    }
  };

  return object;

}(Archangel || {}));
