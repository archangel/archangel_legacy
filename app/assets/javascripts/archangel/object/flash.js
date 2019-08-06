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
      if (message === '' || message === undefined) {
        return false;
      }

      type = type || 'warning';

      $('.alert-messages').append(
        '<div class="alert alert-' + type + ' alert-link alert-dismissable" role="alert">' +
          message +
          '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
            '<span aria-hidden="true">&times;</span>' +
          '</button>' +
        '</div>');

      setTimeout(function(){
        $('.alert').alert('close');
      }, 5000);
    }
  };

  return object;
}(Archangel || {}));
