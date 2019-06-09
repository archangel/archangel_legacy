# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Collections (HTML)", type: :feature do
  def fill_in_collection_form_with(name = "", slug = "")
    fill_in "Name", with: name
    page.find("input#collection_slug").set(slug)
  end

  def fill_in_field_form_with(label = "", slug = "", classification = "String")
    within ".form-group.collection_fields" do
      select classification, from: "Classification"
      fill_in "Label", with: label
      fill_in "Slug", with: slug
    end
  end

  describe "creation" do
    before { stub_authorization! }

    describe "successful" do
      it "returns successful message with valid data" do
        visit "/backend/collections/new"

        fill_in_collection_form_with("Amazing Collection", "amazing")
        fill_in_field_form_with("Name", "name", "String")
        click_button "Create Collection"

        expect(page).to have_content("Collection was successfully created.")
      end
    end

    describe "unsuccessful" do
      it "fails without Collection name" do
        visit "/backend/collections/new"

        fill_in_collection_form_with("", "amazing")
        fill_in_field_form_with("Name", "name", "String")
        click_button "Create Collection"

        expect(page.find(".input.collection_name"))
          .to have_content("can't be blank")
      end

      it "fails without Collection slug" do
        visit "/backend/collections/new"

        fill_in_collection_form_with("Amazing Collection", "")
        fill_in_field_form_with("Name", "name", "String")
        click_button "Create Collection"

        expect(page.find(".input.collection_slug"))
          .to have_content("can't be blank")
      end

      it "fails with repeated Collection slug" do
        create(:collection, slug: "amazing")

        visit "/backend/collections/new"

        fill_in_collection_form_with("Amazing Collection", "amazing")
        fill_in_field_form_with("Name", "name", "String")
        click_button "Create Collection"

        expect(page.find(".input.collection_slug"))
          .to have_content("has already been taken")
      end

      it "fails without Field label" do
        visit "/backend/collections/new"

        fill_in_collection_form_with("Amazing Collection", "amazing")
        fill_in_field_form_with("", "name", "String")
        click_button "Create Collection"

        within ".form-group.collection_fields" do
          expect(page.find(".input.collection_fields_label"))
            .to have_content("can't be blank")
        end
      end

      it "fails without Field slug" do
        visit "/backend/collections/new"

        fill_in_collection_form_with("Amazing Collection", "amazing")
        fill_in_field_form_with("Name", "", "String")
        click_button "Create Collection"

        within ".form-group.collection_fields" do
          expect(page.find(".input.collection_fields_slug"))
            .to have_content("can't be blank")
        end
      end
    end
  end
end
