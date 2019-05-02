# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Backend - Collections (HTML)", type: :feature do
  describe "creation" do
    before { stub_authorization!(profile) }

    let(:profile) { create(:user) }

    describe "successful" do
      scenario "with valid data for a full collection" do
        visit "/backend/collections/new"

        fill_in "Name", with: "Amazing Collection"
        page.find("input#collection_slug").set("amazing")

        within ".form-group.collection_fields" do
          select "String", from: "Classification"

          fill_in "Label", with: "Name"
          fill_in "Slug", with: "name"
        end

        click_button "Create Collection"

        expect(page).to have_content("Collection was successfully created.")
      end
    end

    describe "unsuccessful" do
      scenario "without Collection name" do
        visit "/backend/collections/new"

        fill_in "Name", with: ""
        page.find("input#collection_slug").set("amazing")

        within ".form-group.collection_fields" do
          select "String", from: "Classification"

          fill_in "Label", with: "Name"
          fill_in "Slug", with: "name"
        end

        click_button "Create Collection"

        expect(page.find(".input.collection_name"))
          .to have_content("can't be blank")
      end

      scenario "without Collection slug" do
        visit "/backend/collections/new"

        fill_in "Name", with: "Amazing Collection"
        page.find("input#collection_slug").set("")

        within ".form-group.collection_fields" do
          select "String", from: "Classification"

          fill_in "Label", with: "Name"
          fill_in "Slug", with: "name"
        end

        click_button "Create Collection"

        expect(page.find(".input.collection_slug"))
          .to have_content("can't be blank")
      end

      scenario "with repeated Collection slug" do
        create(:collection, slug: "amazing")

        visit "/backend/collections/new"

        fill_in "Name", with: "Amazing Collection"
        page.find("input#collection_slug").set("amazing")

        within ".form-group.collection_fields" do
          select "String", from: "Classification"

          fill_in "Label", with: "Name"
          fill_in "Slug", with: "name"
        end

        click_button "Create Collection"

        expect(page.find(".input.collection_slug"))
          .to have_content("has already been taken")
      end

      scenario "without any Field data" do
        visit "/backend/collections/new"

        fill_in "Name", with: "Amazing Collection"
        page.find("input#collection_slug").set("amazing")

        click_button "Create Collection"

        within ".form-group.collection_fields" do
          expect(page.find(".input.collection_fields_label"))
            .to have_content("can't be blank")
          expect(page.find(".input.collection_fields_slug"))
            .to have_content("can't be blank")
        end
      end

      scenario "without Field label" do
        visit "/backend/collections/new"

        fill_in "Name", with: "Amazing Collection"
        page.find("input#collection_slug").set("amazing")

        within ".form-group.collection_fields" do
          select "String", from: "Classification"

          fill_in "Label", with: ""
          fill_in "Slug", with: "name"
        end

        click_button "Create Collection"

        within ".form-group.collection_fields" do
          expect(page.find(".input.collection_fields_label"))
            .to have_content("can't be blank")
        end
      end

      scenario "without Field slug" do
        visit "/backend/collections/new"

        fill_in "Name", with: "Amazing Collection"
        page.find("input#collection_slug").set("amazing")

        within ".form-group.collection_fields" do
          select "String", from: "Classification"

          fill_in "Label", with: "Name"
          fill_in "Slug", with: ""
        end

        click_button "Create Collection"

        within ".form-group.collection_fields" do
          expect(page.find(".input.collection_fields_slug"))
            .to have_content("can't be blank")
        end
      end
    end
  end
end
