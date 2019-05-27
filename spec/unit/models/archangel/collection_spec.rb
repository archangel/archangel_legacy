# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe Collection, type: :model do
    context "callbacks" do
      it { is_expected.to callback(:parameterize_slug).before(:validation) }

      it { is_expected.to callback(:column_reset).after(:destroy) }
    end

    context "validations" do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:slug) }

      it "has a unique slug scoped to Site" do
        resource = build(:collection)

        expect(resource)
          .to validate_uniqueness_of(:slug).scoped_to(:site_id).case_insensitive
      end
    end

    context "associations" do
      it { is_expected.to belong_to(:site) }

      it { is_expected.to have_many(:entries) }
      it { is_expected.to have_many(:fields) }
    end

    context "#to_param" do
      it "uses `slug` as the identifier for routes" do
        resource = build(:collection, slug: "foo")

        expect(resource.to_param).to eq("foo")
      end
    end

    context "#column_reset" do
      it "resets `slug` to `slug` + current time" do
        resource = create(:collection)

        slug = resource.slug

        resource.destroy!

        expect(resource.slug).to eq "#{Time.current.to_i}_#{slug}"
      end
    end
  end
end
