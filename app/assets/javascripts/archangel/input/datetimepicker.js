$(function() {
  'use strict';

  var archangelDatetimepickerTranslations = function() {
    return {
      separator: Archangel.translate.datetimepicker.separator,
      applyLabel: Archangel.translate.datetimepicker.apply,
      cancelLabel: Archangel.translate.datetimepicker.cancel,
      fromLabel: Archangel.translate.datetimepicker.from,
      toLabel: Archangel.translate.datetimepicker.to,
      customRangeLabel: Archangel.translate.datetimepicker.custom_range,
      weekLabel: Archangel.translate.datetimepicker.week,
      daysOfWeek: [
        Archangel.translate.datetimepicker.days.sunday,
        Archangel.translate.datetimepicker.days.monday,
        Archangel.translate.datetimepicker.days.tuesday,
        Archangel.translate.datetimepicker.days.wednesday,
        Archangel.translate.datetimepicker.days.thursday,
        Archangel.translate.datetimepicker.days.friday,
        Archangel.translate.datetimepicker.days.saturday
      ],
      monthNames: [
        Archangel.translate.datetimepicker.months.january,
        Archangel.translate.datetimepicker.months.february,
        Archangel.translate.datetimepicker.months.march,
        Archangel.translate.datetimepicker.months.april,
        Archangel.translate.datetimepicker.months.may,
        Archangel.translate.datetimepicker.months.june,
        Archangel.translate.datetimepicker.months.july,
        Archangel.translate.datetimepicker.months.august,
        Archangel.translate.datetimepicker.months.september,
        Archangel.translate.datetimepicker.months.october,
        Archangel.translate.datetimepicker.months.november,
        Archangel.translate.datetimepicker.months.december
      ]
    };
  };

  function extend(obj, src) {
    for (var key in src) {
      if (src.hasOwnProperty(key)) {
        obj[key] = src[key];
      }
    }
    return obj;
  }

  // Time picker
  $('input.time_picker').daterangepicker({
    singleDatePicker: true,
    timePicker: true,
    timePickerIncrement: 5,
    timePicker24Hour: false,
    timePickerSeconds: false,
    showDropdowns: true,
    locale: extend(
      archangelDatetimepickerTranslations(),
      { format: Archangel.translate.datetimepicker.time_format }
    )
  });

  // Date picker
  $('input.date_picker').daterangepicker({
    singleDatePicker: true,
    timePicker: false,
    showDropdowns: true,
    locale: extend(
      archangelDatetimepickerTranslations(),
      { format: Archangel.translate.datetimepicker.date_format }
    )
  });

  // Date time picker
  $('input.date_time_picker').daterangepicker({
    singleDatePicker: true,
    timePicker: true,
    timePickerIncrement: 5,
    timePicker24Hour: false,
    timePickerSeconds: false,
    showDropdowns: true,
    locale: extend(
      archangelDatetimepickerTranslations(),
      { format: Archangel.translate.datetimepicker.datetime_format }
    )
  });

});
