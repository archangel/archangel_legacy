# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Liquid custom tags", type: :feature do
  describe "for `youtube` tag" do
    let(:youtube_id) { "NOGEyBeoBGM" }

    it "returns error without a YouTube ID" do
      create(:page, slug: "amazing", content: "{% youtube %}")

      visit "/amazing"

      syntax_error = "Syntax Error in 'youtube' - Valid syntax: " \
                     "{% youtube '[key]' width:640 height:480 %}"

      expect(page).to have_css("span.liquid-syntax-error", text: syntax_error)
    end

    it "returns video with valid video" do
      create(:page, slug: "amazing", content: "{% youtube '#{youtube_id}' %}")

      visit "/amazing"

      expect(page).to(
        have_css("iframe[src^='https://www.youtube.com/embed/#{youtube_id}']")
      )
    end

    it "returns video with `class` attribute set" do
      content = "{% youtube '#{youtube_id}' class:'amazing-video' %}"

      create(:page, slug: "amazing", content: content)

      visit "/amazing"

      expect(page).to have_css("iframe[class='amazing-video']")
    end

    it "returns video with `width` attribute set" do
      content = "{% youtube '#{youtube_id}' width:400 %}"

      create(:page, slug: "amazing", content: content)

      visit "/amazing"

      expect(page).to have_css("iframe[width='400']")
    end

    it "returns video with `width` attribute as percent" do
      content = "{% youtube '#{youtube_id}' width:'100%' %}"

      create(:page, slug: "amazing", content: content)

      visit "/amazing"

      expect(page).to have_css("iframe[width='100%']")
    end

    it "returns video with `start` param passed" do
      content = "{% youtube '#{youtube_id}' start:18 %}"

      create(:page, slug: "amazing", content: content)

      visit "/amazing"

      expect(page).to have_css("iframe[src*='start=18']")
    end

    it "returns video with `captions` (closed captioning) turned on" do
      content = "{% youtube '#{youtube_id}' captions:1 %}"

      create(:page, slug: "amazing", content: content)

      visit "/amazing"

      expect(page).to have_css("iframe[src*='cc_load_policy=1']")
    end

    it "returns video with `width` param" do
      content = "{% youtube '#{youtube_id}' width:400 %}"

      create(:page, slug: "amazing", content: content)

      visit "/amazing"

      expect(page).to have_css("iframe[src*='width=400']")
    end

    it "returns video with `width` param as percent" do
      content = "{% youtube '#{youtube_id}' width:'100%' %}"

      create(:page, slug: "amazing", content: content)

      visit "/amazing"

      expect(page).to have_css("iframe[src*='width=100%']")
    end
  end
end
