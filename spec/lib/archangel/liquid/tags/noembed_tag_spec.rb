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

        it "returns YouTube video embed" do
          content = <<-NOEMBED
            {% noembed 'https://www.youtube.com/watch?v=-X2atEH7nCg' %}
          NOEMBED

          result = ::Liquid::Template.parse(content).render(context)

          expect(result).to include(
            "https://www.youtube.com/embed/-X2atEH7nCg?feature=oembed"
          )
        end

        it "returns YouTube video embed with Javascript loading" do
          video = "https://player.vimeo.com/video/183344978"
          content = "{% noembed '#{video}' remote:true %}"

          result = ::Liquid::Template.parse(content).render(context)

          expect(result).to include(CGI.escape(video))
        end
      end
    end
  end
end
