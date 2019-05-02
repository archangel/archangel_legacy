# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Backend - Collections (HTML)", type: :feature do
  describe "listing" do
    before { stub_authorization!(profile) }

    let(:profile) { create(:user) }

    before do
      ("A".."Z").each do |letter|
        create(:collection, name: "Collection #{letter} Name")
      end
    end

    describe "sorted" do
      scenario "ascending from A-Z (default)" do
        visit "/backend/collections"

        within("tbody") do
          expect(page.find("tr:eq(1)")).to have_content("Collection A Name")
          expect(page.find("tr:eq(2)")).to have_content("Collection B Name")
          expect(page.find("tr:eq(3)")).to have_content("Collection C Name")
        end
      end
    end

    describe "paginated" do
      scenario "finds the second page of Collections" do
        visit "/backend/collections?page=2"

        within("tbody") do
          expect(page).to_not have_content("Collection A Name")
          expect(page).to_not have_content("Collection X Name")

          expect(page).to have_content("Collection Y Name")
          expect(page).to have_content("Collection Z Name")
        end
      end

      scenario "finds the second page of Collections with `per` count" do
        visit "/backend/collections?page=2&per=3"

        within("tbody") do
          expect(page).to_not have_content("Collection A Name")
          expect(page).to_not have_content("Collection C Name")

          expect(page).to have_content("Collection D Name")
          expect(page).to have_content("Collection F Name")

          expect(page).to_not have_content("Collection G Name")
          expect(page).to_not have_content("Collection Z Name")
        end
      end

      scenario "finds nothing outside the count" do
        visit "/backend/collections?page=2&per=26"

        expect(page).to have_content("No collections found.")
      end
    end

    describe "excludes" do
      scenario "deleted Collections" do
        create(:collection, :deleted, name: "Deleted Collection Name")

        visit "/backend/collections"

        within("tbody") do
          expect(page).to_not have_content("Deleted Collection Name")
        end
      end
    end
  end
end
