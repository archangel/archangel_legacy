# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Liquid
    module Tags
      RSpec.describe NoembedTag, type: :liquid_tag do
        let(:context) { ::Liquid::Context.new({}, {}, view: view) }

        it "raises error with invalid syntax" do
          content = "{% noembed %}"

          expect { ::Liquid::Template.parse(content).render(context) }.to(
            raise_error(::Liquid::SyntaxError)
          )
        end

        context "Ruby request" do
          let(:content_url) { "https://www.youtube.com/watch?v=-X2atEH7nCg" }
          let(:content) { "{% noembed '#{content_url}' %}" }

          it "returns YouTube video embed" do
            result = ::Liquid::Template.parse(content).render(context)

            expect(result).to include(
              "https://www.youtube.com/embed/-X2atEH7nCg?feature=oembed"
            )
          end

          it "returns a connection error when the site is down" do
            allow(Net::HTTP)
              .to receive(:get_response).and_return(Net::HTTPError)

            result = ::Liquid::Template.parse(content).render(context)

            expect(result).to include("Error connecting to noembed server.")
          end

          it "returns specific error when an error occurres" do
            response = Net::HTTPSuccess.new("1.1", 200, nil)
            allow(response).to receive(:body)
              .and_return({ error: "Error. Bad things happened." }.to_json)
            allow(Net::HTTP).to receive(:get_response).and_return(response)

            result = ::Liquid::Template.parse(content).render(context)

            expect(result).to include("Error. Bad things happened.")
          end

          it "returns generic error when an error occurres" do
            response = Net::HTTPSuccess.new("1.1", 200, nil)
            allow(response).to receive(:body)
              .and_return({ foo: "bar" }.to_json)
            allow(Net::HTTP).to receive(:get_response).and_return(response)

            result = ::Liquid::Template.parse(content).render(context)

            expect(result).to include("Unknown error.")
          end
        end

        context "Javascript request" do
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
