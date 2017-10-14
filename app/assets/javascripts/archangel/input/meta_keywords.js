$.fn.inputTextMetaKeywords = function () {
  'use strict';

  this.selectize({
    delimiter: ',',
    persist: false,
    create: function(input) {
      return {
        value: input,
        text: input
      };
    }
  });

};

$(function() {
  'use strict';

  $('input.meta_keywords').inputTextMetaKeywords();

});
