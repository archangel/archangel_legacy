# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Liquid
    module Tags
      RSpec.describe LocaleTag, type: :liquid_tag,
                                disable: :verify_partial_doubles do
        let(:context) { ::Liquid::Context.new({}, {}, view: view) }

        it "returns current locale" do
          allow(view).to receive(:locale).and_return("en")

          result = ::Liquid::Template.parse("{% locale %}").render(context)

          expect(result).to eq("en")
        end
      end
    end
  end
end
