# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe Collection, type: :model do
    context "callbacks" do
      it { is_expected.to callback(:parameterize_slug).before(:validation) }

      it { is_expected.to callback(:column_reset).after(:destroy) }
    end

    context "validations" do
      it { expect(subject).to validate_presence_of(:name) }
      it { expect(subject).to validate_presence_of(:slug) }

      it { expect(subject).to have_db_index(:slug).unique(true) }
    end

    context "associations" do
      it { expect(subject).to have_many(:entries) }
      it { expect(subject).to have_many(:fields) }
    end

    context "#to_param" do
      it "uses `slug` as the identifier for routes" do
        resource = build(:collection, slug: "foo")

        expect(resource.to_param).to eq("foo")
      end
    end

    context "#column_reset" do
      before { ::Timecop.freeze }
      after { ::Timecop.return }

      it "resets `slug` to `slug` + current time" do
        resource = create(:collection)

        slug = resource.slug

        resource.destroy!

        expect(resource.slug).to eq "#{Time.current.to_i}_#{slug}"
      end
    end
  end
end
