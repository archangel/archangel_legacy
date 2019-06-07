# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Liquid custom variable", type: :feature do
  let(:site) { create(:site) }

  describe "for `current_page` variable" do
    it "knows the current page at root level" do
      create(:page, site: site,
                    slug: "amazing",
                    content: "Current Page: {{ current_page }}")

      visit "/amazing"

      expect(page).to have_content("Current Page: /amazing")
    end

    it "knows the current page at child level" do
      parent_resource = create(:page, site: site, slug: "amazing")
      create(:page, site: site, parent: parent_resource,
                    slug: "grace", content: "Current Page: {{ current_page }}")

      visit "/amazing/grace"

      expect(page).to have_content("Current Page: /amazing/grace")
    end

    it "knows it is on the current page" do
      content = %(
        {% if current_page == page.permalink %}
          Current Page?: Yup!
        {% else %}
          Current Page?: Nope!
        {% endif %}
      )

      create(:page, site: site, slug: "amazing", content: content)

      visit "/amazing"

      expect(page).to have_content("Current Page?: Yup!")
    end

    it "knows it is not on the current page" do
      content = %(
        {% if current_page == '/some-other-page' %}
          Current Page?: Yup!
        {% else %}
          Current Page?: Nope!
        {% endif %}
      )

      create(:page, site: site, slug: "amazing", content: content)

      visit "/amazing"

      expect(page).to have_content("Current Page?: Nope!")
    end

    it "knows the current page with all known slug characters" do
      slug = "abcdefghijklmnopqrstuvwxyz0123456789-_"
      create(:page, site: site,
                    slug: slug, content: "Current Page: {{ current_page }}")

      visit "/#{slug}"

      expect(page).to have_content("Current Page: /#{slug}")
    end
  end
end
