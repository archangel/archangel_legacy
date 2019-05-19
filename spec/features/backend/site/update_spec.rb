# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Backend - Site (HTML)", type: :feature do
  describe "updating" do
    before { stub_authorization!(profile) }

    let(:profile) { create(:user, :admin) }

    describe "successful" do
      scenario "with valid data for site" do
        visit "/backend/site/edit"

        fill_in "Name", with: "Amazing Site"

        click_button "Update Site"

        expect(page).to have_content("Site was successfully updated.")
      end

      scenario "with valid data for site with Logo" do
        visit "/backend/site/edit"

        attach_file "Logo", uploader_test_image

        click_button "Update Site"

        expect(page).to have_content("Site was successfully updated.")

        expect(page).to have_css("img[src^='/uploads/archangel/site/logo']")
      end
    end

    describe "unsuccessful" do
      scenario "without name" do
        visit "/backend/site/edit"

        fill_in "Name", with: ""

        click_button "Update Site"

        expect(page.find(".input.site_name"))
          .to have_content("can't be blank")

        expect(page).to_not have_content("Site was successfully created.")
      end
    end
  end
end