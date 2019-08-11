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

        validates :value, presence: true, allow_blank: true

        after_initialize :add_accessors_for_entry_fields
        after_initialize :add_presence_validator_for_entry_fields
        after_initialize :add_classification_validator_for_entry_fields

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

      ##
      # Initialize storage for fields
      #
      def add_accessors_for_entry_fields
        (resource_value_fields || []).each do |field|
          singleton_class.class_eval do
            store_accessor :value, field.slug.to_sym
          end
        end
      end

      ##
      # Add presence validation for required fields
      #
      def add_presence_validator_for_entry_fields
        (resource_value_fields || []).each do |field|
          singleton_class.class_eval do
            validates field.slug.to_sym, presence: true if field.required?
          end
        end
      end

      ##
      # Add classification specific validation for fields
      #
      def add_classification_validator_for_entry_fields
        (resource_value_fields || []).each do |field|
          singleton_class.class_eval do
            if %w[boolean email integer url].include?(field.classification)
              send("add_#{field.classification}_validator".to_sym,
                   field.slug.to_sym, !field.required?)
            end
          end
        end
      end
    end
  end
end
