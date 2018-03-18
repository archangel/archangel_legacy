$(function() {
  'use strict';

  var requestObject = new XMLHttpRequest(),
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
      },
      sortElement = document.getElementById('sortable'),
      sortableObject = new Sortable(sortElement, {
        animation: 150,
        handle: '.fa-sort',
        draggable: 'tr',
        ghostClass: 'sortable-ghost',
        dragClass: 'sortable-drag',
        onEnd: function () {
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
              alert(event.target.responseText);
            } else {
              alert(event.target.statusText);
            }
          };

          requestObject.onerror = function (event) {
            alert('Request failed: ' + event.target.statusText);
          };

          requestObject.send(dataSerializer(postData));
        }
      });
});
