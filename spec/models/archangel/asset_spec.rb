# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe Asset, type: :model do
    context "validations" do
      it { expect(subject).to validate_presence_of(:file) }
      it { expect(subject).to validate_presence_of(:file_name) }
    end

    context "callbacks" do
      it do
        expect(subject).to callback(:parameterize_file_name).before(:validation)
      end

      it { expect(subject).to callback(:save_asset_attributes).before(:save) }
    end
  end
end
