# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Page (HTML)", type: :feature do
  describe "show" do
    before { stub_authorization!(profile) }

    let(:profile) { create(:user) }

    describe "is available" do
      scenario "finds the Page" do
        resource = create(:page, title: "Amazing Page",
                                 slug: "amazing",
                                 content: "Content of the Page")

        visit "/backend/pages/#{resource.id}"

        expect(page).to have_content("Title: Amazing Page")
        expect(page).to have_content("Permalink: /amazing")
        expect(page).to have_content("Slug: amazing")
        expect(page).to have_content("Content: Content of the Page")
      end
    end

    describe "is not available" do
      scenario "when it does not exist" do
        visit "/backend/pages/0"

        expect(page)
          .to have_content("Page not found. Could not find what was requested")
      end

      scenario "when deleted" do
        resource = create(:page, :deleted)

        visit "/backend/pages/#{resource.id}"

        expect(page)
          .to have_content("Page not found. Could not find what was requested")
      end
    end
  end
end
