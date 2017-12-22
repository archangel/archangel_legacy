# frozen_string_literal: true

module Archangel
  ##
  # Language select custom input for SimpleForm
  #
  class LanguageInput < SimpleForm::Inputs::CollectionSelectInput
    ##
    # Do not include blank select option
    #
    # @return [Boolean] to skip blank select option
    #
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
