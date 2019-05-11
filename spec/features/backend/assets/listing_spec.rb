# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Backend - Assets (HTML)", type: :feature do
  describe "listing" do
    before { stub_authorization!(profile) }

    let(:profile) { create(:user) }

    before do
      ("A".."Z").each do |letter|
        create(:asset, file_name: "asset-#{letter}.jpg")
      end
    end

    describe "sorted" do
      scenario "ascending from A-Z (default)" do
        visit "/backend/assets"

        within("tbody") do
          expect(page.find("tr:eq(1)")).to have_content("asset-A.jpg")
          expect(page.find("tr:eq(1)"))
            .to have_css("img[src^='/uploads/archangel/asset/file']")

          expect(page.find("tr:eq(2)")).to have_content("asset-B.jpg")
          expect(page.find("tr:eq(2)"))
            .to have_css("img[src^='/uploads/archangel/asset/file']")

          expect(page.find("tr:eq(3)")).to have_content("asset-C.jpg")
          expect(page.find("tr:eq(3)"))
            .to have_css("img[src^='/uploads/archangel/asset/file']")
        end
      end
    end

    describe "paginated" do
      scenario "finds the second page of Assets" do
        visit "/backend/assets?page=2"

        expect(page).to_not have_content("asset-A.jpg")
        expect(page).to_not have_content("asset-X.jpg")

        expect(page).to have_content("asset-Y.jpg")
        expect(page).to have_content("asset-Z.jpg")
      end

      scenario "finds the second page of Assets with `per` count" do
        visit "/backend/assets?page=2&per=3"

        expect(page).to_not have_content("asset-A.jpg")
        expect(page).to_not have_content("asset-C.jpg")

        expect(page).to have_content("asset-D.jpg")
        expect(page).to have_content("asset-F.jpg")

        expect(page).to_not have_content("asset-G.jpg")
        expect(page).to_not have_content("asset-Z.jpg")
      end

      scenario "finds nothing outside the count" do
        visit "/backend/assets?page=2&per=26"

        expect(page).to have_content("No assets found.")

        expect(page).to_not have_content("asset-A.jpg")
        expect(page).to_not have_content("asset-Z.jpg")
      end
    end

    describe "excludes" do
      scenario "deleted Assets" do
        create(:asset, :deleted, file_name: "deleted.jpg")

        visit "/backend/assets"

        expect(page).to_not have_content("deleted.jpg")
      end
    end
  end
end
