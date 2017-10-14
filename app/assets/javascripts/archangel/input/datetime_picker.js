$(function() {
  'use strict';

  var archangelDatetimepickerTranslations = function() {
    return {
      clear:        Archangel.translate.datetimepicker.clear,
      close:        Archangel.translate.datetimepicker.close,
      nextCentury:  Archangel.translate.datetimepicker.next_century,
      nextDecade:   Archangel.translate.datetimepicker.next_decade,
      nextMonth:    Archangel.translate.datetimepicker.next_month,
      nextYear:     Archangel.translate.datetimepicker.next_year,
      prevCentury:  Archangel.translate.datetimepicker.prev_century,
      prevDecade:   Archangel.translate.datetimepicker.prev_decade,
      prevMonth:    Archangel.translate.datetimepicker.prev_month,
      prevYear:     Archangel.translate.datetimepicker.prev_year,
      selectDecade: Archangel.translate.datetimepicker.select_decade,
      selectMonth:  Archangel.translate.datetimepicker.select_month,
      selectYear:   Archangel.translate.datetimepicker.select_year,
      today:        Archangel.translate.datetimepicker.today
    };
  };

  // Time picker
  $('input.time_picker').datetimepicker({
    format:    Archangel.translate.datetimepicker.time_format,
    showClear: true,
    stepping:  5,
    tooltips:  archangelDatetimepickerTranslations
  });

  // Date picker
  $('input.date_picker').datetimepicker({
    format:    Archangel.translate.datetimepicker.date_format,
    showClear: true,
    tooltips:  archangelDatetimepickerTranslations
  });

  // Date time picker
  $('input.date_time_picker').datetimepicker({
    format:    Archangel.translate.datetimepicker.format,
    showClear: true,
    stepping:  5,
    tooltips:  archangelDatetimepickerTranslations
  });

});
