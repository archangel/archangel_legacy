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

      def fill_in_widget_form_with(name = "", slug = "", content = "")
        fill_in "Name", with: name
        fill_in "Slug", with: slug
        fill_in "Content", with: content
      end

      def fill_in_user_form_with(name = "", username = "", email = "")
        fill_in "Name", with: name
        fill_in "Username", with: username
        fill_in "Email", with: email
      end
    end
  end
end

RSpec.configure do |config|
  config.include Archangel::TestingSupport::FillInFormHelpers,
                 type: :feature
end
