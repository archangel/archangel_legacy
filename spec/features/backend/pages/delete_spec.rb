# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Backend - Pages (HTML)", type: :feature do
  describe "deletion" do
    before { stub_authorization!(profile) }

    let(:profile) { create(:user) }

    scenario "confirms the Page is no longer accessible" do
      create(:page, title: "Delete Me")
      create(:page, title: "Published Page")

      visit "/backend/pages"

      within("tbody tr:eq(1)") do
        click_on "Destroy"
      end

      expect(page).to have_content("Page was successfully destroyed.")

      within("tbody tr:eq(1)") do
        expect(page).not_to have_content("Delete Me")
        expect(page).to have_content("Published Page")
      end
    end
  end
end
