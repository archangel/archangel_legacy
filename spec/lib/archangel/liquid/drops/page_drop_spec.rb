# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Liquid
    module Drops
      RSpec.describe PageDrop, type: :liquid_drop do
        let(:resource) do
          create(:page, title: "Test Page",
                        slug: "path-for-page",
                        published_at: "2018-04-20 14:20:18")
        end
        let(:resource_drop) { described_class.new(resource) }

        context "attributes" do
          it "_attributes" do
            expect(resource_drop.class._attributes)
              .to eq(%i[published_at title])
          end

          it "returns correct attribute values" do
            expect(resource_drop.published_at).to eq("2018-04-20 14:20:18")
            expect(resource_drop.title).to eq("Test Page")
          end

          it "returns correct #id value" do
            expect(resource_drop.id).to eq(resource.id.to_s)
          end

          it "returns correct #path value" do
            expect(resource_drop.path).to eq("/path-for-page")
          end
        end

        context "#as_json" do
          it "returns hash of attributes" do
            json_object = {
              published_at: "2018-04-20T14:20:18.000Z",
              title: "Test Page"
            }

            expect(resource_drop.as_json).to eq(json_object.as_json)
          end
        end

        context "#to_json" do
          it "returns hash of attributes" do
            json_object = {
              published_at: "2018-04-20T14:20:18.000Z",
              title: "Test Page"
            }

            expect(resource_drop.to_json).to eq(json_object.to_json)
          end
        end

        context "#inspect" do
          it "returns inspect string" do
            expect(resource_drop.inspect)
              .to include("#<Archangel::Liquid::Drops::PageDrop")
            expect(resource_drop.inspect)
              .to include("#<Archangel::Page")
          end
        end
      end
    end
  end
end
