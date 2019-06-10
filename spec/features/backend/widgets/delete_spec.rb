# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Widgets (HTML)", type: :feature do
  describe "deletion" do
    before do
      stub_authorization!

      create(:widget, name: "Delete Me")
      create(:widget, name: "Not Deleted Widget")
    end

    it "confirms the Widget is no longer accessible" do
      visit "/backend/widgets"

      within("tbody tr:eq(1)") { click_on "Destroy" }

      expect(page).to have_content("Widget was successfully destroyed.")
    end

    it "confirms the deleted Widget is no longer listed" do
      visit "/backend/widgets"

      within("tbody tr:eq(1)") { click_on "Destroy" }

      within("tbody tr:eq(1)") do
        expect(page).not_to have_content("Delete Me")
      end
    end

    it "confirms the first available Widget is correct" do
      visit "/backend/widgets"

      within("tbody tr:eq(1)") { click_on "Destroy" }

      within("tbody tr:eq(1)") do
        expect(page).to have_content("Not Deleted Widget")
      end
    end
  end
end
