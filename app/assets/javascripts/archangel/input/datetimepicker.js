$.fn.inputTimePicker = function () {
  'use strict';
};

$.fn.inputDatePicker = function () {
  'use strict';
};

$.fn.inputDateTimePicker = function () {
  'use strict';
};

$(function() {
  'use strict';

  // Time picker
  $('input.time_picker').inputTimePicker();

  // Date picker
  $('input.date_picker').inputDatePicker();

  // Date time picker
  $('input.date_time_picker').inputDateTimePicker();

});
