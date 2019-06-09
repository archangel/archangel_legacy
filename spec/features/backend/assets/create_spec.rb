# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Assets (HTML)", type: :feature do
  def fill_in_asset_form_with(file_name = "", file = "")
    fill_in "File Name", with: file_name
    attach_file "File", file unless file.blank?
  end

  describe "creation" do
    before { stub_authorization! }

    describe "successful" do
      it "returns success message with valid data" do
        visit "/backend/assets/new"

        fill_in_asset_form_with("amazing.jpg", uploader_test_image)
        click_button "Create Asset"

        expect(page).to have_content("Asset was successfully created.")
      end
    end

    describe "unsuccessful" do
      it "fails without file_name" do
        visit "/backend/assets/new"

        fill_in_asset_form_with("", uploader_test_image)
        click_button "Create Asset"

        expect(page.find(".input.asset_file_name"))
          .to have_content("can't be blank")
      end

      it "fails without file" do
        visit "/backend/assets/new"

        fill_in_asset_form_with("amazing.jpg", "")
        click_button "Create Asset"

        expect(page.find(".input.asset_file")).to have_content("can't be blank")
      end

      it "fails with invalid file_name" do
        visit "/backend/assets/new"

        fill_in_asset_form_with("amazing", uploader_test_image)

        click_button "Create Asset"

        expect(page.find(".input.asset_file_name"))
          .to have_content("must be valid file name")
      end

      it "fails with invalid file type" do
        visit "/backend/assets/new"

        fill_in_asset_form_with("amazing.jpg", uploader_test_stylesheet)
        click_button "Create Asset"

        expect(page.find(".input.asset_file"))
          .to have_content("You are not allowed to upload \"css\" files")
      end
    end
  end
end
