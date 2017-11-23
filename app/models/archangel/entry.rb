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

    belongs_to :collection
    belongs_to :field

    default_scope { order(position: :asc) }
  end
end
