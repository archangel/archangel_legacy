# frozen_string_literal: true

module Archangel
  module TestingSupport
    ##
    # Fill in form helpers for testing
    #
    # Does not submit the form
    #
    module FillInFormHelpers
      def fill_in_password_with(password = "", confirm_password = "")
        fill_in "Password", with: password, match: :prefer_exact
        fill_in "Confirm Password", with: confirm_password, match: :prefer_exact
      end
    end
  end
end

RSpec.configure do |config|
  config.include Archangel::TestingSupport::FillInFormHelpers,
                 type: :feature
end
