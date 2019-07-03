(function() {
  'use strict';

  var sortable_entry_element = document.getElementById('sortable');

  if (sortable_entry_element != null)
  {
    Sortable.create(sortable_entry_element, {
      handle: '.sortable-handle',
      animation: 150,
      onSort: function (evt) {
        if (evt.type != 'sort') { return; }

        return $.ajax({
          url: evt.to.dataset.sortableUrl,
          method: 'POST',
          dataType: 'json',
          data: {
            collection_entry: {
              sort: {
                id: evt.item.dataset.sortableItemId,
                position: evt.newIndex
              }
            }
          }
        })
          .done(function() {
            $('#alert-messages').append(
              '<div class="alert alert-info alert-link alert-dismissable" role="alert">' +
                'Sort order has been updated' +
              '</div>');
          })
          .fail(function() {
            $('#alert-messages').append(
              '<div class="alert alert-error alert-link alert-dismissable" role="alert">' +
                'There was a problem updating position' +
              '</div>');
          });
      }
    });
  }

})();
