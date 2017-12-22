# frozen_string_literal: true

module Archangel
  ##
  # @see Archangel::BackendController
  #
  module Backend
    ##
    # Backend dashboards controller
    #
    class DashboardsController < BackendController
      include Archangel::SkipAuthorizableConcern

      ##
      # Backend dashboard
      #
      # Formats
      #   HTML, JSON
      #
      # Request
      #   GET /backend
      #   GET /backend.json
      #
      def show; end
    end
  end
end
