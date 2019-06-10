# frozen_string_literal: true

module Archangel
  module TestingSupport
    ##
    # Authorization helpers for testing
    #
    module AuthorizationHelpers
      ##
      # Authorization helpers for feature and request testing
      #
      module Feature
        include Warden::Test::Helpers

        Warden.test_mode!

        def stub_authorization!(user = nil)
          user ||= create(:user)

          login_as user, scope: :user

          user
        end
      end
    end
  end
end

RSpec.configure do |config|
  %i[feature request].each do |type|
    config.include Archangel::TestingSupport::AuthorizationHelpers::Feature,
                   type: type
  end
end
