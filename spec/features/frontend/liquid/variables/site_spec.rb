# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Liquid custom variables", type: :feature do
  let!(:site) { create(:site, name: "Site A", locale: "en") }

  describe "for `site` variable object" do
    it "knows the `site` properties" do
      content = <<-CONTENT
        Site Name: {{ site.name }}
        Site Locale: {{ site.locale }}
        Site Logo: {{ site.logo }}
        Site Unknown: >{{ site.unknown_variable }}<
      CONTENT

      create(:page, site: site, slug: "foo", content: content)

      visit "/foo"

      expect(page).to have_content("Site Name: Site A")
      expect(page).to have_content("Site Locale: en")
      expect(page).to have_content("Site Logo: #{site.logo}")
      expect(page).to have_content("Site Unknown: ><")
    end
  end
end
