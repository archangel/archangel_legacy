# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Profile (HTML)", type: :feature do
  describe "show" do
    before { stub_authorization!(profile) }

    let(:profile) do
      create(:user, :admin, email: "amazing@example.com",
                            name: "Amazing User",
                            username: "amazing")
    end

    it "returns 200 status" do
      visit "/backend/profile"

      expect(page.status_code).to eq 200
    end

    it "has correct Name" do
      visit "/backend/profile"

      expect(page).to have_content("Name: Amazing User")
    end

    it "has correct Username" do
      visit "/backend/profile"

      expect(page).to have_content("Username: amazing")
    end

    it "has correct Email" do
      visit "/backend/profile"

      expect(page).to have_content("Email: amazing@example.com")
    end

    it "uses default avatar" do
      visit "/backend/profile"

      expect(page)
        .to have_css("img[src^='/assets/archangel/fallback/small_avatar']")
    end
  end
end
