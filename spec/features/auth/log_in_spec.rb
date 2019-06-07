# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Auth log in", type: :feature do
  describe "with valid credentials" do
    it "is successful" do
      create(:user, email: "me@example.com", password: "password")

      visit "/account/login"

      fill_in_login_form_with("me@example.com", "password")
      click_button "Log in"

      expect(page).to have_content I18n.t("devise.sessions.signed_in")
    end

    it "locks account after 4 failed attempts" do
      email = "me@example.com"
      create(:user, email: email)

      visit "/account/login"

      attempts = 3
      (1..attempts).each do |attempt|
        fill_in_login_form_with(email, "wrong-password-#{attempt}")
        click_button "Log in"

        message = I18n.t("devise.failure.not_found_in_database",
                         authentication_keys: "Email")
        message = I18n.t("devise.failure.last_attempt") if attempt == attempts

        expect(page).to have_content message
      end

      fill_in_login_form_with(email, "wrong-password-#{attempts + 1}")
      click_button "Log in"

      expect(page).to have_content(I18n.t("devise.failure.locked"))
    end
  end

  describe "with invalid credentials" do
    it "fails with unknown user credentials" do
      visit "/account/login"

      fill_in_login_form_with("me@example.com", "password")
      click_button "Log in"

      expect(page).to(
        have_content(I18n.t("devise.failure.not_found_in_database",
                            authentication_keys: "Email"))
      )
    end

    it "fails with invalid email" do
      create(:user, email: "me@example.com", password: "password")

      visit "/account/login"

      fill_in_login_form_with("not_me@example.com", "password")
      click_button "Log in"

      expect(page).to(
        have_content(I18n.t("devise.failure.not_found_in_database",
                            authentication_keys: "Email"))
      )
    end

    it "fails with invalid password" do
      create(:user, email: "me@example.com", password: "password")

      visit "/account/login"

      fill_in_login_form_with("me@example.com", "bad_password")
      click_button "Log in"

      expect(page).to(
        have_content(I18n.t("devise.failure.invalid",
                            authentication_keys: "Email"))
      )
    end

    it "fails to log in with unconfirmed user" do
      create(:user, :unconfirmed, email: "me@example.com",
                                  password: "password",
                                  created_at: 1.day.ago)

      visit "/account/login"

      fill_in_login_form_with("me@example.com", "password")
      click_button "Log in"

      expect(page).to have_content I18n.t("devise.failure.unconfirmed")
    end
  end

  it "fails to log in with locked user" do
    create(:user, :locked, email: "me@example.com", password: "password")

    visit "/account/login"

    fill_in_login_form_with("me@example.com", "password")
    click_button "Log in"

    expect(page).to have_content(I18n.t("devise.failure.locked"))
  end
end
