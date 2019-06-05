# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Backend - Designs (HTML)", type: :feature do
  describe "deletion" do
    before { stub_authorization!(profile) }

    let(:profile) { create(:user) }

    scenario "confirms the Design is no longer accessible" do
      create(:design, name: "Delete Me")
      create(:design, name: "Main Design")

      visit "/backend/designs"

      within("tbody tr:eq(1)") do
        click_on "Destroy"
      end

      expect(page).to have_content("Design was successfully destroyed.")

      within("tbody tr:eq(1)") do
        expect(page).not_to have_content("Delete Me")
        expect(page).to have_content("Main Design")
      end
    end
  end
end
