# frozen_string_literal: true

module Archangel
  class MetaKeywordsInput < SimpleForm::Inputs::CollectionSelectInput
    def multiple?
      true
    end

    def input_options
      super.tap do |options|
        options[:include_blank] = false
        options[:selected] = selected_options
      end
    end

    protected

    def collection
      keywords = object.blank? ? "" : object.meta_keywords.to_s

      @collection ||= keywords.downcase.split(",").map(&:strip)
    end

    def selected_options
      collection
    end
  end
end
