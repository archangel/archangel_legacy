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
    root_path: object.backendPath(),

    // Assets
    assets_path: object.backendPathFor('assets'),
    new_asset_path: object.backendPathFor('assets/new'),
    asset_path: function (id) {
      return object.backendPathFor('assets/' + id);
    },
    edit_asset_path: function (id) {
      return object.backendPathFor('assets/' + id + '/edit');
    },

    // Collections
    collections_path: object.backendPathFor('collections'),
    new_collection_path: object.backendPathFor('collections/new'),
    collection_path: function (slug) {
      return object.backendPathFor('collections/' + slug);
    },
    edit_collection_path: function (slug) {
      return object.backendPathFor('collections/' + slug + '/edit');
    },

    // Collection Entries
    collection_entries_path: function (slug) {
      return object.backendPathFor('collections/' + slug + '/entries');
    },
    new_collection_entry_path: function (slug) {
      return object.backendPathFor('collections/' + slug + '/entries/new');
    },
    collection_entry_path: function (slug, id) {
      return object.backendPathFor('collections/' + slug + '/entries/' + id);
    },
    edit_collection_entry_path: function (slug, id) {
      return object.backendPathFor('collections/' + slug + '/entries/' + id + '/edit');
    },
    sort_collection_entry_path: function (slug) {
      return object.backendPathFor('collections/' + slug + '/entries/sort');
    },

    // Pages
    pages_path: object.backendPathFor('pages'),
    new_page_path: object.backendPathFor('pages/new'),
    page_path: function (id) {
      return object.backendPathFor('pages/' + id);
    },
    edit_page_path: function (id) {
      return object.backendPathFor('pages/' + id + '/edit');
    },

    // Profile
    profile_path: object.backendPathFor('profile'),
    edit_profile_path: object.backendPathFor('profile/edit'),

    // Site
    site_path: object.backendPathFor('site'),
    edit_site_path: object.backendPathFor('site/edit'),

    // Templates
    templates_path: object.backendPathFor('templates'),
    new_template_path: object.backendPathFor('templates/new'),
    template_path: function (id) {
      return object.backendPathFor('templates/' + id);
    },
    edit_template_path: function (id) {
      return object.backendPathFor('templates/' + id + '/edit');
    },

    // Users
    users_path: object.backendPathFor('users'),
    new_user_path: object.backendPathFor('users/new'),
    user_path: function (username) {
      return object.backendPathFor('users/' + username);
    },
    edit_user_path: function (username) {
      return object.backendPathFor('users/' + username + '/edit');
    },

    // Widgets
    widgets_path: object.backendPathFor('widgets'),
    new_widget_path: object.backendPathFor('widgets/new'),
    widget_path: function (slug) {
      return object.backendPathFor('widgets/' + slug);
    },
    edit_widget_path: function (slug) {
      return object.backendPathFor('widgets/' + slug + '/edit');
    }
  };

  return object;
}(Archangel || {}));
