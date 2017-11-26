# frozen_string_literal: true

module Archangel
  class Field < ApplicationRecord
    CLASSIFICATIONS = %w[string text boolean].freeze

    acts_as_paranoid

    acts_as_list scope: :collection_id,
                 top_of_list: 0,
                 add_new_at: :bottom

    validates :classification, presence: true,
                               inclusion: { in: CLASSIFICATIONS }
    validates :collection_id, presence: true, on: :update
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
      self.class
          .where(collection_id: collection_id, slug: slug)
          .where.not(id: id)
          .empty?
    end
  end
end
