# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Widgets (HTML)", type: :feature do
  describe "listing" do
    before do
      stub_authorization!

      ("A".."Z").each do |letter|
        create(:widget, name: "Widget #{letter} Name")
      end
    end

    describe "with A-Z sorting (default)" do
      it "returns first ascending" do
        visit "/backend/widgets"

        within("tbody") do
          expect(page.find("tr:eq(1)")).to have_content("Widget A Name")
        end
      end

      it "returns second ascending" do
        visit "/backend/widgets"

        within("tbody") do
          expect(page.find("tr:eq(2)")).to have_content("Widget B Name")
        end
      end

      it "returns third ascending" do
        visit "/backend/widgets"

        within("tbody") do
          expect(page.find("tr:eq(3)")).to have_content("Widget C Name")
        end
      end
    end

    describe "with paginated results" do
      it "does not find the first page of Widgets" do
        visit "/backend/widgets?page=2"

        expect(page).not_to have_content("Widget A Name")
      end

      it "finds the second page of Widgets" do
        visit "/backend/widgets?page=2"

        expect(page).to have_content("Widget Y Name")
      end

      it "does not find the first page of Widgets with `per` count" do
        visit "/backend/widgets?page=2&per=3"

        expect(page).not_to have_content("Widget A Name")
      end

      it "does not find the third page of Widgets with `per` count" do
        visit "/backend/widgets?page=2&per=3"

        expect(page).not_to have_content("Widget G Name")
      end

      it "finds the second page of Widgets with `per` count" do
        visit "/backend/widgets?page=2&per=3"

        expect(page).to have_content("Widget D Name")
      end

      it "finds nothing outside the count" do
        visit "/backend/widgets?page=2&per=26"

        expect(page).to have_content("No widgets found.")
      end
    end

    describe "without deleted Widgetsexcludes" do
      it "does not display" do
        create(:widget, :deleted, name: "Deleted Widget Name")

        visit "/backend/widgets"

        expect(page).not_to have_content("Deleted Widget Name")
      end
    end
  end
end
