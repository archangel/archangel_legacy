# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Assets (HTML)", type: :feature do
  describe "deletion" do
    before { stub_authorization!(profile) }

    let(:profile) { create(:user) }

    scenario "confirms the Asset is no longer accessible" do
      create(:asset, file_name: "delete-me.jpg")
      create(:asset, file_name: "keep-me.jpg")

      visit "/backend/assets"

      within("tbody tr:eq(1)") do
        click_on "Destroy"
      end

      expect(page).to have_content("Asset was successfully destroyed.")

      within("tbody tr:eq(1)") do
        expect(page).not_to have_content("delete-me.jpg")
        expect(page).to have_content("keep-me.jpg")
      end
    end
  end
end
