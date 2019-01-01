# frozen_string_literal: true

module Archangel
  ##
  # Controller concerns
  #
  module Controllers
    ##
    # Backend controller concerns
    #
    module Backend
      ##
      # Resourceful concern
      #
      module ResourcefulConcern
        extend ActiveSupport::Concern

        include Archangel::Controllers::ResourcefulConcern

        protected

        def resource_namespace
          :backend
        end
      end
    end
  end
end
