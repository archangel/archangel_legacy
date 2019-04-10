# frozen_string_literal: true

module Archangel
  ##
  # Controller concerns
  #
  module Controllers
    ##
    # Controller pagination concern
    #
    module PaginatableConcern
      extend ActiveSupport::Concern

      included do
        helper_method :page_num, :per_page
      end

      ##
      # Record limt count
      #
      # @return [Integer] the record count limit
      #
      def per_page
        params.fetch(:per, per_page_default).to_i
      end

      ##
      # Current page number
      #
      # @return [Integer] the page number
      #
      def page_num
        params.fetch(Kaminari.config.param_name, 1).to_i
      end

      protected

      def per_page_default
        Kaminari.config.default_per_page
      end
    end
  end
end
