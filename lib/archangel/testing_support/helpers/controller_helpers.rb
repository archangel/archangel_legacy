# frozen_string_literal: true

module Archangel
  module TestingSupport
    ##
    # Controller helpers for testing
    #
    module ControllerHelpers
      extend ActiveSupport::Concern

      included do
        routes { Archangel::Engine.routes }
      end
    end
  end
end

RSpec.configure do |config|
  config.include Archangel::TestingSupport::ControllerHelpers, type: :controller
end
