(function () {
  'use strict';

  document.addEventListener('DOMContentLoaded', function() {
    var sidebarDropdownItems = document.querySelectorAll('nav > ul.nav'),
        sidebarDropdownItemCount = sidebarDropdownItems.length,
        sidebarToggler = document.querySelector('.sidebar-toggler'),
        sidebarMinimizer = document.querySelector('.sidebar-minimizer'),
        brandMinimizer = document.querySelector('.brand-minimizer'),
        mobileSidebarToggler = document.querySelector('.mobile-sidebar-toggler'),
        toggleBodyElement = document.querySelector('body'),
        localStorageMinimizerName = 'sidebar-minimized';

    ////
    // Resize event
    //
    function resizeBroadcast() {
      var timesRun = 0,
          interval = setInterval(function() {
            timesRun += 1;

            if (timesRun === 5) {
              clearInterval(interval);
            }

            window.dispatchEvent(new Event('resize'));
          }, 62.5);
    }

    ////
    // Toggle sidebar dropdowns
    //
    function toggleSidebarDropdown(event) {
      var hasToggleClass = event.target.classList.contains('nav-dropdown-toggle'),
          parentObject = event.target.parentNode;

      if (hasToggleClass) {
        parentObject.toggleClass('open');

        resizeBroadcast();
      }

      return false;
    }

    ////
    // Toggle initial on/off of brand minimizer
    //
    function triggerInitialSidebarCollapse() {
      if (typeof(Storage) === 'undefined') {
        return;
      }

      var localStorageToggled = localStorage.getItem(localStorageMinimizerName);

      if (localStorageToggled === '1') {
        brandMinimizer.dispatchEvent(new CustomEvent('click'));
      }
    }

    ////
    // Sidebar dropdowns
    //
    for (var i = 0; i < sidebarDropdownItemCount; i += 1) {
      var item = sidebarDropdownItems[i],
          itemLink = item.querySelector('a');

      itemLink.addEventListener('click', toggleSidebarDropdown, false);
    }

    ////
    // Sidebar toggler
    //
    sidebarToggler.addEventListener('click', function() {
      toggleBodyElement.classList.toggle('sidebar-hidden');

      resizeBroadcast();
    }, false);

    ////
    // Sidebar minimizer
    //
    sidebarMinimizer.addEventListener('click', function() {
      toggleBodyElement.classList.toggle('sidebar-minimized');

      resizeBroadcast();
    }, false);

    ////
    // Sidebar and brand minimizer
    //
    brandMinimizer.addEventListener('click', function() {
      var hasToggleClass = toggleBodyElement.classList.contains('brand-minimized') ? '0' : '1' ;

      localStorage.setItem(localStorageMinimizerName, hasToggleClass);

      toggleBodyElement.classList.toggle('brand-minimized');
    }, false);

    ////
    // Mobile browser size sidebar toggler
    //
    mobileSidebarToggler.addEventListener('click', function() {
      toggleBodyElement.classList.toggle('sidebar-mobile-show');

      resizeBroadcast();
    }, false);

    ////
    // Toggle initial on/off of brand minimizer
    //
    triggerInitialSidebarCollapse();
  });
}());
