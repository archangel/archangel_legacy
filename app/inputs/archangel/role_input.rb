# frozen_string_literal: true

module Archangel
  class RoleInput < SimpleForm::Inputs::CollectionSelectInput
    def skip_include_blank?
      true
    end

    protected

    def collection
      @collection ||= resource_options
    end

    def resource_options
      [].tap do |option|
        Archangel::ROLES.each do |role|
          option << [Archangel.t("role.#{role}"), role]
        end
      end
    end
  end
end
