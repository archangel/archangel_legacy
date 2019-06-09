# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Auth log in", type: :feature do
  def fill_in_and_submit_login_form_with(email = "", password = "")
    fill_in_login_form_with(email, password)
    click_button "Log in"
  end

  describe "with login attempts" do
    let(:email) { "me@example.com" }

    before { create(:user, email: email) }

    it "returns message after 1 failed login attempt" do
      visit "/account/login"

      fill_in_and_submit_login_form_with(email, "wrong-password")

      expect(page).to have_content("Invalid Email or password")
    end

    it "returns message after 2 failed login attempts" do
      visit "/account/login"

      2.times { fill_in_and_submit_login_form_with(email, "wrong-password") }

      expect(page).to have_content("Invalid Email or password")
    end

    it "returns warning message after 3 failed login attempts" do
      visit "/account/login"

      3.times { fill_in_and_submit_login_form_with(email, "wrong-password") }

      expect(page).to have_content(
        "You have one more attempt before your account is locked"
      )
    end

    it "locks account after 5 failed login attempts" do
      visit "/account/login"

      4.times { fill_in_and_submit_login_form_with(email, "wrong-password") }

      expect(page).to have_content("Your account is locked.")
    end
  end
end
