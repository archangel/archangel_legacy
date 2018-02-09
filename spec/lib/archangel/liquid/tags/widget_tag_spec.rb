# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Liquid
    module Tags
      RSpec.describe WidgetTag, type: :tag, disable: :verify_partial_doubles do
        let(:site) { create(:site) }
        let(:context) do
          ::Liquid::Context.new({ "site" => site }, {}, view: view)
        end

        it "returns widget content" do
          widget = create(:widget, site: site)

          result = ::Liquid::Template.parse("{% widget '#{widget.slug}' %}")
                                     .render(context)

          expect(result).to include("<p>Content of the widget</p>")
        end

        it "returns widget content" do
          widget = create(:widget, site: site)

          result = ::Liquid::Template.parse("{% widget '#{widget.slug}' %}")
                                     .render(context)

          expect(result).to include("<p>Content of the widget</p>")
        end

        it "returns widget content with template" do
          template = create(:template, :partial, site: site)
          widget = create(:widget, site: site, template: template)

          result = ::Liquid::Template.parse("{% widget '#{widget.slug}' %}")
                                     .render(context)

          expect(result).to include("<p>Content of the widget</p>")
        end

        it "returns nothing for unknown widget" do
          result = ::Liquid::Template.parse("{% widget 'unknown_widget' %}")
                                     .render(context)

          expect(result).to eq("")
        end
      end
    end
  end
end
