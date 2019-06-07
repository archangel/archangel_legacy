# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Liquid custom variables", type: :feature do
  let(:site) { create(:site) }

  describe "for unknown variables" do
    it "responds with blank value" do
      create(:page, site: site,
                    slug: "amazing",
                    content: "Unknown Variable: ~{{ unknown_variable }}~")

      visit "/amazing"

      expect(page).to have_content("Unknown Variable: ~~")
    end
  end
end
