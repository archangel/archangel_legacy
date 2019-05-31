# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Backend - Collection Entries (HTML)", type: :feature do
  describe "creation" do
    before { stub_authorization!(profile) }

    let(:profile) { create(:user) }

    describe "successful" do
      let!(:collection) { create(:collection, slug: "amazing") }

      let!(:field_name) do
        create(:field, collection: collection, label: "Name", slug: "name")
      end
      let!(:field_slug) do
        create(:field, collection: collection,
                       label: "Slug",
                       slug: "slug",
                       required: true)
      end
      let!(:field_email) do
        create(:field, collection: collection,
                       classification: "email",
                       label: "Email",
                       slug: "email")
      end

      scenario "with valid data for a full collection" do
        visit "/backend/collections/amazing/entries/new"

        fill_in "Name", with: "Really Good Entry Item"
        fill_in "Slug", with: "really-good-entry-item"
        fill_in "Email", with: "foo@example.com"
        fill_in "Published At", with: "2019-01-01 00:00:00"

        click_button "Create Entry"

        expect(page).to have_content("Entry was successfully created.")
      end

      scenario "when non-required field is empty" do
        visit "/backend/collections/amazing/entries/new"

        fill_in "Slug", with: "really-good-entry-item"

        click_button "Create Entry"

        expect(page).to have_content("Entry was successfully created.")
      end
    end

    describe "unsuccessful" do
      let!(:collection) { create(:collection, slug: "amazing") }

      let!(:field_required) do
        create(:field, collection: collection,
                       label: "Required Field",
                       slug: "required_field",
                       required: true)
      end
      let!(:field_boolean) do
        create(:field, collection: collection,
                       classification: "boolean",
                       label: "Boolean Field",
                       slug: "boolean_field")
      end
      let!(:field_email) do
        create(:field, collection: collection,
                       classification: "email",
                       label: "Email Field",
                       slug: "email_field")
      end
      let!(:field_integer) do
        create(:field, collection: collection,
                       classification: "integer",
                       label: "Integer Field",
                       slug: "integer_field")
      end
      let!(:field_string) do
        create(:field, collection: collection,
                       classification: "string",
                       label: "String Field",
                       slug: "string_field")
      end
      let!(:field_url) do
        create(:field, collection: collection,
                       classification: "url",
                       label: "URL Field",
                       slug: "url_field")
      end

      scenario "without value for required field" do
        visit "/backend/collections/amazing/entries/new"

        fill_in "Required Field", with: ""

        click_button "Create Entry"

        expect(page).to_not have_content("Entry was successfully created.")

        expect(page.find(".input.collection_entry_required_field"))
          .to have_content("can't be blank")
      end

      scenario "without valid email for email field" do
        visit "/backend/collections/amazing/entries/new"

        fill_in "Required Field", with: "Amazing Required Value"
        fill_in "Email Field", with: "not an email address"

        click_button "Create Entry"

        expect(page).to_not have_content("Entry was successfully created.")

        expect(page.find(".input.collection_entry_email_field"))
          .to have_content("not a valid email address")
      end

      scenario "without valid integer for integer field" do
        visit "/backend/collections/amazing/entries/new"

        fill_in "Required Field", with: "Amazing Required Value"
        fill_in "Integer Field", with: "not an integer"

        click_button "Create Entry"

        expect(page).to_not have_content("Entry was successfully created.")

        expect(page.find(".input.collection_entry_integer_field"))
          .to have_content("not a valid integer")
      end

      scenario "without valid URL for URL field" do
        visit "/backend/collections/amazing/entries/new"

        fill_in "Required Field", with: "Amazing Required Value"
        fill_in "URL Field", with: "not a valid URL"

        click_button "Create Entry"

        expect(page).to_not have_content("Entry was successfully created.")

        expect(page.find(".input.collection_entry_url_field"))
          .to have_content("not a valid URL")
      end
    end
  end
end
