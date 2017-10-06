# frozen_string_literal: true

module Archangel
  class Entry < ApplicationRecord
    acts_as_paranoid

    acts_as_list scope: %i[collection_id field_id],
                 top_of_list: 0,
                 add_new_at: :bottom

    validates :collection_id, presence: true
    validates :field_id, presence: true
    validates :value, presence: true

    validate :unique_slug_per_field

    belongs_to :collection
    belongs_to :field

    default_scope { order(position: :asc) }

    protected

    def unique_slug_per_field
      return if unique_slug_per_field?

      errors.add(:slug, I18n.t(:duplicate_entry_slug))
    end

    def unique_slug_per_field?
      self.class.where(field_id: field_id).where.not(id: id).empty?
    end
  end
end
