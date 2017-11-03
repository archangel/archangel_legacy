# frozen_string_literal: true

module Archangel
  class LanguageInput < SimpleForm::Inputs::CollectionSelectInput
    def skip_include_blank?
      true
    end

    protected

    def collection
      @collection ||= resource_options
    end

    def resource_options
      [].tap do |option|
        Archangel::LANGUAGES.each do |language|
          option << [Archangel.t("language.#{language}.name"), language]
        end
      end
    end
  end
end
