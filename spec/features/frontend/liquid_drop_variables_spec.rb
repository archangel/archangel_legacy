# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Default variables", type: :feature do
  describe "for $current_page" do
    let(:site) { create(:site) }

    it "knows the current page at root level" do
      content = <<-CONTENT
        Current Page: {{ current_page }}
      CONTENT

      post = create(:page, site: site, slug: "foo", content: content)

      visit archangel.frontend_page_path(post.path)

      expect(page).to have_content("Current Page: /foo")
    end

    it "knows the current page at child level" do
      content = <<-CONTENT
        Current Page: {{ current_page }}
      CONTENT

      parent_post = create(:page, site: site, slug: "foo")
      post = create(:page, site: site,
                           parent: parent_post,
                           slug: "bar",
                           content: content)

      visit CGI.unescape(archangel.frontend_page_path(post.path))

      expect(page).to have_content("Current Page: /foo/bar")
    end

    it "knows it is on the current page" do
      content = <<-CONTENT
        {% if current_page == page.path %}
          Is Current Page?: Yup!
        {% else %}
          Is Current Page?: Nope!
        {% endif %}
      CONTENT

      post = create(:page, site: site, content: content)

      visit archangel.frontend_page_path(post.path)

      expect(page).to have_content("Is Current Page?: Yup!")
      expect(page).not_to have_content("Is Current Page?: Nope!")
    end

    it "knows it is not on the current page" do
      content = <<-CONTENT
        {% if current_page == '/some-other-page' %}
          Is Current Page?: Yup!
        {% else %}
          Is Current Page?: Nope!
        {% endif %}
      CONTENT

      post = create(:page, site: site, content: content)

      visit archangel.frontend_page_path(post.path)

      expect(page).not_to have_content("Is Current Page?: Yup!")
      expect(page).to have_content("Is Current Page?: Nope!")
    end
  end

  describe "for $page" do
    let(:site) { create(:site) }

    it "knows the page properties" do
      content = <<-CONTENT
        Page ID: {{ page.id }}
        Page Title: {{ page.title }}
        Page Path: {{ page.path }}
        Page Meta Keywords: {{ page.meta_keywords }}
        Page Meta Description: {{ page.meta_description }}
        Page Published At: {{ page.published_at }}
      CONTENT

      post = create(:page, site: site, content: content)

      visit archangel.frontend_page_path(post.path)

      expect(page).to have_content("Page ID: #{post.id}")
      expect(page).to have_content("Page Title: #{post.title}")
      expect(page).to have_content("Page Path: /#{post.path}")
      expect(page).to have_content("Page Meta Keywords: #{post.meta_keywords}")
      expect(page)
        .to have_content("Page Meta Description: #{post.meta_description}")
      expect(page).to have_content("Page Published At: #{post.published_at}")
    end
  end

  describe "for site" do
    let(:site) { create(:site) }

    it "knows the site properties" do
      content = <<-CONTENT
        Site Name: {{ site.name }}
        Site Locale: {{ site.locale }}
        Site Meta Keywords: {{ site.meta_keywords }}
        Site Meta Description: {{ site.meta_description }}
        Site Logo: {{ site.logo }}
      CONTENT

      post = create(:page, site: site, content: content)

      visit archangel.frontend_page_path(post.path)

      expect(page).to have_content("Site Name: #{site.name}")
      expect(page).to have_content("Site Locale: #{site.locale}")
      expect(page).to have_content("Site Meta Keywords: #{site.meta_keywords}")
      expect(page)
        .to have_content("Site Meta Description: #{site.meta_description}")
      expect(page).to have_content("Site Logo: #{site.logo}")
    end
  end

  describe "for unknown variable" do
    let(:site) { create(:site) }

    it "responds with blank value" do
      content = <<-CONTENT
        Unknown Variable: ~{{ unknown_variable }}~
      CONTENT

      post = create(:page, site: site, content: content)

      visit archangel.frontend_page_path(post.path)

      expect(page).to have_content("Unknown Variable: ~~")
    end
  end
end
