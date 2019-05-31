# frozen_string_literal: true

module Archangel
  ##
  # Entry model
  #
  class Entry < ApplicationRecord
    include Archangel::Models::PublishableConcern

    acts_as_paranoid

    store :value, coder: JSON

    acts_as_list scope: :collection_id, top_of_list: 0, add_new_at: :top

    validates :collection_id, presence: true
    validates :value, presence: true

    belongs_to :collection

    default_scope { order(position: :asc) }

    after_initialize :add_accessors_for_entry_value

    protected

    def add_accessors_for_entry_value
      resource_value_fields.each do |field|
        singleton_class.class_eval do
          field_sym = field.slug.to_sym

          store_accessor :value, field_sym

          validates field_sym, presence: true if field.required?
          if field.classification == "email"
            validates field_sym, allow_blank: !field.required?,
                                 email: { message: "not a valid email address" }
          end
          if field.classification == "url"
            validates field_sym, allow_blank: !field.required?,
                                 url: { message: "not a valid URL" }
          end
          if field.classification == "boolean"
            validates field_sym, inclusion: { in: %w[0 1] }
          end
        end
      end
    end

    def resource_value_fields
      return [] if try(:collection).try(:fields).blank?

      collection.fields
    end
  end
end
