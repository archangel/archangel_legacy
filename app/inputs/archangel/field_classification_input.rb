# frozen_string_literal: true

module Archangel
  ##
  # Field classification custom input for SimpleForm
  #
  class FieldClassificationInput < SimpleForm::Inputs::CollectionSelectInput
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
        Archangel::Field::CLASSIFICATIONS.each do |classification|
          option <<
            [Archangel.t("classification.#{classification}"), classification]
        end
      end
    end
  end
end
