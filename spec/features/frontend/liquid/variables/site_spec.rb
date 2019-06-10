# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Liquid custom variables", type: :feature do
  let(:site) { create(:site, name: "Site A", locale: "en") }

  let(:resource_content) do
    %(
      Site Name: {{ site.name }}
      Site Locale: {{ site.locale }}
      Site Logo: {{ site.logo }}
      Site Unknown: >{{ site.unknown_variable }}<
    )
  end

  before do
    create(:page, site: site, slug: "amazing", content: resource_content)
  end

  describe "for `site` variable object" do
    it "knows the `site` name" do
      visit "/amazing"

      expect(page).to have_content("Site Name: Site A")
    end

    it "knows the `site` locale" do
      visit "/amazing"

      expect(page).to have_content("Site Locale: en")
    end

    it "knows the `site` logo" do
      visit "/amazing"

      expect(page).to have_content("Site Logo: #{site.logo}")
    end

    it "returns blank for unknown `site` properties" do
      visit "/amazing"

      expect(page).to have_content("Site Unknown: ><")
    end
  end
end
