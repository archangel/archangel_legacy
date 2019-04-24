# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Liquid custom variables", type: :feature do
  let!(:site) { create(:site) }

  describe "for `page` variable object" do
    it "knows the `page` properties" do
      content = <<-CONTENT
        Page ID: {{ page.id }}
        Page Title: {{ page.title }}
        Page Permalink: {{ page.permalink }}
        Page Published At: {{ page.published_at }}
        Page Unknown: >{{ page.unknown_variable }}<
      CONTENT

      resource = create(:page, site: site,
                               slug: "foo",
                               title: "Foo Page Title",
                               content: content,
                               published_at: "2019-04-22 03:09:40 UTC")

      visit "/foo"

      expect(page).to have_content("Page ID: #{resource.id}")
      expect(page).to have_content("Page Title: Foo Page Title")
      expect(page).to have_content("Page Permalink: /foo")
      expect(page).to have_content("Page Published At: 2019-04-22 03:09:40 UTC")
      expect(page).to have_content("Page Unknown: ><")
    end
  end
end
