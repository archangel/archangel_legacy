# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe AssetUploader, type: :uploader do
    let(:asset) { create(:asset) }
    let(:uploader) { described_class.new(asset, :file) }

    it "uses default image" do
      expect(subject.default_url).to include("assets/archangel/fallback/asset")
    end

    it "allows certain extensions" do
      expect(subject.extension_whitelist).to eq %i[gif jpeg jpg png]
    end

    context "with image file" do
      before do
        described_class.enable_processing = true

        uploader.store!(fixture_file_upload(uploader_test_image, "image/gif"))
      end

      after do
        described_class.enable_processing = false

        uploader.remove!
      end

      it "is an image file" do
        expect(uploader.image?).to be_truthy
      end

      it "scales a small image to be no larger than 64 by 64 pixels" do
        expect(uploader.small).to be_no_larger_than(64, 64)
      end

      it "scales a tiny image to be no larger than 32 by 32 pixels" do
        expect(uploader.tiny).to be_no_larger_than(32, 32)
      end

      it "makes the image with 666 permissions" do
        expect(uploader).to have_permissions(0o666)
      end
    end
  end
end
