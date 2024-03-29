# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe Collection, type: :model do
    context "with validations" do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:slug) }

      it "has a unique slug scoped to Site" do
        resource = build(:collection)

        expect(resource)
          .to validate_uniqueness_of(:slug).scoped_to(:site_id).case_insensitive
      end
    end

    context "with #to_param" do
      it "uses `slug` as the identifier for routes" do
        resource = build(:collection, slug: "foo")

        expect(resource.to_param).to eq("foo")
      end
    end

    context "with #column_reset" do
      it "resets `slug` to `slug` + current time" do
        resource = create(:collection)

        slug = resource.slug

        resource.destroy!

        expect(resource.slug).to eq "#{Time.current.to_i}_#{slug}"
      end
    end
  end
end
