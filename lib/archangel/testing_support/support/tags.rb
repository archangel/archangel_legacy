# frozen_string_literal: true

module Archangel
  module TestingSupport
    module Tags
      extend ActiveSupport::Concern
      include Archangel::TestingSupport::ViewControllerContext

      included do
        metadata[:type] = :tag

        before(:each) { setup_view_and_controller }
      end
    end
  end
end

RSpec.configure do |config|
  config.include Archangel::TestingSupport::Tags, type: :tag
end
