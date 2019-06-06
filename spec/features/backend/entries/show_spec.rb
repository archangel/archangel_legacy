# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Backend - Collection Entry (HTML)", type: :feature do
  describe "show" do
    before { stub_authorization!(profile) }

    let(:profile) { create(:user) }

    let!(:collection) { create(:collection, slug: "amazing") }

    describe "is available" do
      scenario "finds the Entry" do
        create(:field, collection: collection,
                       label: "Field Name",
                       slug: "name")
        create(:field, collection: collection,
                       label: "Field Slug",
                       slug: "slug")

        resource = create(:entry, collection: collection,
                                  value: {
                                    name: "Available Entry",
                                    slug: "available"
                                  })

        visit "/backend/collections/amazing/entries/#{resource.id}"

        expect(page).to have_content("name: Available Entry")
        expect(page).to have_content("slug: available")
      end
    end

    describe "is not available" do
      scenario "when it does not exist" do
        visit "/backend/collections/amazing/entries/0"

        expect(page)
          .to have_content("Page not found. Could not find what was requested")
      end

      scenario "when deleted" do
        resource = create(:entry, :deleted, collection: collection,
                                            value: {
                                              name: "Available Entry",
                                              slug: "available"
                                            })

        visit "/backend/collections/amazing/entries/#{resource.id}"

        expect(page)
          .to have_content("Page not found. Could not find what was requested")
      end
    end
  end
end
