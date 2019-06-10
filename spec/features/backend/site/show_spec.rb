# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Site (HTML)", type: :feature do
  describe "show" do
    before { stub_authorization!(profile) }

    let(:profile) do
      create(:user, :admin, email: "amazing@example.com",
                            name: "Amazing User",
                            username: "amazing")
    end

    it "returns the correct Site name" do
      create(:site, name: "Amazing Site")

      visit "/backend/site"

      expect(page).to have_content("Name: Amazing Site")
    end

    it "returns the correct Site theme" do
      create(:site, name: "Amazing Site", theme: "default")

      visit "/backend/site"

      expect(page).to have_content("Theme: default")
    end

    it "returns the correct Site locale" do
      create(:site, name: "Amazing Site", locale: "en")

      visit "/backend/site"

      expect(page).to have_content("Locale: en")
    end

    it "returns default Logo image src for the Site" do
      visit "/backend/site"

      expect(page)
        .to have_css("img[src^='/assets/archangel/fallback/small_logo']")
    end
  end
end
