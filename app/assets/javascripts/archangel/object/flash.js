(function(object) {
  'use strict';

  object.flash = {
    success: function(message) {
      object.flash.flashMessage('success', message);
    },

    error: function(message) {
      object.flash.danger(message);
    },
    danger: function(message) {
      object.flash.flashMessage('danger', message);
    },

    alert: function(message) {
      object.flash.warning(message);
    },
    warning: function(message) {
      object.flash.flashMessage('warning', message);
    },

    notice: function(message) {
      object.flash.info(message);
    },
    info: function(message) {
      object.flash.flashMessage('info', message);
    },

    flashMessage: function(type, message) {
      if (message == '' || message == undefined) {
        return false;
      }

      type = type || 'warning';

      var messagesContainer = document.querySelector('#alert-messages'),
          msgContainer = document.createElement('div');

      msgContainer.setAttribute('class', 'alert alert-' + type + ' alert-link');
      msgContainer.setAttribute('role', 'alert');
      msgContainer.innerHTML = message;

      messagesContainer.appendChild(msgContainer);
    }
  };

  return object;
}(Archangel || {}));
