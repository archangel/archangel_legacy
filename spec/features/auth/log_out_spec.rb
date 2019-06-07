# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Auth log out", type: :feature do
  describe "while logged in" do
    before { stub_authorization! }

    it "signs out successfully" do
      visit "/backend"

      click_link "Log Out"

      expect(page).to have_content "Signed out successfully"
    end

    it "signs out and redirects to login page" do
      visit "/backend"

      click_link "Log Out"

      expect(page).to have_current_path("/account/login")
    end
  end
end
