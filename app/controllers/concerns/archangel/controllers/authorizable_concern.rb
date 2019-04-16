# frozen_string_literal: true

module Archangel
  ##
  # Controller concerns
  #
  module Controllers
    ##
    # Controller authorize concern
    #
    module AuthorizableConcern
      extend ActiveSupport::Concern

      included do
        after_action :verify_authorized
      end
    end
  end
end
