# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Backend - Pages (HTML)", type: :feature do
  describe "creation" do
    before { stub_authorization!(profile) }

    let(:profile) { create(:user) }

    describe "successful" do
      scenario "with valid data including meta tags" do
        visit "/backend/pages/new"

        fill_in "Title", with: "Amazing Page"
        fill_in "Slug", with: "amazing"

        page.find("textarea#page_content").set("<p>Content of the page</p>")

        fill_in "Published At", with: Time.now

        within ".form-group.page_metatags" do
          fill_in "Name", with: "description"
          fill_in "Content", with: "Description of the Page"
        end

        click_button "Create Page"

        expect(page).to have_content("Page was successfully created.")
      end
    end
  end
end
