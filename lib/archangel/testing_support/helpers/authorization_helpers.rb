# frozen_string_literal: true

module Archangel
  module TestingSupport
    module AuthorizationHelpers
      module Controller
        def stub_authorization!(user = double("user"))
          user.nil? ? stub_nil_authorization : stub_user_authorization(user)
        end

        private

        def stub_nil_authorization
          allow(request.env["warden"]).to(receive(:authenticate!))
                                      .and_throw(:warden, scope: :user)
          allow(controller).to receive(:current_user).and_return(nil)
        end

        def stub_user_authorization(user)
          allow(request.env["warden"]).to(receive(:authenticate!))
                                      .and_return(user)
          allow(controller).to receive(:current_user).and_return(user)
        end
      end

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
  config.include Archangel::TestingSupport::AuthorizationHelpers::Controller,
                 type: :controller

  config.include Archangel::TestingSupport::AuthorizationHelpers::Feature,
                 type: :feature
end
