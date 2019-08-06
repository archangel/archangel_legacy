# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Design (HTML)", type: :feature do
  describe "show" do
    before { stub_authorization!(profile) }

    let(:profile) { create(:user) }

    describe "is available" do
      let(:resource) do
        create(:design, name: "Amazing Design",
                        content: "Content of the Design")
      end

      it "finds the Design name" do
        visit "/backend/designs/#{resource.id}"

        expect(page).to have_content("Name: Amazing Design")
      end

      it "finds the Design Partial" do
        visit "/backend/designs/#{resource.id}"

        expect(page).to have_content("Partial: false")
      end
    end

    describe "is not available" do
      it "returns 404 when it does not exist" do
        visit "/backend/designs/0"

        expect(page)
          .to have_content("Page not found. Could not find what was requested")
      end

      it "returns 404 when it is deleted" do
        resource = create(:design, :deleted, name: "Deleted Design Name")

        visit "/backend/designs/#{resource.id}"

        expect(page)
          .to have_content("Page not found. Could not find what was requested")
      end
    end
  end
end
