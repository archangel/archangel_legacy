# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Site (HTML)", type: :feature do
  describe "show" do
    before { stub_authorization!(profile) }

    let!(:site) { create(:site, name: "Amazing Site", theme: "default") }

    let(:profile) do
      create(:user, :admin, email: "amazing@example.com",
                            name: "Amazing User",
                            username: "amazing")
    end

    describe "successful" do
      scenario "finds the Site" do
        visit "/backend/site"

        expect(page).to have_content("Name: Amazing Site")
        expect(page).to have_content("Theme: default")
        expect(page).to have_content("Locale: en")
      end

      scenario "has default Logo for the Site" do
        visit "/backend/site"

        expect(page)
          .to have_css("img[src^='/assets/archangel/fallback/small_logo']")
        expect(page).to have_css("img[alt='Amazing Site']")
      end
    end
  end
end
