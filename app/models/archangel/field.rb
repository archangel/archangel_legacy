# frozen_string_literal: true

module Archangel
  ##
  # Field model
  #
  class Field < ApplicationRecord
    ##
    # Available field types constant
    #
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
    validates :slug, presence: true, uniqueness: { scope: :collection_id }

    belongs_to :collection

    default_scope { order(position: :asc) }
  end
end
