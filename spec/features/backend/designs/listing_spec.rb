# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Designs (HTML)", type: :feature do
  describe "listing" do
    before { stub_authorization!(profile) }

    let(:profile) { create(:user) }

    before do
      ("A".."Z").each do |letter|
        create(:design, name: "Design #{letter} Name")
      end
    end

    describe "sorted" do
      scenario "ascending from A-Z (default)" do
        visit "/backend/designs"

        within("tbody") do
          expect(page.find("tr:eq(1)")).to have_content("Design A Name")
          expect(page.find("tr:eq(2)")).to have_content("Design B Name")
          expect(page.find("tr:eq(3)")).to have_content("Design C Name")
        end
      end
    end

    describe "paginated" do
      scenario "finds the second page of Designs" do
        visit "/backend/designs?page=2"

        expect(page).not_to have_content("Design A Name")
        expect(page).not_to have_content("Design X Name")

        expect(page).to have_content("Design Y Name")
        expect(page).to have_content("Design Z Name")
      end

      scenario "finds the second page of Designs with `per` count" do
        visit "/backend/designs?page=2&per=3"

        expect(page).not_to have_content("Design A Name")
        expect(page).not_to have_content("Design C Name")

        expect(page).to have_content("Design D Name")
        expect(page).to have_content("Design F Name")

        expect(page).not_to have_content("Design G Name")
        expect(page).not_to have_content("Design Z Name")
      end

      scenario "finds nothing outside the count" do
        visit "/backend/designs?page=2&per=26"

        expect(page).to have_content("No designs found.")

        expect(page).not_to have_content("Design A Name")
        expect(page).not_to have_content("Design Z Name")
      end
    end

    describe "excludes" do
      scenario "deleted Designs" do
        create(:design, :deleted, name: "Deleted Design Name")

        visit "/backend/designs"

        expect(page).not_to have_content("Deleted Design Name")
      end
    end
  end
end
