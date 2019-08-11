# frozen_string_literal: true

module Archangel
  module TestingSupport
    ##
    # Fill in login form helpers for testing
    #
    # Does not submit the form
    #
    module FillInAuthFormHelpers
      def fill_in_login_form_with(email = "", password = "")
        fill_in "Email", with: email
        fill_in "Password", with: password
      end

      def fill_in_registration_form_with(name = "", username = "", email = "",
                                         password = "")
        fill_in "Name", with: name
        fill_in "Username", with: username
        fill_in "Email", with: email
        fill_in_password_with(password, password)
      end

      def fill_in_invitation_form_with(password = "", confirm_password = "")
        fill_in_password_with(password, confirm_password)
      end
    end
  end
end

RSpec.configure do |config|
  config.include Archangel::TestingSupport::FillInAuthFormHelpers,
                 type: :feature
end
