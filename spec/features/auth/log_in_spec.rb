# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Auth log in", type: :feature do
  describe "with valid credentials" do
    it "is successful" do
      create(:user, email: "me@example.com", password: "password")

      visit archangel.new_user_session_path

      fill_in "Email", with: "me@example.com"
      fill_in "Password", with: "password"
      click_button "Log in"

      expect(page.body).to have_content "Signed in successfully"
    end

    it "locks account after 4 failed attempts" do
      email = "me@example.com"
      create(:user, email: email)

      visit archangel.new_user_session_path

      attempts = 3
      (1..attempts).each do |attempt|
        fill_in "Email", with: email
        fill_in "Password", with: "wrong-password-#{attempt}"
        click_button "Log in"

        message = "Invalid Email or password"

        if attempt == attempts
          message = "You have one more attempt before your account is locked"
        end

        expect(page.body).to have_content message
      end

      fill_in "Email", with: email
      fill_in "Password", with: "wrong-password-#{attempts + 1}"
      click_button "Log in"

      expect(page.body).to have_content "Your account is locked"
    end
  end

  describe "unconfirmed user" do
    it "cannot login" do
      Timecop.travel(1.week.ago) do
        create(:user, :unconfirmed, email: "me@example.com",
                                    password: "password")
      end

      visit archangel.new_user_session_path

      fill_in "Email", with: "me@example.com"
      fill_in "Password", with: "password"
      click_button "Log in"

      expect(current_path).to eq(archangel.new_user_session_path)
      expect(page).to have_content(
        "You have to confirm your email address before continuing"
      )
    end
  end

  describe "locked user" do
    it "cannot login" do
      create(:user, :locked, email: "me@example.com", password: "password")

      visit archangel.new_user_session_path

      fill_in "Email", with: "me@example.com"
      fill_in "Password", with: "password"
      click_button "Log in"

      expect(current_path).to eq(archangel.new_user_session_path)
      expect(page).to have_content("Your account is locked")
    end
  end

  describe "with invalid or unknown user credentials" do
    it "is not successful" do
      visit archangel.new_user_session_path

      fill_in "Email", with: "me@example.com"
      fill_in "Password", with: "password"
      click_button "Log in"

      expect(page.body).to have_content "Invalid Email or password"
    end
  end
end
