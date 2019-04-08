# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Home page", type: :feature do
  describe "when on home page permalink" do
    it "redirects to /" do
      resource = create(:page, :homepage)

      visit archangel.frontend_page_path(resource.permalink)

      expect(page.current_path).to eq archangel.frontend_root_path
    end
  end
end
