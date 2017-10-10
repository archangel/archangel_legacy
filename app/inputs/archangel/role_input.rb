# frozen_string_literal: true

module Archangel
  class RoleInput < SimpleForm::Inputs::CollectionSelectInput
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
        Archangel::ROLES.each do |role|
          obj << [Archangel.t("role.#{role}"), role]
        end
      end
    end
  end
end
