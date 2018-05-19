# frozen_string_literal: true

module Archangel
  ##
  # Entry model
  #
  class Entry < ApplicationRecord
    acts_as_paranoid

    serialize :value, JSON

    acts_as_list scope: :collection_id, top_of_list: 0, add_new_at: :top

    validates :collection_id, presence: true
    validates :available_at, allow_blank: true, date: true
    validates :value, presence: true

    belongs_to :collection

    default_scope { order(position: :asc) }

    ##
    # Check if Entry is available. Available in the past, present and future.
    # Future availability date is also considered available.
    #
    # @return [Boolean] if available
    #
    def available?
      available_at.present?
    end

    ##
    # Return string of availability status.
    #
    # @return [String] available status
    #
    def available_status
      if available?
        if available_at > Time.now
          "future-available"
        else
          "available"
        end
      else
        "unavailable"
      end
    end
  end
end
