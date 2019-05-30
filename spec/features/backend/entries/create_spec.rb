# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Backend - Collection Entries (HTML)", type: :feature do
  describe "creation" do
    before { stub_authorization!(profile) }

    let(:profile) { create(:user) }

    let!(:collection) { create(:collection, slug: "amazing") }
    let!(:field_name) do
      create(:field, collection: collection, label: "Name", slug: "name")
    end
    let!(:field_slug) do
      create(:field, collection: collection,
                     label: "Slug",
                     slug: "slug",
                     required: true)
    end

    describe "successful" do
      scenario "with valid data for a full collection" do
        visit "/backend/collections/amazing/entries/new"

        fill_in "Name", with: "Really Good Entry Item"
        fill_in "Slug", with: "really-good-entry-item"
        fill_in "Published At", with: "2019-01-01 00:00:00"

        click_button "Create Entry"

        expect(page).to have_content("Entry was successfully created.")
      end

      scenario "when non-required field is empty" do
        visit "/backend/collections/amazing/entries/new"

        fill_in "Slug", with: "really-good-entry-item"

        click_button "Create Entry"

        expect(page).to have_content("Entry was successfully created.")
      end
    end

    describe "unsuccessful" do
      scenario "without value for required field" do
        visit "/backend/collections/amazing/entries/new"

        fill_in "Name", with: "Really Good Entry Item"
        fill_in "Slug", with: ""
        fill_in "Published At", with: "2019-01-01 00:00:00"

        click_button "Create Entry"

        expect(page).to_not have_content("Entry was successfully created.")

        expect(page.find(".input.collection_entry_slug"))
          .to have_content("can't be blank")
      end
    end
  end
end
