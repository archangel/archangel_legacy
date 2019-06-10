# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Auth log in", type: :feature do
  describe "with valid credentials" do
    it "is successful" do
      create(:user, email: "me@example.com", password: "password")

      visit "/account/login"

      fill_in_login_form_with("me@example.com", "password")
      click_button "Log in"

      expect(page).to have_content("Signed in successfully.")
    end
  end

  describe "with invalid credentials" do
    it "fails with unknown user credentials" do
      visit "/account/login"

      fill_in_login_form_with("me@example.com", "password")
      click_button "Log in"

      expect(page).to have_content("Invalid Email or password.")
    end

    it "fails with invalid email" do
      create(:user, email: "me@example.com", password: "password")

      visit "/account/login"

      fill_in_login_form_with("not_me@example.com", "password")
      click_button "Log in"

      expect(page).to have_content("Invalid Email or password.")
    end

    it "fails with invalid password" do
      create(:user, email: "me@example.com", password: "password")

      visit "/account/login"

      fill_in_login_form_with("me@example.com", "bad_password")
      click_button "Log in"

      expect(page).to have_content("Invalid Email or password.")
    end
  end
end
