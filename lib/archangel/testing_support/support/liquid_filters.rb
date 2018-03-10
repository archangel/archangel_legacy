# frozen_string_literal: true

module Archangel
  module TestingSupport
    ##
    # Liquid filter meta type for testing
    #
    module LiquidFilters
      extend ActiveSupport::Concern
      include Archangel::TestingSupport::ViewControllerContext

      included do
        metadata[:type] = :liquid_filter

        before(:each) { setup_view_and_controller }
      end
    end
  end
end

RSpec.configure do |config|
  config.include Archangel::TestingSupport::LiquidFilters, type: :liquid_filter
end
