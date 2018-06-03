$(function() {
  'use strict';

  // New Template
  $('#template_partial').change(function() {
    var checked = this.checked;

    if (checked === true) {
      $('#template_parent_id option:selected').prop('selected', false);
    }

    $('.new_template .template_parent').toggle(!checked);
  });

  // Edit Template
  $('#template_partial').change(function() {
    var checked = this.checked;

    if (checked === true) {
      $('#template_parent_id option:selected').prop('selected', false);
    }

    $('.edit_template .template_parent').toggle(!checked);
  }).trigger('change');

});
