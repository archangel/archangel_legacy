# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Backend - Widgets (HTML)", type: :feature do
  describe "deletion" do
    before { stub_authorization!(profile) }

    let(:profile) { create(:user) }

    scenario "confirms the Widget is no longer accessible" do
      create(:widget, name: "Delete Me")
      create(:widget, name: "Published Widget")

      visit "/backend/widgets"

      within("tbody tr:eq(1)") do
        click_on "Destroy"
      end

      expect(page).to have_content("Widget was successfully destroyed.")

      within("tbody tr:eq(1)") do
        expect(page).to_not have_content("Delete Me")
        expect(page).to have_content("Published Widget")
      end
    end
  end
end
