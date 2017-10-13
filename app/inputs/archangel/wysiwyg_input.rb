# frozen_string_literal: true

module Archangel
  class WysiwygInput < SimpleForm::Inputs::TextInput
    def input_html_classes
      super.push("wysiwyg")
    end
  end
end
