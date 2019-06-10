# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Designs (HTML)", type: :feature do
  describe "deletion" do
    before do
      stub_authorization!

      create(:design, name: "Delete Me")
      create(:design, name: "Main Design")
    end

    it "displays error message when deleted" do
      visit "/backend/designs"

      within("tbody tr:eq(1)") { click_on "Destroy" }

      expect(page).to have_content("Design was successfully destroyed.")
    end

    it "does not list deleted Designs" do
      visit "/backend/designs"

      within("tbody tr:eq(1)") { click_on "Destroy" }

      within("tbody tr:eq(1)") do
        expect(page).not_to have_content("Delete Me")
      end
    end
  end
end
