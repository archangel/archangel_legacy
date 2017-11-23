# frozen_string_literal: true

module Archangel
  class FieldClassificationInput < SimpleForm::Inputs::CollectionSelectInput
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
