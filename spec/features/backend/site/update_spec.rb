# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Site (HTML)", type: :feature do
  describe "updating" do
    before { stub_authorization!(profile) }

    let(:profile) { create(:user, :admin) }

    context "with valid data" do
      it "updates the Site successfully" do
        visit "/backend/site/edit"

        fill_in "Name", with: "Amazing Site"

        click_button "Update Site"

        expect(page).to have_content("Site was successfully updated.")
      end

      it "updates the Site successfully with custom logo" do
        visit "/backend/site/edit"

        attach_file "Logo", uploader_test_image

        click_button "Update Site"

        expect(page).to have_css("img[src^='/uploads/archangel/site/logo']")
      end
    end

    context "with invalid data" do
      it "fails without Site name" do
        visit "/backend/site/edit"

        fill_in "Name", with: ""

        click_button "Update Site"

        expect(page.find(".input.site_name")).to have_content("can't be blank")
      end
    end
  end
end
