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

    validate :required_fields_present

    belongs_to :collection

    default_scope { order(position: :asc) }

    after_initialize :add_accessors_for_entry_value

    protected

    def required_fields_present
      return [] if try(:collection).try(:fields).blank?

      collection.fields.each do |field|
        next unless field.required? && send(field.slug).blank?

        errors.add(field.slug.to_sym, "can't be blank")
      end
    end

    def add_accessors_for_entry_value
      resource_value_fields.each do |field|
        singleton_class.class_eval do
          store_accessor :value, field
        end
      end
    end

    def resource_value_fields
      return [] if try(:collection).try(:fields).blank?

      collection.fields.map(&:slug).map(&:to_sym)
    end
  end
end
