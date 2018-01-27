# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Liquid
    module Tags
      RSpec.describe LocaleTag, type: :tag do
        let(:context) { ::Liquid::Context.new({}, {}, view: view) }

        it "returns current locale", disable: :verify_partial_doubles do
          allow(view).to receive(:locale).and_return("en")

          result = ::Liquid::Template.parse("{% locale %}").render(context)

          expect(result).to eq("en")
        end
      end
    end
  end
end
