# frozen_string_literal: true

module Archangel
  module TestingSupport
    ##
    # Liquid tag meta type for testing
    #
    module LiquidTags
      extend ActiveSupport::Concern
      include Archangel::TestingSupport::ViewControllerContext

      included do
        metadata[:type] = :liquid_tag

        before(:each) { setup_view_and_controller }
      end
    end
  end
end

RSpec.configure do |config|
  config.include Archangel::TestingSupport::LiquidTags, type: :liquid_tag
end
