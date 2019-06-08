# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Assets (HTML)", type: :feature do
  describe "listing" do
    before do
      stub_authorization!

      ("A".."Z").each do |letter|
        create(:asset, file_name: "asset-#{letter}.jpg")
      end
    end

    describe "ascending from A-Z (default)" do
      it "displays the first resource" do
        visit "/backend/assets"

        within("tbody") do
          expect(page.find("tr:eq(1)")).to have_content("asset-A.jpg")
        end
      end

      it "displays the second resource" do
        visit "/backend/assets"

        within("tbody") do
          expect(page.find("tr:eq(2)")).to have_content("asset-B.jpg")
        end
      end

      it "displays the third resource" do
        visit "/backend/assets"

        within("tbody") do
          expect(page.find("tr:eq(3)")).to have_content("asset-C.jpg")
        end
      end
    end

    describe "paginated" do
      it "does not find the first page of Assets" do
        visit "/backend/assets?page=2"

        expect(page).not_to have_content("asset-A.jpg")
      end

      it "finds the second page of Assets" do
        visit "/backend/assets?page=2"

        expect(page).to have_content("asset-Y.jpg")
      end

      it "does not find the first page of Assets with `per` count" do
        visit "/backend/assets?page=2&per=3"

        expect(page).not_to have_content("asset-A.jpg")
      end

      it "finds the second page of Assets with `per` count" do
        visit "/backend/assets?page=2&per=3"

        expect(page).to have_content("asset-D.jpg")
      end

      it "finds nothing outside the count" do
        visit "/backend/assets?page=2&per=26"

        expect(page).to have_content("No assets found.")
      end
    end

    describe "excludes" do
      it "does not list deleted Asset after it is deleted" do
        create(:asset, :deleted, file_name: "deleted.jpg")

        visit "/backend/assets"

        expect(page).not_to have_content("deleted.jpg")
      end
    end
  end
end
