$.fn.inputTimePicker = function () {
  'use strict';

  $(this).flatpickr({
    enableTime: true,
    noCalendar: true,
    dateFormat: 'h:i K'
  });
};

$.fn.inputDatePicker = function () {
  'use strict';

  $(this).flatpickr({
    dateFormat: 'Y-m-d',
    altInput: true,
    altFormat: 'F j, Y'
  });
};

$.fn.inputDateTimePicker = function () {
  'use strict';

  $(this).flatpickr({
    enableTime: true,
    dateFormat: 'Y-m-d H:i',
    altInput: true,
    altFormat: 'F j, Y @ h:i K'
  });
};

$(function() {
  'use strict';

  $('input.time_picker').inputTimePicker();

  $('input.date_picker').inputDatePicker();

  $('input.date_time_picker').inputDateTimePicker();

});
