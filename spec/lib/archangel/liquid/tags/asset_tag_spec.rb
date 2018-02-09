# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Liquid
    module Tags
      RSpec.describe AssetTag, type: :tag, disable: :verify_partial_doubles do
        let(:site) { create(:site) }
        let(:context) do
          ::Liquid::Context.new({ "site" => site }, {}, view: view)
        end

        it "returns image asset" do
          asset = create(:asset, site: site, file_name: "abc.jpg")

          result = ::Liquid::Template.parse("{% asset '#{asset.file_name}' %}")
                                     .render(context)
          expected = "<img alt=\"#{asset.file_name}\" " \
                     "src=\"/uploads/archangel/asset/file/"

          expect(result).to include(expected)
        end

        it "returns nothing when asset not found" do
          result = ::Liquid::Template.parse("{% asset 'whatever.jpg' %}")
                                     .render(context)

          expect(result).to eq("")
        end
      end
    end
  end
end
