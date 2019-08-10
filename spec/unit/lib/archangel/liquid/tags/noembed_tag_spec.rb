# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Liquid
    module Tags
      RSpec.describe NoembedTag, type: :liquid_tag do
        let(:context) { ::Liquid::Context.new({}, {}, view: view) }

        context "with Ruby request" do
          let(:vid_id) { "NOGEyBeoBGM" }
          let(:content_url) { "https://www.youtube.com/watch?v=#{vid_id}" }
          let(:content) { "{% noembed '#{content_url}' %}" }

          # In leiu of adding VRC or WebMock as a dependency, hard code the
          # expected API response in order to make the test work offline.
          let(:expected_json) do
            {
              author_name: "treatsforbeasts",
              url: "https://www.youtube.com/watch?v=#{vid_id}",
              title: "beasts",
              provider_name: "YouTube",
              width: 459,
              height: 344,
              thumbnail_url: "https://i.ytimg.com/vi/#{vid_id}/hqdefault.jpg",
              thumbnail_width: 480,
              author_url: "https://www.youtube.com/user/treatsforbeasts",
              provider_url: "https://www.youtube.com/",
              thumbnail_height: 360,
              type: "video",
              version: "1.0",
              html: "<iframe
                width=\"459\"
                height=\"344\"
                src=\"https://www.youtube.com/embed/#{vid_id}?feature=oembed\"
                frameborder=\"0\"
                allowfullscreen=\"allowfullscreen\">
              </iframe>"
            }
          end
          let(:expected_error) { "Error. Bad things happened." }

          let(:response) { Net::HTTPSuccess.new("1.1", 200, nil) }

          it "returns YouTube video embed" do
            allow(response).to receive(:body).and_return(expected_json.to_json)
            allow(Net::HTTP).to receive(:get_response).and_return(response)

            result = ::Liquid::Template.parse(content).render(context)

            expect(result).to include(
              "https://www.youtube.com/embed/#{vid_id}?feature=oembed"
            )
          end

          it "returns a connection error when the site is down" do
            allow(Net::HTTP)
              .to receive(:get_response).and_return(Net::HTTPError)

            result = ::Liquid::Template.parse(content).render(context)

            expect(result).to include("Error connecting to noembed server.")
          end

          it "returns specific error when an error occurres" do
            allow(response).to receive(:body)
              .and_return({ error: expected_error }.to_json)
            allow(Net::HTTP).to receive(:get_response).and_return(response)

            result = ::Liquid::Template.parse(content).render(context)

            expect(result).to include(expected_error)
          end

          it "returns generic error when an error occurres" do
            allow(response).to receive(:body).and_return({ foo: "bar" }.to_json)
            allow(Net::HTTP).to receive(:get_response).and_return(response)

            result = ::Liquid::Template.parse(content).render(context)

            expect(result).to include("Unknown error.")
          end
        end

        context "with Javascript request" do
          it "returns YouTube video embed" do
            video = "https://player.vimeo.com/video/183344978"
            content = "{% noembed '#{video}' remote:true %}"

            result = ::Liquid::Template.parse(content).render(context)

            expect(result).to include(CGI.escape(video))
          end
        end
      end
    end
  end
end
