# frozen_string_literal: true

module Archangel
  class ThemeInput < SimpleForm::Inputs::CollectionSelectInput
    def multiple?
      false
    end

    def skip_include_blank?
      true
    end

    protected

    def collection
      @collection ||= resource_options
    end

    def resource_options
      [].tap { |opt| Archangel.themes.each { |theme| opt << [theme, theme] } }
    end
  end
end
