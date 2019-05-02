# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Backend - Collections (HTML)", type: :feature do
  describe "deletion" do
    before { stub_authorization!(profile) }

    let(:profile) { create(:user) }

    scenario "confirms the Collection is no longer accessible" do
      create(:collection, name: "Delete Me")
      create(:collection, name: "Do No Delete")

      visit "/backend/collections"

      within("tbody tr:eq(1)") do
        click_on "Destroy"
      end

      expect(page).to have_content("Collection was successfully destroyed.")

      within("tbody tr:eq(1)") do
        expect(page).to_not have_content("Delete Me")
        expect(page).to have_content("Do No Delete")
      end
    end
  end
end
