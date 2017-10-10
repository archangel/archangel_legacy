# frozen_string_literal: true

module Archangel
  class TimePickerInput < SimpleForm::Inputs::Base
    def input(_wrapper_options)
      template.content_tag(:div, class: "input-group") do
        template.concat calendar_addon
        template.concat @builder.text_field(attribute_name, input_html_options)
      end
    end

    def input_html_options
      super.merge(class: "form-control timepicker")
    end

    protected

    def calendar_addon
      template.content_tag(:span, class: "input-group-addon") do
        template.concat icon_calendar
      end
    end

    def icon_calendar
      "<span class='glyphicon glyphicon-timestamp'></span>".html_safe
    end
  end
end
