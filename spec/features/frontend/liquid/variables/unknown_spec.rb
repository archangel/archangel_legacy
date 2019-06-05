# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Liquid custom variables", type: :feature do
  let!(:site) { create(:site, name: "Site A", locale: "en") }

  describe "for unknown variables" do
    it "responds with blank value" do
      create(:page, site: site,
                    slug: "foo",
                    content: "Unknown Variable: ~{{ unknown_variable }}~")

      visit "/foo"

      expect(page).to have_content("Unknown Variable: ~~")
    end
  end
end
