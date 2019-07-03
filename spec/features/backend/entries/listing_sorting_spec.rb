# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Collection Entries (HTML)", type: :feature do
  describe "listing sorting", js: true do
    let(:collection) { create(:collection, slug: "amazing") }

    before do
      stub_authorization!

      create(:field, :required, collection: collection, slug: "name")

      create(:entry, collection: collection, value: { name: "Entry A" })
      create(:entry, collection: collection, value: { name: "Entry B" })
      create(:entry, collection: collection, value: { name: "Entry C" })
    end

    it "can drag/drop entry to sort" do
      visit "/backend/collections/amazing/entries"

      draggable = page.find("tbody#sortable tr:nth-child(3) .sortable-handle")
      droppable = page.find("tbody#sortable tr:nth-child(1)")

      draggable.drag_to(droppable)

      wait_for_ajax

      expect(page).to have_content("Sort order has been updated")
    end
  end
end
