# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Backend - Profile (HTML)", type: :feature do
  describe "show" do
    before { stub_authorization!(profile) }

    let(:profile) do
      create(:user, :admin, email: "amazing@example.com",
                            name: "Amazing User",
                            username: "amazing")
    end

    describe "successful" do
      scenario "with valid data for profile" do
        visit "/backend/profile"

        expect(page)
          .to have_css("img[src^='/assets/archangel/fallback/small_avatar']")
        expect(page).to have_css("img[alt='amazing']")

        expect(page).to have_content("Name: Amazing User")
        expect(page).to have_content("Username: amazing")
        expect(page).to have_content("Email: amazing@example.com")
      end
    end
  end
end
