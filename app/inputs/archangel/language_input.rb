# frozen_string_literal: true

module Archangel
  class LanguageInput < SimpleForm::Inputs::CollectionSelectInput
    def multiple?
      false
    end

    def input_options
      super.tap do |options|
        options[:include_blank] = false
      end
    end

    protected

    def collection
      @collection ||= resource_options
    end

    def resource_options
      [].tap do |obj|
        Archangel::LANGUAGES.each do |translation|
          obj << [Archangel.t("language.#{translation}"), translation]
        end
      end
    end
  end
end
