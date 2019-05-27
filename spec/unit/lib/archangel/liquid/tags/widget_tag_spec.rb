# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Liquid
    module Tags
      RSpec.describe WidgetTag, type: :liquid_tag do
        let(:site) { create(:site) }
        let(:context) do
          ::Liquid::Context.new({ "site" => site }, {}, view: view)
        end

        it "raises error with invalid syntax" do
          content = "{% widget %}"

          expect { ::Liquid::Template.parse(content).render(context) }.to(
            raise_error(::Liquid::SyntaxError)
          )
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

        it "returns widget content with design" do
          design = create(:design, :partial, site: site)
          widget = create(:widget, site: site, design: design)

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
