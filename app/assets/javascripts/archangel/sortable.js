$(function() {
  'use strict';

  var sort_element = document.getElementById('sortable'),
      sortable_object = new Sortable(sort_element, {
        animation: 150,
        handle: '.fa-sort',
        draggable: 'tr',
        ghostClass: 'sortable-ghost',
        dragClass: 'sortable-drag',
        onEnd: function (evt) {
          var sort_order = sortable_object.toArray(),
              collection_slug = Archangel.url.segment('collections'),
              post_url = Archangel.route.backend.sort_collection_entry_path(collection_slug),
              post_data = {
                collection_entry: {
                  sort: sort_order
                }
              };

          $.ajax({
            method: 'POST',
            url: post_url,
            data: post_data
          })
          .done(function(msg) {
            // alert(msg);
          })
          .fail(function(jqXHR, textStatus) {
            alert('Request failed: ' + textStatus);
          })
          .always(function() { });
        }
      });
});
