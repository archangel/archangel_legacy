# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe Asset, type: :model do
    context "callbacks" do
      it { is_expected.to callback(:save_asset_attributes).before(:save) }
    end

    context "validations" do
      it { is_expected.to validate_presence_of(:file) }
      it { is_expected.to validate_presence_of(:file_name) }

      it { is_expected.to allow_value("success.jpg").for(:file_name) }

      it { is_expected.to_not allow_value("without-extension").for(:file_name) }
      it { is_expected.to_not allow_value("with.dot.jpg").for(:file_name) }
      it { is_expected.to_not allow_value("with space.jpg").for(:file_name) }
    end

    context "associations" do
      it { is_expected.to belong_to(:site) }
    end
  end
end
