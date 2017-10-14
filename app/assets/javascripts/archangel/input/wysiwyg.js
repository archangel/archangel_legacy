$.fn.inputTextareaWysiwyg = function () {
  'use strict';

  this.summernote({
    minHeight: '150px',
    shortcuts: true,
    toolbar: [
      ['task', ['undo', 'redo']],
      ['style', ['bold', 'italic', 'underline', 'clear']],
      ['color', ['color']],
      ['para', ['style', 'ul', 'ol', 'paragraph']],
      ['insert', ['picture', 'link', 'video', 'table']],
      ['misc', ['codeview']]
    ]
  });

};

$(function() {
  'use strict';

  $('textarea.wysiwyg').inputTextareaWysiwyg();

});
