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
    rootPath: object.frontendPath(),

    // Page
    pagePath: function(path) {
      return object.frontendPathFor(path);
    }
  };

  return object;

}(Archangel || {}));
