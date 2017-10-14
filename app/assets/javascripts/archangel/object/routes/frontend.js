(function(object) {
  'use strict';

  object.frontendPath = function() {
    return object.pathBuilder([object.mountScope(), object.frontendScope()]);
  };

  object.frontendPathFor = function(path, args) {
    return object.pathFor([object.frontendScope(), path], args);
  };

  object.route.frontend = {
    // Homepage
    root_path: object.frontendPath(),

    // Page
    page_path: function(path) {
      return object.frontendPathFor(path);
    }
  };

  return object;

}(Archangel || {}));
