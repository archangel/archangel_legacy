# frozen_string_literal: true

module Archangel
  module TestingSupport
    module FormHelpers
      def submit_form
        find("input[name='commit']").click
      end
    end
  end
end

RSpec.configure do |config|
  config.include Archangel::TestingSupport::FormHelpers, type: :feature
end
