# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Pages (HTML)", type: :feature do
  describe "deletion" do
    before do
      stub_authorization!

      create(:page, title: "Delete Me")
      create(:page, title: "Published Page")
    end

    it "displays success message" do
      visit "/backend/pages"

      within("tbody tr:eq(1)") { click_on "Destroy" }

      expect(page).to have_content("Page was successfully destroyed.")
    end

    it "does not list deleted Page" do
      visit "/backend/pages"

      within("tbody tr:eq(1)") { click_on "Destroy" }

      within("tbody tr:eq(1)") do
        expect(page).not_to have_content("Delete Me")
      end
    end
  end
end
