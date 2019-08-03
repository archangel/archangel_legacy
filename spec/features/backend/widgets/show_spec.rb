# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Widget (HTML)", type: :feature do
  describe "show" do
    before { stub_authorization! }

    context "when available" do
      before do
        create(:widget, name: "Amazing Widget",
                        slug: "amazing",
                        content: "Content of the Widget")
      end

      it "has the correct Name" do
        visit "/backend/widgets/amazing"

        expect(page).to have_content("Name: Amazing Widget")
      end

      it "has the correct Slug" do
        visit "/backend/widgets/amazing"

        expect(page).to have_content("Slug: amazing")
      end
    end

    context "when not available" do
      it "fails when it does not exist" do
        visit "/backend/widgets/unknown"

        expect(page)
          .to have_content("Page not found. Could not find what was requested")
      end

      it "fails when deleted" do
        create(:widget, :deleted, slug: "deleted-widget")

        visit "/backend/widgets/deleted-widget"

        expect(page)
          .to have_content("Page not found. Could not find what was requested")
      end
    end
  end
end
