# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Profile (HTML)", type: :feature do
  describe "deletion" do
    before { stub_authorization!(profile) }

    let(:profile) do
      create(:user, email: "me@example.com", password: "password")
    end

    scenario "confirms the User was deleted, logged out and cannot log in" do
      visit "/backend/profile"

      click_on "Destroy"

      expect(current_path).to eq("/account/login")

      expect(page)
        .to have_content("You need to sign in or sign up before continuing.")

      fill_in "Email", with: "me@example.com"
      fill_in "Password", with: "password"
      click_button "Log in"

      expect(page).to have_content("Invalid Email or password.")
    end
  end
end
