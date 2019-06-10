# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Auth log in", type: :feature do
  describe "with invalid credentials" do
    let(:message) do
      "You have to confirm your email address before continuing."
    end

    it "fails to log in with unconfirmed user" do
      create(:user, :unconfirmed, created_at: 1.day.ago, email: "me@email.com")

      visit "/account/login"

      fill_in_login_form_with("me@email.com", "password")
      click_button "Log in"

      expect(page).to have_content(message)
    end
  end
end
