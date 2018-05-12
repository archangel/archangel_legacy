# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe Entry, type: :model do
    context "validations" do
      it { is_expected.to validate_presence_of(:collection_id) }
      it { is_expected.to validate_presence_of(:value) }

      it { is_expected.to allow_value(nil).for(:available_at) }
      it { is_expected.to allow_value("").for(:available_at) }
      it { is_expected.to allow_value(Time.current).for(:available_at) }

      it { is_expected.to_not allow_value("invalid").for(:available_at) }
    end

    context "associations" do
      it { is_expected.to belong_to(:collection) }
    end
  end
end
