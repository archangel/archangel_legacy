# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Liquid
    module Tags
      RSpec.describe RenderPartialTag, type: :tag,
                                       disable: :verify_partial_doubles do
        let(:context) { ::Liquid::Context.new({}, {}, view: view) }

        xit "returns rendered partial" do
        end
      end
    end
  end
end
