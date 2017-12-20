# frozen_string_literal: true

module Archangel
  class Entry < ApplicationRecord
    acts_as_paranoid

    serialize :value, JSON

    acts_as_list scope: :collection_id, top_of_list: 0, add_new_at: :top

    validates :collection_id, presence: true
    validates :available_at, allow_blank: true, date: true
    validates :value, presence: true

    belongs_to :collection

    default_scope { order(position: :asc) }
  end
end
