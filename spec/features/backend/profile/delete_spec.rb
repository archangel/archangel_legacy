# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Profile (HTML)", type: :feature do
  describe "deletion" do
    before { stub_authorization!(profile) }

    let(:profile) do
      create(:user, email: "me@example.com", password: "password")
    end

    it "redirects back to the login page" do
      visit "/backend/profile"

      click_on "Destroy"

      expect(page).to have_current_path("/account/login")
    end

    it "shows message that the User was logged out" do
      visit "/backend/profile"

      click_on "Destroy"

      expect(page)
        .to have_content("You need to sign in or sign up before continuing.")
    end

    it "does not allow logging back in" do
      visit "/backend/profile"

      click_on "Destroy"

      fill_in_login_form_with("me@example.com", "password")
      click_button "Log in"

      expect(page).to have_content("Invalid Email or password.")
    end
  end
end
