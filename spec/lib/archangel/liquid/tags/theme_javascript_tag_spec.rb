# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Liquid
    module Tags
      RSpec.describe ThemeJavascriptTag, type: :liquid_tag,
                                         disable: :verify_partial_doubles do
        let(:site) { create(:site) }
        let(:context) do
          ::Liquid::Context.new({ "site" => site }, {}, view: view)
        end

        it "renders Javascript tag for theme" do
          allow(view).to receive(:current_theme).and_return("default")

          result = ::Liquid::Template.parse("{% theme_javascript %}")
                                     .render(context)

          expect(result).to include('<script src="/assets/default/frontend')
        end
      end
    end
  end
end
