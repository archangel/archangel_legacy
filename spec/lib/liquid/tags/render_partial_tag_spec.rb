# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Liquid
    module Tags
      RSpec.describe RenderPartialTag, type: :tag do
        let(:context) { ::Liquid::Context.new({}, {}, view: view) }

        xit "returns rendered partial", disable: :verify_partial_doubles do
        end
      end
    end
  end
end
