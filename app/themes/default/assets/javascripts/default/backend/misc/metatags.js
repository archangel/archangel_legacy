$(function() {
  'use strict';

  var metatag_selects = 'select[name^="page[metatags_attributes]"], select[name^="site[metatags_attributes]"]';

  $(metatag_selects).select2({
    tags: true
  });

  $('.form-inputs').on('cocoon:after-insert', function(_e, insertedItem) {
    insertedItem.find(metatag_selects).select2({
      tags: true
    });
  });

});
