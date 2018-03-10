# frozen_string_literal: true

module Archangel
  module TestingSupport
    ##
    # Routing helpers for testing
    #
    module RoutingHelpers
      extend ActiveSupport::Concern

      included do
        routes { Archangel::Engine.routes }
      end
    end
  end
end

RSpec.configure do |config|
  %i[controller routing].each do |type|
    config.include Archangel::TestingSupport::RoutingHelpers, type: type
  end
end
