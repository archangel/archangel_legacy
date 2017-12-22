# frozen_string_literal: true

module Archangel
  ##
  # Role select custom input for SimpleForm
  #
  class RoleInput < SimpleForm::Inputs::CollectionSelectInput
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
        Archangel::ROLES.each do |role|
          option << [Archangel.t("role.#{role}"), role]
        end
      end
    end
  end
end
