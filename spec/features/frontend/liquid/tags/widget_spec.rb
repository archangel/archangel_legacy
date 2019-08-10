# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Liquid custom tags", type: :feature do
  describe "for `widget` tag" do
    let(:design) do
      create(:design, :partial,
             content: "BEFORE {{ content_for_layout }} AFTER")
    end

    before { create(:site) }

    it "returns content with valid Widget slug" do
      create(:widget, slug: "amazing", content: "Good stuff")
      create(:page, slug: "amazing", content: "~{% widget 'amazing' %}~")

      visit "/amazing"

      expect(page.body).to include("~Good stuff~")
    end

    it "returns content with Widget design" do
      create(:widget, design: design, slug: "amazing", content: "Good stuff")
      create(:page, slug: "amazing", content: "~{% widget 'amazing' %}~")

      visit "/amazing"

      expect(page.body).to include("~BEFORE Good stuff AFTER~")
    end

    it "returns nothing for unknown widget" do
      create(:page, slug: "amazing", content: "~{% widget 'unknown' %}~")

      visit "/amazing"

      expect(page.body).to include("~~")
    end
  end
end
