# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Backend - Collection Entries (HTML)", type: :feature do
  describe "deletion" do
    before { stub_authorization!(profile) }

    let(:profile) { create(:user) }

    let!(:collection) { create(:collection, slug: "amazing") }
    let!(:field) { create(:field, collection: collection, slug: "name") }

    scenario "confirms the Collection is no longer accessible" do
      create(:entry, collection: collection, value: { name: "Do Not Delete" })
      create(:entry, collection: collection, value: { name: "Delete Me" })

      visit "/backend/collections/amazing/entries"

      within("tbody tr:eq(1)") do
        click_on "Destroy"
      end

      expect(page).to have_content("Entry was successfully destroyed.")

      within("tbody tr:eq(1)") do
        expect(page).to_not have_content("Delete Me")
        expect(page).to have_content("Do Not Delete")
      end
    end
  end
end
