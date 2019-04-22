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
    validates :published_at, allow_blank: true, date: true
    validates :value, presence: true

    belongs_to :collection

    scope :available, (lambda do
      published.where("published_at <= ?", Time.now)
    end)

    scope :published, (lambda do
      where.not(published_at: nil)
    end)

    scope :unpublished, (lambda do
      where("published_at IS NULL OR published_at > ?", Time.now)
    end)

    default_scope { order(position: :asc) }

    ##
    # Check if Entry is currently available.
    #
    # This will return true if there is a published date and it is in the past.
    # Future publication date will return false.
    #
    # @return [Boolean] if available
    #
    def available?
      published? && published_at < Time.now
    end

    ##
    # Check if Entry is published.
    #
    # Future publication date is also considered published. This will return
    # true if there is any published date avaialable; past and future.
    #
    # @see Entry.available?
    #
    # @return [Boolean] if published
    #
    def published?
      published_at.present?
    end
  end
end
