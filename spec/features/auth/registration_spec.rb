# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Auth registration", type: :feature do
  describe "when registration is disabled" do
    before { create(:site, allow_registration: false) }

    it "returns a 404" do
      visit "/account/register"

      expect(page.status_code).to eq 404
    end
  end

  describe "when registration is enabled" do
    before do
      create(:site, allow_registration: true)

      create(:page, :homepage, content: "Welcome to the homepage")
    end

    it "has additional Name form field label" do
      visit "/account/register"

      expect(page).to have_text "Name"
    end

    it "has additional Username form field label" do
      visit "/account/register"

      expect(page).to have_text "Username"
    end

    it "has additional `name` form field" do
      visit "/account/register"

      expect(page).to have_selector("input[type=text][id='user_name']")
    end

    it "has additional `username` form field" do
      visit "/account/register"

      expect(page).to have_selector("input[type=text][id='user_username']")
    end

    it "allows successful registration" do
      visit "/account/register"

      fill_in_registration_form_with("John Doe", "john_doe", "me@example.com",
                                     "password")
      click_button "Sign up"

      expect(page).to have_content("Welcome to the homepage")
    end
  end
end
