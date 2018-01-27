# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Liquid
    module Tags
      RSpec.describe CsrfMetaTagsTag, type: :tag do
        let(:context) { ::Liquid::Context.new({}, {}, view: view) }

        it "returns CSRF meta tags", disable: :verify_partial_doubles do
          allow(view).to receive(:protect_against_forgery?).and_return(true)
          allow(view).to(
            receive(:form_authenticity_token)
              .and_return("rails_form_authenticity_token")
          )

          result = ::Liquid::Template.parse("{% csrf_meta_tags %}")
                                     .render(context)

          expected_param =
            '<meta name="csrf-param" content="authenticity_token" />'
          expected_token =
            '<meta name="csrf-token" content="rails_form_authenticity_token" />'

          expect(result).to include(expected_param)
          expect(result).to include(expected_token)
        end
      end
    end
  end
end
