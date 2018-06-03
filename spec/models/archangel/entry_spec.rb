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

    context ".available?" do
      it "is available" do
        entry = build(:entry)

        expect(entry.available?).to be_truthy
      end

      it "is available in the future" do
        entry = build(:entry, available_at: 1.week.from_now)

        expect(entry.available?).to be_truthy
      end

      it "is not available" do
        entry = build(:entry, :unavailable)

        expect(entry.available?).to be_falsey
      end
    end

    context "#status" do
      it "returns `unavailable` for Entries not available" do
        entry = build(:entry, :unavailable)

        expect(entry.status).to eq("unavailable")
      end

      it "returns `future-available` for Entries available in the future" do
        entry = build(:entry, :future)

        expect(entry.status).to eq("future-available")
      end

      it "returns `available` for Entries available in the past" do
        entry = build(:entry)

        expect(entry.status).to eq("available")
      end
    end
  end
end
