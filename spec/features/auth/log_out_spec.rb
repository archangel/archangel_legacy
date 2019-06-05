# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Auth log out", type: :feature do
  describe "while logged in" do
    before { stub_authorization! }

    it "has additional form fields" do
      visit archangel.backend_root_path

      click_link "Log Out"

      expect(page).to have_content "Signed out successfully"
      expect(current_path).to eq(archangel.new_user_session_path)
    end
  end
end
