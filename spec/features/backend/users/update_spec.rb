# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Backend - Users (HTML)", type: :feature do
  describe "updating" do
    before { stub_authorization!(profile) }

    let(:profile) { create(:user) }

    describe "successful" do
      scenario "with valid data" do
        create(:user, username: "amazing")

        visit "/backend/users/amazing/edit"

        fill_in "Username", with: "grace"

        click_button "Update User"

        expect(page).to have_content("User was successfully updated.")
      end
    end

    describe "unsuccessful" do
      scenario "with used email" do
        create(:user, username: "amazing", email: "amazing@example.com")
        create(:user, username: "grace", email: "grace@example.com")

        visit "/backend/users/amazing/edit"

        fill_in "Email", with: "grace@example.com"

        click_button "Update User"

        expect(page.find(".input.user_email"))
          .to have_content("has already been taken")

        expect(page).not_to have_content("User was successfully updated.")
      end

      scenario "with used username" do
        create(:user, username: "amazing", email: "amazing@example.com")
        create(:user, username: "grace", email: "grace@example.com")

        visit "/backend/users/amazing/edit"

        fill_in "Username", with: "grace"

        click_button "Update User"

        expect(page.find(".input.user_username"))
          .to have_content("has already been taken")

        expect(page).not_to have_content("User was successfully updated.")
      end
    end
  end
end
