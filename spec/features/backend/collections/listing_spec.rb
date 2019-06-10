# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Collections (HTML)", type: :feature do
  describe "listing" do
    before do
      stub_authorization!

      ("A".."Z").each do |letter|
        create(:collection, name: "Collection #{letter} Name")
      end
    end

    describe "ascending from A-Z (default)" do
      it "returns the first resource" do
        visit "/backend/collections"

        within("tbody") do
          expect(page.find("tr:eq(1)")).to have_content("Collection A Name")
        end
      end

      it "returns the second resource" do
        visit "/backend/collections"

        within("tbody") do
          expect(page.find("tr:eq(2)")).to have_content("Collection B Name")
        end
      end

      it "returns the third resource" do
        visit "/backend/collections"

        within("tbody") do
          expect(page.find("tr:eq(3)")).to have_content("Collection C Name")
        end
      end
    end

    describe "paginated" do
      it "does not find the first page of Collections" do
        visit "/backend/collections?page=2"

        within("tbody") do
          expect(page).not_to have_content("Collection A Name")
        end
      end

      it "finds the second page of Collections" do
        visit "/backend/collections?page=2"

        within("tbody") do
          expect(page).to have_content("Collection Y Name")
        end
      end

      it "does not find the first page of Collections with `per` count" do
        visit "/backend/collections?page=2&per=3"

        within("tbody") do
          expect(page).not_to have_content("Collection A Name")
        end
      end

      it "finds the second page of Collections with `per` count" do
        visit "/backend/collections?page=2&per=3"

        within("tbody") do
          expect(page).to have_content("Collection D Name")
        end
      end

      it "finds nothing outside the count" do
        visit "/backend/collections?page=2&per=26"

        expect(page).to have_content("No collections found.")
      end
    end

    describe "excludes" do
      it "does not display deleted Collections" do
        create(:collection, :deleted, name: "Deleted Collection Name")

        visit "/backend/collections"

        within("tbody") do
          expect(page).not_to have_content("Deleted Collection Name")
        end
      end
    end
  end
end
