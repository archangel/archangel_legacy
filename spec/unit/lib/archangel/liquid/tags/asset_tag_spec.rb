# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Liquid
    module Tags
      RSpec.describe AssetTag, type: :liquid_tag do
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

        it "returns link for non-image asset" do
          asset = create(:asset)
          asset.update(content_type: "text/css")

          result = ::Liquid::Template.parse("{% asset '#{asset.file_name}' %}")
                                     .render(context)
          expected = %r{<a href="#{asset.file.url}">#{asset.file_name}\</a>}

          expect(result).to match(expected)
        end

        it "returns image asset" do
          asset = create(:asset, site: site)

          result = ::Liquid::Template.parse("{% asset '#{asset.file_name}' %}")
                                     .render(context)

          expect(result).to match(
            %r{<img alt="#{asset.file_name}" src="#{asset.file.url}" />}
          )
        end

        context "with `size` attribute" do
          %w[small tiny].each do |size|
            it "returns `#{size}` sized image asset" do
              asset = create(:asset, site: site)

              content = "{% asset '#{asset.file_name}' size: '#{size}' %}"
              result = ::Liquid::Template.parse(content).render(context)

              asset_file_url = asset.file.send(size.to_sym).url

              expect(result).to match(
                %r{<img alt="#{asset.file_name}" src="#{asset_file_url}" />}
              )
            end
          end

          it "returns original image asset" do
            asset = create(:asset, site: site)

            content = "{% asset '#{asset.file_name}' size: 'unknown_size' %}"
            result = ::Liquid::Template.parse(content).render(context)

            expect(result).to match(
              %r{<img alt="#{asset.file_name}" src="#{asset.file.url}" />}
            )
          end
        end

        it "returns image with options" do
          asset = create(:asset, site: site)

          content = "{% asset '#{asset.file_name}' alt:'This is the alt tag' %}"
          result = ::Liquid::Template.parse(content).render(context)
          expect(result).to match(
            %r{<img alt="This is the alt tag" src="#{asset.file.url}" />}
          )
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
