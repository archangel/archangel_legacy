# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Liquid custom variables", type: :feature do
  let(:site) { create(:site) }

  let(:resource_content) do
    %(
      Page Title: {{ page.title }}
      Page Permalink: {{ page.permalink }}
      Page Published At: {{ page.published_at }}
      Page Unknown: >{{ page.unknown_variable }}<
    )
  end

  before do
    create(:page, site: site,
                  slug: "amazing",
                  title: "Amazing Page Title",
                  content: resource_content,
                  published_at: "2019-04-22 03:09:40 UTC")
  end

  describe "for `page` variable object" do
    it "knows the `page` title property" do
      visit "/amazing"

      expect(page).to have_content("Page Title: Amazing Page Title")
    end

    it "knows the `page` permalink property" do
      visit "/amazing"

      expect(page).to have_content("Page Permalink: /amazing")
    end

    it "knows the `page` published_at property" do
      visit "/amazing"

      expect(page).to have_content("Page Published At: 2019-04-22 03:09:40 UTC")
    end

    it "returns blank value for unknown `page` properties" do
      visit "/amazing"

      expect(page).to have_content("Page Unknown: ><")
    end
  end
end
