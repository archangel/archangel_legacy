# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Collections (HTML)", type: :feature do
  describe "deletion" do
    before do
      stub_authorization!

      create(:collection, name: "Delete Me")
      create(:collection, name: "Do No Delete")
    end

    it "displays success message when the Collection is no longer available" do
      visit "/backend/collections"

      within("tbody tr:eq(1)") { click_on "Destroy" }

      expect(page).to have_content("Collection was successfully destroyed.")
    end

    it "does not list deleted resources" do
      visit "/backend/collections"

      within("tbody tr:eq(1)") { click_on "Destroy" }

      within("tbody tr:eq(1)") do
        expect(page).not_to have_content("Delete Me")
      end
    end
  end
end
