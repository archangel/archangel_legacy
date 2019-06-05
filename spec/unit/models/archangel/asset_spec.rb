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

      it { is_expected.to allow_value("success.js").for(:file_name) }
      it { is_expected.to allow_value("success.jpg").for(:file_name) }
      it { is_expected.to allow_value("filename.extension").for(:file_name) }
      it { is_expected.to allow_value("foo-bar.jpg").for(:file_name) }
      it { is_expected.to allow_value("foo_bar.jpg").for(:file_name) }
      it { is_expected.to allow_value("18.jpg").for(:file_name) }

      it { is_expected.not_to allow_value("error").for(:file_name) }
      it { is_expected.not_to allow_value("error.j").for(:file_name) }
      it { is_expected.not_to allow_value("with.dot.jpg").for(:file_name) }
      it { is_expected.not_to allow_value("with space.jpg").for(:file_name) }
      it { is_expected.not_to allow_value("with/slash.jpg").for(:file_name) }
      it { is_expected.not_to allow_value("with/numbers.18").for(:file_name) }
    end

    context "associations" do
      it { is_expected.to belong_to(:site) }
    end
  end
end
