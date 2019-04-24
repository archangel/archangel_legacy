(function (object) {
  'use strict';

  object.backendPath = function () {
    return object.pathBuilder([object.mountScope(), object.backendScope()]);
  };

  object.backendUrl = function () {
    return [object.rootUrl(), object.backendPath()].join('/');
  };

  object.backendPathFor = function (path, args) {
    return object.pathFor([object.backendScope(), path], args);
  };

  object.backendUrlFor = function (path, args) {
    return object.backendUrl() + object.backendPathFor(path, args);
  };

  object.route.backend = {
    // Dashboard (path)
    rootPath: object.backendPath(),

    // Dashboard (url)
    rootUrl: object.backendUrl(),

    // Assets (path)
    assetsPath: object.backendPathFor('assets'),
    newAssetPath: object.backendPathFor('assets/new'),
    assetPath: function (id) {
      return object.backendPathFor('assets/' + id);
    },
    editAssetPath: function (id) {
      return object.backendPathFor('assets/' + id + '/edit');
    },

    // Collections
    collectionsPath: object.backendPathFor('collections'),
    newCollectionPath: object.backendPathFor('collections/new'),
    collectionPath: function (slug) {
      return object.backendPathFor('collections/' + slug);
    },
    editCollectionPath: function (slug) {
      return object.backendPathFor('collections/' + slug + '/edit');
    },

    // Collection Entries
    collectionEntriesPath: function (slug) {
      return object.backendPathFor('collections/' + slug + '/entries');
    },
    newCollectionEntryPath: function (slug) {
      return object.backendPathFor('collections/' + slug + '/entries/new');
    },
    collectionEntryPath: function (slug, id) {
      return object.backendPathFor('collections/' + slug + '/entries/' + id);
    },
    editCollectionEntryPath: function (slug, id) {
      return object.backendPathFor('collections/' + slug + '/entries/' + id + '/edit');
    },
    sortCollectionEntryPath: function (slug) {
      return object.backendPathFor('collections/' + slug + '/entries/sort');
    },

    // Designs
    designsPath: object.backendPathFor('designs'),
    newDesignPath: object.backendPathFor('designs/new'),
    designPath: function (id) {
      return object.backendPathFor('designs/' + id);
    },
    editDesignPath: function (id) {
      return object.backendPathFor('designs/' + id + '/edit');
    },

    // Pages
    pagesPath: object.backendPathFor('pages'),
    newPagePath: object.backendPathFor('pages/new'),
    pagePath: function (id) {
      return object.backendPathFor('pages/' + id);
    },
    editPagePath: function (id) {
      return object.backendPathFor('pages/' + id + '/edit');
    },

    // Profile
    profilePath: object.backendPathFor('profile'),
    editProfilePath: object.backendPathFor('profile/edit'),

    // Site
    sitePath: object.backendPathFor('site'),
    editSitePath: object.backendPathFor('site/edit'),

    // Users
    usersPath: object.backendPathFor('users'),
    newUserPath: object.backendPathFor('users/new'),
    userPath: function (username) {
      return object.backendPathFor('users/' + username);
    },
    editUserPath: function (username) {
      return object.backendPathFor('users/' + username + '/edit');
    },

    // Widgets
    widgetsPath: object.backendPathFor('widgets'),
    newWidgetPath: object.backendPathFor('widgets/new'),
    widgetPath: function (slug) {
      return object.backendPathFor('widgets/' + slug);
    },
    editWidgetPath: function (slug) {
      return object.backendPathFor('widgets/' + slug + '/edit');
    }
  };

  return object;
}(Archangel || {}));
