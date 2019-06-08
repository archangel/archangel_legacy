# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe AvatarUploader, type: :uploader do
    subject(:resource) { described_class.new }

    let(:user) { create(:user) }
    let(:uploader) { described_class.new(user, :avatar) }

    before do
      described_class.enable_processing = true

      uploader.store!(fixture_file_upload(uploader_test_image))
    end

    after do
      described_class.enable_processing = false

      uploader.remove!
    end

    it "uses default image" do
      expect(resource.default_url)
        .to include("assets/archangel/fallback/avatar")
    end

    it "scales an original image to be no larger than 512 by 512 pixels" do
      expect(uploader).to be_no_larger_than(512, 512)
    end

    it "scales a large image to be no larger than 256 by 256 pixels" do
      expect(uploader.large).to be_no_larger_than(256, 256)
    end

    it "scales a medium image to be no larger than 128 by 128 pixels" do
      expect(uploader.medium).to be_no_larger_than(128, 128)
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
