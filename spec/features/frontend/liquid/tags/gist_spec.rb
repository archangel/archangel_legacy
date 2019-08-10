# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Liquid custom tags", type: :feature do
  describe "for `gist` tag" do
    let(:gist_id) { "0d6f8a168a225fda62e8d2ddfe173271" }
    let(:gist_id_js) { "https://gist.github.com/#{gist_id}.js" }
    let(:gist_path) { "dfreerksen/#{gist_id}" }
    let(:gist_path_js) { "https://gist.github.com/#{gist_path}.js" }
    let(:gist_file) { "hello.rb" }

    it "returns the gist with id" do
      create(:page, slug: "amazing", content: "{% gist '#{gist_id}' %}")

      visit "/amazing"

      expected = "script[src='#{gist_id_js}']"

      expect(page).to have_css(expected, visible: false)
    end

    it "returns the gist file with id" do
      content = "{% gist '#{gist_id}' file: '#{gist_file}' %}"

      create(:page, slug: "amazing", content: content)

      visit "/amazing"

      expected = "script[src='#{gist_id_js}?file=#{gist_file}']"

      expect(page).to have_css(expected, visible: false)
    end

    it "returns the gist with path" do
      create(:page, slug: "amazing", content: "{% gist '#{gist_path}' %}")

      visit "/amazing"

      expected = "script[src='#{gist_path_js}']"

      expect(page).to have_css(expected, visible: false)
    end

    it "returns the gist file with path" do
      content = "{% gist '#{gist_path}' file: '#{gist_file}' %}"

      create(:page, slug: "amazing", content: content)

      visit "/amazing"

      expected = "script[src='#{gist_path_js}?file=#{gist_file}']"

      expect(page).to have_css(expected, visible: false)
    end
  end
end
