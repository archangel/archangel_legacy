# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Liquid
    module Tags
      RSpec.describe VimeoTag, type: :liquid_tag do
        let(:context) { ::Liquid::Context.new({}, {}, view: view) }

        it "raises error with invalid syntax" do
          content = "{% vimeo %}"

          expect { ::Liquid::Template.parse(content).render(context) }.to(
            raise_error(::Liquid::SyntaxError)
          )
        end

        it "returns default Vimeo embed" do
          result = ::Liquid::Template.parse("{% vimeo '183344978' %}")
                                     .render(context)

          expect(result).to include("https://player.vimeo.com/video/183344978")
          expect(result).to include("width=\"640\"")
          expect(result).to include("height=\"360\"")
        end

        it "returns Vimeo embed with options" do
          content = "{% vimeo '183344978' width:800 height:600 %}"
          result = ::Liquid::Template.parse(content).render(context)

          expect(result).to include("https://player.vimeo.com/video/183344978")
          expect(result).to include("width=\"800\"")
          expect(result).to include("height=\"600\"")
        end
      end
    end
  end
end
