# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Pages (HTML)", type: :feature do
  describe "listing" do
    before { stub_authorization!(profile) }

    let(:profile) { create(:user) }

    before do
      ("A".."Z").each { |letter| create(:page, title: "Page #{letter} Title") }
    end

    describe "sorted" do
      scenario "ascending from A-Z (default)" do
        visit "/backend/pages"

        within("tbody") do
          expect(page.find("tr:eq(1)")).to have_content("Page A Title")
          expect(page.find("tr:eq(2)")).to have_content("Page B Title")
          expect(page.find("tr:eq(3)")).to have_content("Page C Title")
        end
      end
    end

    describe "paginated" do
      scenario "finds the second page of Pages" do
        visit "/backend/pages?page=2"

        expect(page).not_to have_content("Page A Title")
        expect(page).not_to have_content("Page X Title")

        expect(page).to have_content("Page Y Title")
        expect(page).to have_content("Page Z Title")
      end

      scenario "finds the second page of Pages with `per` count" do
        visit "/backend/pages?page=2&per=3"

        expect(page).not_to have_content("Page A Title")
        expect(page).not_to have_content("Page C Title")

        expect(page).to have_content("Page D Title")
        expect(page).to have_content("Page F Title")

        expect(page).not_to have_content("Page G Title")
        expect(page).not_to have_content("Page Z Title")
      end

      scenario "finds nothing outside the count" do
        visit "/backend/pages?page=2&per=26"

        expect(page).to have_content("No pages found.")

        expect(page).not_to have_content("Page A Title")
        expect(page).not_to have_content("Page Z Title")
      end
    end

    describe "excludes" do
      scenario "deleted Pages" do
        create(:page, :deleted, title: "Deleted Page Title")

        visit "/backend/pages"

        expect(page).not_to have_content("Deleted Page Title")
      end
    end
  end
end
