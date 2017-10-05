# frozen_string_literal: true

module Archangel
  module Backend
    class DashboardsController < BackendController
      after_action :skip_authorization

      def show; end
    end
  end
end
