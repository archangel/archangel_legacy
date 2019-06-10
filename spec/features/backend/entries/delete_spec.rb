# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Collection Entries (HTML)", type: :feature do
  describe "deletion" do
    before do
      stub_authorization!

      collection = create(:collection, slug: "amazing")
      create(:field, collection: collection, slug: "name")

      create(:entry, collection: collection, value: { name: "Do Not Delete" })
      create(:entry, collection: collection, value: { name: "Delete Me" })
    end

    it "returns success message when the Collection is no longer available" do
      visit "/backend/collections/amazing/entries"

      within("tbody tr:eq(1)") { click_on "Destroy" }

      expect(page).to have_content("Entry was successfully destroyed.")
    end

    it "does not have deleted resource" do
      visit "/backend/collections/amazing/entries"

      within("tbody tr:eq(1)") { click_on "Destroy" }

      within("tbody tr:eq(1)") do
        expect(page).not_to have_content("Delete Me")
      end
    end
  end
end
