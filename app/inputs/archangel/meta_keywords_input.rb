# frozen_string_literal: true

module Archangel
  ##
  # META keywords custom input for SimpleForm
  #
  class MetaKeywordsInput < SimpleForm::Inputs::Base
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
    # Add `meta_keywords` as an HTML class
    #
    def input_html_classes
      super.push("meta_keywords")
    end
  end
end
