# frozen_string_literal: true

module Archangel
  ##
  # Theme select custom input for SimpleForm
  #
  class ThemeInput < SimpleForm::Inputs::CollectionSelectInput
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
        Archangel.themes.each { |theme| option << [theme, theme] }
      end
    end
  end
end
