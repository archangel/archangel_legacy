(function(object) {
  'use strict';

  object.authPath = function() {
    return object.pathBuilder([object.mountScope(), object.authScope()]);
  };

  object.authPathFor = function(path, args) {
    return object.pathFor([object.authScope(), path], args);
  };

  object.route.auth = {
    // Root
    rootPath: object.authPath(),

    // Login
    loginPath: object.authPathFor('login')
  };

  return object;

}(Archangel || {}));
