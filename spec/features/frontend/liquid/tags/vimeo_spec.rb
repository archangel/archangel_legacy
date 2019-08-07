# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Liquid custom tags", type: :feature do
  describe "for `vimeo` tag" do
    let(:vimeo_id) { "1234567890" }

    it "returns error without a Vimeo ID" do
      create(:page, slug: "amazing", content: "{% vimeo %}")

      visit "/amazing"

      syntax_error = "Syntax Error in 'vimeo' - Valid syntax: " \
                     "{% vimeo '[key]' width:640 height:480 %}"

      expect(page).to have_css("span.liquid-syntax-error", text: syntax_error)
    end

    it "returns video with valid video" do
      create(:page, slug: "amazing", content: "{% vimeo '#{vimeo_id}' %}")

      visit "/amazing"

      expect(page).to(
        have_css("iframe[src^='https://player.vimeo.com/video/#{vimeo_id}']")
      )
    end

    it "returns video with `class` attribute set" do
      content = "{% vimeo '#{vimeo_id}' class:'amazing-video' %}"

      create(:page, slug: "amazing", content: content)

      visit "/amazing"

      expect(page).to have_css("iframe[class='amazing-video']")
    end

    it "returns video with `width` attribute set" do
      content = "{% vimeo '#{vimeo_id}' width:400 %}"

      create(:page, slug: "amazing", content: content)

      visit "/amazing"

      expect(page).to have_css("iframe[width='400']")
    end

    it "returns video with `width` attribute as percent" do
      content = "{% vimeo '#{vimeo_id}' width:'100%' %}"

      create(:page, slug: "amazing", content: content)

      visit "/amazing"

      expect(page).to have_css("iframe[width='100%']")
    end

    it "returns video with `autoplay` param on" do
      content = "{% vimeo '#{vimeo_id}' autoplay:1 %}"

      create(:page, slug: "amazing", content: content)

      visit "/amazing"

      expect(page).to have_css("iframe[src*='autoplay=1']")
    end

    it "returns video with `width` param" do
      content = "{% vimeo '#{vimeo_id}' width:400 %}"

      create(:page, slug: "amazing", content: content)

      visit "/amazing"

      expect(page).to have_css("iframe[src*='width=400']")
    end

    it "returns video with `width` param as percent" do
      content = "{% vimeo '#{vimeo_id}' width:'100%' %}"

      create(:page, slug: "amazing", content: content)

      visit "/amazing"

      expect(page).to have_css("iframe[src*='width=100%']")
    end
  end
end
