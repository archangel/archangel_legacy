# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Liquid
    module Tags
      RSpec.describe RenderPartialTag, type: :tag do
        let(:context) { ::Liquid::Context.new({}, {}, view: view) }

        xit "returns rendered partial" do
          content = "{% render_partial 'real/partial' %}"
          result = ::Liquid::Template.parse(content).render(context)

          expect(result).to eq("")
        end

        xit "returns nothing for rendered unknown partial" do
          content = "{% render_partial 'unknown/partial' %}"
          result = ::Liquid::Template.parse(content).render(context)

          expect(result).to eq("")
        end
      end
    end
  end
end
