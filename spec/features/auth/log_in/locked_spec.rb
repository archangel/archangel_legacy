# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Auth log in", type: :feature do
  describe "with locked user" do
    it "fails with error message before lock timeout expires" do
      create(:user, :locked, locked_at: 59.minutes.ago, email: "me@example.com")

      visit "/account/login"

      fill_in_login_form_with("me@example.com", "password")
      click_button "Log in"

      expect(page).to have_content("Your account is locked.")
    end

    it "is successful with recently unlocked user after lock timeout expired" do
      create(:user, :locked, locked_at: 61.minutes.ago, email: "me@example.com")

      visit "/account/login"

      fill_in_login_form_with("me@example.com", "password")
      click_button "Log in"

      expect(page).to have_content("Signed in successfully.")
    end
  end
end
