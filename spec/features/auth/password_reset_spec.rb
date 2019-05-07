# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Auth password reset", type: :feature do
  describe "unaccepted invitation" do
    it "does not actually send password reset instructions" do
      create(:user, :invited, email: "amazing@email.com")

      visit "/account/password/new"

      fill_in "Email", with: "amazing@email.com"

      click_button "Send me reset password instructions"

      message = "You will receive an email with instructions on how to reset " \
                "your password in a few minutes."

      expect(current_path).to eq("/account/login")
      expect(page).to have_content(message)
    end
  end
end
