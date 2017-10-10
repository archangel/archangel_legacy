# frozen_string_literal: true

module Archangel
  class ThemeInput < SimpleForm::Inputs::CollectionSelectInput
    def multiple?
      false
    end

    def input_options
      super.tap do |options|
        options[:include_blank] = false
      end
    end

    private

    def collection
      @collection ||= resource_options
    end

    def resource_options
      [].tap do |obj|
        Archangel.themes.each { |theme| obj << [theme, theme] }
      end
    end
  end
end
