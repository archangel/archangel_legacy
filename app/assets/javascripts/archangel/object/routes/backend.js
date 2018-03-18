(function (object) {
  'use strict';

  object.backendPath = function () {
    return object.pathBuilder([object.mountScope(), object.backendScope()]);
  };

  object.backendPathFor = function (path, args) {
    return object.pathFor([object.backendScope(), path], args);
  };

  object.route.backend = {
    // Dashboard
    rootPath: object.backendPath(),

    // Assets
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

    // Templates
    templatesPath: object.backendPathFor('templates'),
    newTemplatePath: object.backendPathFor('templates/new'),
    templatePath: function (id) {
      return object.backendPathFor('templates/' + id);
    },
    editTemplatePath: function (id) {
      return object.backendPathFor('templates/' + id + '/edit');
    },

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
