# frozen_string_literal: true

module Archangel
  ##
  # Model concerns
  #
  module Models
    ##
    # Model publish concern
    #
    module PublishableConcern
      extend ActiveSupport::Concern

      included do
        validates :published_at, allow_blank: true, date: true

        scope :available, (lambda do
          published.where("published_at <= ?", Time.current)
        end)

        scope :published, (lambda do
          where.not(published_at: nil)
        end)
      end

      ##
      # Check if resource is published.
      #
      # Future publication date is also considered published. This will return
      # true if there is any published date avaialable; past and future.
      #
      # @see resource.available?
      #
      # @return [Boolean] if published
      #
      def published?
        published_at.present?
      end

      ##
      # Check if resource is currently available.
      #
      # This will return true if there is a published date and it is in the
      # past. Future publication date will return false.
      #
      # @return [Boolean] if available
      #
      def available?
        published? && published_at <= Time.current
      end
    end
  end
end
