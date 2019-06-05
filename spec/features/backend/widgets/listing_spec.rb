# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Widgets (HTML)", type: :feature do
  describe "listing" do
    before { stub_authorization!(profile) }

    let(:profile) { create(:user) }

    before do
      ("A".."Z").each do |letter|
        create(:widget, name: "Widget #{letter} Name")
      end
    end

    describe "sorted" do
      scenario "ascending from A-Z (default)" do
        visit "/backend/widgets"

        within("tbody") do
          expect(page.find("tr:eq(1)")).to have_content("Widget A Name")
          expect(page.find("tr:eq(2)")).to have_content("Widget B Name")
          expect(page.find("tr:eq(3)")).to have_content("Widget C Name")
        end
      end
    end

    describe "paginated" do
      scenario "finds the second page of Widgets" do
        visit "/backend/widgets?page=2"

        expect(page).not_to have_content("Widget A Name")
        expect(page).not_to have_content("Widget X Name")

        expect(page).to have_content("Widget Y Name")
        expect(page).to have_content("Widget Z Name")
      end

      scenario "finds the second page of Widgets with `per` count" do
        visit "/backend/widgets?page=2&per=3"

        expect(page).not_to have_content("Widget A Name")
        expect(page).not_to have_content("Widget C Name")

        expect(page).to have_content("Widget D Name")
        expect(page).to have_content("Widget F Name")

        expect(page).not_to have_content("Widget G Name")
        expect(page).not_to have_content("Widget Z Name")
      end

      scenario "finds nothing outside the count" do
        visit "/backend/widgets?page=2&per=26"

        expect(page).to have_content("No widgets found.")

        expect(page).not_to have_content("Widget A Name")
        expect(page).not_to have_content("Widget Z Name")
      end
    end

    describe "excludes" do
      scenario "deleted Widgets" do
        create(:widget, :deleted, name: "Deleted Widget Name")

        visit "/backend/widgets"

        expect(page).not_to have_content("Deleted Widget Name")
      end
    end
  end
end
