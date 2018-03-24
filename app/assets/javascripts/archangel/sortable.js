$(function() {
  'use strict';

  var sortableItems = document.querySelectorAll('#sortable'),
      sortableItemCount = sortableItems.length,
      requestObject = new XMLHttpRequest(),
      dataSerializer = function(obj, prefix) {
        var p,
            str = [];

        for (p in obj) {
          if (obj.hasOwnProperty(p)) {
            var k = prefix ? prefix + '[' + p + ']' : p,
                v = obj[p];

            str.push((v !== null && typeof v === 'object') ?
              dataSerializer(v, k) :
              encodeURIComponent(k) + '=' + encodeURIComponent(v));
          }
        }

        return str.join('&');
      };

  for (var i = 0; i < sortableItemCount; i += 1) {
    var item = sortableItems[i],
        sortableObject,
        onEndSortable = function () {
          var sortOrder = sortableObject.toArray(),
              collectionSlug = Archangel.url.segment('collections'),
              postUrl = Archangel.route.backend.sortCollectionEntryPath(collectionSlug),
              postData = {
                collection_entry: {
                  sort: sortOrder
                }
              };

          postData[Archangel.authTokenName] = Archangel.authToken;

          requestObject.open('POST', postUrl, true);
          requestObject.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=UTF-8');
          requestObject.onload = function (event) {
            if (event.target.status >= 200 && event.target.status < 400) {
              var successMsg = Archangel.translate.sortable.success;

              Archangel.flash.success(successMsg);
            } else {
              var errorMsg = 'Request failed: ' + event.target.statusText;

              Archangel.flash.error(errorMsg);
            }
          };

          requestObject.onerror = function (event) {
            var errorMsg = 'Request failed: ' + event.target.statusText;

            Archangel.flash.error(errorMsg);
          };

          requestObject.send(dataSerializer(postData));
        };

    sortableObject = new Sortable(item, {
      animation: 150,
      handle: '.fa-sort',
      draggable: 'tr',
      ghostClass: 'sortable-ghost',
      dragClass: 'sortable-drag',
      onEnd: onEndSortable
    });
  }
});
