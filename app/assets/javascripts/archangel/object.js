var Archangel = (function(object) {
  'use strict';

  function mergeRecursive(obj1, obj2) {
    for (var p in obj2) {
      try {
        if (obj2[p].constructor == Object) {
          obj1[p] = mergeRecursive(obj1[p], obj2[p]);
        } else {
          obj1[p] = obj2[p];
        }
      } catch(e) {
        obj1[p] = obj2[p];
      }
    }

    return obj1;
  }

  object.authTokenName = window._auth_token_name;
  object.authToken = window._auth_token;

  return object;

}(Archangel || {}));
