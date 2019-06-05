# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Backend - Users (HTML)", type: :feature do
  describe "deletion" do
    before { stub_authorization!(profile) }

    let(:profile) { create(:user) }

    scenario "confirms the User is no longer accessible" do
      create(:user, name: "Delete Me")
      create(:user, name: "Keep Me")

      visit "/backend/users"

      within("tbody tr:eq(1)") do
        click_on "Destroy"
      end

      expect(page).to have_content("User was successfully destroyed.")

      within("tbody tr:eq(1)") do
        expect(page).not_to have_content("Delete Me")
        expect(page).to have_content("Keep Me")
      end
    end
  end
end
