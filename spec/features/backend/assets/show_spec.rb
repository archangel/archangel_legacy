# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Asset (HTML)", type: :feature do
  describe "show" do
    before { stub_authorization! }

    describe "is available" do
      let(:resource) { create(:asset, file_name: "amazing.jpg") }

      it "finds the Asset file_name" do
        visit "/backend/assets/#{resource.id}"

        expect(page).to have_content("File Name: amazing.jpg")
      end

      it "finds the Asset file" do
        visit "/backend/assets/#{resource.id}"

        expect(page).to have_css(
          "img[src^='/uploads/archangel/asset/file/#{resource.id}']"
        )
      end

      it "finds the Asset file_size" do
        visit "/backend/assets/#{resource.id}"

        expect(page).to have_content("File Size: 442 KB")
      end

      it "finds the Asset content_type" do
        visit "/backend/assets/#{resource.id}"

        expect(page).to have_content("Content Type: image/gif")
      end
    end

    describe "is not available" do
      it "return 404 when it does not exist" do
        visit "/backend/assets/0"

        expect(page)
          .to have_content("Page not found. Could not find what was requested")
      end

      it "returns error message when deleted" do
        resource = create(:asset, :deleted, file_name: "amazing.jpg")

        visit "/backend/assets/#{resource.id}"

        expect(page)
          .to have_content("Page not found. Could not find what was requested")
      end
    end
  end
end
