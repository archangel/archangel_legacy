# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Assets (HTML)", type: :feature do
  describe "deletion" do
    before do
      stub_authorization!

      create(:asset, file_name: "delete-me.jpg")
      create(:asset, file_name: "keep-me.jpg")
    end

    it "shows a success message to confirm the Asset is no longer available" do
      visit "/backend/assets"

      within("tbody tr:eq(1)") { click_on "Destroy" }

      expect(page).to have_content("Asset was successfully destroyed.")
    end

    it "does not list Asset after it is deleted" do
      visit "/backend/assets"

      within("tbody tr:eq(1)") { click_on "Destroy" }

      within("tbody tr:eq(1)") do
        expect(page).not_to have_content("delete-me.jpg")
      end
    end
  end
end
