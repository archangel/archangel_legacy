# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Liquid
    module Tags
      RSpec.describe MetaTagsTag, type: :tag,
                                  disable: :verify_partial_doubles do
        let(:context) { ::Liquid::Context.new({}, {}, view: view) }

        it "returns meta tags" do
          canonical = "<link rel=\"canonical\" href=\"http://localhost/\">"

          allow(view).to receive(:display_meta_tags).and_return(canonical)

          result = ::Liquid::Template.parse("{% meta_tags %}").render(context)

          expect(result).to eq(canonical)
        end
      end
    end
  end
end
