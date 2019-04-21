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

    context ".accessible?" do
      it "is accessible" do
        entry = build(:entry)

        expect(entry.accessible?).to be_truthy
      end

      it "is not accessible in the future" do
        entry = build(:entry, available_at: 1.week.from_now)

        expect(entry.accessible?).to be_falsey
      end

      it "is not accessible" do
        entry = build(:entry, :unavailable)

        expect(entry.accessible?).to be_falsey
      end
    end

    context "scopes" do
      context ".accessible" do
        it "returns all where available_at <= now" do
          entry = create(:entry)

          expect(described_class.accessible.first).to eq(entry)
        end

        it "returns all where available_at <= now in the future" do
          entry = create(:entry, :future)

          expect(described_class.accessible.first).to_not eq(entry)
        end
      end

      context ".available" do
        it "returns all where available_at <= now" do
          entry = create(:entry)

          expect(described_class.available.first).to eq(entry)
        end

        it "returns all where available_at <= now in the future" do
          entry = create(:entry, :future)

          expect(described_class.available.first).to eq(entry)
        end
      end

      context ".unavailable" do
        it "returns all where available_at is nil" do
          entry = create(:entry, :unavailable)

          expect(described_class.unavailable.first).to eq(entry)
        end

        it "returns all where available_at is > now" do
          entry = create(:entry, :future)

          expect(described_class.unavailable.first).to eq(entry)
        end
      end
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
  end
end
