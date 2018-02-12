# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Liquid
    module Tags
      RSpec.describe AssetTag, type: :tag do
        let(:site) { create(:site) }
        let(:context) do
          ::Liquid::Context.new({ "site" => site }, {}, view: view)
        end

        it "raises error with invalid syntax" do
          content = "{% asset %}"

          expect { ::Liquid::Template.parse(content).render(context) }.to(
            raise_error(::Liquid::SyntaxError)
          )
        end

        it "returns image asset" do
          asset = create(:asset, site: site, file_name: "abc.jpg")

          result = ::Liquid::Template.parse("{% asset '#{asset.file_name}' %}")
                                     .render(context)
          expected = "<img alt=\"#{asset.file_name}\" " \
                     "src=\"/uploads/archangel/asset/file/"

          expect(result).to include(expected)
        end

        it "returns image with options" do
          asset = create(:asset, site: site, file_name: "abc.jpg")

          content = "{% asset '#{asset.file_name}' alt:'This is the alt tag' %}"
          result = ::Liquid::Template.parse(content).render(context)
          expected = "<img alt=\"This is the alt tag\" " \
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
