# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Liquid custom variable", type: :feature do
  let!(:site) { create(:site) }

  describe "for `current_page` variable" do
    it "knows the current page at root level" do
      create(:page, site: site,
                    slug: "foo",
                    content: "Current Page: {{ current_page }}")

      visit "/foo"

      expect(page).to have_content("Current Page: /foo")
    end

    it "knows the current page at child level" do
      parent_resource = create(:page, site: site, slug: "foo")
      create(:page, site: site,
                    parent: parent_resource,
                    slug: "bar",
                    content: "Current Page: {{ current_page }}")

      visit "/foo/bar"

      expect(page).to have_content("Current Page: /foo/bar")
    end

    it "knows it is on the current page" do
      content = <<-CONTENT
        {% if current_page == page.permalink %}
          Current Page?: Yup!
        {% else %}
          Current Page?: Nope!
        {% endif %}
      CONTENT

      create(:page, site: site, slug: "foo", content: content)

      visit "/foo"

      expect(page).to have_content("Current Page?: Yup!")
      expect(page).not_to have_content("Current Page?: Nope!")
    end

    it "knows it is not on the current page" do
      content = <<-CONTENT
        {% if current_page == '/some-other-page' %}
          Current Page?: Yup!
        {% else %}
          Current Page?: Nope!
        {% endif %}
      CONTENT

      create(:page, site: site, slug: "foo", content: content)

      visit "/foo"

      expect(page).not_to have_content("Current Page?: Yup!")
      expect(page).to have_content("Current Page?: Nope!")
    end

    it "knows the current page with all known slug characters" do
      create(:page, site: site,
                    slug: "abcdefghijklmnopqrstuvwxyz0123456789-_",
                    content: "Current Page: {{ current_page }}")

      visit "/abcdefghijklmnopqrstuvwxyz0123456789-_"

      expect(page).to have_content(
        "Current Page: /abcdefghijklmnopqrstuvwxyz0123456789-_"
      )
    end
  end
end
