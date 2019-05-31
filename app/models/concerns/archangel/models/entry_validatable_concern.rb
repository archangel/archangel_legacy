# frozen_string_literal: true

module Archangel
  ##
  # Model concerns
  #
  module Models
    ##
    # Entry validation concern
    #
    module EntryValidatableConcern
      extend ActiveSupport::Concern

      included do
        store :value, coder: JSON

        validates :value, presence: true

        after_initialize :add_accessors_for_entry_value
        after_initialize :add_validators_for_entry_fields

        def self.add_boolean_validator(field, _allow_blank)
          validates field, inclusion: { in: %w[0 1] }
        end

        def self.add_email_validator(field, allow_blank)
          validates field, allow_blank: allow_blank,
                           email: { message: "not a valid email address" }
        end

        def self.add_integer_validator(field, allow_blank)
          validates field, allow_blank: allow_blank,
                           numericality: {
                             only_integer: true,
                             message: "not a valid integer"
                           }
        end

        def self.add_url_validator(field, allow_blank)
          validates field, allow_blank: allow_blank,
                           url: { message: "not a valid URL" }
        end
      end

      def add_accessors_for_entry_value
        (resource_value_fields || []).each do |field|
          singleton_class.class_eval do
            field_sym = field.slug.to_sym

            store_accessor :value, field_sym
          end
        end
      end

      def add_validators_for_entry_fields
        (resource_value_fields || []).each do |field|
          singleton_class.class_eval do
            field_sym = field.slug.to_sym

            validates field_sym, presence: true if field.required?

            if %w[boolean email integer url].include?(field.classification)
              send("add_#{field.classification}_validator".to_sym,
                   field_sym, !field.required?)
            end
          end
        end
      end
    end
  end
end
