# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Liquid
    module Tags
      RSpec.describe WidgetTag, type: :tag do
        let(:site) { create(:site) }
        let(:context) do
          ::Liquid::Context.new({ "site" => site }, {}, view: view)
        end

        it "returns widget content", disable: :verify_partial_doubles do
          widget = create(:widget, site: site, slug: "my_widget")

          result = ::Liquid::Template.parse("{% widget '#{widget.slug}' %}")
                                     .render(context)

          expect(result).to include("<p>Content of the widget</p>")
        end

        it "returns nothing for unknown widget",
           disable: :verify_partial_doubles do
          result = ::Liquid::Template.parse("{% widget 'unknown_widget' %}")
                                     .render(context)

          expect(result).to eq("")
        end
      end
    end
  end
end
