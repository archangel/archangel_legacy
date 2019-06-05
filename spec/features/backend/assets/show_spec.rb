# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Asset (HTML)", type: :feature do
  describe "show" do
    before { stub_authorization!(profile) }

    let(:profile) { create(:user) }

    describe "is available" do
      scenario "finds the Asset" do
        resource = create(:asset, file_name: "amazing.jpg")

        visit "/backend/assets/#{resource.id}"

        expect(page).to have_content("File Name: amazing.jpg")

        expect(page).to have_css(
          "img[src^='/uploads/archangel/asset/file/#{resource.id}']"
        )
        expect(page).to have_css("img[alt='amazing.jpg']")

        expect(page).to have_content("File Size: 442 KB")
        expect(page).to have_content("Content Type: image/gif")
      end
    end

    describe "is not available" do
      scenario "when it does not exist" do
        visit "/backend/assets/0"

        expect(page)
          .to have_content("Page not found. Could not find what was requested")
      end

      scenario "when deleted" do
        resource = create(:asset, :deleted, file_name: "amazing.jpg")

        visit "/backend/assets/#{resource.id}"

        expect(page)
          .to have_content("Page not found. Could not find what was requested")
      end
    end
  end
end
