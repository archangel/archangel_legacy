# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Collection Entry (HTML)", type: :feature do
  describe "show" do
    before { stub_authorization! }

    let(:collection) { create(:collection, slug: "amazing") }

    describe "is available" do
      before do
        create(:field, collection: collection,
                       label: "Field Name",
                       slug: "name")
        create(:field, collection: collection,
                       label: "Field Slug",
                       slug: "slug")
      end

      let(:resource) do
        create(:entry, collection: collection,
                       value: {
                         name: "Entry Name",
                         slug: "entry-slug"
                       })
      end

      it "finds the Entry name" do
        visit "/backend/collections/amazing/entries/#{resource.id}"

        expect(page).to have_content("name: Entry Name")
      end

      it "finds the Entry slug" do
        visit "/backend/collections/amazing/entries/#{resource.id}"

        expect(page).to have_content("slug: entry-slug")
      end
    end

    describe "is not available" do
      it "returns 404 status when it does not exist" do
        visit "/backend/collections/amazing/entries/0"

        expect(page)
          .to have_content("Page not found. Could not find what was requested")
      end

      it "return error message when deleted" do
        resource = create(:entry, :deleted,
                          collection: collection,
                          value: { name: "Entry Name", slug: "entry-slug" })

        visit "/backend/collections/amazing/entries/#{resource.id}"

        expect(page)
          .to have_content("Page not found. Could not find what was requested")
      end
    end
  end
end
