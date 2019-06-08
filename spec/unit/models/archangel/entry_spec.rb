# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe Entry, type: :model do
    context "with validations" do
      it { is_expected.to validate_presence_of(:collection_id) }
      it { is_expected.to validate_presence_of(:value) }

      it { is_expected.to allow_value(nil).for(:published_at) }
      it { is_expected.to allow_value("").for(:published_at) }
      it { is_expected.to allow_value(Time.current).for(:published_at) }

      it { is_expected.not_to allow_value("invalid").for(:published_at) }
    end

    context "with associations" do
      it { is_expected.to belong_to(:collection) }
    end

    context "with scopes" do
      context "with .available" do
        it "returns all where published_at <= now" do
          entry = create(:entry)

          expect(described_class.available.first).to eq(entry)
        end

        it "returns all where published_at <= now in the future" do
          entry = create(:entry, :future)

          expect(described_class.available.first).not_to eq(entry)
        end
      end

      context "with .available" do
        it "returns all where published_at <= now" do
          entry = create(:entry)

          expect(described_class.available.first).to eq(entry)
        end

        it "returns all where published_at <= now not in the future" do
          entry = create(:entry, :future)

          expect(described_class.available.first).not_to eq(entry)
        end
      end

      context "with .unpublished" do
        it "returns all where available_at is nil" do
          entry = create(:entry, :unpublished)

          expect(described_class.unpublished.first).to eq(entry)
        end

        it "returns all where available_at is > now" do
          entry = create(:entry, :future)

          expect(described_class.unpublished.first).to eq(entry)
        end
      end
    end

    context "with .available?" do
      it "is available" do
        entry = build(:entry, published_at: 1.minute.ago)

        expect(entry.available?).to be_truthy
      end

      it "is not available in the future" do
        entry = build(:entry, published_at: 1.week.from_now)

        expect(entry.available?).to be_falsey
      end

      it "is not available" do
        entry = build(:entry, :unpublished)

        expect(entry.available?).to be_falsey
      end
    end

    context "with .published?" do
      it "is published" do
        entry = build(:entry)

        expect(entry.published?).to be_truthy
      end

      it "is published in the future" do
        entry = build(:entry, published_at: 1.week.from_now)

        expect(entry.published?).to be_truthy
      end

      it "is not published" do
        entry = build(:entry, :unpublished)

        expect(entry.published?).to be_falsey
      end
    end
  end
end
