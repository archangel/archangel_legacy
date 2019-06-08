# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Designs (HTML)", type: :feature do
  describe "listing" do
    before do
      stub_authorization!

      ("A".."Z").each do |letter|
        create(:design, name: "Design #{letter} Name")
      end
    end

    describe "sorted ascending from A-Z (default)" do
      it "displays the first resource" do
        visit "/backend/designs"

        within("tbody") do
          expect(page.find("tr:eq(1)")).to have_content("Design A Name")
        end
      end

      it "displays the second resource" do
        visit "/backend/designs"

        within("tbody") do
          expect(page.find("tr:eq(2)")).to have_content("Design B Name")
        end
      end

      it "displays the third resource" do
        visit "/backend/designs"

        within("tbody") do
          expect(page.find("tr:eq(3)")).to have_content("Design C Name")
        end
      end
    end

    describe "paginated" do
      it "finds the second page of Designs" do
        visit "/backend/designs?page=2"

        expect(page).to have_content("Design Y Name")
      end

      it "does not find the first page of Designs with `per` count" do
        visit "/backend/designs?page=2&per=3"

        expect(page).not_to have_content("Design A Name")
      end

      it "finds the second page of Designs with `per` count" do
        visit "/backend/designs?page=2&per=3"

        expect(page).to have_content("Design D Name")
      end

      it "finds nothing outside the count" do
        visit "/backend/designs?page=2&per=26"

        expect(page).to have_content("No designs found.")
      end
    end

    describe "excludes" do
      it "does not list deleted Designs" do
        create(:design, :deleted, name: "Deleted Design Name")

        visit "/backend/designs"

        expect(page).not_to have_content("Deleted Design Name")
      end
    end
  end
end
