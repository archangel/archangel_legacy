# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe ApplicationUploader, type: :uploader do
    subject(:resource) { described_class.new }

    it "uses default image" do
      expect(resource.default_url).to eq("/images/fallback/default.png")
    end

    it "allows certain extensions" do
      expect(resource.extension_whitelist).to eq %w[gif jpeg jpg png]
    end
  end
end
