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

    scope :accessible, (lambda do
      available.where("available_at <= ?", Time.now)
    end)

    scope :available, (lambda do
      where.not(available_at: nil)
    end)

    scope :unavailable, (lambda do
      where("available_at IS NULL OR available_at > ?", Time.now)
    end)

    default_scope { order(position: :asc) }

    ##
    # Check if Entry is currently accessible.
    #
    # This will return true if there is a published date and it is in the past.
    # Future publication date will return false.
    #
    # @return [Boolean] if accessible
    #
    def accessible?
      available? && available_at < Time.now
    end

    ##
    # Check if Entry is available.
    #
    # Future publication date is also considered available. This will return
    # true if there is any available date avaialable; past and future.
    #
    # @see Entry.accessible?
    #
    # @return [Boolean] if available
    #
    def available?
      available_at.present?
    end
  end
end
