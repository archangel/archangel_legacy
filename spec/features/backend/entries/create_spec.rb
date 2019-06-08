# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Collection Entries (HTML)", type: :feature do
  describe "creation" do
    before { stub_authorization! }

    let(:collection) { create(:collection, slug: "amazing") }

    describe "successful" do
      before do
        create(:field, collection: collection, label: "Name", slug: "name")
        create(:field, collection: collection, label: "Slug", slug: "slug",
                       required: true)
      end

      it "returns success message with valid data" do
        visit "/backend/collections/amazing/entries/new"

        fill_in "Name", with: "Archgabriel"
        fill_in "Slug", with: "gabriel"
        fill_in "Published At", with: "2019-11-24 03:41:18 UTC"
        click_button "Create Entry"

        expect(page).to have_content("Entry was successfully created.")
      end

      it "returns success message when non-required field is empty" do
        visit "/backend/collections/amazing/entries/new"

        fill_in "Name", with: ""
        fill_in "Slug", with: "gabriel"
        fill_in "Published At", with: ""
        click_button "Create Entry"

        expect(page).to have_content("Entry was successfully created.")
      end
    end

    describe "unsuccessful" do
      before do
        create(:field, collection: collection, required: true,
                       label: "Required Field", slug: "required_field")

        %w[boolean email integer string url].each do |field_classification|
          create(:field, collection: collection,
                         classification: field_classification,
                         label: "#{field_classification.titleize} Field",
                         slug: "#{field_classification}_field")
        end
      end

      it "fails without value for required field" do
        visit "/backend/collections/amazing/entries/new"

        fill_in "Required Field", with: ""
        click_button "Create Entry"

        expect(page.find(".input.collection_entry_required_field"))
          .to have_content("can't be blank")
      end

      it "fails without valid email for email field" do
        visit "/backend/collections/amazing/entries/new"

        fill_in "Required Field", with: "Amazing Required Value"
        fill_in "Email Field", with: "me_at_email_dot_com"
        click_button "Create Entry"

        expect(page.find(".input.collection_entry_email_field"))
          .to have_content("not a valid email address")
      end

      it "fails without valid integer for integer field" do
        visit "/backend/collections/amazing/entries/new"

        fill_in "Required Field", with: "Amazing Required Value"
        fill_in "Integer Field", with: "One"
        click_button "Create Entry"

        expect(page.find(".input.collection_entry_integer_field"))
          .to have_content("not a valid integer")
      end

      it "fails without valid URL for url field" do
        visit "/backend/collections/amazing/entries/new"

        fill_in "Required Field", with: "Amazing Required Value"
        fill_in "Url Field", with: "not a valid URL"
        click_button "Create Entry"

        expect(page.find(".input.collection_entry_url_field"))
          .to have_content("not a valid URL")
      end
    end
  end
end
