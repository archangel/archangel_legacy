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
    root_path: object.authPath(),

    // Login
    login_path: object.authPathFor('login')
  };

  return object;

}(Archangel || {}));
