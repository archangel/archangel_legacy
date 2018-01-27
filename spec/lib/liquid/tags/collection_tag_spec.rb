# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Liquid
    module Tags
      RSpec.describe CollectionTag, type: :tag do
        let(:context) { ::Liquid::Context.new({}, {}, view: view) }

        xit "returns collection content", disable: :verify_partial_doubles do
        end
      end
    end
  end
end
