# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Pages", type: :feature do
  describe "slug creation" do
    before { stub_authorization! }

    it "can have duplicate slug at different level" do
      foo = create(:page, slug: "foo")
      create(:page, slug: "archangel")

      visit archangel.new_backend_page_path

      fill_in(:page_title, with: "Page Title")
      fill_in(:page_slug, with: "archangel")
      fill_in(:page_content, with: "Page content here.")
      select(foo.title, from: :page_parent_id)

      submit_form

      expect(page).to have_content(
        I18n.t("flash.actions.create.notice", resource_name: "Page")
      )
    end

    it "cannot have duplicate slug at same level" do
      create(:page, slug: "archangel")

      visit archangel.new_backend_page_path

      fill_in(:page_title, with: "Page Title")
      fill_in(:page_slug, with: "archangel")
      fill_in(:page_content, with: "Page content here.")

      submit_form

      expect(page).to have_content Archangel.t(:duplicate_slug)
    end
  end
end
