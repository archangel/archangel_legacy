# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Backend - Widget (HTML)", type: :feature do
  describe "show" do
    before { stub_authorization!(profile) }

    let(:profile) { create(:user) }

    describe "is available" do
      scenario "finds the Widget" do
        create(:widget, name: "Amazing Widget",
                        slug: "amazing",
                        content: "Content of the Widget")

        visit "/backend/widgets/amazing"

        expect(page).to have_content("Name: Amazing Widget")
        expect(page).to have_content("Slug: amazing")
        expect(page).to have_content("Content: Content of the Widget")
      end
    end

    describe "is not available" do
      scenario "when it does not exist" do
        visit "/backend/widgets/unknown"

        expect(page)
          .to have_content("Page not found. Could not find what was requested")
      end

      scenario "when deleted" do
        create(:widget, :deleted, slug: "deleted-widget")

        visit "/backend/widgets/deleted-widget"

        expect(page)
          .to have_content("Page not found. Could not find what was requested")
      end
    end
  end
end
