# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Users (HTML)", type: :feature do
  describe "creation" do
    before { stub_authorization!(profile) }

    let(:profile) { create(:user) }

    describe "successful" do
      scenario "with valid data" do
        visit "/backend/users/new"

        fill_in "Name", with: "Amazing User"
        fill_in "Username", with: "amazing"
        fill_in "Email", with: "me@example.com"

        click_button "Create User"

        expect(page).to have_content("User was successfully created.")
      end

      scenario "with valid data with Role" do
        visit "/backend/users/new"

        fill_in "Name", with: "Amazing User"
        fill_in "Username", with: "amazing"
        fill_in "Email", with: "me@example.com"

        select "Admin", from: "Role"

        click_button "Create User"

        expect(page).to have_content("User was successfully created.")
      end
    end

    describe "unsuccessful" do
      scenario "without name" do
        visit "/backend/users/new"

        fill_in "Name", with: ""
        fill_in "Username", with: "amazing"
        fill_in "Email", with: "me@example.com"

        click_button "Create User"

        expect(page.find(".input.user_name")).to have_content("can't be blank")

        expect(page).not_to have_content("User was successfully created.")
      end

      scenario "without username" do
        visit "/backend/users/new"

        fill_in "Name", with: "Amazing User"
        fill_in "Username", with: ""
        fill_in "Email", with: "me@example.com"

        click_button "Create User"

        expect(page.find(".input.user_username"))
          .to have_content("can't be blank")

        expect(page).not_to have_content("User was successfully created.")
      end

      scenario "without email" do
        visit "/backend/users/new"

        fill_in "Name", with: "Amazing User"
        fill_in "Username", with: "amazing"
        fill_in "Email", with: ""

        click_button "Create User"

        expect(page.find(".input.user_email")).to have_content("can't be blank")

        expect(page).not_to have_content("User was successfully created.")
      end

      scenario "with used username" do
        create(:user, username: "amazing")

        visit "/backend/users/new"

        fill_in "Name", with: "Amazing User"
        fill_in "Username", with: "amazing"
        fill_in "Email", with: "me@example.com"

        click_button "Create User"

        expect(page.find(".input.user_username"))
          .to have_content("has already been taken")

        expect(page).not_to have_content("User was successfully created.")
      end
    end
  end
end
