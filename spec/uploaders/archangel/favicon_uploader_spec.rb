# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe FaviconUploader, type: :uploader do
    let(:site) { create(:site) }
    let(:uploader) { described_class.new(site, :favicon) }

    before do
      described_class.enable_processing = true

      uploader.store!(fixture_file_upload(uploader_test_favicon))
    end

    after do
      described_class.enable_processing = false

      uploader.remove!
    end

    it "allows certain extensions" do
      expect(subject.extension_whitelist).to eq %i[gif ico jpeg jpg png]
    end

    it "scales an original image to be no larger than 32 by 32 pixels" do
      expect(uploader).to be_no_larger_than(32, 32)
    end

    it "makes the image with 666 permissions" do
      expect(uploader).to have_permissions(0o666)
    end
  end
end
