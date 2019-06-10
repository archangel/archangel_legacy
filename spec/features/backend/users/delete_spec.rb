# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Users (HTML)", type: :feature do
  describe "deletion" do
    before do
      stub_authorization!

      create(:user, name: "Delete Me")
      create(:user, name: "Keep Me")
    end

    it "returns success message when User is deleted" do
      visit "/backend/users"

      within("tbody tr:eq(1)") { click_on "Destroy" }

      expect(page).to have_content("User was successfully destroyed.")
    end

    it "does not list deleted User" do
      visit "/backend/users"

      within("tbody tr:eq(1)") { click_on "Destroy" }

      within("tbody tr:eq(1)") do
        expect(page).not_to have_content("Delete Me")
      end
    end
  end
end
