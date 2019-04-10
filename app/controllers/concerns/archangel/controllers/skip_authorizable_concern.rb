# frozen_string_literal: true

module Archangel
  ##
  # Controller concerns
  #
  module Controllers
    ##
    # Controller skip authorize concern
    #
    module SkipAuthorizableConcern
      extend ActiveSupport::Concern

      included do
        after_action :skip_authorization
      end
    end
  end
end
