# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Liquid
    module Drops
      RSpec.describe SiteDrop, type: :liquid_drop do
        let(:resource) { create(:site, name: "Test Site", locale: "en") }
        let(:resource_drop) { described_class.new(resource) }

        context "with attributes" do
          it "_attributes" do
            expect(resource_drop.class._attributes).to eq(%i[locale name])
          end

          it "returns correct #logo value" do
            expect(resource_drop.logo)
              .to match(%r{/assets/archangel/fallback/logo(.+).png})
          end
        end

        context "with #as_json" do
          it "returns hash of attributes" do
            json_object = {
              locale: "en",
              name: "Test Site"
            }

            expect(resource_drop.as_json).to eq(json_object.as_json)
          end
        end

        context "with #to_json" do
          it "returns hash of attributes" do
            json_object = {
              locale: "en",
              name: "Test Site"
            }

            expect(resource_drop.to_json).to eq(json_object.to_json)
          end
        end
      end
    end
  end
end
