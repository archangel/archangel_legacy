# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Auth password reset", type: :feature do
  describe "with unaccepted invitation" do
    before { create(:user, :invited, email: "amazing@email.com") }

    it "returns success message" do
      visit "/account/password/new"

      fill_in "Email", with: "amazing@email.com"
      click_button "Send me reset password instructions"

      expect(page)
        .to have_content("You will receive an email with instructions")
    end

    it "redirects back to the login form" do
      visit "/account/password/new"

      fill_in "Email", with: "amazing@email.com"
      click_button "Send me reset password instructions"

      expect(page).to have_current_path("/account/login")
    end
  end
end
