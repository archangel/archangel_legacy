# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Collection (HTML)", type: :feature do
  describe "show" do
    before { stub_authorization! }

    describe "is available" do
      before do
        create(:collection, slug: "amazing", name: "Amazing Collection")
      end

      it "finds the Collection name" do
        visit "/backend/collections/amazing"

        expect(page).to have_content("Name: Amazing Collection")
      end

      it "finds the Collection slug" do
        visit "/backend/collections/amazing"

        expect(page).to have_content("Slug: amazing")
      end
    end

    describe "is not available" do
      it "returns 404 when it does not exist" do
        visit "/backend/collections/unknown"

        expect(page)
          .to have_content("Page not found. Could not find what was requested")
      end

      it "displays error message when deleted" do
        visit "/backend/collections/deleted-collection"

        expect(page)
          .to have_content("Page not found. Could not find what was requested")
      end
    end
  end
end
