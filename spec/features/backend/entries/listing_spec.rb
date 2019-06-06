# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Backend - Collection Entries (HTML)", type: :feature do
  describe "listing" do
    before { stub_authorization!(profile) }

    let(:profile) { create(:user) }

    let!(:collection) { create(:collection, slug: "amazing") }
    let!(:field_name) do
      create(:field, collection: collection, label: "Name", slug: "name")
    end

    before do
      ("A".."Z").each do |letter|
        create(:entry, collection: collection,
                       value: {
                         name: "Entry #{letter} Name"
                       })
      end
    end

    describe "sorted" do
      scenario "ascending from position" do
        visit "/backend/collections/amazing/entries"

        within("tbody") do
          expect(page.find("tr:eq(1)")).to have_content("Entry Z Name")
          expect(page.find("tr:eq(2)")).to have_content("Entry Y Name")
          expect(page.find("tr:eq(3)")).to have_content("Entry X Name")
        end
      end
    end

    describe "paginated" do
      scenario "finds the second page of Collections" do
        visit "/backend/collections/amazing/entries?page=2"

        within("tbody") do
          expect(page).to_not have_content("Entry Z Name")
          expect(page).to_not have_content("Entry C Name")

          expect(page).to have_content("Entry B Name")
          expect(page).to have_content("Entry A Name")
        end
      end

      scenario "finds the second page of Collections with `per` count" do
        visit "/backend/collections/amazing/entries?page=2&per=3"

        within("tbody") do
          expect(page).to_not have_content("Entry Z Name")
          expect(page).to_not have_content("Entry X Name")

          expect(page).to have_content("Entry W Name")
          expect(page).to have_content("Entry U Name")

          expect(page).to_not have_content("Entry T Name")
          expect(page).to_not have_content("Entry A Name")
        end
      end

      scenario "finds nothing outside the count" do
        visit "/backend/collections/amazing/entries?page=2&per=26"

        expect(page).to have_content("No entries found.")
      end
    end

    describe "excludes" do
      scenario "deleted Entries" do
        create(:entry, :deleted, collection: collection,
                                 value: {
                                   name: "Deleted Entry Name"
                                 })

        visit "/backend/collections/amazing/entries"

        within("tbody") do
          expect(page).to_not have_content("Deleted Entry Name")
        end
      end
    end
  end
end
