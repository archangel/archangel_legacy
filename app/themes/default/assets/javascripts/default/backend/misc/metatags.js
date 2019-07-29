$(function() {
  'use strict';

  $('select[name^="page[metatags_attributes]"], select[name^="site[metatags_attributes]"]').select2({
    tags: true
  });

});
