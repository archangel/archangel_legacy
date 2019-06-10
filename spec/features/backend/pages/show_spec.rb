# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Page (HTML)", type: :feature do
  describe "show" do
    before { stub_authorization! }

    describe "is available" do
      let(:resource) do
        create(:page, title: "Amazing Page",
                      slug: "amazing",
                      content: "Content of the Page")
      end

      it "finds the Page title" do
        visit "/backend/pages/#{resource.id}"

        expect(page).to have_content("Title: Amazing Page")
      end

      it "finds the Page permalink" do
        visit "/backend/pages/#{resource.id}"

        expect(page).to have_content("Permalink: /amazing")
      end

      it "finds the Page slug" do
        visit "/backend/pages/#{resource.id}"

        expect(page).to have_content("Slug: amazing")
      end

      it "finds the Page content" do
        visit "/backend/pages/#{resource.id}"

        expect(page).to have_content("Content: Content of the Page")
      end
    end

    describe "is not available" do
      it "returns 404 when it does not exist" do
        visit "/backend/pages/0"

        expect(page)
          .to have_content("Page not found. Could not find what was requested")
      end

      it "returns error message when it is deleted" do
        resource = create(:page, :deleted)

        visit "/backend/pages/#{resource.id}"

        expect(page)
          .to have_content("Page not found. Could not find what was requested")
      end
    end
  end
end
