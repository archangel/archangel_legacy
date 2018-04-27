# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Liquid
    module Tags
      RSpec.describe ThemeStylesheetTag, type: :liquid_tag,
                                         disable: :verify_partial_doubles do
        let(:site) { create(:site) }
        let(:context) do
          ::Liquid::Context.new({ "site" => site }, {}, view: view)
        end

        it "renders stylesheet tag for theme" do
          allow(view).to receive(:current_theme).and_return("default")

          result = ::Liquid::Template.parse("{% theme_stylesheet %}")
                                     .render(context)
          expected = '<link rel="stylesheet" media="screen" ' \
                     'href="/assets/default/frontend'

          expect(result).to include(expected)
        end
      end
    end
  end
end
