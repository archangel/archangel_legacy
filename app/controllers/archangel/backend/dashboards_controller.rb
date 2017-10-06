# frozen_string_literal: true

module Archangel
  module Backend
    class DashboardsController < BackendController
      include Archangel::SkipAuthorizableConcern

      def show; end
    end
  end
end
