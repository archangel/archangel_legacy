# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Auth log in", type: :feature do
  describe "with valid credentials" do
    it "is successful" do
      create(:user, email: "me@example.com", password: "password")

      visit "/account/login"

      fill_in "Email", with: "me@example.com"
      fill_in "Password", with: "password"
      click_button "Log in"

      expect(page).to have_content I18n.t("devise.sessions.signed_in")
    end

    it "locks account after 4 failed attempts" do
      email = "me@example.com"
      create(:user, email: email)

      visit "/account/login"

      attempts = 3
      (1..attempts).each do |attempt|
        fill_in "Email", with: email
        fill_in "Password", with: "wrong-password-#{attempt}"
        click_button "Log in"

        message = I18n.t("devise.failure.not_found_in_database",
                         authentication_keys: "Email")
        message = I18n.t("devise.failure.last_attempt") if attempt == attempts

        expect(page).to have_content message
      end

      fill_in "Email", with: email
      fill_in "Password", with: "wrong-password-#{attempts + 1}"
      click_button "Log in"

      expect(page).to have_content(I18n.t("devise.failure.locked"))
    end
  end

  describe "unconfirmed user" do
    it "cannot login" do
      create(:user, :unconfirmed, email: "me@example.com",
                                  password: "password",
                                  created_at: 1.week.ago)

      visit "/account/login"

      fill_in "Email", with: "me@example.com"
      fill_in "Password", with: "password"
      click_button "Log in"

      expect(current_path).to eq("/account/login")
      expect(page).to have_content I18n.t("devise.failure.unconfirmed")
    end
  end

  describe "locked user" do
    it "cannot login" do
      create(:user, :locked, email: "me@example.com", password: "password")

      visit "/account/login"

      fill_in "Email", with: "me@example.com"
      fill_in "Password", with: "password"
      click_button "Log in"

      expect(current_path).to eq("/account/login")
      expect(page).to have_content(I18n.t("devise.failure.locked"))
    end
  end

  describe "unknown user credentials" do
    it "is not successful" do
      visit "/account/login"

      fill_in "Email", with: "me@example.com"
      fill_in "Password", with: "password"
      click_button "Log in"

      expect(page).to(
        have_content(I18n.t("devise.failure.not_found_in_database",
                            authentication_keys: "Email"))
      )
    end
  end

  describe "with invalid email" do
    it "is not successful" do
      create(:user, email: "me@example.com", password: "password")

      visit "/account/login"

      fill_in "Email", with: "not_me@example.com"
      fill_in "Password", with: "password"
      click_button "Log in"

      expect(page).to(
        have_content(I18n.t("devise.failure.not_found_in_database",
                            authentication_keys: "Email"))
      )
    end
  end

  describe "with invalid password" do
    it "is not successful" do
      create(:user, email: "me@example.com", password: "password")

      visit "/account/login"

      fill_in "Email", with: "me@example.com"
      fill_in "Password", with: "bad_password"
      click_button "Log in"

      expect(page).to(
        have_content(I18n.t("devise.failure.invalid",
                            authentication_keys: "Email"))
      )
    end
  end
end
