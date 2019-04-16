# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Default variables", type: :feature do
  let(:site) { create(:site) }

  describe "for `current_page`" do
    it "knows the current page at root level" do
      content = "Current Page: {{ current_page }}"

      resource = create(:page, site: site, slug: "foo", content: content)

      visit archangel.frontend_page_path(resource.permalink)

      expect(page).to have_content("Current Page: /foo")
    end

    it "knows the current page at child level" do
      content = "Current Page: {{ current_page }}"

      parent_resource = create(:page, site: site, slug: "foo")
      resource = create(:page, site: site,
                               parent: parent_resource,
                               slug: "bar",
                               content: content)

      visit CGI.unescape(archangel.frontend_page_path(resource.permalink))

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

      post = create(:page, site: site, content: content)

      visit archangel.frontend_page_path(post.permalink)

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

      post = create(:page, site: site, content: content)

      visit archangel.frontend_page_path(post.permalink)

      expect(page).not_to have_content("Current Page?: Yup!")
      expect(page).to have_content("Current Page?: Nope!")
    end

    it "knows the current page with all known slug characters" do
      slug = "abcdefghijklmnopqrstuvwxyz0123456789-_"
      content = "Current Page: {{ current_page }}"

      resource = create(:page, site: site, slug: slug, content: content)

      visit archangel.frontend_page_path(resource.permalink)

      expect(page).to have_content("Current Page: /#{slug}")
    end
  end

  describe "for `page`" do
    it "knows the `page` properties" do
      content = <<-CONTENT
        Page ID: {{ page.id }}
        Page Title: {{ page.title }}
        Page Permalink: {{ page.permalink }}
        Page Published At: {{ page.published_at }}
        Page Unknown: ~{{ page.unknown_variable }}~
      CONTENT

      resource = create(:page, site: site, content: content)

      visit archangel.frontend_page_path(resource.permalink)

      expect(page).to have_content("Page ID: #{resource.id}")
      expect(page).to have_content("Page Title: #{resource.title}")
      expect(page).to have_content("Page Permalink: /#{resource.permalink}")
      expect(page)
        .to have_content("Page Published At: #{resource.published_at}")
      expect(page).to have_content("Page Unknown: ~~")
    end
  end

  describe "for `site`" do
    it "knows the `site` properties" do
      content = <<-CONTENT
        Site Name: {{ site.name }}
        Site Locale: {{ site.locale }}
        Site Logo: {{ site.logo }}
        Site Unknown: ~{{ site.unknown_variable }}~
      CONTENT

      resource = create(:page, site: site, content: content)

      visit archangel.frontend_page_path(resource.permalink)

      expect(page).to have_content("Site Name: #{site.name}")
      expect(page).to have_content("Site Locale: #{site.locale}")
      expect(page).to have_content("Site Logo: #{site.logo}")
      expect(page).to have_content("Site Unknown: ~~")
    end
  end

  describe "for general unknown variable" do
    it "responds with blank value" do
      content = "Unknown Variable: ~{{ unknown_variable }}~"

      resource = create(:page, site: site, content: content)

      visit archangel.frontend_page_path(resource.permalink)

      expect(page).to have_content("Unknown Variable: ~~")
    end
  end
end
