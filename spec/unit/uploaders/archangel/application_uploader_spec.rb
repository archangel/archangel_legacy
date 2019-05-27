# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe ApplicationUploader, type: :uploader do
    it "uses default image" do
      expect(subject.default_url).to eq("/images/fallback/default.png")
    end

    it "allows certain extensions" do
      expect(subject.extension_whitelist).to eq %w[gif jpeg jpg png]
    end
  end
end
