(function () {
  'use strict';

  document.addEventListener('DOMContentLoaded', function() {
    var sidebarItemLinks = document.querySelectorAll('nav > ul.nav a'),
        sidebarItemLinkCount = sidebarItemLinks.length,
        currentUrl = String(window.location).split('?')[0];

    for (var i = 0; i < sidebarItemLinkCount; i += 1) {
      var item = sidebarItemLinks[i],
          parentLists = item.parentNode.querySelectorAll('ul'),
          parentListLength = parentLists.length;

      if (currentUrl.substr(currentUrl.length - 1) == '#') {
        currentUrl = currentUrl.slice(0, -1);
      }

      if (currentUrl.lastIndexOf(item.href, 0) === 0) {
        item.classList.add('active');

        for (var j = 0; j < parentListLength; j += 1) {
          var linkItem = parentLists[i];

          linkItem.parentclassList.add('open');
        }
      }
    }

  });
}());
