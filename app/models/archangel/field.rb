# frozen_string_literal: true

module Archangel
  class Field < ApplicationRecord
    acts_as_paranoid

    acts_as_list scope: %i[collection_id],
                 top_of_list: 0,
                 add_new_at: :bottom

    validates :classification, presence: true,
                               inclusion: { in: %w[string text boolean] }
    validates :collection_id, presence: true
    validates :label, presence: true
    validates :required, inclusion: { in: [true, false] }
    validates :slug, presence: true

    validate :unique_slug_per_collection

    belongs_to :collection

    default_scope { order(position: :asc) }

    protected

    def unique_slug_per_collection
      return if unique_slug_per_collection?

      errors.add(:slug, Archangel.t(:duplicate_field_slug))
    end

    def unique_slug_per_collection?
      self.class.where(collection_id: collection_id).where.not(id: id).empty?
    end
  end
end
