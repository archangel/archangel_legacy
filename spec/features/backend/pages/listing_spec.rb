# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Pages (HTML)", type: :feature do
  describe "listing" do
    before do
      stub_authorization!

      ("A".."Z").each { |letter| create(:page, title: "Page #{letter} Title") }
    end

    describe "sorted ascending from A-Z (default)" do
      it "lists the first resource" do
        visit "/backend/pages"

        within("tbody") do
          expect(page.find("tr:eq(1)")).to have_content("Page A Title")
        end
      end

      it "lists the second resource" do
        visit "/backend/pages"

        within("tbody") do
          expect(page.find("tr:eq(2)")).to have_content("Page B Title")
        end
      end

      it "lists the third resource" do
        visit "/backend/pages"

        within("tbody") do
          expect(page.find("tr:eq(3)")).to have_content("Page C Title")
        end
      end
    end

    describe "paginated" do
      it "finds the second page of Pages" do
        visit "/backend/pages?page=2"

        expect(page).to have_content("Page Y Title")
      end

      it "does not find the first page of Pages with `per` count" do
        visit "/backend/pages?page=2&per=3"

        expect(page).not_to have_content("Page A Title")
      end

      it "finds the second page of Pages with `per` count" do
        visit "/backend/pages?page=2&per=3"

        expect(page).to have_content("Page D Title")
      end

      it "finds nothing outside the count" do
        visit "/backend/pages?page=2&per=26"

        expect(page).to have_content("No pages found.")
      end
    end

    describe "excludes" do
      it "does not list deleted Pages" do
        create(:page, :deleted, title: "Deleted Page Title")

        visit "/backend/pages"

        expect(page).not_to have_content("Deleted Page Title")
      end
    end
  end
end
