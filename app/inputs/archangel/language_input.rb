# frozen_string_literal: true

module Archangel
  class LanguageInput < SimpleForm::Inputs::CollectionSelectInput
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
      [].tap do |opt|
        Archangel::LANGUAGES.each do |lang|
          opt << [Archangel.t("language.#{lang}"), lang]
        end
      end
    end
  end
end
