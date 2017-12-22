# frozen_string_literal: true

module Archangel
  ##
  # WYSIWYG custom input for SimpleForm
  #
  class WysiwygInput < SimpleForm::Inputs::TextInput
    ##
    # Add `wysiwyg` as an HTML class
    #
    def input_html_classes
      super.push("wysiwyg")
    end
  end
end
