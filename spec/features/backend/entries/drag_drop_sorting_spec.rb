# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Entries", type: :feature, js: true do
  describe "listing sorting" do
    before { stub_authorization! }

    it "can drag/drop entries to sort entries" do
      collection = create(:collection)
      create(:field, :required, collection: collection, slug: "name")
      create(:entry, collection: collection, value: { name: "Entry A" })
      create(:entry, collection: collection, value: { name: "Entry B" })
      create(:entry, collection: collection, value: { name: "Entry C" })

      visit archangel.backend_collection_entries_path(collection_id: collection)

      within("tbody#sortable") do
        item_a = find("tr:nth-child(3) .fa-sort")
        item_b = find("tr:nth-child(1) .fa-sort")

        item_a.drag_to(item_b)
      end

      wait_for_ajax

      expect(page).to have_content("Sort order has been updated")
    end
  end
end
