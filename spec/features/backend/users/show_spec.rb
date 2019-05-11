# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Backend - User (HTML)", type: :feature do
  describe "show" do
    before { stub_authorization!(profile) }

    let(:profile) { create(:user) }

    describe "is available" do
      scenario "finds the User" do
        create(:user, username: "amazing",
                      email: "amazing@example.com",
                      name: "Amazing User")

        visit "/backend/users/amazing"

        expect(page).to have_content("Name: Amazing User")
        expect(page).to have_content("Username: amazing")
        expect(page).to have_content("Email: amazing@example.com")
      end

      scenario "has the default Avatar" do
        create(:user, username: "amazing")

        visit "/backend/users/amazing"

        expect(page)
          .to have_css("img[src^='/assets/archangel/fallback/small_avatar']")
        expect(page).to have_css("img[alt='amazing']")
      end

      scenario "has the default Avatar" do
        create(:user, :avatar, username: "amazing")

        visit "/backend/users/amazing"

        expect(page).to have_css(
          "img[src^='/uploads/archangel/user/avatar/2/small_avatar']"
        )
        expect(page).to have_css("img[alt='amazing']")
      end
    end

    describe "is not available" do
      scenario "when it does not exist" do
        visit "/backend/users/unknown"

        expect(page)
          .to have_content("Page not found. Could not find what was requested")
      end

      scenario "when deleted" do
        create(:user, :deleted, username: "deleted", name: "Deleted User Name")

        visit "/backend/users/deleted"

        expect(page)
          .to have_content("Page not found. Could not find what was requested")
      end
    end
  end
end
