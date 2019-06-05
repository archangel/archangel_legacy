# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Collection (HTML)", type: :feature do
  describe "show" do
    before { stub_authorization!(profile) }

    let(:profile) { create(:user) }

    describe "is available" do
      scenario "finds the Collection" do
        create(:collection, slug: "amazing", name: "Amazing Collection")

        visit "/backend/collections/amazing"

        expect(page).to have_content("Name: Amazing Collection")
        expect(page).to have_content("Slug: amazing")
      end
    end

    describe "is not available" do
      scenario "when it does not exist" do
        visit "/backend/collections/unknown"

        expect(page)
          .to have_content("Page not found. Could not find what was requested")
      end

      scenario "when deleted" do
        create(:collection, :deleted, slug: "deleted-collection",
                                      name: "Deleted Collection Name")

        visit "/backend/collections/deleted-collection"

        expect(page)
          .to have_content("Page not found. Could not find what was requested")
      end
    end
  end
end
