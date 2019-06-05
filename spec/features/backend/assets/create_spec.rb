# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Assets (HTML)", type: :feature do
  describe "creation" do
    before { stub_authorization!(profile) }

    let(:profile) { create(:user) }

    describe "successful" do
      scenario "with valid data for a full asset" do
        visit "/backend/assets/new"

        fill_in "File Name", with: "amazing.jpg"
        attach_file "File", uploader_test_image

        click_button "Create Asset"

        expect(page).to have_content("Asset was successfully created.")
      end
    end

    describe "unsuccessful" do
      scenario "without file name" do
        visit "/backend/assets/new"

        fill_in "File Name", with: ""
        attach_file "File", uploader_test_image

        click_button "Create Asset"

        expect(page.find(".input.asset_file_name"))
          .to have_content("can't be blank")

        expect(page).not_to have_content("Asset was successfully created.")
      end

      scenario "without file" do
        visit "/backend/assets/new"

        fill_in "File Name", with: "amazing.jpg"

        click_button "Create Asset"

        expect(page.find(".input.asset_file"))
          .to have_content("can't be blank")

        expect(page).not_to have_content("Asset was successfully created.")
      end

      scenario "with invalid file name" do
        visit "/backend/assets/new"

        fill_in "File Name", with: "foo"
        attach_file "File", uploader_test_image

        click_button "Create Asset"

        expect(page.find(".input.asset_file_name"))
          .to have_content("must be valid file name")

        expect(page).not_to have_content("Asset was successfully created.")
      end

      scenario "with invalid file type" do
        visit "/backend/assets/new"

        fill_in "File Name", with: "foo"
        attach_file "File", uploader_test_stylesheet

        click_button "Create Asset"

        expect(page.find(".input.asset_file")).to have_content(
          "You are not allowed to upload \"css\" files, allowed types: " \
          "gif, jpeg, jpg, png"
        )

        expect(page).not_to have_content("Asset was successfully created.")
      end
    end
  end
end
