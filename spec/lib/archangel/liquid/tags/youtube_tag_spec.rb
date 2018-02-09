# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Liquid
    module Tags
      RSpec.describe YoutubeTag, type: :tag, disable: :verify_partial_doubles do
        let(:context) { ::Liquid::Context.new({}, {}, view: view) }

        it "returns default YouTube embed" do
          result = ::Liquid::Template.parse("{% youtube '-X2atEH7nCg' %}")
                                     .render(context)

          expect(result).to include("https://www.youtube.com/embed/-X2atEH7nCg")
          expect(result).to include("width=\"640\"")
          expect(result).to include("height=\"360\"")
        end

        it "returns YouTube embed with options" do
          template = "{% youtube '-X2atEH7nCg' width='800' height='600' %}"
          result = ::Liquid::Template.parse(template).render(context)

          expect(result).to include("https://www.youtube.com/embed/-X2atEH7nCg")
          expect(result).to include("width=\"800\"")
          expect(result).to include("height=\"600\"")
        end
      end
    end
  end
end
