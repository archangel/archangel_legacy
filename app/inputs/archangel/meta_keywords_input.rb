# frozen_string_literal: true

module Archangel
  class MetaKeywordsInput < SimpleForm::Inputs::Base
    def input(wrapper_options = nil)
      merged_input_options =
        merge_wrapper_options(input_html_options, wrapper_options)

      @builder.text_field(attribute_name, merged_input_options)
    end

    def input_html_classes
      super.push("metakeywords")
    end
  end
end
