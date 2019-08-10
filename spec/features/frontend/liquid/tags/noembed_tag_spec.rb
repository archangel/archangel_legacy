# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Liquid custom tags", type: :feature do
  describe "for `noembed` tag" do
    let(:video_id) { "NOGEyBeoBGM" }
    let(:video_url) { "https://www.youtube.com/watch?v=#{video_id}" }
    let(:embedded_video_url) do
      "https://www.youtube.com/embed/#{video_id}?feature=oembed"
    end

    let(:content) { "{% noembed '#{video_url}' %}" }

    let(:expected_json) do
      {
        html: "<iframe
                src=\"#{embedded_video_url}\"
                width=\"459\" height=\"344\"
                frameborder=\"0\" allowfullscreen=\"allowfullscreen\">
               </iframe>"
      }
    end
    let(:expected_error) { "Error. Bad things happened." }

    let(:response) { Net::HTTPSuccess.new("1.1", 200, nil) }

    before { create(:site) }

    it "returns content as Ruby request for resource" do
      create(:page, slug: "amazing", content: "{% noembed '#{video_url}' %}")

      visit "/amazing"

      expect(page).to have_css("iframe[src='#{embedded_video_url}']")
    end

    it "returns content as Javascript request for resource" do
      video = "https://player.vimeo.com/video/183344978"

      allow(response).to receive(:body)
        .and_return({ error: expected_json }.to_json)
      allow(Net::HTTP).to receive(:get_response).and_return(response)

      create(:page, slug: "amazing",
                    content: "{% noembed '#{video}' remote:true %}")

      visit "/amazing"

      expect(page).to have_css("script", text: /#{CGI.escape(video)}/,
                                         visible: false)
    end

    it "returns content with resource and maxwidth option" do
      create(:page, slug: "amazing",
                    content: "{% noembed '#{video_url}' maxwidth:200 %}")

      visit "/amazing"

      # HACK: The API seems to be returning "width=' 200'" in the HTML.
      expect(page).to have_css("iframe[width$='200']")
    end

    it "returns content with resource and maxheight option" do
      create(:page, slug: "amazing",
                    content: "{% noembed '#{video_url}' maxheight:200 %}")

      visit "/amazing"

      expect(page).to have_css("iframe[height='200']")
    end

    it "returns a connection error when the site is down" do
      allow(Net::HTTP).to receive(:get_response).and_return(Net::HTTPError)

      create(:page, slug: "amazing", content: "{% noembed '#{video_url}' %}")

      visit "/amazing"

      expect(page).to have_content("Error connecting to noembed server.")
    end

    it "returns specific error when an error occurres" do
      allow(response).to receive(:body)
        .and_return({ error: expected_error }.to_json)
      allow(Net::HTTP).to receive(:get_response).and_return(response)

      create(:page, slug: "amazing", content: "{% noembed '#{video_url}' %}")

      visit "/amazing"

      expect(page).to have_content(expected_error)
    end

    it "returns generic error when an error occurres" do
      allow(response).to receive(:body).and_return({ foo: "bar" }.to_json)
      allow(Net::HTTP).to receive(:get_response).and_return(response)

      create(:page, slug: "amazing", content: "{% noembed '#{video_url}' %}")

      visit "/amazing"

      expect(page).to have_content("Unknown error.")
    end
  end
end
