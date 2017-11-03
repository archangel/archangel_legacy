# frozen_string_literal: true

module Archangel
  class ThemeInput < SimpleForm::Inputs::CollectionSelectInput
    def skip_include_blank?
      true
    end

    protected

    def collection
      @collection ||= resource_options
    end

    def resource_options
      [].tap do |option|
        Archangel.themes.each { |theme| option << [theme, theme] }
      end
    end
  end
end
