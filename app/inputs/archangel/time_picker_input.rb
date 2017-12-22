# frozen_string_literal: true

module Archangel
  ##
  # Time picker custom input for SimpleForm
  #
  class TimePickerInput < SimpleForm::Inputs::Base
    ##
    # Build input field
    #
    # @param wrapper_options [Hash] the wrapper options
    #
    def input(wrapper_options = nil)
      merged_input_options =
        merge_wrapper_options(input_html_options, wrapper_options)

      @builder.text_field(attribute_name, merged_input_options)
    end

    ##
    # Add `timepicker` as an HTML class
    #
    def input_html_classes
      super.push("timepicker")
    end
  end
end
