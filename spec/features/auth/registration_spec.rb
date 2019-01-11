# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Auth registration", type: :feature do
  describe "when registration is disabled" do
    it "returns a 404" do
      visit archangel.new_user_registration_path

      expect(page.status_code).to eq 404
    end
  end

  describe "when registration is enabled" do
    it "has additional form fields" do
      allow(Archangel.config).to receive(:allow_registration) { true }

      visit archangel.new_user_registration_path

      expect(page).to have_text "Name"
      expect(page).to have_text "Username"

      expect(page).to have_selector("input[type=text][id='user_name']")
      expect(page).to have_selector("input[type=text][id='user_username']")
    end

    it "allows successful registration" do
      allow(Archangel.config).to receive(:allow_registration) { true }

      create(:page, homepage: true, content: "Welcome to the homepage")

      visit archangel.backend_root_path

      click_link "Sign up"

      fill_in "Name", with: "John Doe"
      fill_in "Username", with: "john_doe"
      fill_in "Email", with: "me@example.com"
      fill_in "Password", with: "password"
      fill_in "Confirm Password", with: "password"

      click_button "Sign up"

      expect(page).to have_content("Welcome to the homepage")
    end
  end
end
